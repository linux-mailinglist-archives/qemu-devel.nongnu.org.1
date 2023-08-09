Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6677565E
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfVi-0004WZ-2C; Wed, 09 Aug 2023 05:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVc-0004WH-W2
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVb-0003Ze-A0
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=twbGeDDCOf1axOVHV2Bwy5zsl10Cls1OIYokTZajOxQ=;
 b=Vead5npSxPXt5VcYXVEJTCeAnRdR9GZufkOqvwPS+Dsus/gaLOUKU/dJO6G3pUa30Vt04A
 079w4PF2YUtXNI6bjPdP4cLkg66uoB0GKyNVZSSbqwMi3CP06y+6h93CkitJce0KjomfDu
 a2U1Y5Uh6yx32e2RD20b+WhBoRVjgL8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-xplgeizON2aiZbneLmLPgw-1; Wed, 09 Aug 2023 05:29:36 -0400
X-MC-Unique: xplgeizON2aiZbneLmLPgw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe661c0323so9412255e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573375; x=1692178175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twbGeDDCOf1axOVHV2Bwy5zsl10Cls1OIYokTZajOxQ=;
 b=U4Jkd7zZj8Uce1EtBuM82JAJ5s98yhDlN3CTXtlVMMspSk+MM8pawAjXHbfDW7PG2m
 9ZeyFxQAXOtum6MgsQuFwwzdrDfS8ZkP62JXmsjUvmtuos8SoOZ8tUTyFFQdM/7EE56W
 Fyogh3apc5dvVGbqV/1jCsYdXK164A+hanO1aQ/O8FFwsObl3ZnbTRDVKXcrIHBRk0sL
 H7VL99XZ/cT0AU8BIaqDrM2GX2y5jE1A4Bvf0+BJPCgt9xJrYwJvsN/YO8HIUO7sYVL7
 /e4/2ifcMMIDQMf/iTf+A8fa+dWGdcZ8C0dy9iVesda+QlI1Q8zmFWUR5Si7BvQJWLao
 ESEg==
X-Gm-Message-State: AOJu0YyAxrb3CL0QtTRGVr0Gm+st2Aybo+4BXTFa8YClcH2PqgGCIsHK
 iOzlFcjmVctWeIBVARz8N0YpH8H/NUmpFj2in56NsAt4x8t30732I7GbQ2gQT8oa9Rp3FYgQBun
 WJb0exsA4lmUVYG7pB1a3h0a9zjzb27PdHyUY1+ESR7TJLsazfyefvzoGnuiEMKrOyVT6tlu8/B
 M=
X-Received: by 2002:a05:600c:5109:b0:3fe:f45:772d with SMTP id
 o9-20020a05600c510900b003fe0f45772dmr1778593wms.28.1691573374943; 
 Wed, 09 Aug 2023 02:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqrUy9o11a5zFgXhH4vxu025CYK84LSrjXmeqVj9SJghVFPtCBjmrmNJFGJHjwEMMnSmSIyQ==
X-Received: by 2002:a05:600c:5109:b0:3fe:f45:772d with SMTP id
 o9-20020a05600c510900b003fe0f45772dmr1778577wms.28.1691573374460; 
 Wed, 09 Aug 2023 02:29:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a5d5288000000b00315af025098sm16163639wrv.46.2023.08.09.02.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 0/9] Use known good releases when installing in pyvenv
Date: Wed,  9 Aug 2023 11:29:24 +0200
Message-ID: <20230809092933.761524-1-pbonzini@redhat.com>
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

This series introduce a new installation command for mkvenv.py that
retrieves the packages to be installed from a TOML file. This allows
being more flexible in using the system version of a package, while at
the same time using a known-good version when installing the package.
This is important for packages that sometimes have backwards-incompatible
changes or that depend on specific versions of their dependencies.
    
For example, in the case of sphinx we can always use the last version
that supports older versions of Python and especially docutils (Ubuntu
20.04 for example would not support sphinx 6.0), and in the case of
Avocado we can avoid installing a package that conflicts with any
plugins already existing in the system package path.  This in turn
enables using the same virtual environment for both the build and
qemu-iotests.  John has patches for this.

