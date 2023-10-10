Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B17BFAB5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBSe-0005YB-Iy; Tue, 10 Oct 2023 08:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBSZ-0005WY-Ua; Tue, 10 Oct 2023 08:03:36 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBSX-0002G5-Hv; Tue, 10 Oct 2023 08:03:35 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-41810cfc569so36345901cf.2; 
 Tue, 10 Oct 2023 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1696939412; x=1697544212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UjMsoVfzXm5UEvfKcB0doLx38ktljFpCglqxJHImJ0Q=;
 b=lE3vYDjBaSEPZ+WwF6Slj661briEyC/i1FE4K0woZLXHNoe0uQunBZ7rwlwcp4lLNA
 RocLmzceP4x/4XV3iJMCf95iA+LCwqgW3VXr4CbvzeFJwJ9IYArz0YbX+4zeRSxWfl9Y
 T6gRpYkEJwC0Yvs1g8Kezt5GlFngcZMrJxv+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696939412; x=1697544212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UjMsoVfzXm5UEvfKcB0doLx38ktljFpCglqxJHImJ0Q=;
 b=Db98rx4JMGvu70SxDj+mjuYPCNlgvcvxlN4AKdwJ9SMQ7gZ+pGMjdT7oqmZphXc7cn
 Gx2TCbwm/fMtd9MbWsajTO0l7zdjIOdNwST4TALnZKb0m94k5JGVdMbvPvt4rPDTV9vI
 4ruWF/u32wx/DYVqodbnjmQHoUshzqNo/wb1o+SrugxdiSWk+O8Lj2dVYskDtoz/jxwy
 NHhQ9cMJvdXPUhLCVPlzN6MN7riD3okOFn4buB36lHF6JMhYGP7e8Q6dCrCdOt0hXZTO
 yMbQfGbkl+o6NyzIrW3FX6F7KFt+6KmQXpWBXxIsDb7uPuUOsisfYQ7CDVvf9lNt+cak
 OllA==
X-Gm-Message-State: AOJu0YyrEkfL97CJWS0WphUQ53XwEDTozR23xZLfwFZe0VaimeCB6M8l
 +Wm1MlNXlPI6xmGV42O1tW95MZdVl1pfNuIxjxo=
X-Google-Smtp-Source: AGHT+IGe4pq4oPgZ1YZrZ2e1oCsMxAy7g3TGEYpVyJUu1rdWN4ZXK0avMbo6uu0gdC8XOVaGZ9W/VPtt/farRd5oRhE=
X-Received: by 2002:a05:622a:1711:b0:418:875:c330 with SMTP id
 h17-20020a05622a171100b004180875c330mr23292181qtk.42.1696939411733; Tue, 10
 Oct 2023 05:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-6-npiggin@gmail.com>
In-Reply-To: <20231010075238.95646-6-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 10 Oct 2023 22:33:18 +1030
Message-ID: <CACPK8XcS05gQemgRKFTvhAaQzDLg+5MKH0sVyuU=pOs=Oo_=SA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/11] testing/avocado: ppc add new BookE
 boot_linux_console.py tests
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=joel.stan@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 10 Oct 2023 at 18:23, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Add simple Linux kernel boot tests for BookE 64-bit and 32-bit CPUs
> using Guenter Roeck's rootfs images for Linux testing, and a gitlab
> repository with kernel images that I built since there are very few
> sources of modern BookE images now.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Should we get mpe to add a https://github.com/linuxppc/qemu-ci-images
for you to keep those kernel images? But perhaps you'd prefer to keep
them on gitlab. Just a suggestion.

> ---
>  tests/avocado/boot_linux_console.py | 53 +++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index 9434304cd3..dc3346ef49 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -1355,6 +1355,59 @@ def test_ppc64_e500(self):
>          tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
>          self.do_test_advcal_2018('19', tar_hash, 'uImage')
>
> +    def test_ppc64_e6500(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:ppce500
> +        :avocado: tags=cpu:e6500
> +        :avocado: tags=accel:tcg
> +        """
> +        kernel_url = ('https://gitlab.com/npiggin/qemu-ci-images/-/raw/main/ppc/corenet64_vmlinux?ref_type=heads&inline=false')

Is the ref_type?heads=inline-false required? I seem to get the file
successfully with wget and those omitted.

> +        kernel_hash = '01051590b083fec66cb3b9e2e553e95d4cf47691'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/master/rootfs/ppc64/rootfs.cpio.gz')
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
>      def do_test_ppc64_powernv(self, proc):
>          self.require_accelerator("tcg")
>          images_url = ('https://github.com/open-power/op-build/releases/download/v2.7/')
> --
> 2.42.0
>
>

