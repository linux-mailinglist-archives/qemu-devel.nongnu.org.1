Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 904357133B2
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 11:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2qES-0007ZF-0w; Sat, 27 May 2023 05:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEP-0007YU-Np
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEM-0007X0-ST
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685179737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aAG7mL1TSQwEbSQSzcO2tupUJTV97QrmGlWot84gHkk=;
 b=MOvgucah+XIb8hC4/xYwrz5LBKd8u/DsydDvEA9IP0oYIdGWAd/4Alb41GL9AR7ZzlgtdZ
 xIh7upm6vZgDxXroNM44YKncj1kwEneEmQBISvqEyQak2/1CzQtogBduzHP0CrhkrbM9AF
 1UFVokn2a+8/kDQ7eiHGVOcLWOzLrBw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-uLOV8dgnMxyWVadUy259ZQ-1; Sat, 27 May 2023 05:28:55 -0400
X-MC-Unique: uLOV8dgnMxyWVadUy259ZQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96fffd1ba46so139663666b.0
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 02:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685179734; x=1687771734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aAG7mL1TSQwEbSQSzcO2tupUJTV97QrmGlWot84gHkk=;
 b=Socc1O7hFmKMxO0+DOznza4gE4NidHO2BJR7swrsAkuQ3iOmxn1cNujPyZqPpDcqr1
 stu7CjV2PhtAUC94fQ390Xk36SRTrh2kt48cZydqN2pitVyN+CI6QiJgWoIsgQdEeID2
 dhWJtxjAOaSPZMxryq2Jt64HZBLFaX6AFRO6LcAZZGz+0FRJafmHBw2ybYV0rI2j3dck
 5Ix8Psoht4FYQ1ZCuTJXNyhnl6sV3bI4cmj57CcZcyAvGGqDC9rDIrnXOp52Tgsj6WEC
 N25wWreHf+JBtbebEaR1EmIOlPCKkQpOf7D4mqBtRRds9GAAd8qxaUI46DTol6AYTacU
 U1/w==
X-Gm-Message-State: AC+VfDx1DNNMPYG1M+3cHZle1iFLVb/b7ho39soSCPcYJz5u8n5jETYO
 tql+aZuoaEpQMtv7iUSlrtDE65hgiMNYd0cSAZtC65Oq8fSAn9cfpGGqKc1MUvrtUr5ACbnZ1aL
 2dTOuk+IVc+nfZ/37r7ChtzF4rXR4sgw8sTo8xJtK1S2Q4TSHHZvAcuGIwYygChT8e+2gSuLELZ
 c=
X-Received: by 2002:a17:906:eec7:b0:96f:504b:466b with SMTP id
 wu7-20020a170906eec700b0096f504b466bmr4525316ejb.12.1685179734106; 
 Sat, 27 May 2023 02:28:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5F4Y9Ki0/zlFnKVlpvCTp62exw+J4nRR2YSQQsXdP2NpyuUab+ZQG2DfVw984QvEdW0p1Wlw==
X-Received: by 2002:a17:906:eec7:b0:96f:504b:466b with SMTP id
 wu7-20020a170906eec700b0096f504b466bmr4525303ejb.12.1685179733711; 
 Sat, 27 May 2023 02:28:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 us8-20020a170906bfc800b0094bb4c75695sm3171580ejb.194.2023.05.27.02.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 02:28:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 0/5] meson: replace submodules with wrap files
Date: Sat, 27 May 2023 11:28:46 +0200
Message-Id: <20230527092851.705884-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This series replaces git submodules for bundled libraries with .wrap
files that can be used directly by meson for subprojects.  These have
several advantages, either immediate or potential:

* option parsing and downloading is delegated to meson

* the commit is stored in a text file instead of a magic entry in the
  git tree object, and can be a branch name or a version number as well

* now that QEMU's configure script knows how to install missing Python
  dependencies, we could stop shipping external dependencies that are
  only used as a fallback, and download them on demand if the build
  platform lacks them.  For example dtc could be downloaded at build
  time, controlled by --enable-download, even when building from
  a tarball.  This is _not_ done in this patch series, but Marc-André
  has tried it before[1].

* we could also add .wrap files for other dependencies that are missing
  on the GCC compile farm machines, or for people who build on Windows
  and might enjoy getting the mandatory dependencies (pixman, zlib,
  glib, possibly SDL?) via wraps.  In theory meson already supports
  "meson wrap update-db" to automatically use wraps for anything required
  but missing, but one would need to test that it actually works; see
  for example https://github.com/mesonbuild/meson/issues/11821.

dtc and keycodemapdb both support meson, and previously reviewed
patches already run their build system via subproject(), so the
wraps are automatically taken into account.  Two other submodules,
berkeley-softfloat-3 and berkeley-testfloat-3, are used to test QEMU and
can be changed to use wraps; however this requires a few more changes
to extract the corresponding parts of tests/fp/meson.build.  It's mostly
code movement rather than new code.

