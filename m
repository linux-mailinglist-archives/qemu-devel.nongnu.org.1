Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE4A7D3A1
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Apr 2025 07:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1fCD-0005ci-AK; Mon, 07 Apr 2025 01:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u1fBw-0005bo-LE
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 01:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u1fBu-0003Rd-56
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 01:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744004314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xWsJ6q2lih4yZbIGWlXQLSA1n/DWkWhH/ZyrsmSpCjk=;
 b=YYL6NaLl0zm8VBc0mCQUMaG7c9q7IrsXvUthcOGw2tLOJ5aKMmo7tIzw+3KJ6j6WnV5gNo
 6dJaooQFzrZs2UxGae+qAJX43rMA/Of+6vJp9XjBxK7oQpt2XF8y/ur+QxPMaicMd7oFtM
 hdIULQKJeZtSFSlS+yYngkl1UXn5CfU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-5R9NwWrNNd2_HqeL8rXbYw-1; Mon, 07 Apr 2025 01:38:33 -0400
X-MC-Unique: 5R9NwWrNNd2_HqeL8rXbYw-1
X-Mimecast-MFC-AGG-ID: 5R9NwWrNNd2_HqeL8rXbYw_1744004312
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e5dbd04225so3408886a12.3
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 22:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744004312; x=1744609112;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xWsJ6q2lih4yZbIGWlXQLSA1n/DWkWhH/ZyrsmSpCjk=;
 b=sJdY1Kqs944n0mU8bE8EBgvGvw1QrkynCxl01BlmGQGEjbYEKjEv6GB4AXAsigYkBQ
 yQkdQHjvoiy7J0lm8z+C4NBxHVXR5dGyhQMy78LGxuZqRWsofNaJ2CiKNf2euaK1Rw29
 XeJFnt59K5Nf3aLdbiX0nLJgpVfoz9EpB/6bIMepEWGCvpKu2PxgQM3gnc+oMjB5RgBZ
 lrxP0o/ZwEuj3IZUHUrt14T6p/OfOWIiPeQ9CwZVkShJhSTk9mb+Ytzkg6kmBTcYNaWl
 lwUd+6b/qUG1k9UfS3D13zXC/voIEE4fRMzaCrg4yjXsNn+qvF+BT5+S87N0lO6PjTju
 7wfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz4akNOfx3JfrXtMB2d+di+JtBVZiMw4pgusdmFB+vY50rHu/MzwoZsunAfeyjAtl2T/fp/fiQCLEr@nongnu.org
X-Gm-Message-State: AOJu0YyBlIq7Nh43gMLXaB5FzoCl9TLvl6xBIPTKbT/PGUnvH5eruQ+F
 oKDbcNwp5PdBoUZFEfSNhBOBWm1K8NSaRNaqxZJQhcHBm5hDy/OAiehxPJqBc9yARo07gBqNjO/
 fs1Mdosr49hXPKOYWuVFJ4NpdjKandVko2m7JHsjP8/wHoa2vlVXK
X-Gm-Gg: ASbGncsa3gs8wWVUYAc4spf5iJwRA531zEB1ugqRFCbgdiJ2tDVJrY3Vsks194gteO/
 W6p9xRPLf9RkURWdnKClRj8o+TqFoku6mtBTyL6UX64bIeRI9TMv8Ae7xHxbZh35k6iNMbcWEi5
 vSN1VkWC9k2TEGOEVndZwbGVbiKMbEZQu7+cb4FJQMJzttVfPwFDyQDqVeOQTKbxfxk+PQePLaP
 0TDltz3IyHaF86O01BvXZK6GaUzPKgaJAZ8k408mIzBV3g9O1PHIC6w/wWDknfRdGinfBMbn1L0
 sYB/o8leXwIXyjqKdo41dRfLqiL7yFFFrtinL3scTrNX
X-Received: by 2002:a17:907:2d2c:b0:ac7:b368:b193 with SMTP id
 a640c23a62f3a-ac7d6d630bdmr1081010166b.27.1744004311765; 
 Sun, 06 Apr 2025 22:38:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWMx4vys66lb7tOmRGB0tzmPs38wKEfILvZ6IIqMBehSwiiPfDWux1+8DmwtnbSeIBogK32A==
X-Received: by 2002:a17:907:2d2c:b0:ac7:b368:b193 with SMTP id
 a640c23a62f3a-ac7d6d630bdmr1081008166b.27.1744004311349; 
 Sun, 06 Apr 2025 22:38:31 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-76.web.vodafone.de. [109.42.51.76])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe9adfdsm697321466b.62.2025.04.06.22.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 22:38:30 -0700 (PDT)
