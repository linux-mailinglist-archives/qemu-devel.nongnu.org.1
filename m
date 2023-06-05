Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92F7222A9
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tG-0002mQ-1K; Mon, 05 Jun 2023 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t5-0002hJ-3X
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t3-0006jp-37
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7kaZ2dCU40IWUDRJNnCAoCap+HYAp3YuNwUcCEkjEVI=;
 b=ZBaMnKdOb0KAikmg+KqX2usx953LZIksc1HDyfKVuukHVy2gFL2NQl6bLM4uKQEj1LbZvo
 aRY2G5Ui8MReyYuVDjhlWHbm38wdIzTg8nyy6XYFwyKv1/TJ0haWuso2nC5VCxVfWGJKoY
 72sIjh0grq1Capizz91eQl/fHLGJEcI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Ff-vTUlYNqOcpd-YOu0F_A-1; Mon, 05 Jun 2023 05:52:26 -0400
X-MC-Unique: Ff-vTUlYNqOcpd-YOu0F_A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso311456066b.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958745; x=1688550745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kaZ2dCU40IWUDRJNnCAoCap+HYAp3YuNwUcCEkjEVI=;
 b=gOyYhTeFhkNWm/RcGWl7DKJlaBzlgbYZZ59smrE1M5yD/tEIxntUBWb7CK1yxY5zgc
 7QYHxO+YIdkIDy2UtcebQh5uJlwNRT7aSOBOz36rq6lUMCb/KZ59XYR3DfwOSJdh9Wgk
 +2eBcLTycelb33vLUEBTTKc/DRpx5GoRObpvGkNgv9z1lwPXiTPZyslh7m//y/X6fPHk
 EwSmswod+iSCT6HVzbrMXvX9rDhYw2b1xwAvyPgr+zW0QLHe1FEKxIMfrtPUcg2yB1yA
 59KhOCThb9S18WKncpKh+JfoU/geeuu8t7VSVi2PgTVb2MzJjnxk7K4ugh9oCyeW2s7u
 0chw==
X-Gm-Message-State: AC+VfDzC9BuktzTmRFCSMJnknwwL4cO5wKA3ORobVETAx8/g6gGbZlYB
 ZwCbD9cOXuTtVQ8mhqeQO7VVe4PdLajs17YtNZwEQ7aECu6EGlGM7r/P/aKGscF/HQp+A4mvsNi
 0/l5uPhjeJRe9OZZhh2izZLzCVWdaJG4UdLaBYVwgZZtqVAWCrqQTsXI/2S41xPQo70biq1xXTg
 g=
X-Received: by 2002:a17:907:1609:b0:973:e349:43c8 with SMTP id
 hb9-20020a170907160900b00973e34943c8mr5434336ejc.69.1685958745487; 
 Mon, 05 Jun 2023 02:52:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fDfpDSik1/zjiQQmwB/u6ZLDopLqSpE1HqVI9wFjviVBFLYWGPd8kMGNnLsxaRz+/gq8Qrw==
X-Received: by 2002:a17:907:1609:b0:973:e349:43c8 with SMTP id
 hb9-20020a170907160900b00973e34943c8mr5434320ejc.69.1685958744987; 
 Mon, 05 Jun 2023 02:52:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170906140500b00974612a9837sm4087548ejc.20.2023.06.05.02.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 00/10] meson: replace submodules with wrap files
Date: Mon,  5 Jun 2023 11:52:13 +0200
Message-Id: <20230605095223.107653-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
parts of which are used in the QEMU build process for pc-bios/s390-ccw.
For now, the git-submodule.sh rules are moved from the main Makefile to
pc-bios/s390-ccw/ and, to limit the number of configure options,
--with-git-submodules is merged with --enable-download.


Patch 1 removes the --with-git= option for consistency, since git cannot
be overridden for "meson subprojects download".  There is still a GIT
environment variable, which I could look at supporting in meson as well.

Patch 2 renames the recently introduced --enable-pypi command line
option to --enable-download, and makes it control meson's -Dwrapmode
option as well.

Patches 3-4 are small improvements to git-submodule.sh, which make
sense when the submodule updates are split across multiple Makefiles.
At the end of the series actually the updates move entirely to
pc-bios/s390-ccw/Makefile, but these improvements are useful anyway in
my opinion.

Patch 5 replaces submodule update with meson's subproject download for
existing subprojects (including libfdt and keycodemapdb).

Patches 6-7 move roms/SLOF handling to pc-bios/s390-ccw.  While in
the future it is possible that SLOF's networking code will be copied
to the s390 ROMs, for now I am going for a smaller change.

Patch 8 converts berkeley-{soft,test}float-3 to subprojects too,
contextually moving their build rules out of tests/fp/meson.build.

Patches 9-10 are residual cleanups.

Paolo

[1] https://patchew.org/QEMU/20230302131848.1527460-1-marcandre.lureau@redhat.com/20230302131848.1527460-5-marcandre.lureau@redhat.com/



Paolo Bonzini (10):
  configure: remove --with-git= option
  configure: rename --enable-pypi to --enable-download, control
    subprojects too
  git-submodule: allow partial update of .git-submodule-status
  build: log submodule update from git-submodule.sh
  meson: subprojects: replace submodules with wrap files
  configure: move SLOF submodule handling to pc-bios/s390-ccw
  pc-bios/s390-ccw: always build network bootloader
  meson: subprojects: replace berkeley-{soft,test}float-3 with wraps
  build: remove git submodule handling from main makefile
  configure: remove --with-git-submodules=

 .gitignore                                    |   2 -
 .gitlab-ci.d/buildtest-template.yml           |   4 +-
 .gitmodules                                   |  15 -
 Makefile                                      |  12 -
 configure                                     | 169 ++----
 meson.build                                   |  17 +-
 pc-bios/s390-ccw/Makefile                     |  16 +-
 scripts/archive-source.sh                     |  27 +-
 .../ci/org.centos/stream/8/x86_64/configure   |   3 -
 scripts/git-submodule.sh                      |  69 ++-
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
 25 files changed, 716 insertions(+), 758 deletions(-)
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


