Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97317BA54C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:16:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoR01-0001NH-MZ; Thu, 05 Oct 2023 12:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoQzx-0001Kg-5V
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:14:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoQzv-0002rp-Ds
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:14:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so10615295e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696522486; x=1697127286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9MQUSiCBEGSyxhtQdntlMCowvZ5ygMHWYMYRS0ai0LY=;
 b=Glb3eJm81tyajjqz4MO5uLwfd74VHjByX7MpGS2DSkorAv9rIbVHwoi23rCETO7Hqc
 otlk+gHHmyKYTdxPsdJPJ25TDwsImuUANSB6lqjf8EY+IuPpcihyPo4RAj/4sJz8vM7s
 i/98OZoc8vi+yQ1aloTXKOTMmkcISgaJp5EI3xxNMMKH1ee/BxwHd14YGnguDeOTTtnP
 K5sdIOdHJmKjty2bV2hjHtOXhiA/2d1OFgpTPNZkuAwAYhj4ml34hxNmFSskm4bMlY/f
 9MfwDcytXxu8HyYS3cPU2nuIQyl3VHRoDZBfyyGXJBOy1f9PJ+LVZcicoHlQTvRv4zgf
 lDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696522486; x=1697127286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9MQUSiCBEGSyxhtQdntlMCowvZ5ygMHWYMYRS0ai0LY=;
 b=HC2oGl81NQF6/av+eFOCeKT1rgQE53g1VKjUFz46jWavZF6I6RFbQf4QFH9gAAEDKv
 R34vme3rMhMyMCZgzB0iJYlcwSMA+Zov//zDvcANcq4agZ2hFgqTUeAJvSln2O/sOgdF
 FWoqFiHfGElsrwpCotdMxlWIU+C29aWA0Kc5k1K0aGBIWsSRZb00ScVlZim9xRp4TdhD
 xVjP22L2HYlhXjFAyF9C0MszQyR24bLr2DJdePD4ME6PwtrJbcpp3GP9Zi6t3es5EJsC
 Vp2bfs/DlICq1++myIDW9AheJB4IDdQyieF4WFt2FPxXXNcd75Jh4CsGVnEtt6SJteVz
 aKyQ==
X-Gm-Message-State: AOJu0Yw0sH3KuK1wA2NdN8dAwm9O2MiEw3ddiMHeucznfXkrl8AdRAqk
 OkMiG0Bar5ikvN8tbI45+JOuhg==
X-Google-Smtp-Source: AGHT+IHzZQGL+lqKMHYHLvMtTGs11gJdv7TKEKTgCzhivTSSDyuEYPv7hxpclzYqO+giFHcrGsOKvg==
X-Received: by 2002:a7b:cbc8:0:b0:406:7d74:a2a4 with SMTP id
 n8-20020a7bcbc8000000b004067d74a2a4mr5671354wmi.12.1696522485772; 
 Thu, 05 Oct 2023 09:14:45 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c025300b00401d8181f8bsm4091359wmj.25.2023.10.05.09.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:14:45 -0700 (PDT)
Message-ID: <3ff69283-ee2a-5feb-6736-93e6f3848e34@linaro.org>
Date: Thu, 5 Oct 2023 18:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 18/19] linux-user/s390x: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-19-richard.henderson@linaro.org>
 <92c8b00d-157e-6a03-7629-c331cf41ffc5@linaro.org>
 <4e1ade7c-8414-eade-6ea6-5e3fa58583fb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4e1ade7c-8414-eade-6ea6-5e3fa58583fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/10/23 01:01, Richard Henderson wrote:
> On 10/3/23 06:07, Philippe Mathieu-Daudé wrote:
>>> +++ b/linux-user/s390x/vdso.ld
>>> @@ -0,0 +1,69 @@
>>> +/*
>>> + * Linker script for linux x86-64 replacement vdso.
>>> + *
>>> + * Copyright 2023 Linaro, Ltd.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +VERSION {
>>> +        LINUX_2.6.29 {
>>> +        global:
>>> +                __kernel_gettimeofday;
>>> +                __kernel_clock_gettime;
>>> +                __kernel_clock_getres;
>>> +                __kernel_getcpu;
>>> +                __kernel_restart_syscall;
>>
>> Where is __kernel_restart_syscall defined?
> 
> It isn't, and I guess isn't needed for qemu (we have QEMU_ERESTARTSYS).
> I'm not sure why it's an exported symbol for the s390x vdso for the 
> kernel, even if they do require some user-space code.
> 
> Anyway, I'll remove the symbol here.

OK.

I dare to give:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

But still I'm Cc'ing David / Thomas who better know s390x :)

