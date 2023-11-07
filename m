Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA17E3C2B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:13:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KwU-0005M2-Ss; Tue, 07 Nov 2023 07:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KwT-0005Jp-1x
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:12:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KwO-0002Ep-N4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:12:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so48186875e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699359139; x=1699963939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cuzo9aA7mWUZvzO99aptSJSRrVMCSXHyguEIR5yP5nI=;
 b=K/K6v1sAvThWIQf5djyYlLYwpdesqjAWAsyrTYty6y749eQzA6CM/R7VSEENGuUfD4
 hcbiNls8KHAoweDyTXbF22tQk7UbfevYLywqPFBVTYvTTJ0tX+Vf6sY/eayE76zuYYdV
 AENP5laUsRpnTVvtTOlEewtSmQEhItc3jP6MCxr1Z1MPwPtDhGwI3uQd4+FaF1DuTw9E
 QAjSb9b39+V0WUVFIqVAXliMvbQYVKBuB/w+OVuLYbQnxMYRpxD5w29eII9Mvkg5cS49
 oQBYZ3Dtj2cXiZAyXcYk+YhUsTqwo+7gPhucVGY1oHYqLuXFL7KxMCbFx3KSz1DvDlkp
 onlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359139; x=1699963939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cuzo9aA7mWUZvzO99aptSJSRrVMCSXHyguEIR5yP5nI=;
 b=Sa9cWlx/0wRtTtg+6tk0ON9374lKBtlbmm/bzlUlWlCsAcBBAKNwdz+9EaOhN/K8qn
 yDEnxvxDu4lP9zn51Pc7xXRxAGV7TALQcJXG8NBPu5F8pnTZ+YB0d3R0d/G3QSwOSOXg
 J3zNUIwJLn7834BtU2GsgVT11w7a5gSZ1fvdhYV17a3RCXT3jGP6X9ogW0JYq4xCkbHk
 fjh/34ZAbSp7cXMiVGWQbuZQohlD+QMfhl/V45ANVUD7Za+iBG6xt6f1db4bSV1vU7Zs
 g/GCmLyjDDtPyZ5EbILkm721UICxJpsIPBt9bIy1oDZQo/+zq9D8m9g2pUmzgDOIFp7f
 n1sg==
X-Gm-Message-State: AOJu0YzO4aWipSHaki+olhWF3q+e+lrVyofA4U0BOHtqArDgpWNMF4Tv
 yNYv9cRc3OqhSsO8BlgCSpRonw==
X-Google-Smtp-Source: AGHT+IGox+I8lMCGkMX/3Xzmd/027apFYrMuw4Wg9J/YX30GFNWE//RJ6Fvt87kFJCbZgplzxgRmkA==
X-Received: by 2002:a05:600c:19c8:b0:401:be5a:989 with SMTP id
 u8-20020a05600c19c800b00401be5a0989mr2119031wmq.23.1699359139062; 
 Tue, 07 Nov 2023 04:12:19 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c314f00b004094d4292aesm15339775wmo.18.2023.11.07.04.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 04:12:18 -0800 (PST)
Message-ID: <dc17be3c-5520-4636-a826-f112078b323b@linaro.org>
Date: Tue, 7 Nov 2023 13:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/s390x/cpu: Restrict CPUS390XState declaration
 to 'cpu.h'
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231106114500.5269-1-philmd@linaro.org>
 <c53fd7bd-b9ea-43d4-8d1b-b7acdeef0f90@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c53fd7bd-b9ea-43d4-8d1b-b7acdeef0f90@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 7/11/23 11:44, Thomas Huth wrote:
> On 06/11/2023 12.44, Philippe Mathieu-Daudé wrote:
>> In order to restrict CPUS390XState declaration to "cpu.h" (both
>> target-specific):
>> - have the following prototypes take a S390CPU* instead:
>>    . css_do_sic()
>>    . sclp_service_call()
>>    . sclp_service_call_protected()
>> - restrict cpu_get_tb_cpu_state() definition to TCG
>>
>> Philippe Mathieu-Daudé (4):
>>    hw/s390x/css: Have css_do_sic() take S390CPU instead of CPUS390XState
>>    hw/s390x/sclp: Have sclp_service_call[_protected]() take S390CPU*
>>    target/s390x/cpu: Restrict cpu_get_tb_cpu_state() definition to TCG
>>    target/s390x/cpu: Restrict CPUS390XState declaration to 'cpu.h'
> 
> Patches look reasonable. Thanks, queued them now!

Thanks, since I wasn't sure the series would be reviewed in time for
soft freeze, I didn't mention it would be more convenient for me to
take it via my hw-misc tree. Since you kindly reviewed it, I'll take
it :) Thanks!

Phil.

