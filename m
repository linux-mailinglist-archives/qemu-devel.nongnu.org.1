Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0337B6228
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZVh-00056c-K5; Tue, 03 Oct 2023 03:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZVe-00056Q-Vg
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:07:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZVd-0000RM-FI
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:07:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so5549315e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696316876; x=1696921676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cMSs4MZVk9TDop+GVm0UJWQX4RL0btBgCLqKO40mhfg=;
 b=qclnLzVyFyPwkhZn5LgrJrDdLRTzOYotzULZegGB/9Ke/sJ72ZjxZKKYi/5c5nIbcr
 FxDSWHxT5en/tCVRWeVP/BiQXCf4pEKn0CTdeFJlBqZfRmHwYeWbc8cgJRudDN84vxhe
 8ZBommqA0POrtRJpwErqVQQIDeuamYOWGAvA3I8+fd6TWuafoRdARnQvFFV+jw6Zrwle
 kBkagiw40Lza9/4AGv2pVxGvjwMh2zRL3JRzEP4MySEoF5kMRInjAkk6yhBRlq0Csa3U
 1yGRkRsEeH7VonAmUbrksErPxSl3fev/kVhuvqYjFlNHjTXfkLYDvc4jwuRuZM3v0A3s
 LgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696316876; x=1696921676;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cMSs4MZVk9TDop+GVm0UJWQX4RL0btBgCLqKO40mhfg=;
 b=jrYS0jIl9Mf7iqD6fIt80s4c2QM3SPwU9UW1BPqBD1A4AScGHzZwgkFSKj1emJPfpu
 rrVzMGyEDH2MSVbfQeJ8nBVpaKXKW93jvyNHJaoAlzIpGNiBDQ4sGXEYP3xq+2PSbHs9
 AIniGGNz0njFD1QsxdVpvGKhhs5/VJaWSADzNo7BUZPnJ8uVRYUhakzhhD+BgzPljMEs
 y25anxtsxJlWwDZO/YmSjn/4SbGDPWnxKAaaeLYI9l5xEDJxm5ty+yqfGUzItPYTJFCQ
 SD2dKJB25aJUihxgxldBeX/URdR0TJxSbnu1qRX6q4WRSdnGDSchr/yTfJ5DDvRdBOEz
 jtIA==
X-Gm-Message-State: AOJu0Yx8Hz19P7zJykKuTeb3K1G7kF5wdsYxQGICEey7eQEx340j/Qyj
 AlCCUmWLK49Nt2j5PnCdct0GtFoLHj/elMtSUGEmSQ==
X-Google-Smtp-Source: AGHT+IHN8jY6gxD+ITw3wLpCxocdpKPamqNm5UP5ULxJuvvqlg4iB3Q/Jw6NzqqG3tlX4yACuVc40A==
X-Received: by 2002:a7b:cb86:0:b0:402:8c7e:3fc4 with SMTP id
 m6-20020a7bcb86000000b004028c7e3fc4mr11325060wmi.30.1696316875635; 
 Tue, 03 Oct 2023 00:07:55 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b0040531f5c51asm561751wmi.5.2023.10.03.00.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:07:55 -0700 (PDT)
Message-ID: <4b7b2522-a110-57b0-5afd-97a231ca7f0e@linaro.org>
Date: Tue, 3 Oct 2023 09:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] hw/intc/apic: QOM cleanup
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow
 <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20230915162042.55890-1-philmd@linaro.org>
 <f4da7efb-f31b-8dc4-7076-320019e30163@linaro.org>
In-Reply-To: <f4da7efb-f31b-8dc4-7076-320019e30163@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 3/10/23 08:45, Philippe Mathieu-Daudé wrote:
> On 15/9/23 18:20, Philippe Mathieu-Daudé wrote:
>> Minor cleanup extracted from a bigger series
>> touching x86_cpu_realizefn().
>>
>> Philippe Mathieu-Daudé (2):
>>    target/i386: Only realize existing APIC device
>>    hw/intc/apic: Pass CPU using QOM link property
> 
> Ping?

Oops I didn't noticed I sent these patches by mistake
in another series, and Richard already reviewed them
(with comment to address):
https://lore.kernel.org/qemu-devel/a6d0175f-a343-4b1f-232f-280786e7dce3@linaro.org/

