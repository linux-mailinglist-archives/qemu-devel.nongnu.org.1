Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26CE7C9F9D
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8c-0003rg-3D; Mon, 16 Oct 2023 02:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8a-0003rU-AK
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8Y-0005Qy-MK
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cgI3E7SNjjA4N3eE0I3y5b6egd29VWH8e2xfnpZN+q8=;
 b=favsJfU1CNxPWaBIvF2ckWDirOZVQcpoHqj9HBzv7t/lG7zs+5VUvEm9ZJWi+kdL60xTp9
 j0Nui4TOfpFYRL5IQ1wEHfCBlDSUZXPnw1bElvXquxWo3mLEaEdOrdjVMxbE2BfrzWkSCv
 +oJNwu3+MnOZYWbjVwIDMCWCNCkOu2M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-L1oPeeCdOxGE1XmEinrenw-1; Mon, 16 Oct 2023 02:31:31 -0400
X-MC-Unique: L1oPeeCdOxGE1XmEinrenw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b99b6b8315so301385066b.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437889; x=1698042689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cgI3E7SNjjA4N3eE0I3y5b6egd29VWH8e2xfnpZN+q8=;
 b=mcQ3iE1pQUwCpeAQZm7SbiyifLh/6zMyi0ng48z7zZl/2T/jKVe/ayFAFEPm43vLr4
 M3R5zUdJzFuFYWIC+HG8SFw8DorrR7zDyg9wQ0rpCV3YRNo6Fe4Ijl/xAaQHw4v26Rkf
 VV0dhOg6/4r4nTLTFwKXB++QG23yDt8Es3H3b+bD+lxJBiRgDXakbGSnC2CzIYnydNM/
 q1uEjw+a7qiM+5ITBlOnQcNKITBx41IwIMrJOPtmKoYBe4hmCCxnCZN4R1fHbt25Bxmf
 e02CkWbJzKj5my0PnY9ePAfrlaZZG1p/PuUpV7NHJPlcWaaachEWs+YjIioH4BqUVgqd
 1nNQ==
X-Gm-Message-State: AOJu0YxWBp3Mmu4wosurgIuhtS+yjtQIqIt2NrENeOyKj7HEAjGNR8QE
 zuWSS+Y8URM5dPZNxqqCCXUtf88BvzRaZEAaQifGWZSWUSXR0wkg1ALXLgB/VcrFUSXSYU1Z+x0
 EKdbf4jMaSGps3UCWGtihdFa06qaCsIQygWmerlwmjdn/QT62XjoMKy5vIpdn5rePpr7701ZfdY
 0=
X-Received: by 2002:a17:906:99c2:b0:9be:7b67:1674 with SMTP id
 s2-20020a17090699c200b009be7b671674mr5616600ejn.3.1697437889543; 
 Sun, 15 Oct 2023 23:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEePmq6MUz47iZTa1TeYpbiEWWqCCiLri3+ek94QgQ5zxuTBFKcyc9KZuFWl1UvXUUQ2YkeZA==
X-Received: by 2002:a17:906:99c2:b0:9be:7b67:1674 with SMTP id
 s2-20020a17090699c200b009be7b671674mr5616586ejn.3.1697437889161; 
 Sun, 15 Oct 2023 23:31:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 gx8-20020a1709068a4800b0098f99048053sm3422195ejc.148.2023.10.15.23.31.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/17] More build system cleanups,
 optional non-relocatable installs
Date: Mon, 16 Oct 2023 08:31:10 +0200
Message-ID: <20231016063127.161204-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

This mostly removes or simplifies some option parsing code, with some extra
items of interest:

- support for non-relocatable installs, which Michael Tokarev requested
  a while ago.

- the main change outside configure and meson.build is a simplification
  of GDB conditionals, by unifying HAVE_GDB_BIN and HOST_GDB_SUPPORTS_ARCH
  in tests/tcg.

- on the "future work" side, patch 2 adds a macro IS_ENABLED() that can
  be used in the future to replace #ifdef statements with "if()" so that
  both sides are compiled.

- qemu-ga parameters (manufacturer, distro, version) can be configured
  with command-line options in addition to environment variables

- finally, some changes to add comments or put related code together

Paolo

Paolo Bonzini (17):
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

 configs/meson/windows.txt                     |   9 +
 configure                                     | 250 +++++++-----------
 hw/arm/meson.build                            |   1 -
 hw/i386/meson.build                           |   1 -
 hw/remote/meson.build                         |   4 +-
 .../remote/vfio-user-obj-stub.c               |   0
 hw/xen/meson.build                            |  11 +-
 include/qemu/compiler.h                       |  15 ++
 meson.build                                   |  32 ++-
 meson_options.txt                             |   9 +
 qga/meson.build                               |   9 +-
 scripts/meson-buildoptions.py                 |  32 ++-
 scripts/meson-buildoptions.sh                 |  26 +-
 stubs/meson.build                             |   1 -
 tests/tcg/aarch64/Makefile.target             |  16 +-
 tests/tcg/multiarch/Makefile.target           |  18 +-
 .../multiarch/system/Makefile.softmmu-target  |  15 +-
 tests/tcg/s390x/Makefile.target               |   6 +-
 tests/unit/test-coroutine.c                   |   2 +-
 ui/shader/meson.build                         |   1 +
 util/cutils.c                                 |  11 +-
 util/qemu-coroutine.c                         |   4 +-
 22 files changed, 251 insertions(+), 222 deletions(-)
 create mode 100644 configs/meson/windows.txt
 rename stubs/vfio-user-obj.c => hw/remote/vfio-user-obj-stub.c (100%)

-- 
2.41.0


