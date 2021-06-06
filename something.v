FRAME_3 : 
					begin 
						// SECTION 3.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 3.1 (TOP OF SCREEN)
						
						// SECTION 3.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 180)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 3.2 (FOREHEAD)
						
						// SECTION 3.3 (EYES)
						else if (i_vcounter >= 180 && i_vcounter < 207)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 207 && i_vcounter < 213)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 361)
									r_color <= white;
                else if (i_hcounter >= 361 && i_hcounter < 367)
                  r_color <= black;
                else if (i_hcounter >= 367 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 541)
									r_color <= white; 
                else if (i_hcounter >= 541 && i_hcounter < 547)
                  r_color <= black;
                else if (i_hcounter >= 547 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 213 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
						// END SECTION 3.3 (EYES)
            
						// SECTION 3.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 3.4 (MIDDLE OF FACE)
						
						// SECTION 3.5 (MOUTH)
            else if (i_vcounter >= 300 && i_vcounter < 315)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 371)
									r_color <= yellow;
								else if (i_hcounter >= 371 && i_hcounter < 557)
									r_color <= black;
								else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 3.5 (MOUTH)
						
						// SECTION 3.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 320)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 320 && i_vcounter < 330)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 330 && i_vcounter < 340)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            // END SECTION 3.6 (TONUGE)
						
						// SECTION 3.7 (CHIN)
						else if (i_vcounter >= 340 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 3.7 (CHIN)
						
						// SECTION 3.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 3.8 (BOTTOM OF SCREEN)
					end  // FRAME_3
