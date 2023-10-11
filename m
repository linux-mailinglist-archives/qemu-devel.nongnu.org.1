Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 490947C469D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 02:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqN2u-0007TN-D2; Tue, 10 Oct 2023 20:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqN2m-0007QZ-9a; Tue, 10 Oct 2023 20:25:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqN2g-0005hX-9t; Tue, 10 Oct 2023 20:25:43 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso49920785ad.2; 
 Tue, 10 Oct 2023 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696983936; x=1697588736; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iS+RLGcfX5Jr3mV0kBt8sPNpd/pbAvz7R3ZdZq4zpzE=;
 b=WgGU8Qp2KxmGbA7VV/SNyFyi2leoOwimAyrxSw2hAw6nyMGNVs1+kYWdvDjO6ogVrE
 UCCvdV8mCfcCD4a/BMQuCHKzNdLMvJn0AfNRWnPvIrEXqLbGgAmXBf8ElTst86d5wcBj
 ZbIfbOQ4DduLu3waPP2Oqi7CJioCNAl3zUisDdQOaTLM5zG5ok0rpa890vnqdRhH/qgm
 tX9a70uoFxKBk5K73oFD7tShzyMQ8k5QmwhryQwEAOXh+kfKZl6YDh+UUnRgwwvvCMDw
 XgIOqJ/fIUCnn4oDJff7IZ2LYnaoZjGFosJDihfQ1dkOYDy4SAaAqgT2YBPjfiFoYaZ4
 85rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696983936; x=1697588736;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iS+RLGcfX5Jr3mV0kBt8sPNpd/pbAvz7R3ZdZq4zpzE=;
 b=Iq5wSfEZvnjAA7zlTl6sbCPC7Vm3159e7fF+I0twNNU5CIznNv0acNh1Xz/VFjUl9c
 8I/h23WRUXCwCfwUUr6TqqAS7XPuIO0z5KebQja5g3+O4ZPdI1W/EEjJ6zvdKb3UG19n
 ieGTzmlgmZowo0GW1bC/nGqanxXzt9j/kGy6oifSujqxhlDZODOwg4yWssXe2qTTzo5P
 RsJppcENyigrIEjTWK8aQvtz8r5FKVUIqzsoeEBlXP6+KaZr1daTM1h//QdXSVlQrRqe
 F3MqPva/6zuiqs3wYnRgaWKQJhPu2ZOAAm1PdfdFrUo94VJbKqc/H+YZ5pqRUT7V0Lag
 KOIQ==
X-Gm-Message-State: AOJu0Ywl8BxqtTc7tH0QAA31LUxrmjbrSE3AC5XybybmZdyLWSWGN3vA
 FbviHkCwZt/8Fffs+j9bHY8=
X-Google-Smtp-Source: AGHT+IEcGBA/O1h2tJtrCwT0ZAAzjoVxPGO941QG/a0VopTCDJn0q1O64ObXcNKBJBCxJzCS1tic2Q==
X-Received: by 2002:a17:902:d4d1:b0:1c9:cc3a:7b3 with SMTP id
 o17-20020a170902d4d100b001c9cc3a07b3mr366229plg.54.1696983936457; 
 Tue, 10 Oct 2023 17:25:36 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 be8-20020a170902aa0800b001bb99e188fcsm12384441plb.194.2023.10.10.17.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 17:25:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2023 10:25:31 +1000
Message-Id: <CW56LJVY3BAA.30I7HDM9UETI9@wheely>
Cc: "Cleber Rosa" <crosa@redhat.com>, "Wainer dos Santos Moschetta"
 <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 08/11] tests/avocado: Add ppc MacOS tests
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-9-npiggin@gmail.com>
 <2d455bcf-f586-52df-eb85-136bc4362d5d@linaro.org>