The remaining submodules consist of tests/lcitool/libvirt-ci and the
firmware in roms/.  The former is only used in very specific cases,
while the latter is mostly used only as a pointer used to create the QEMU
tarball.  Unfortunately, git-submodule.sh is still needed for roms/SLOF,
parts of which are used in the QEMU build process for pc-bios/s390-ccw;
more on this later in this cover letter.

I'm not sure what's the best way to proceed for roms/SLOF.  Some
possibilities, in no particular order, include:

* doing nothing

* merging --with-git-submodules with --enable-download, and
  moving the git-submodule.sh rules from the main Makefile to
  pc-bios/s390-ccw/ (my favorite option)

* copying the relevant SLOF files into pc-bios/

Also, getting into more overengineered territory:

* same as the second option, but also replace the roms/ submodules
  with text files, in a format similar to .wrap files; meson uses the
  standard configparser to read them, so it would not be a lot of
  code.  The files would be parsed by scripts/make-release and
  pc-bios/s390-ccw/Makefile.

* adding support for firmware with a meson build system to
  configure; turn SLOF into a wrap and roms/SLOF into a symlink
  for ../pc-bios/s390-ccw/subprojects/SLOF.  I'm mentioning this for
  completeness but this is not something I would like.  On the other
  hand it could reuse some (or most?) of the code currently used to
  generate config-meson.cross, so maybe it isn't that bad...


Patch 1 removes the --with-git= option for consistency, since git cannot
be overridden for "meson subprojects download".

Patch 2 renames the recently introduced --enable-pypi command line
option to --enable-download, and makes it control meson's -Dwrapmode
option as well.

Patch 3 replaces submodule update with meson's subproject download for
existing subprojects (including libfdt and keycodemapdb).

Patch 5 converts berkeley-{soft,test}float-3 to subprojects too.
However, those are the submodules that are used in configure to
check the validity of the source tree, so patch 4 adds an extra check
for the presence of the aforementioned SLOF submodule.


Still a bit RFCish, in case people prefer to have a solution for
git-submodule.sh and roms/SLOF before the switch to wraps.  For this
reason, and because I have exhausted my gitlab CI minutes for this month,
it's only tested lightly (it passed gitlab CI in a previous version and
passes vm-build-netbsd in this one).

Paolo

Supersedes: <20230519085647.1104775-1-pbonzini@redhat.com>

[1] https://patchew.org/QEMU/20230302131848.1527460-1-marcandre.lureau@redhat.com/20230302131848.1527460-5-marcandre.lureau@redhat.com/


Paolo Bonzini (5):
  configure: remove --with-git= option
  configure: rename --enable-pypi to --enable-download, control
    subprojects too
  meson: subprojects: replace submodules with wrap files
  configure: check for SLOF submodule before building pc-bios/s390-ccw
  meson: subprojects: replace berkeley-{soft,test}float-3 with wraps

 .gitlab-ci.d/buildtest-template.yml           |   1 +
 .gitmodules                                   |  15 -
 Makefile                                      |   2 +-
 configure                                     | 126 ++--
 meson.build                                   |  16 +-
 scripts/archive-source.sh                     |  27 +-
 scripts/git-submodule.sh                      |   8 +-
 scripts/make-release                          |   5 +
 subprojects/.gitignore                        |   8 +
 subprojects/berkeley-softfloat-3.wrap         |   5 +
 subprojects/berkeley-testfloat-3.wrap         |   5 +
 subprojects/dtc                               |   1 -
 subprojects/dtc.wrap                          |   4 +
 subprojects/keycodemapdb                      |   1 -
 subprojects/keycodemapdb.wrap                 |   4 +
 subprojects/libvfio-user                      |   1 -
 subprojects/libvfio-user.wrap                 |   4 +
 .../berkeley-softfloat-3/meson.build          | 339 +++++++++++
 .../berkeley-softfloat-3/meson_options.txt    |   1 +
 .../berkeley-testfloat-3/meson.build          | 220 +++++++
 .../berkeley-testfloat-3/meson_options.txt    |   1 +
 tests/fp/meson.build                          | 541 +-----------------
 22 files changed, 668 insertions(+), 667 deletions(-)
 create mode 100644 subprojects/.gitignore
 create mode 100644 subprojects/berkeley-softfloat-3.wrap
 create mode 100644 subprojects/berkeley-testfloat-3.wrap
 delete mode 160000 subprojects/dtc
 create mode 100644 subprojects/dtc.wrap
 delete mode 160000 subprojects/keycodemapdb
 create mode 100644 subprojects/keycodemapdb.wrap
 delete mode 160000 subprojects/libvfio-user
 create mode 100644 subprojects/libvfio-user.wrap
 create mode 100644 subprojects/packagefiles/berkeley-softfloat-3/meson.build
 create mode 100644 subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt
 create mode 100644 subprojects/packagefiles/berkeley-testfloat-3/meson.build
 create mode 100644 subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt

-- 
2.40.1


