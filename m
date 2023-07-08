Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A774BE97
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 19:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIBhh-0004jR-MJ; Sat, 08 Jul 2023 13:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIBhf-0004jJ-PR
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:26:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIBhe-0001q1-8X
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:26:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2947176f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688837196; x=1691429196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8YVE9sjUHrgnyVAngHiCymdXEFiamEXqLzlYlxl3xds=;
 b=bIjM4qwv07UjeJcq3Weldx7U3x9a0eG3kzSmzMekA6fOXV7jZmqcQ7qinHYuEwMKMY
 OMT2aD6uQZa5LS4ySOyAmLHJXrPQONFzqltB0e2oo95CRVXJbKM0deHeUQdHmevMl2K3
 8Gm1Eo9ra4iDJXhaY+reG649vQWeuIpru1Ec2yg+x5tOQMJSof8WR+gfd4f+80sfCShQ
 IIpQgWm4aV/A/f26SCfkDUN68W516D48V4ZaYI2WGs+an1oEMe4yOqTGbGTmxxZrxG7s
 whRGOedfHa6QAKrvlrmG4X4RySJZlUoorCTvbHQ3TkBHt4UAx61c16dd2ft25E/jV5ss
 xqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688837196; x=1691429196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8YVE9sjUHrgnyVAngHiCymdXEFiamEXqLzlYlxl3xds=;
 b=VDN8jppIQJ3lKzJM4roTiRvNIdCKvbAxPAFvo3d6x/FLycS0im0/kDuuaVWpWyd4T0
 oG+wWgYdT6/E6hEaGEq2RLnnRujlqPGfbF4Ws9ml+zx9VwER0yfKGW4SnVXA+mMkTnoD
 NGl8p5vdqwpAfFMSh/tpbdjuRx9G/Yn3kDPnwK056IyUl7dhQKl99NA02Ewk2/GCvInH
 /gfTwl1YAu3Dop+rIcLibwS0oDVfhHoCk00QnrEYDVWm6i8+Hif0UeSew7TTNTfvYGRD
 jWOI4Ip/1Tq87UnwBVvDgxqjRnTASjU8bOqqy9505w1ynyoq5YZ5cIDHPSJok0urGHuy
 2YuQ==
X-Gm-Message-State: ABy/qLYMylWiNDWc8emI2hTYuSSKyqMnk4zuc5ufTncZ9beSYHJHBJij
 RyKvj/EafojtRvDvXL5V+Iv1RA==
X-Google-Smtp-Source: APBJJlHS1UjJydR7+KMLnYPZR49XwhejQaKnhhIzBTFDpN71eXe9CbcjYbcg/TB3dkPxvBwg53NQdA==
X-Received: by 2002:a05:6000:1151:b0:315:8a13:ef16 with SMTP id
 d17-20020a056000115100b003158a13ef16mr3261265wrx.69.1688837196470; 
 Sat, 08 Jul 2023 10:26:36 -0700 (PDT)
Received: from [192.168.8.133] ([148.252.133.210])
 by smtp.gmail.com with ESMTPSA id
 c3-20020adfef43000000b003141e9e2f81sm7442621wrp.4.2023.07.08.10.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 10:26:36 -0700 (PDT)
Message-ID: <0110c2c4-e9de-a2d0-5c0a-6831415beb9f@linaro.org>
Date: Sat, 8 Jul 2023 18:26:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user: make sure brk(0) returns a page-aligned value
To: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <mvmpm55qnno.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmpm55qnno.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/6/23 12:34, Andreas Schwab wrote:
> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 08162cc966..e8a17377f5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -805,7 +805,7 @@ static abi_ulong brk_page;
>   
>   void target_set_brk(abi_ulong new_brk)
>   {
> -    target_brk = new_brk;
> +    target_brk = TARGET_PAGE_ALIGN(new_brk);
>       brk_page = HOST_PAGE_ALIGN(target_brk);
>   }
>   

It make sense, since that's how do_brk aligns things.
I'm curious why this error might have produced host memory clobbering, but I'm not going 
to debug that.

Queuing for tcg/linux-user.


r~

