Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C267CD697
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uY-0000Vj-Lg; Wed, 18 Oct 2023 04:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uV-0000TL-Th
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uT-0003ZI-Mq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b83yAfW1EQ3a+gzEXnF60a71GooBannom07e6loOxyI=;
 b=LPbvZm6UIKIzjjHpWNyqHKHyTO244jie9OFcE5ohSN9OdmjDSyVfIaS6Zy7dkXKY+ASpgQ
 7IIdcZPqtK5eo8+GBh8lgHLs16XFgPfMtbdtgJap1gIvTMt4MZPZ6CKXlpWJh5BBhUPBAO
 rPPyOFEw9uvZh6eR9F/TBzeT+Bi3sRg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-7q-1Bnn0MkWRE4Iha1rKZg-1; Wed, 18 Oct 2023 04:27:57 -0400
X-MC-Unique: 7q-1Bnn0MkWRE4Iha1rKZg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b9ecd8c351so459735466b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617674; x=1698222474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b83yAfW1EQ3a+gzEXnF60a71GooBannom07e6loOxyI=;
 b=oTU7/BRHMFOZCzuHA2h9KvBiXQI08BuLGJenA0IKgXgKMHpZHxJgfPP+XC5LryoDYT
 RJ+oSv7MMe+X7bAVroz+wANRVWHJTgOWeZR1oBSkHqbkZSUddrgO1juTWms79rHI2cEK
 MzvCpOI+zbYI5N4XNZ96R5BRMNPdYl9VWz7dLF0Oszmsuy6mNxCAhvbT7zEG59Vgd8Oo
 MOFdnct3dtH9kPGyGzeHyKUkpzlFEZwQNAncSh7nVYPGAVgyaQDrSNwDzP1UQMWxitMu
 wtIIoMbJ2hSPrBRJ/Y4ysrReJEiMRjPGfF3Lxkhm2mlI/WolynpgxLptPShy7vuz2oDn
 /Z9A==
X-Gm-Message-State: AOJu0YyaP/+hXEX9lJ8jkPteaVSpOvj/OaP8j9FpVjA2YKU0ZtQhJswl
 LHuqsXIrf1ekKDSzOULSAZHjIw0yU5ZABMoRVceqtbXRLXEOSICHMZRYnLjD8lqyceQyfRxuIfn
 NatiQU1PjPhMRqHsKMA8nje/0QNqhFdLU3yo9pEIpv21hovnTNnW5pPz20/inFFBW0/I57a3imG
 8=
X-Received: by 2002:a05:6402:84a:b0:53f:739e:cd34 with SMTP id
 b10-20020a056402084a00b0053f739ecd34mr55522edz.13.1697617674433; 
 Wed, 18 Oct 2023 01:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbxgNkSe1kkYE7EGCJ1igNSZAdF7sHMtBw9/jmelldvnJuwBfFZABSZTy+wAawsd+CxiOxSA==
X-Received: by 2002:a05:6402:84a:b0:53f:739e:cd34 with SMTP id
 b10-20020a056402084a00b0053f739ecd34mr55503edz.13.1697617673888; 
 Wed, 18 Oct 2023 01:27:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 a93-20020a509ee6000000b00536159c6c45sm2439037edf.15.2023.10.18.01.27.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:27:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] x86 and build system changes for 2023-10-18
Date: Wed, 18 Oct 2023 10:27:20 +0200
Message-ID: <20231018082752.322306-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 800485762e6564e04e2ab315132d477069562d91:

  Merge tag 'python-pull-request' of https://gitlab.com/jsnow/qemu into staging (2023-10-16 12:37:48 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 528148980adb78bc368a5254204e2ea98e4f6b6c:

  configure: define "pkg-config" in addition to "pkgconfig" (2023-10-18 10:01:02 +0200)

----------------------------------------------------------------
* build system and Python cleanups
* fix netbsd VM build
* allow non-relocatable installs
* allow using command line options to configure qemu-ga
* target/i386: check intercept for XSETBV
* target/i386: fix CPUID_HT exposure

----------------------------------------------------------------
Emmanouil Pitsidianakis (1):
      scripts/get_maintainer.pl: don't print parentheses

