Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22B7BF516
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7df-0005yC-In; Tue, 10 Oct 2023 03:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7db-0005xd-EC
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:58:44 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7dY-0006lW-DN
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:58:42 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-991c786369cso891229766b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696924717; x=1697529517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Gp4Riewyv0DK95MVemP/xZYgg4pZrujFGC1uUPZXIA=;
 b=OefQaSAT+qSqTbAB4XT7tf1V7+GC3feF2T0DS3nWARvO2Y/glraSOqZPME6rn83t5L
 XYzUBLxW7CJUcktbznYHDbv5rFEvcRyn6/x+qu2hte8RrCiclOE8pPMNivCm7vIsABtq
 A0Z1RbltAMGNU3drkgjpdt9rd305qU1TZrpFjxF9JN8T3Qb1H4DESq/5+DGHbv5m/IMz
 G2SoYrvW9qcqEEj9smnVsZgErTbEzM6mE6PCsLh9mZJuU04WjDztp8ED/kGMKHiRK+6e
 tt9C/5odS0KCYL9jg6HbepdOI6sRZKgwHjOvcLou+7IJfE5RBbO6+BSknKDsUyjZj9Z0
 7bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924717; x=1697529517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Gp4Riewyv0DK95MVemP/xZYgg4pZrujFGC1uUPZXIA=;
 b=TGs9eMmY8YfZvD9yX55hjatKOGVYRmDkWP7i+GO7RVzO8gmEE0tmLEL9SIHT0diXPd
 rPzttSpAkw80IyssM+6KRp5M2PSDWzecx9kvHP0BIIwI8hbX8MLtNOYYvOo9ymoUnTCS
 2+Ulc3NrTcOUH1cSf9JmhaD/pSPcjC8m7cGMM/1s4MhKhfpK5WxZSOPB+sA0nym4bpKN
 1IGEa+8xt6LJNzqSVLKDD3RXN+gEoatRramG0FsVxZFzPG2vHShv7RnU3ia9ymnc3xXL
 Vb/oFmfLP4q1ymd6AO1i4buO3Y3/rA2xj7ZFZV3WhPFrqrx04I0BhmLXl/gFtuoJ4M0t
 Recw==
X-Gm-Message-State: AOJu0Yzjz9e79zbFo/cwFpDzLXg0BWFV6hVnxihSRYStc/V+MtZN8aGJ
 bHQQHzc3qRFl66/iJw1D7wgsBg==
X-Google-Smtp-Source: AGHT+IGk19n0GXY8/QvvDxweNnZQ+3TvIN72ca232Nboa24kcddn4cYZz39hYZF20PSyI+JguoU/Zw==
X-Received: by 2002:a17:906:57:b0:99c:c50f:7fb4 with SMTP id
 23-20020a170906005700b0099cc50f7fb4mr14242896ejg.1.1696924717425; 
 Tue, 10 Oct 2023 00:58:37 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 la18-20020a170906ad9200b0099cd008c1a4sm8034692ejb.136.2023.10.10.00.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 00:58:37 -0700 (PDT)
Message-ID: <2d455bcf-f586-52df-eb85-136bc4362d5d@linaro.org>
Date: Tue, 10 Oct 2023 09:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 08/11] tests/avocado: Add ppc MacOS tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-9-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010075238.95646-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Nicholas,

On 10/10/23 09:52, Nicholas Piggin wrote:
> Similarly to the AIX test, this adds some tests that can boot MacOS9
> and OSX images that are provided.
> ---
>   tests/avocado/ppc/macos9.ppm | Bin 0 -> 921615 bytes
>   tests/avocado/ppc_macos.py   |  90 +++++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+)
>   create mode 100644 tests/avocado/ppc/macos9.ppm
>   create mode 100644 tests/avocado/ppc_macos.py