Message-ID: <122aaf9e-cb4c-4117-90ae-2803f4810700@redhat.com>
Date: Mon, 7 Apr 2025 07:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/3] tests/functional: Add test for imx8mp-evk
 board with USDHC coverage
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250405214900.7114-1-shentey@gmail.com>
 <20250405214900.7114-2-shentey@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250405214900.7114-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

  Hi!

On 05/04/2025 23.48, Bernhard Beschow wrote:
> Introduce a functional test which boots Debian 12 on the imx8mp-evk board. Since
> the root filesystem resides on an SD card, the test also verifies the basic
> operation of the USDHC.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   MAINTAINERS                                 |  1 +
>   tests/functional/meson.build                |  1 +
>   tests/functional/test_aarch64_imx8mp_evk.py | 69 +++++++++++++++++++++
>   3 files changed, 71 insertions(+)
>   create mode 100644 tests/functional/test_aarch64_imx8mp_evk.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f8..4ceffa89dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp.h
>   F: include/hw/misc/imx8mp_*.h
>   F: include/hw/pci-host/fsl_imx8m_phy.h
>   F: docs/system/arm/imx8mp-evk.rst
> +F: tests/functional/test_aarch64_imx8mp_evk.py
>   F: tests/qtest/rs5c372-test.c
>   
>   MPS2 / MPS3
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 0f8be30fe2..aaaf3472f1 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -75,6 +75,7 @@ tests_aarch64_system_quick = [
>   
>   tests_aarch64_system_thorough = [
>     'aarch64_aspeed',
> +  'aarch64_imx8mp_evk',
>     'aarch64_raspi3',
>     'aarch64_raspi4',
>     'aarch64_replay',
> diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
> new file mode 100644

The test files should be executable so you can run them directly (after 
setting PYTHONPATH and QEMU_TEST_QEMU_BINARY)

> index 0000000000..5419d3c525
> --- /dev/null
> +++ b/tests/functional/test_aarch64_imx8mp_evk.py
> @@ -0,0 +1,69 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +
> +class Imx8mpEvkMachine(LinuxKernelTest):
> +
> +    ASSET_IMAGE = Asset(
> +        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
> +         'debian-12-generic-arm64-20231210-1590.tar.xz'),
> +        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
> +
> +    KERNEL_OFFSET = 0x51000000
> +    KERNEL_SIZE = 32622528
> +    INITRD_OFFSET = 0x76000000
> +    INITRD_SIZE = 30987766
> +    DTB_OFFSET = 0x64F51000
> +    DTB_SIZE = 45 * 1024
> +
> +    def extract(self, in_path, out_path, offset, size):
> +        try:
> +            with open(in_path, "rb") as source:
> +                source.seek(offset)
> +                data = source.read(size)
> +            with open(out_path, "wb") as target:
> +                target.write(data)
> +        except (IOError, ValueError) as e:
> +            self.log.error(f"Failed to extract {out_path}: {e}")
> +            raise
> +
> +    def setUp(self):
> +        super().setUp()

Is there any special reason for overriding the setUp function here? ... 
otherwise, I think this could also simply be done from the 
test_aarch64_imx8mp_evk_usdhc function instead?

> +        self.ASSET_IMAGE.fetch()

I think you can omit the fetch() here, it should be handled by 
archive_extract() already. At least that's what we're doing in the other 
spots that use archive_extract().

> +        self.archive_extract(self.ASSET_IMAGE)
> +
> +        self.image_path = self.scratch_file("disk.raw")
> +        self.kernel_path = self.scratch_file("linux")
> +        self.initrd_path = self.scratch_file("initrd.zstd")
> +        self.dtb_path = self.scratch_file("imx8mp-evk.dtb")
> +
> +        self.extract(self.image_path, self.kernel_path,
> +                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
> +        self.extract(self.image_path, self.initrd_path,
> +                     self.INITRD_OFFSET, self.INITRD_SIZE)
> +        self.extract(self.image_path, self.dtb_path,
> +                     self.DTB_OFFSET, self.DTB_SIZE)
> +
> +    def test_aarch64_imx8mp_evk_usdhc(self):
> +        self.set_machine('imx8mp-evk')
> +        self.vm.set_console(console_index=1)
> +        self.vm.add_args('-m', '2G',
> +                         '-smp', '4',
> +                         '-accel', 'tcg',

The imx8mp-evk board has a "depends on TCG" in its Kconfig file, so I think 
you could omit "-accel tcg" here (but it also does not hurt to be explicit, 
I guess).

  Thomas


> +                         '-kernel', self.kernel_path,
> +                         '-initrd', self.initrd_path,
> +                         '-dtb', self.dtb_path,
> +                         '-append', 'root=/dev/mmcblk2p1',
> +                         '-drive', f'file={self.image_path},if=sd,bus=2,'
> +                                    'format=raw,id=mmcblk2')
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Welcome to ')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


