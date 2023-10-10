Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 835347BFBB3
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqC7y-0004eB-VF; Tue, 10 Oct 2023 08:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqC6L-0004QM-6r
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:44:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqC6E-0002I1-Rn
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:44:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40537481094so52113865e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696941872; x=1697546672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETBJ9AwKpa+8ZXMMmgrItwWCD/hOf7Sp9mED3zsx2SU=;
 b=qvYP+Mj6C1eMWiPNN3hUNGBbrcfJpzvTtzLX+KIESxHZ2LLdgmWh71QGcYGDrzgW1E
 02WUIVWEwvN+d7LFA6v81yhRyRwUny4G//VwFqTrP6GFx/GjTtbR44lKYL73ro+2gbZK
 kPEvNzVPKBJDUtn61Lmpz9dN+02joPxEd4icBb6tChcBbYtFM9i4TOUitrMFCz+kp1aX
 xshZyem3t860bHQ9LFYnqQhmn+rZqgJiesqXKmOMl3Qwyg9ao4B0v5F0Qu05qs/4JtGq
 hBmkgGBZuk7XY2oZo3Vq8MAEr5ZJHo+KLGnjKEO7soMVGz5YXRPxIIz4bFM6gAaRYtED
 06Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696941872; x=1697546672;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ETBJ9AwKpa+8ZXMMmgrItwWCD/hOf7Sp9mED3zsx2SU=;
 b=h03uvFu4BQT8H3eQDsVIACh2mIU0HWwHgov1nJk05ieWfqn0MwEUF4mxd4QRvvPoo5
 mEiz3t448FByN+ZJa2qPeXPw0ygVzlzeUjSVe2LdtKur6z/EUrKZtVV+FUxD875cq5es
 yin3O3KYuN37NGZ64BwYiUfH1t6MR8lpCEQdtaQRiEhAQjQvqwhZ3VSN6fBDlPyeV+nZ
 Mx3ykl8pLyJRh9ak4ZWDAwvWYX2BmndewDktkW3l2FxFrVMxSKt9mQ0os7P+7Y0/9ELA
 bvJECH+sIa9vdrV1DFstqcksrUw3j+jIlVMVaYhUOP46jAa0KtiZenheGC4MvkChHeG1
 i7Bw==
X-Gm-Message-State: AOJu0YwRAFXC+CAGfj3oV25JO4PYqMFjtIJhEXX64q7Y0jt7jFVU73iJ
 SwXO8no670w53R+6D9WNCxEdUg==
X-Google-Smtp-Source: AGHT+IFzmgmTSVOZPEpkPro2RsqRHyNW+2MXFBtAACi1mgvyhSsPFQodLEJfxiHKdZy2HIRB/ucUEA==
X-Received: by 2002:a05:6000:1f87:b0:32d:24c7:a268 with SMTP id
 bw7-20020a0560001f8700b0032d24c7a268mr1736289wrb.4.1696941872633; 
 Tue, 10 Oct 2023 05:44:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a5d54ce000000b0031773a8e5c4sm12675338wrv.37.2023.10.10.05.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:44:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A62F1FFBB;
 Tue, 10 Oct 2023 13:44:31 +0100 (BST)
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-8-npiggin@gmail.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 07/11] tests/avocado: Add ppc boot tests for
 non-free AIX images
Date: Tue, 10 Oct 2023 13:43:16 +0100
In-reply-to: <20231010075238.95646-8-npiggin@gmail.com>
Message-ID: <87h6mypryo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Nicholas Piggin <npiggin@gmail.com> writes:

> An AIX image can be provided by setting AIX_IMAGE environment
> variable when running avocado.
>
> It's questionable whether we should carry these in upstream QEMU.
> It's convenient to see how to run these things, but simple enough
> to maintain in out of tree branch. I just wanted to see opinions
> about it.

Yeah there is no point adding a test no one else can run. We already
have tests that utilise dead URLs that can only run if you happen to
have the image in the avocado cache which should arguably be removed.

> ---
>  tests/avocado/ppc_aix.py | 63 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 tests/avocado/ppc_aix.py
>
> diff --git a/tests/avocado/ppc_aix.py b/tests/avocado/ppc_aix.py
> new file mode 100644
> index 0000000000..b8d5d4cc38
> --- /dev/null
> +++ b/tests/avocado/ppc_aix.py
> @@ -0,0 +1,63 @@
> +# Functional test that boots AIX on ppc pseries TCG and KVM
> +#
> +# Copyright (c) 2023 IBM Corporation
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +from avocado.utils import archive
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern
> +
> +class pseriesMachine(QemuSystemTest):
> +
> +    timeout =3D 600
> +
> +    def do_test_ppc64_aix_boot(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        """
> +
> +        image =3D os.getenv('AIX_IMAGE')
> +        if not image:
> +            self.cancel('No AIX_IMAGE environment variable defined')
> +
> +        _hash =3D os.getenv('AIX_HASH')
> +        if _hash:
> +            aix_disk =3D self.fetch_asset(image, asset_hash=3D_hash)
> +        else:
> +            aix_disk =3D self.fetch_asset(image)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-machine', 'ic-mode=3Dxics',
> +                         '-smp', '16,threads=3D8,cores=3D2',
> +                         '-m', '4g',
> +#                         '-device', 'spapr-vlan,netdev=3Dnet0,mac=3D52:=
54:00:49:53:14',
> +#                         '-netdev', 'tap,id=3Dnet0,helper=3D/usr/libexe=
c/qemu-bridge-helper,br=3Dvirbr0',
> +                         '-device', 'qemu-xhci',
> +                         '-device', 'virtio-scsi,id=3Dscsi0',
> + '-drive',
> f'file=3D{aix_disk},if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,cache=
=3Dnone',
> + '-device',
> 'scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi=
0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1',
> +                         '-nodefaults')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'AIX Version 7')
> +
> +    def test_ppc64_aix_boot_tcg(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.do_test_ppc64_aix_boot()
> +
> +    def test_ppc64_aix_boot_kvm(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        :avocado: tags=3Daccel:kvm
> +        """
> +        self.require_accelerator("kvm")
> +        self.do_test_ppc64_aix_boot()


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

