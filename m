Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A30EC7F2705
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:12:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5LrK-0003TP-62; Tue, 21 Nov 2023 03:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5LrH-0003Sv-5W
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:11:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5LrF-0000VE-Ew
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:11:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b26d700a1so4603055e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700554303; x=1701159103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Y8iJLzZgVQddiNZxqZdU2o2KVrvF73/lYzKKDQsnis=;
 b=C2Sufqgw3s0rolNBabjnGnWb7Ie/09kiiSC75W1mOr9ytYO3/gRpX7rFxzt2o1YEC4
 JOV/6NC2KV6xbtXr2hJU0BM64/I49mMBB0XhgKh6MqnboS8HaSqj0+O8XtcG8PJjWbfI
 TBbN0G5IULfPqewc6QQy0E971a+KeDm3xxdpfthxwc1+vBUCbAw3ODdfjzwagmv9NIik
 vhZvexhCWu/20I+Mpt6Sg8Ic9VoHPRyyNVYUQDfOTr8bQ052Gta9XB0bQCNlVXVYXRVC
 DCz17niYlx5aQCKjJ+O+9dFFIScmUevFBlD2kGlxZIyXtR2XQtYtFDpGRz4oG9uD7H+Q
 UF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700554303; x=1701159103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Y8iJLzZgVQddiNZxqZdU2o2KVrvF73/lYzKKDQsnis=;
 b=pLhmSA9i4j+H70MYtH0ugoLc6kn5CbZkbB/E5MDbQkdmajKbnYzu1Shaa3itiIeroR
 r4Ci2zLuDKTYtRprxCGBeMVWF97MieUfX/Kvo5tAyaOVDD033ORpVJTluQ9Kkmhvdaro
 CUp/twlpWQKhK0QUaYYufK8mgCLgR+tY2pAx6QoGURyGa+ADmdTt+NmxNj/UJ2XBDw2Y
 Or1ILjqOHgGb+MU2ug0TgL6F6cEfqC7BCyaEV0sUik0nzz11ILgdvMiall02jYM3Jmop
 lkjbfbFe9AzM1iU7Pr/JDPPluo8XNiKFGSBBR3bfessQSukcIJ2oYz/d0LpWulwH0Gs4
 O2wA==
X-Gm-Message-State: AOJu0Yw5AGJwl34Z8kHE4mcyuSEoSl1DJx2d4WQWb8mYDpT2wbzqZX14
 f2ZQ2S+rPMSwOSL2P3PbTWS6VQ==
X-Google-Smtp-Source: AGHT+IGW5M9SEzNZVGOlYfn21Ax29uHnr1dDdFI+dGhEwpVIsV4B4LcndOQpxS7Ci81dEwcn3MACDA==
X-Received: by 2002:a05:600c:3103:b0:40a:20f3:d126 with SMTP id
 g3-20020a05600c310300b0040a20f3d126mr6688351wmo.6.1700554303060; 
 Tue, 21 Nov 2023 00:11:43 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c510700b0040b2ae9ef5dsm704776wms.36.2023.11.21.00.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 00:11:42 -0800 (PST)
Message-ID: <bc92d36f-7dcd-461e-a151-4a6e5bd072ad@linaro.org>
Date: Tue, 21 Nov 2023 09:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2?] hw/arm/fsl-imx: Do not ignore Error argument
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-arm@nongnu.org
References: <20231120115116.76858-1-philmd@linaro.org>
 <CAFEAcA-YRPL_UOu5JPwfY4yRU=USk678JayDjqL=DKQjv+SWWw@mail.gmail.com>
 <87learmww9.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87learmww9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Markus,

On 21/11/23 07:40, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 20 Nov 2023 at 11:51, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> Both i.MX25 and i.MX6 SoC models ignore the Error argument when
>>> setting the PHY number. Pick &error_abort which is the error
>>> used by the i.MX7 SoC (see commit 1f7197deb0 "ability to change
>>> the FEC PHY on i.MX7 processor").
>>>
>>> Fixes: 74c1330582 ("ability to change the FEC PHY on i.MX25 processor")
>>> Fixes: a9c167a3c4 ("ability to change the FEC PHY on i.MX6 processor")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>
>>
>>
>> Applied to target-arm.next, thanks.
> 
> With or without my commit message clarification?

I didn't get your email on this patch, but per the other
ones on similar fixes:
https://lore.kernel.org/all/87cyw3mu4r.fsf@pond.sub.org/
https://lore.kernel.org/all/87il5vlemo.fsf@pond.sub.org/
I assume you want:

   Both i.MX25 and i.MX6 SoC models ignore the Error argument when
   setting the PHY number with object_property_set_uint(). If this
   @errp argument is set, its following use via sysbus_realize()
   might potentially triggers an assertion in error_setv().

   Pick &error_abort which is the error used by the i.MX7 SoC (see
   commit 1f7197deb0 "ability to change the FEC PHY on i.MX7 processor").

If that is OK with you, Peter, do you mind updating the description?

Thanks both!

Phil.

