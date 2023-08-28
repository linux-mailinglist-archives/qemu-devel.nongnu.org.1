Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B4878AC62
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeI-0003JF-Fe; Mon, 28 Aug 2023 06:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeF-0003IA-MD
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeD-000538-3e
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G6SpsVbfFACE8/4iaG0M0+V+M40HwuWd4lT17G5R1+Q=;
 b=IzkEhc3mM0rxSUqR1EzpREisJ8xSRNnICn6lBl5Q2GOQcqfqAH3A9ng3JEuCF97akbOUx0
 4Np+I2FGxWGtJ+wEIiXIc4LxQShrw5pofQQF12eYy/teAqHkxaGQRM+Kcl5fzPP6569SJX
 QGWGIzQ2cHMMZfDjPFNH8UhQzurMOjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-lWllxgvQPcymwwGLGCSpkA-1; Mon, 28 Aug 2023 06:39:00 -0400
X-MC-Unique: lWllxgvQPcymwwGLGCSpkA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fee34b0eb8so23047275e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219139; x=1693823939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G6SpsVbfFACE8/4iaG0M0+V+M40HwuWd4lT17G5R1+Q=;
 b=Zu4ePglkCN1sYnes/4DrchcXjM/+OpszhcvQTw8h3RrtmG/1FwB+hWXJx2FPKeNsKY
 peJ214afPjmLOkVVQW/G0bB7R0cM+k6RxBz5Ehw7ulMCNDNOAKBRt9RUmorE8j0O2FrV
 gN0oNxV5zVGZr7tkUxsRNBIQE+VVUBKfCa2STMZq6NaFTpLuthqgm3VvI4xG5eJzCHZT
 pEBKg/Fblx7s3wS4zrmJE1ucALLYcbu5mc4cjHf48DoGpNSV+njpX38wUS25+LO3lKFK
 zt1/Zd64mGxs4pbJrIH4xAaj651AINkW5X4f7zNPkCsqgrFg1Y1xXFD4xVF3Ka+n7qAg
 YnyA==
X-Gm-Message-State: AOJu0YzM6E2oz8M4n37BG5T9tgRp4F0FuinnWYrWQIHHIOptymVGEdqi
 QqExz+2qz0YlbJNXXIoUNzWlsxR6L++aFIL6E7uZHmdIS9S+ikvB/NVUig5DYXaD+1FT1IeR/Rk
 gWWc0NkLOtmnC6XBQUr0kXX+x/TWWgK3NVg/C9qb7rEb81VaBgs92CCfEJs/lkTiiT4/eNOTvSe
 0=
X-Received: by 2002:a05:600c:20f:b0:401:aa8f:7576 with SMTP id
 15-20020a05600c020f00b00401aa8f7576mr8324293wmi.26.1693219138999; 
 Mon, 28 Aug 2023 03:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl3/blML9JKugv7mVEpGPv7RkJcpK5zcmjPFhY93Yeh+U/WXeAh7fGs/4tI/E1BA0UpVi0mg==
X-Received: by 2002:a05:600c:20f:b0:401:aa8f:7576 with SMTP id
 15-20020a05600c020f00b00401aa8f7576mr8324277wmi.26.1693219138499; 
 Mon, 28 Aug 2023 03:38:58 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 2-20020a05600c248200b003fee567235bsm13224468wms.1.2023.08.28.03.38.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:38:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] Python, i386 changes for 2023-08-28
Date: Mon, 28 Aug 2023 12:38:39 +0200
Message-ID: <20230828103856.46031-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:

  Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 29a8238510df27080b0ffa92c58400412ce19daa:

  configure: remove unnecessary mkdir -p (2023-08-28 10:01:44 +0200)

----------------------------------------------------------------
* separate accepted and auto-installed versions of Python dependencies
* bump tricore container to Debian 11
* small configure cleanups

----------------------------------------------------------------
Ake Koomsin (1):
      target/i386: add support for VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE

Paolo Bonzini (13):
      configure: fix and complete detection of tricore tools
      dockerfiles: bump tricore cross compiler container to Debian 11
      python: mkvenv: tweak the matching of --diagnose to depspecs
      python: mkvenv: introduce TOML-like representation of dependencies
      python: mkvenv: add ensuregroup command
      lcitool: bump libvirt-ci submodule and regenerate
      configure: never use PyPI for Meson
      python: use vendored tomli
      configure: switch to ensuregroup
      Revert "tests: Use separate virtual environment for avocado"
      tests/docker: add python3-tomli dependency to containers
      configure: fix container_hosts misspellings and duplications
      configure: remove unnecessary mkdir -p

 .gitlab-ci.d/buildtest.yml                         |   6 +-
 .gitlab-ci.d/cirrus/freebsd-13.vars                |   2 +-
 .gitlab-ci.d/cirrus/macos-12.vars                  |   2 +-
 configure                                          |  31 +---
 docs/devel/acpi-bits.rst                           |   6 +-
 docs/devel/testing.rst                             |  14 +-
 python/scripts/mkvenv.py                           | 201 +++++++++++++++++++--
 python/scripts/vendor.py                           |   5 +-
 python/setup.cfg                                   |   6 +
 python/wheels/tomli-2.0.1-py3-none-any.whl         | Bin 0 -> 12757 bytes
 pythondeps.toml                                    |  32 ++++
 scripts/ci/org.centos/stream/8/x86_64/test-avocado |   4 +-
 scripts/device-crash-test                          |   2 +-
 target/i386/cpu.c                                  |   6 +-
 target/i386/cpu.h                                  |   1 +
 tests/Makefile.include                             |  19 +-
 tests/docker/dockerfiles/centos8.docker            |   3 +-
 .../dockerfiles/debian-all-test-cross.docker       |   7 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |   6 +-
 tests/docker/dockerfiles/debian-amd64.docker       |   4 +
 tests/docker/dockerfiles/debian-arm64-cross.docker |   6 +-
 tests/docker/dockerfiles/debian-armel-cross.docker |   6 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   6 +-
 .../docker/dockerfiles/debian-hexagon-cross.docker |   6 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   6 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   6 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   6 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   6 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |   4 +-
 tests/docker/dockerfiles/fedora-i386-cross.docker  |   1 +
 tests/docker/dockerfiles/fedora-win32-cross.docker |   2 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |   2 +-
 tests/docker/dockerfiles/opensuse-leap.docker      |  22 +--
 tests/docker/dockerfiles/ubuntu2004.docker         |   4 +-
 tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/mappings.yml                         |  28 ++-
 tests/lcitool/projects/qemu.yml                    |   3 +-
 tests/lcitool/targets/opensuse-leap-15.yml         |   4 +-
 tests/requirements.txt                             |   6 -
 tests/vm/Makefile.include                          |   2 +-
 tests/vm/generated/freebsd.json                    |   1 +
 43 files changed, 377 insertions(+), 112 deletions(-)
 create mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl
 create mode 100644 pythondeps.toml
 delete mode 100644 tests/requirements.txt
-- 
2.41.0