John Snow (2):
      iotests: get rid of '..' in path environment output
      iotests: use the correct python to run linters

Paolo Bonzini (26):
      target/i386: check intercept for XSETBV
      tests/vm: netbsd: install dtc
      tests/docker: avoid invalid escape in Python string
      docs/sphinx: avoid invalid escape in Python string
      target/hexagon: avoid invalid escape in Python string
      tests/avocado: avoid invalid escape in Python string
      tests/vm: avoid invalid escape in Python string
      tracetool: avoid invalid escape in Python string
      meson: do not build shaders by default
      meson: do not use set10
      meson, cutils: allow non-relocatable installs
      configure: clean up handling of CFI option
      hw/xen: cleanup sourcesets
      hw/remote: move stub vfu_object_set_bus_irq out of stubs/
      tests/tcg/arm: move non-SVE tests out of conditional
      configure, tests/tcg: simplify GDB conditionals
      configure: clean up plugin option handling
      configure: clean up PIE option handling
      configure: remove some dead cruft
      configure: move target-specific defaults to an external machine file
      configure: move environment-specific defaults to config-meson.cross
      configure: unify handling of several Debian cross containers
      configure, meson: use command line options to configure qemu-ga
      meson-buildoptions: document the data at the top
      meson: add a note on why we use config_host for program paths
      configure: define "pkg-config" in addition to "pkgconfig"

Thomas Huth (1):
      scripts: Mark feature_to_c.py as non-executable to fix a build issue

Xiaoyao Li (1):
      target/i386/cpu: Fix CPUID_HT exposure

Yonggang Luo (1):
      Revert "configure: Add workaround for ccache and clang"

 configs/meson/windows.txt                          |   9 +
 configure                                          | 288 +++++++--------------
 docs/sphinx/hxtool.py                              |   2 +-
 hw/arm/meson.build                                 |   1 -
 hw/i386/meson.build                                |   1 -
 hw/remote/meson.build                              |   4 +-
 .../remote/vfio-user-obj-stub.c                    |   0
 hw/xen/meson.build                                 |  11 +-
 include/qemu/compiler.h                            |  15 ++
 meson.build                                        |  31 ++-
 meson_options.txt                                  |   9 +
 qga/meson.build                                    |   9 +-
 scripts/feature_to_c.py                            |   0
 scripts/get_maintainer.pl                          |   1 +
 scripts/meson-buildoptions.py                      |  32 ++-
 scripts/meson-buildoptions.sh                      |  26 +-
 scripts/tracetool/__init__.py                      |  14 +-
 scripts/tracetool/format/log_stap.py               |   2 +-
 stubs/meson.build                                  |   1 -
 target/hexagon/hex_common.py                       |   4 +-
 target/i386/cpu.c                                  |   1 +
 target/i386/kvm/kvm.c                              |   2 +
 target/i386/svm.h                                  |   1 +
 target/i386/tcg/translate.c                        |   1 +
 tests/avocado/virtio_check_params.py               |   2 +-
 tests/docker/docker.py                             |   2 +-
 tests/qemu-iotests/linters.py                      |   2 +-
 tests/qemu-iotests/testenv.py                      |   2 +-
 tests/tcg/aarch64/Makefile.target                  |  16 +-
 tests/tcg/multiarch/Makefile.target                |  18 +-
 tests/tcg/multiarch/system/Makefile.softmmu-target |  15 +-
 tests/tcg/s390x/Makefile.target                    |   6 +-
 tests/unit/test-coroutine.c                        |   2 +-
 tests/vm/basevm.py                                 |   6 +-
 tests/vm/netbsd                                    |   6 +-
 ui/shader/meson.build                              |   1 +
 util/cutils.c                                      |  11 +-
 util/qemu-coroutine.c                              |   4 +-
 38 files changed, 283 insertions(+), 275 deletions(-)
 create mode 100644 configs/meson/windows.txt
 rename stubs/vfio-user-obj.c => hw/remote/vfio-user-obj-stub.c (100%)
 mode change 100755 => 100644 scripts/feature_to_c.py
-- 
2.41.0


