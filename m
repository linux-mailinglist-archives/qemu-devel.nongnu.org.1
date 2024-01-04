Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77BE8242A3
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:24:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNgv-0007Py-Al; Thu, 04 Jan 2024 08:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNgt-0007PT-Ss
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:23:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNgq-0006QM-V6
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:23:19 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d604b4b30so8695885e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704374595; x=1704979395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xmzCqV5c1vs4p/3DIrUdifQrQShB7IDP72TLYH2EaSA=;
 b=Y8MF6LnrCKswqHu3DqE8IVGyG94ZDpEZY+Ykh1J8eEoZ60wxSQH6jhSCRhKmcoXNdi
 XdtRNbX6jQeFWfcdMXJeyMTalmzY/wZTUHkpi/G9cLs0qvELWvNDM2OzdNl8APnQpzhh
 LXkFo/9ojwNMIdcgd24HDYzIRZc//8JR9ajbdpG4ck5uAfhLXtW6A67KfiIgixIGYfad
 uFsSRNw6We78Ynhfcf9s0IqMEZZ3yGAznrVRSvLFGPty0mayN+NPdYdSZIMXH8Eo7lhS
 cZDHUjaQuUxv8gqOmeZ6D9ucXMM/1p5UnW1I2PD6PayKs0H1HaSzW9uZDXwgyfKq54A0
 EjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704374595; x=1704979395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmzCqV5c1vs4p/3DIrUdifQrQShB7IDP72TLYH2EaSA=;
 b=aqa5ZGmRyWT/oUKqJ3pS9GMea9DYEigQ3ky3Ejc5iBeMsHEAMBe1JH53PfI4d4HtzN
 crzjScffW+vAD+D09Bz6AycwRebbNIYbAyc19E/QhE4t2oV7Pn4xdZWsxLr9RYVMNd8z
 LzXS7V41I7e7Wkh5Xc22lYMQLKydpTruxvDkYlkEPqf9DMeLzxvaE7fCLya87xcY+V34
 k4WHBIoiPddNWT1yi7AMD45W7yu/3BGrymwVEW/WJJqU/pzntb7+VVpA6iqDQZQPPFo6
 30JpTdKAaEuPllOgUw0vNjDVanWZCIVhaz9a089C92ks8bAO82jH1GfvUJTRmr2s51rR
 L6aw==
X-Gm-Message-State: AOJu0Yzb8mxhG7ChK8agd9DJ2m/Vy9KCiSDEXBU0owApPA+L4P2RTM56
 omZqK4/Kw0nu+6yhYYQ2x210DxnF4h0J0g==
X-Google-Smtp-Source: AGHT+IEObZ0jMN2sSyOO8OMg9qIjZF0SLOVQtLqqrc5p5VTNMwM0RXO+ZHwCjR/rb6i8NeZxjoXCXw==
X-Received: by 2002:a05:600c:c1a:b0:40d:899a:9fb2 with SMTP id
 fm26-20020a05600c0c1a00b0040d899a9fb2mr346205wmb.136.1704374595263; 
 Thu, 04 Jan 2024 05:23:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 ay10-20020a05600c1e0a00b0040d94b65342sm2502409wmb.48.2024.01.04.05.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:23:14 -0800 (PST)
Message-ID: <4d6cb918-cf05-445d-b7b3-5d180947774a@linaro.org>
Date: Thu, 4 Jan 2024 14:23:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tests/qtest: Add STM32L4x5 SYSCFG QTest testcase
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20231229164915.133199-1-ines.varhol@telecom-paris.fr>
 <20231229164915.133199-3-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231229164915.133199-3-ines.varhol@telecom-paris.fr>
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

On 29/12/23 17:47, Inès Varhol wrote:
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/meson.build             |   3 +-
>   tests/qtest/stm32l4x5_syscfg-test.c | 408 ++++++++++++++++++++++++++++
>   2 files changed, 410 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

Sitting on this commit, the test fails (because the tested
device is added in the following patch):

▶ 19/36 /arm/stm32l4x5/syscfg/test_reset 
   FAIL
▶ 19/36 /arm/stm32l4x5/syscfg/test_reserved_bits 
   FAIL
▶ 19/36 /arm/stm32l4x5/syscfg/test_set_and_clear 
   FAIL
▶ 19/36 /arm/stm32l4x5/syscfg/test_set_only_bits 
   FAIL
▶ 19/36 /arm/stm32l4x5/syscfg/test_interrupt 
   FAIL
▶ 19/36 /arm/stm32l4x5/syscfg/test_irq_pin_multiplexer 
   FAIL
▶ 19/36 /arm/stm32l4x5/syscfg/test_irq_gpio_multiplexer 
   FAIL
Listing only the last 100 lines from a long log.
**
ERROR:../../tests/qtest/stm32l4x5_syscfg-test.c:140:test_set_and_clear: 
code should not be reached
**
ERROR:../../tests/qtest/stm32l4x5_syscfg-test.c:148:test_set_and_clear: 
assertion failed (cfgr1 == 0xFCFF0101): (0 == 4244570369)
**
ERROR:../../tests/qtest/stm32l4x5_syscfg-test.c:148:test_set_and_clear: 
code should not be reached
**
ERROR:../../tests/qtest/stm32l4x5_syscfg-test.c:151:test_set_and_clear: 
assertion failed (cfgr1 == 0x00000001): (0 == 1)
**
ERROR:../../tests/qtest/stm32l4x5_syscfg-test.c:151:test_set_and_clear: 
code should not be reached
**
ERROR:../../tests/qtest/stm32l4x5_syscfg-test.c:155:test_set_and_clear: 
assertion failed (exticr1 == 0x0000FFFF): (0 == 65535)
**
...

To avoid breaking automatic bisections, first add the device, then the
test (invert patches 2 <-> 3).

Regards,

Phil.

