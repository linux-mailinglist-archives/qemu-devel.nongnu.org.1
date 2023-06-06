Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DDB724621
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XiZ-00051b-GG; Tue, 06 Jun 2023 10:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiX-00050f-DT
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiV-0001Cu-5V
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TtiGukcD+Ug/cuzCIWq6+t4MQd8xYORQkIilPIGQq8Q=;
 b=TXOW/7bwbFTAaq0W9nMKHEhmu8FjFWp/3kzI4N09l7kg1t8/cwQY8zKIeDwq3wYYsIkV9+
 ibJ4veCW20pKgMT4sumUF9ZRe/gl6rkkVQzyblYzWG+iLZicL3qZ04L7YSCnECJ9U71v7q
 lMvAX4eMS8iWhGhJZwtjvujE34skJLs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-hFhatXYlNVmhJIX49V_GwA-1; Tue, 06 Jun 2023 10:31:19 -0400
X-MC-Unique: hFhatXYlNVmhJIX49V_GwA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-97594143f1fso403176566b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061878; x=1688653878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TtiGukcD+Ug/cuzCIWq6+t4MQd8xYORQkIilPIGQq8Q=;
 b=eqQmDdzOS6YGSSO7eIMM/KTQK17zzreAy9nuxgRqj7deoIDxVNSIezVBZ0wrFXeeZA
 eV/xFdMc72LgBU+EjhESN4MCCHccFGjvlykLgdnPq28EQUexto4EG7DoJ1AtStvokbDe
 WlX7OR1v6508ovwR5nIRKqmlVSljK+RDCTTi/WiJ9x4MhR6XznPqzB2Kd/0T7XVGZjSr
 4uk3KTCYxlHWQO49zt69tGZUznmiUjmdICtqTf1BERmx4DEwL5gvlg5RJDuEVtv16q/A
 sY1LAntQrGhN9NkFO+YxyYx2HwBVmI0IEKNQo5009He6csGpuE/Ii0n06dYZ45h8yEPB
 gjyg==
X-Gm-Message-State: AC+VfDxnk4guGdwaYsuSj17naS9qbPMb2GY2NWAdDH/ieGshsCXjbloc
 PoVICGKXAkfXp2Z33+9Sr6gGYLAHv+vqktU3OgqokemuPA4YUAWJQZaGkPWumdZdEgnADCqYZFg
 baVezswokJ/ydZlHv3M4vLODuz4crbZbGtCQwdBGTpSeCQS5M2N9NenyAsGpz1FntCPJzz331pV
 A=
X-Received: by 2002:a17:907:7b9b:b0:974:571f:202c with SMTP id
 ne27-20020a1709077b9b00b00974571f202cmr2672644ejc.40.1686061878044; 
 Tue, 06 Jun 2023 07:31:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Ht4QzSRwaykXUZP+43dar+YpfnHb5yh7YpVIyZFykZsoUZM4TBvUJYLjr9wLJ79Mwm7wJJA==
X-Received: by 2002:a17:907:7b9b:b0:974:571f:202c with SMTP id
 ne27-20020a1709077b9b00b00974571f202cmr2672621ejc.40.1686061877609; 
 Tue, 06 Jun 2023 07:31:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a170906601200b0096f71ace804sm5665077ejj.99.2023.06.06.07.31.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] (Mostly) build system patches for 2023-06-06
Date: Tue,  6 Jun 2023 16:30:55 +0200
Message-Id: <20230606143116.685644-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The following changes since commit 369081c4558e7e940fa36ce59bf17b2e390f55d3:

  Merge tag 'pull-tcg-20230605' of https://gitlab.com/rth7680/qemu into staging (2023-06-05 13:16:56 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6f3ae23b29ad5831902e3ecdc7e443bbbf295bde:

  configure: remove --with-git-submodules= (2023-06-06 16:30:01 +0200)

----------------------------------------------------------------
* finish atomics revamp
* meson.build tweaks
* revert avocado update
* always upgrade/downgrade locally installed Python packages
* switch from submodules to subprojects
* remove --with-git= option
* rename --enable-pypi to --enable-download, control submodules and subprojects too