For the configuration file, TOML was chosen because it was more human
readable and easier to edit than JSON.  A parser is available in the
Python 3.11 standard library; for older versions, the API-compatible
replacement tomli is very small (12k).  I am introducing it as a vendored
.whl file because it is not installed by default in most distros (unlike
pip and setuptools which were introduced in 8.0) and because Debian
11 only has it in bullseye-backports.  However, if preferred the patch
"python: use vendored tomli" can be dropped.  In that case, tomli will
have to be installed from either PyPI or bullseye-backports.

While tomli is bundled with pip, this is only true of recent versions
of pip.  Of all the supported OSes pretty much only FreeBSD has a recent
enough version of pip while staying on Python <3.11.  So we cannot use
the same trick that is in place for distlib.

In order to pick the tomli mapping, lcitool is updated to a recent
version.  As a side effect this updates from LEAP 15.4 to 15.5.

Paolo
    

Paolo Bonzini (9):
  python: mkvenv: tweak the matching of --diagnose to depspecs
  python: mkvenv: introduce TOML-like representation of dependencies
  python: mkvenv: add ensuregroup command
  lcitool: bump libvirt-ci submodule and regenerate
  configure: never use PyPI for Meson
  python: use vendored tomli
  configure: switch to ensuregroup
  Revert "tests: Use separate virtual environment for avocado"
  tests/docker: add python3-tomli dependency to containers

 .gitlab-ci.d/buildtest.yml                    |   6 +-
 .gitlab-ci.d/cirrus/freebsd-13.vars           |   2 +-
 .gitlab-ci.d/cirrus/macos-12.vars             |   2 +-
 configure                                     |  22 +-
 docs/devel/acpi-bits.rst                      |   6 +-
 docs/devel/testing.rst                        |  14 +-
 python/scripts/mkvenv.py                      | 201 ++++++++++++++++--
 python/scripts/vendor.py                      |   5 +-
 python/setup.cfg                              |   9 +
 python/wheels/tomli-2.0.1-py3-none-any.whl    | Bin 0 -> 12757 bytes
 pythondeps.toml                               |  32 +++
 .../org.centos/stream/8/x86_64/test-avocado   |   4 +-
 scripts/device-crash-test                     |   2 +-
 tests/Makefile.include                        |  19 +-
 tests/docker/dockerfiles/centos8.docker       |   3 +-
 .../dockerfiles/debian-all-test-cross.docker  |   7 +-
 .../dockerfiles/debian-amd64-cross.docker     |   6 +-
 tests/docker/dockerfiles/debian-amd64.docker  |   4 +
 .../dockerfiles/debian-arm64-cross.docker     |   6 +-
 .../dockerfiles/debian-armel-cross.docker     |   6 +-
 .../dockerfiles/debian-armhf-cross.docker     |   6 +-
 .../dockerfiles/debian-hexagon-cross.docker   |   6 +-
 .../dockerfiles/debian-mips64el-cross.docker  |   6 +-
 .../dockerfiles/debian-mipsel-cross.docker    |   6 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   6 +-
 .../dockerfiles/debian-riscv64-cross.docker   |   2 +-
 .../dockerfiles/debian-s390x-cross.docker     |   6 +-
 .../dockerfiles/debian-tricore-cross.docker   |   2 +
 .../dockerfiles/fedora-i386-cross.docker      |   1 +
 .../dockerfiles/fedora-win32-cross.docker     |   2 +-
 .../dockerfiles/fedora-win64-cross.docker     |   2 +-
 tests/docker/dockerfiles/opensuse-leap.docker |  23 +-
 tests/docker/dockerfiles/ubuntu2004.docker    |   4 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |   1 +
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/mappings.yml                    |  27 ++-
 tests/lcitool/projects/qemu.yml               |   3 +-
 tests/lcitool/targets/opensuse-leap-15.yml    |   4 +-
 tests/requirements.txt                        |   6 -
 tests/vm/Makefile.include                     |   2 +-
 tests/vm/generated/freebsd.json               |   1 +
 41 files changed, 371 insertions(+), 103 deletions(-)
 create mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl
 create mode 100644 pythondeps.toml
 delete mode 100644 tests/requirements.txt

-- 
2.41.0


