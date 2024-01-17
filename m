Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA98830133
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:23:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1C1-0008Di-MP; Wed, 17 Jan 2024 03:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1Bz-00086x-Op
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:22:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1By-0006DH-9b
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:22:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so54491675e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479753; x=1706084553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5negX8TjAiTtZEJaJr1kCgnB3D++H/1aGD3/FkzTS7A=;
 b=fB7IXmULO0j6yggZwC8h86FaxVOtJhmm2fMm4qhDiZ6OEzd1AMZyDL5VUxtj4NnQ+Y
 m+8Vy7DsGCGCAsqKaY4MqbuzLzi72G4TVP+18DDTsZC8BkMHKwIzEl9asK9DkOCPk7H5
 R4oSCz6LKdrPBEbU6sRpIPvENz049i9XFwGsdh0IBNQ2kEPlesqdAusjDZ/HZstjOF1a
 ojn3jq1TEoCRB/Hh9E+TobMvLN8Ra9fms+dz1vIka2uW1ipf7Kl26IGp5BlTVrA6b9t6
 bE7efUq0OE/FBtg83lIkQQoavpaE8qZ/qalNXys44no4n9SKl6vcUZwWbVOKnZiTY+7p
 odsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479753; x=1706084553;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5negX8TjAiTtZEJaJr1kCgnB3D++H/1aGD3/FkzTS7A=;
 b=cO6meceYZMI0actPR1WvPzBz2DHNXeAsg+1+lv/ia48qNKkpbgWGCD1LPR0/C+LGoI
 tHYPNkCwJ9T4AFnUfZfvlcJjF47sUgF5NyFZiPPLRcJLiFJRDxSLRoORtzei0NxHZ1zX
 71tRWVBO53C6fbWXxYDPI+O8V2bw38f+Kvg04Ajbi7RpAbH8kITlHb/XJ/ipr/xyNADl
 ikYnpFwCnjDD6Jl8MYMK8kJVMLn7byoe70Ial8kx90TZVXzaOIcfMnTiqoNTi91EUs7w
 hT0CY5ioS9AJCTxtJPMrmoGdh3QIvoRHZaPrNCp5FWFO/Il3JGmDvbHZIdbDa8fibzoE
 mVVg==
X-Gm-Message-State: AOJu0YyN0wDn47K5fdmOH4kOTPg7OJxUo+3gVys7qEpUgoioDq+16oXN
 YlcJGzJhQINtW1hqCc7ix2B6l7SkWBJhispHrBFYy/uTQQM=
X-Google-Smtp-Source: AGHT+IFOMXLHtJMMi7iKMn0FFPe39BiQ7U+hDWOGDF0JfSN2Oz0UUwsdGpIoNh14A/KEXKovqXfjUQ==
X-Received: by 2002:a05:600c:474d:b0:40e:47f4:a3f6 with SMTP id
 w13-20020a05600c474d00b0040e47f4a3f6mr232049wmo.152.1705479752862; 
 Wed, 17 Jan 2024 00:22:32 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:22:32 -0800 (PST)
Message-ID: <371060e3-c15d-402e-860c-606193444872@linaro.org>
Date: Wed, 17 Jan 2024 09:22:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/alpha: Only build sys_helper.c on system
 emulation
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20231207105426.49339-1-philmd@linaro.org>
 <9814eab3-f50b-4240-acb5-3e0f06154ac4@linaro.org>
In-Reply-To: <9814eab3-f50b-4240-acb5-3e0f06154ac4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 26/12/23 12:17, Philippe Mathieu-Daudé wrote:
> On 7/12/23 11:54, Philippe Mathieu-Daudé wrote:
>> Extract helper_load_pcc() to clk_helper.c so we can
>> restrict sys_helper.c to system emulation.
>>
>> Philippe Mathieu-Daudé (2):
>>    target/alpha: Extract clk_helper.c from sys_helper.c
>>    target/alpha: Only build sys_helper.c on system emulation
>>
>>   target/alpha/clk_helper.c | 32 ++++++++++++++++++++++++++++++++
>>   target/alpha/sys_helper.c | 18 ------------------
>>   target/alpha/meson.build  |  7 +++++--
>>   3 files changed, 37 insertions(+), 20 deletions(-)
>>   create mode 100644 target/alpha/clk_helper.c
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Eh I meant "series queued" :)