----------------------------------------------------------------
Michal Privoznik (1):
      meson: Avoid implicit declaration of absent functions

Paolo Bonzini (15):
      atomics: eliminate mb_read/mb_set
      scripts: remove dead file
      Revert "tests/requirements.txt: bump up avocado-framework version to 101.0"
      tests: Use separate virtual environment for avocado
      mkvenv: always pass locally-installed packages to pip
      configure: remove --with-git= option
      configure: rename --enable-pypi to --enable-download, control subprojects too
      git-submodule: allow partial update of .git-submodule-status
      build: log submodule update from git-submodule.sh
      meson: subprojects: replace submodules with wrap files
      configure: move SLOF submodule handling to pc-bios/s390-ccw
      pc-bios/s390-ccw: always build network bootloader
      meson: subprojects: replace berkeley-{soft,test}float-3 with wraps
      build: remove git submodule handling from main makefile
      configure: remove --with-git-submodules=

Philippe Mathieu-Daudé (1):
      scsi/qemu-pr-helper: Drop support for 'old' libmultipath API

Thomas Huth (4):
      meson.build: Group the UI entries in a separate summary section
      meson.build: Group the network backend entries in a separate summary section
      meson.build: Group the audio backend entries in a separate summary section
      meson.build: Use -Wno-undef only for SDL2 versions that need it

 .gitignore                                         |   2 -
 .gitlab-ci.d/buildtest-template.yml                |   4 +-
 .gitlab-ci.d/buildtest.yml                         |   6 +-
 .gitmodules                                        |  15 -
 Makefile                                           |  12 -
 accel/tcg/cpu-exec.c                               |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c                    |   2 +-
 accel/tcg/tcg-accel-ops-rr.c                       |   4 +-
 configure                                          | 169 ++-----
 docs/devel/acpi-bits.rst                           |   6 +-
 docs/devel/atomics.rst                             |  27 +-
 docs/devel/testing.rst                             |  14 +-
 include/qemu/atomic.h                              |  17 +-
 meson.build                                        | 134 +++--
 monitor/qmp.c                                      |   2 +-
 pc-bios/s390-ccw/Makefile                          |  16 +-
 python/scripts/mkvenv.py                           |  76 ++-
 scripts/archive-source.sh                          |  27 +-
 scripts/ci/org.centos/stream/8/x86_64/configure    |   3 -
 scripts/ci/org.centos/stream/8/x86_64/test-avocado |   4 +-
 scripts/device-crash-test                          |   2 +-
 scripts/git-submodule.sh                           |  69 +--
 scripts/make-release                               |   5 +
 scripts/test-driver.py                             |  35 --
 scsi/qemu-pr-helper.c                              |   4 -
 softmmu/cpus.c                                     |   2 +-
 softmmu/physmem.c                                  |   2 +-
 subprojects/.gitignore                             |   8 +
 subprojects/berkeley-softfloat-3.wrap              |   5 +
 subprojects/berkeley-testfloat-3.wrap              |   5 +
 subprojects/dtc                                    |   1 -
 subprojects/dtc.wrap                               |   4 +
 subprojects/keycodemapdb                           |   1 -
 subprojects/keycodemapdb.wrap                      |   4 +
 subprojects/libvfio-user                           |   1 -
 subprojects/libvfio-user.wrap                      |   4 +
 .../packagefiles/berkeley-softfloat-3/meson.build  | 339 +++++++++++++
 .../berkeley-softfloat-3/meson_options.txt         |   1 +
 .../packagefiles/berkeley-testfloat-3/meson.build  | 220 +++++++++
 .../berkeley-testfloat-3/meson_options.txt         |   1 +
 target/arm/hvf/hvf.c                               |   2 +-
 tests/Makefile.include                             |  32 +-
 tests/fp/meson.build                               | 541 +--------------------
 tests/requirements.txt                             |   9 +-
 tests/unit/test-aio-multithread.c                  |   2 +-
 tests/vm/Makefile.include                          |   2 +-
 util/qemu-coroutine-lock.c                         |   4 +-
 47 files changed, 900 insertions(+), 947 deletions(-)
 delete mode 100644 scripts/test-driver.py
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