In-Reply-To: <2d455bcf-f586-52df-eb85-136bc4362d5d@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Oct 10, 2023 at 5:58 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Nicholas,
>
> On 10/10/23 09:52, Nicholas Piggin wrote:
> > Similarly to the AIX test, this adds some tests that can boot MacOS9
> > and OSX images that are provided.
> > ---
> >   tests/avocado/ppc/macos9.ppm | Bin 0 -> 921615 bytes
> >   tests/avocado/ppc_macos.py   |  90 ++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 90 insertions(+)
> >   create mode 100644 tests/avocado/ppc/macos9.ppm
> >   create mode 100644 tests/avocado/ppc_macos.py
>
>
> > diff --git a/tests/avocado/ppc_macos.py b/tests/avocado/ppc_macos.py
> > new file mode 100644
> > index 0000000000..055fc3aca4
> > --- /dev/null
> > +++ b/tests/avocado/ppc_macos.py
> > @@ -0,0 +1,90 @@
> > +# Functional test that boots MacOS on ppc mac99
> > +#
> > +# Copyright (c) 2023 IBM Corporation
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +import time
> > +import tempfile
> > +import filecmp
> > +import os
> > +
> > +from typing import List
> > +from avocado.utils import archive
> > +from avocado_qemu import QemuSystemTest
> > +from avocado_qemu import wait_for_console_pattern
> > +
> > +class PPCMacOSTest(QemuSystemTest):
> > +
> > +    timeout =3D 240
> > +
> > +    def test_macos9(self):
> > +        """
> > +        :avocado: tags=3Darch:ppc
> > +        :avocado: tags=3Dmachine:mac99
> > +        :avocado: tags=3Ddevice:framebuffer
> > +        """
> > +
> > +        basedir =3D os.getenv('AVOCADO_TEST_BASEDIR')
> > +        screenshot_path =3D os.path.join(basedir, 'ppc/macos9.ppm')
> > +
> > +        image =3D os.getenv('MACOS9_IMAGE')
> > +        if not image:
> > +            self.cancel('No MACOS9_IMAGE environment variable defined'=
)
> > +        drive_path =3D self.fetch_asset(image)
> > +
> > +        self.vm.set_console()
> > +        self.vm.add_args('-M', 'via=3Dpmu')
> > +        self.vm.add_args('-m', '1g')
> > +        self.vm.add_args('-cpu', 'G4')
> > +        self.vm.add_args('-drive', 'file=3D' + drive_path)
> > +#        self.vm.add_args('-net', 'nic,model=3Drtl8139')
> > +#        self.vm.add_args('-net', 'user,hostfwd=3D:127.0.0.1:2223-:22,=
hostname=3Dqemu')
> > +        self.vm.add_args('-vga', 'std')
> > +        self.vm.add_args('-g', '640x480')
> > +        self.vm.launch()
> > +
> > +        # This comes up after 60 seconds on a fast x86 CPU. Give it
> > +        # 180s to be sure.
> > +        time.sleep(180)
> > +        with tempfile.NamedTemporaryFile(suffix=3D'.ppm',
> > +                                         prefix=3D'screendump-', delet=
e=3DFalse) as ppmfile:
> > +            self.vm.command('screendump', filename=3Dppmfile.name)
> > +            if not filecmp.cmp(ppmfile.name, screenshot_path):
> > +                self.fail('Screenshot does not match')
> > +
>
> Nitpicking, I'd rather use:
>
>         @skipUntil(os.getenv('MACOS10_IMAGE'),
>                    'No MACOS10_IMAGE environment variable defined')

Aha I didn't know about that one. I don't think it's nitpicking, that's
a good suggestion, thank you.

> > +    def test_macos10(self):
> > +        """
> > +        :avocado: tags=3Darch:ppc
> > +        :avocado: tags=3Dmachine:mac99
> > +        :avocado: tags=3Ddevice:framebuffer
> > +        """
> > +
> > +        basedir =3D os.getenv('AVOCADO_TEST_BASEDIR')
> > +        screenshot_path =3D os.path.join(basedir, 'ppc/macos10.ppm')
> > +
> > +        image =3D os.getenv('MACOS10_IMAGE')
> > +        if not image:
> > +            self.cancel('No MACOS10_IMAGE environment variable defined=
')
> > +        drive_path =3D self.fetch_asset(image)
>
> Please commit the hash if the image you used.

Sure.

>
> > +        self.vm.set_console()
> > +        self.vm.add_args('-M', 'via=3Dpmu')
> > +        self.vm.add_args('-m', '1g')
> > +        self.vm.add_args('-cpu', 'G4')
> > +        self.vm.add_args('-drive', 'file=3D' + drive_path)
> > +#        self.vm.add_args('-net', 'nic,model=3Drtl8139')
> > +#        self.vm.add_args('-net', 'user,hostfwd=3D:127.0.0.1:2223-:22,=
hostname=3Dqemu')
>
> Why is that commented? If not needed, just drop, since your test
> is already useful as it.

Yeah I will. That was the option used by some scripts here but it
doesn't seem to work for me here, whereas the default IIRC sungem
does get networking up. Could be a QEMU regression so I was meaning
to try a bisect.

Thanks for the feedback on these. I'll leave the MacOS and AIX ones
out of the next ppc PR so there is more time for thought and
discussion about them.

Thanks,
Nick