> diff --git a/tests/avocado/ppc_macos.py b/tests/avocado/ppc_macos.py
> new file mode 100644
> index 0000000000..055fc3aca4
> --- /dev/null
> +++ b/tests/avocado/ppc_macos.py
> @@ -0,0 +1,90 @@
> +# Functional test that boots MacOS on ppc mac99
> +#
> +# Copyright (c) 2023 IBM Corporation
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import time
> +import tempfile
> +import filecmp
> +import os
> +
> +from typing import List
> +from avocado.utils import archive
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern
> +
> +class PPCMacOSTest(QemuSystemTest):
> +
> +    timeout = 240
> +
> +    def test_macos9(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:mac99
> +        :avocado: tags=device:framebuffer
> +        """
> +
> +        basedir = os.getenv('AVOCADO_TEST_BASEDIR')
> +        screenshot_path = os.path.join(basedir, 'ppc/macos9.ppm')
> +
> +        image = os.getenv('MACOS9_IMAGE')
> +        if not image:
> +            self.cancel('No MACOS9_IMAGE environment variable defined')
> +        drive_path = self.fetch_asset(image)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-M', 'via=pmu')
> +        self.vm.add_args('-m', '1g')
> +        self.vm.add_args('-cpu', 'G4')
> +        self.vm.add_args('-drive', 'file=' + drive_path)
> +#        self.vm.add_args('-net', 'nic,model=rtl8139')
> +#        self.vm.add_args('-net', 'user,hostfwd=:127.0.0.1:2223-:22,hostname=qemu')
> +        self.vm.add_args('-vga', 'std')
> +        self.vm.add_args('-g', '640x480')
> +        self.vm.launch()
> +
> +        # This comes up after 60 seconds on a fast x86 CPU. Give it
> +        # 180s to be sure.
> +        time.sleep(180)
> +        with tempfile.NamedTemporaryFile(suffix='.ppm',
> +                                         prefix='screendump-', delete=False) as ppmfile:
> +            self.vm.command('screendump', filename=ppmfile.name)
> +            if not filecmp.cmp(ppmfile.name, screenshot_path):
> +                self.fail('Screenshot does not match')
> +

Nitpicking, I'd rather use:

        @skipUntil(os.getenv('MACOS10_IMAGE'),
                   'No MACOS10_IMAGE environment variable defined')

> +    def test_macos10(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:mac99
> +        :avocado: tags=device:framebuffer
> +        """
> +
> +        basedir = os.getenv('AVOCADO_TEST_BASEDIR')
> +        screenshot_path = os.path.join(basedir, 'ppc/macos10.ppm')
> +
> +        image = os.getenv('MACOS10_IMAGE')
> +        if not image:
> +            self.cancel('No MACOS10_IMAGE environment variable defined')
> +        drive_path = self.fetch_asset(image)

Please commit the hash if the image you used.

> +        self.vm.set_console()
> +        self.vm.add_args('-M', 'via=pmu')
> +        self.vm.add_args('-m', '1g')
> +        self.vm.add_args('-cpu', 'G4')
> +        self.vm.add_args('-drive', 'file=' + drive_path)
> +#        self.vm.add_args('-net', 'nic,model=rtl8139')
> +#        self.vm.add_args('-net', 'user,hostfwd=:127.0.0.1:2223-:22,hostname=qemu')

Why is that commented? If not needed, just drop, since your test
is already useful as it.

> +        self.vm.add_args('-vga', 'std')
> +        self.vm.add_args('-g', '640x480')
> +        self.vm.launch()
> +
> +        # This comes up after 60 seconds on a fast x86 CPU. Give it
> +        # 180s to be sure.
> +        time.sleep(180)
> +        with tempfile.NamedTemporaryFile(suffix='.ppm',
> +                                         prefix='screendump-', delete=False) as ppmfile:
> +            self.vm.command('screendump', filename=ppmfile.name)
> +            if not filecmp.cmp(ppmfile.name, screenshot_path):
> +                self.fail('Screenshot does not match')


