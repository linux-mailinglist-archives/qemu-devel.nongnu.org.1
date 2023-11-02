Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F4B7DEE91
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 10:01:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyTYR-0001Sl-Oe; Thu, 02 Nov 2023 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qyTYP-0001SO-Qm
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:59:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qyTYO-0006xV-6C
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:59:53 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso1003656a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698915589; x=1699520389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axEpUD5ZalmuHlQ/gJOtEbUrZJCl8M+Ba/fkUMm/LLA=;
 b=Zr3VUIHSKvLdBxzBEzpUzLIWtFT3ZFWG+0qS3ioo/8KGa9GmBKvardejCgG5B+qtv2
 JOcT23YQRAH6KLbF7kPUUrxKF0SAT0P+ooFtxhmRmQQiZiGAxVpJR5ufOXIcwJB3ZX3T
 3JUvNmR4bwEYNAAabI1FfdtLlU/yDiINjfjgqqxOZoZ3p9AwqCOFOms9O9nKqo8zfu9Q
 2vCDjiB8p6xa6SS0eyqpnWbPs539XS3e/ecQD2/3gVvnIwK/MB+1Klui4iNL/8gB06EG
 EBrqPpVVpoRFsvhrqmEEWN8JStWWREnU0MtOrqDMCXTyMfZeUJ7M6hqMLFONiGgzVL/s
 kRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698915589; x=1699520389;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axEpUD5ZalmuHlQ/gJOtEbUrZJCl8M+Ba/fkUMm/LLA=;
 b=fYLTSXwtrVYLmthPWmKAVWjjll+ZE9Co1frM0fVezW+N7jFslBSB5HcvfS/8GiPZDH
 vJ0MLPJG8da2tjUPS1uTQba2VlRnuYUk1cLXHs71AFL2zSoTrMfCc8QN9hW+ApqTbUR+
 Xnc+rEMj1vIJyrWW6G829Z4OEOeEue0kG6iIKo7wZx5S6f3so5+NommjWtv7O2+P3Tvg
 MSLLH3/E7Z4XWYt6/EIL2tCMyhxdwhaVuxviVfMyEk8PTZLpK5SYSYW4e9InFuZ9YQy/
 IUFaDeBMDVadseu5wpQW/bhKAJD8UQhxuj54sLIxkOmFucXcttgBre1UbBN1ewX9KxH3
 2RXQ==
X-Gm-Message-State: AOJu0Yy0tARU6Tb8/o+2CiZ0UG2Kptg94UywnmCv8yTtHO02J4MiWB3D
 ilzHvx366gmeiDEyDRSxTbl1xaiwPeOzFp8JFgM=
X-Google-Smtp-Source: AGHT+IHvvG+iKzgStTRAIdeC1u3E3eF0z08xd26az7r0bRTOoDqp1nDqxGV64oOn+DkS38QD3+dP5A==
X-Received: by 2002:a05:6402:8ce:b0:53e:72be:2b31 with SMTP id
 d14-20020a05640208ce00b0053e72be2b31mr11618140edz.42.1698915589440; 
 Thu, 02 Nov 2023 01:59:49 -0700 (PDT)
Received: from [192.168.69.115] (176-131-219-113.abo.bbox.fr.
 [176.131.219.113]) by smtp.gmail.com with ESMTPSA id
 q23-20020a50aa97000000b00522828d438csm2098617edc.7.2023.11.02.01.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 01:59:49 -0700 (PDT)
Message-ID: <326cbd53-7425-15bb-3808-5296ba7cb493@linaro.org>
Date: Thu, 2 Nov 2023 09:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ui/sdl2: use correct key names in win title on mac
Content-Language: en-US
To: Adrian Wowk <dev@adrianwowk.com>, qemu-devel@nongnu.org
References: <20231030024119.28342-1-dev@adrianwowk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231030024119.28342-1-dev@adrianwowk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.777,
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

On 30/10/23 03:41, Adrian Wowk wrote:
> Previously, when using the SDL2 UI on MacOS, the title bar uses incorrect
> key names (such as Ctrl and Alt instead of the standard MacOS key symbols
> like ⌃ and ⌥). This commit changes sdl_update_caption in ui/sdl2.c to
> use the correct symbols when compiling for MacOS (CONFIG_DARWIN is
> defined).
> 
> Unfortunately, standard Mac keyboards do not include a "Right-Ctrl" key,
> so in the case that the SDL grab mode is set to HOT_KEY_MOD_RCTRL, the
> default text is still used.
> 
> Signed-off-by: Adrian Wowk <dev@adrianwowk.com>
> ---
> Hi! I created this patch after having to compile QEMU from source with the SDL UI enabled to avoid an unrelated bug in the Cocoa UI. I noticed that the title of the window was not correct so I added a quick fix. I have tested this change on MacOS Sonoma (Version 14.1), and it works as expected. I did my best to ensure correctness, but this is my first time contrbuting to QEMU (and also my first time sending git patches over email), so if there is anything I can do better then please let me know. Thank You!

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And patch queued, thank you for your contribution!

> 
>   ui/sdl2.c | 8 ++++++++
>   1 file changed, 8 insertions(+)


