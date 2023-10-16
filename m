Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 629087CA1B1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJ1M-0000ds-0Z; Mon, 16 Oct 2023 04:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsJ1J-0000dB-DG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsJ1D-00074l-IJ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697445126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXphkgNuPP7XRfrP2vCbRKiRKuwvw7rkNbXDo0LFtr8=;
 b=Xr/WWuomjr+mDZfZsjtiWip9g4GfVUCVfPXAX82zhKTJFrgAENpv3CnY+yryJ1CqCktifq
 bpvv3XxWXfJkyTiFm4j0Fz46H+m64Wy1VGYZFQt4PazRbIDEKlFFQr3EdhPdqUsLUndT4V
 LaFlcBZw6zo2iHaURZIXcfGzDUqvUvk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-VyORKTNaMFW5CMSGZ_ihUw-1; Mon, 16 Oct 2023 04:32:05 -0400
X-MC-Unique: VyORKTNaMFW5CMSGZ_ihUw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7770bfcbdc6so536553185a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697445123; x=1698049923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXphkgNuPP7XRfrP2vCbRKiRKuwvw7rkNbXDo0LFtr8=;
 b=K7czfgF3E3Yo84e4xY9eZtCS28BOvweZUykMmMTgj06KCCAjVxeT4WCJmNg2KKQaJH
 cNqlJ2CIuPRtGVMcXwyqLn7TxxxaGZOdyedbWQR9OxEjXLKItEuJfgWq5XSWdCeKCuuV
 natmz7TGW6jS8HCB1GIfdWhgrcIPtPXaOlpf8mtbruL2vjaBvFmzPKIJbV2QYtuF5WAr
 l24t9DuWRmRuNv+7LBRvPF0TcA5gegD1w4KJchIpIBXdq5HJubtQPs5PgZAaLi/Dj7ig
 OYkx9MGA/si7aCi/ORZLKE4KivhRcBKoZ9tuGAr59fIeywwDk8k1r8+j0LY4KDIBJsKN
 0rZw==
X-Gm-Message-State: AOJu0YxExAF5/ldj3sTr7sOqHlh5z/1YTD46KgMLMHsRqRS9ksrgPua2
 GaxuF15J458hvMMEDFWa1tn/d930JpsHhUFerfWGvYOyXHUGx96sPmOsCo2/xJ5xX2Gv5o4QEHJ
 1n4VouU9bqE9M6kQ=
X-Received: by 2002:a05:620a:2454:b0:76f:1ead:e4fd with SMTP id
 h20-20020a05620a245400b0076f1eade4fdmr40236338qkn.40.1697445122855; 
 Mon, 16 Oct 2023 01:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/6414wmsV0FCwfso9Sqt2dJlYToqUWNV5QGWxnRBJuviY6HdGLoeZttvAadFdRb/yyPyhiQ==
X-Received: by 2002:a05:620a:2454:b0:76f:1ead:e4fd with SMTP id
 h20-20020a05620a245400b0076f1eade4fdmr40236326qkn.40.1697445122578; 
 Mon, 16 Oct 2023 01:32:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 kd9-20020a05622a268900b00410a9dd3d88sm2860416qtb.68.2023.10.16.01.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 01:32:02 -0700 (PDT)
Message-ID: <ba330f83-b84f-4aa1-9855-2577596cdeb7@redhat.com>
Date: Mon, 16 Oct 2023 10:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] testing/avocado: ppc add new BookE
 boot_linux_console.py tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231010075238.95646-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/23 09:52, Nicholas Piggin wrote:
> Add simple Linux kernel boot tests for BookE 64-bit and 32-bit CPUs
> using Guenter Roeck's rootfs images for Linux testing, and a gitlab
> repository with kernel images that I built since there are very few
> sources of modern BookE images now.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/avocado/boot_linux_console.py | 53 +++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index 9434304cd3..dc3346ef49 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -1355,6 +1355,59 @@ def test_ppc64_e500(self):
>           tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
>           self.do_test_advcal_2018('19', tar_hash, 'uImage')
>   
> +    def test_ppc64_e6500(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:ppce500
> +        :avocado: tags=cpu:e6500
> +        :avocado: tags=accel:tcg
> +        """
> +        kernel_url = ('https://gitlab.com/npiggin/qemu-ci-images/-/raw/main/ppc/corenet64_vmlinux?ref_type=heads&inline=false')
> +        kernel_hash = '01051590b083fec66cb3b9e2e553e95d4cf47691'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/master/rootfs/ppc64/rootfs.cpio.gz')


I think you should use buildroot images from the qemu_ppc64_e5500 defconfig:

   https://github.com/buildroot/buildroot/tree/master/board/qemu/ppc64-e5500

The question is where to store them. I did under my GH account for PPC and
Aspeed but it is not satisfactory in the long term.

May be could have a common repo for all the buildroot QEMU boards images ?
and rebuild once a year ?

Thanks,

C.


> +        initrd_hash = '798acffc036c3b1ae6cacf95c869bba2'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                       algorithm="md5")
> +
> +        self.vm.set_console()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> +        self.vm.add_args('-smp', '2',
> +                         '-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        # Wait for VM to shut down gracefully
> +        self.vm.wait()
> +
> +    def test_ppc32_mpc85xx(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:ppce500
> +        :avocado: tags=cpu:mpc8568
> +        :avocado: tags=accel:tcg
> +        """
> +        kernel_url = ('https://gitlab.com/npiggin/qemu-ci-images/-/raw/main/ppc/mpc85xx_vmlinux?ref_type=heads&inline=false')
> +        kernel_hash = '726f7f574a491282454850b48546b3827593142b'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/master/rootfs/ppc/rootfs.cpio.gz')
> +        initrd_hash = '4d30fa93b742c493e8cf2140e49bbd9a'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                       algorithm="md5")
> +
> +        self.vm.set_console()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        # Wait for VM to shut down gracefully
> +        self.vm.wait()
> +
>       def do_test_ppc64_powernv(self, proc):
>           self.require_accelerator("tcg")
>           images_url = ('https://github.com/open-power/op-build/releases/download/v2.7/')


