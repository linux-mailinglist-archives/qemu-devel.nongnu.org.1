Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493E7B9ACD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMW-0001eE-R5; Thu, 05 Oct 2023 00:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGMR-00016n-Cm
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:53:19 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGML-0007tW-QH
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:53:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32336a30d18so508689f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481591; x=1697086391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZHDirR49kl/OFImSRD5/SXCqBaJRHCMrzCJafFdwgU=;
 b=e16dIs3uX495oLA7QAm1Vn71fFyMty1QBbJcKCAZZRBn56MLQI7TW5vkKngx5WHYD2
 8Lc4mVSz/9QWjOzTJHstR5II/jd0AT/cGDwFikb2PYrnBChs35/4WHzXRm4gneAFv8BK
 74+Se9buwPK3i9dfG6FMzi9eWxDowewLQvXtUfU4bxoYEsfF2/tMAye2pc7TQ6KiSKYY
 YkPhqIaxM+qk3Rfd6KzXggpf3il5ERT+zjw0xcpkMz6xfvm9xY1uoRGTnoyU8QrBcdJv
 yBWlniCrAYaMVPFCqYV7scBuBhEB2Qe3oni3TCnFEZIdsWZ0E9frnyjofLdoP8oXCT07
 Uxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481591; x=1697086391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZHDirR49kl/OFImSRD5/SXCqBaJRHCMrzCJafFdwgU=;
 b=lMk6qXg4l2JR1/ein+bM/EgfdtDqVHcZvcjZ+u902O69guVkfYsU4tydfyaBHI1knp
 jSeBuEpzV+sN2ApldvcS6lbo2ZpbTs9T3LbLWCDrdEDNwSFils0BKJVuh44bHSyvxVpF
 eYr9dxeVfPJnW1st3J12Ye9Nw+/lPhQP6/BxiinKXOpg0+WrNVOIbIod6mw5191Q2qPs
 bZ6QntpLoLRZ2NbZnCvG8XTSGkP2qZbLXzRNZvCu/hJnkQkwGqtpPDZRfK2d/VNHygtN
 EmAnyvnFKxItbUUpDUIbnTOrDPs0wX5fgLubRXAebvaedIwNh8MVSu10jh/MiqL6uh8T
 YK5Q==
X-Gm-Message-State: AOJu0Yw8IblT85ADMNnRzH8PIGCUsMKaef95f5csE4umCI1zNIgv3B8D
 5mQI8ZOsrkzEpBfAn8Oe791Idd15WBCTeV44hPc=
X-Google-Smtp-Source: AGHT+IGOU9Cr6LaHaPv01UHjez5gEFeG7savt3aXKW+EuwwGIZFthThiUu3a5COp8BBtHmitL8S+HQ==
X-Received: by 2002:adf:f286:0:b0:31f:db1b:7296 with SMTP id
 k6-20020adff286000000b0031fdb1b7296mr3919088wro.21.1696481590888; 
 Wed, 04 Oct 2023 21:53:10 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 w17-20020a5d4b51000000b0031ad5fb5a0fsm755396wrs.58.2023.10.04.21.53.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:53:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org
Subject: [PATCH v2 22/22] qapi: Remove 'qapi/qmp/qerror.h' header
Date: Thu,  5 Oct 2023 06:50:39 +0200
Message-ID: <20231005045041.52649-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This file is now empty. Avoid new definitions by killing it,
paying off a 8 years old debt (with interests).

Mechanical change using:

  $ git grep -l qapi/qmp/qerror.h | while read f; do \
      gawk -i inplace '/#include "qapi\/qmp\/qerror.h"/ && !p {p++;next}1' $f; \
    done
  $ git rm include/qapi/qmp/qerror.h

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/qapi/qmp/qerror.h        | 20 --------------------
 backends/cryptodev-vhost-user.c  |  1 -
 backends/dbus-vmstate.c          |  1 -
 backends/rng-egd.c               |  1 -
 backends/rng-random.c            |  1 -
 block/gluster.c                  |  1 -
 block/monitor/block-hmp-cmds.c   |  1 -
 block/quorum.c                   |  1 -
 block/snapshot.c                 |  1 -
 block/vmdk.c                     |  1 -
 blockdev.c                       |  1 -
 blockjob.c                       |  1 -
 chardev/char-fe.c                |  1 -
 chardev/char.c                   |  1 -
 dump/dump.c                      |  1 -
 dump/win_dump.c                  |  1 -
 hw/core/qdev-properties-system.c |  1 -
 hw/core/qdev-properties.c        |  1 -
 hw/core/qdev.c                   |  1 -
 hw/intc/openpic.c                |  1 -
 hw/ppc/spapr_pci.c               |  1 -
 hw/usb/redirect.c                |  1 -
 migration/migration.c            |  1 -
 migration/options.c              |  1 -
 migration/page_cache.c           |  1 -
 migration/ram.c                  |  1 -
 migration/savevm.c               |  1 -
 monitor/fds.c                    |  1 -
 monitor/hmp-cmds.c               |  1 -
 monitor/qmp-cmds.c               |  1 -
 net/filter-buffer.c              |  1 -
 net/filter.c                     |  1 -
 net/net.c                        |  1 -
 qapi/opts-visitor.c              |  1 -
 qapi/qapi-forward-visitor.c      |  1 -
 qapi/qapi-util.c                 |  1 -
 qapi/qapi-visit-core.c           |  1 -
 qapi/qobject-input-visitor.c     |  1 -
 qapi/string-input-visitor.c      |  1 -
 qga/commands-bsd.c               |  1 -
 qga/commands-posix.c             |  1 -
 qga/commands-win32.c             |  1 -
 qga/commands.c                   |  1 -
 qom/object.c                     |  1 -
 qom/object_interfaces.c          |  1 -
 qom/qom-qmp-cmds.c               |  1 -
 softmmu/balloon.c                |  1 -
 softmmu/cpus.c                   |  1 -
 softmmu/qdev-monitor.c           |  1 -
 softmmu/rtc.c                    |  1 -
 softmmu/tpm.c                    |  1 -
 softmmu/vl.c                     |  1 -
 target/arm/arm-qmp-cmds.c        |  1 -
 target/i386/cpu.c                |  1 -
 target/s390x/cpu_models_sysemu.c |  1 -
 ui/input-barrier.c               |  1 -
 ui/ui-qmp-cmds.c                 |  1 -
 util/block-helpers.c             |  1 -
 util/qemu-option.c               |  1 -
 scripts/qapi/visit.py            |  1 -
 60 files changed, 79 deletions(-)
 delete mode 100644 include/qapi/qmp/qerror.h

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
deleted file mode 100644
index 7606f4525d..0000000000
--- a/include/qapi/qmp/qerror.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * QError Module
- *
- * Copyright (C) 2009 Red Hat Inc.
- *
- * Authors:
- *  Luiz Capitulino <lcapitulino@redhat.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- */
-#ifndef QERROR_H
-#define QERROR_H
-
-/*
- * These macros will go away, please don't use in new code, and do not
- * add new ones!
- */
-
-#endif /* QERROR_H */
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index d93ccd5528..5a41aa7be8 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -23,7 +23,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/vhost-user.h"
 #include "standard-headers/linux/virtio_crypto.h"
diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index e781ded17c..0006f8c400 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -16,7 +16,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "qapi/qmp/qerror.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 8f101afadc..35f19257bd 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -14,7 +14,6 @@
 #include "sysemu/rng.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 
diff --git a/backends/rng-random.c b/backends/rng-random.c
index 9cb7d26cb5..a49e4a4970 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -14,7 +14,6 @@
 #include "sysemu/rng-random.h"
 #include "sysemu/rng.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 
diff --git a/block/gluster.c b/block/gluster.c
index 8d97d698c3..91df6f1d07 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -16,7 +16,6 @@
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 90e593ed38..9c3d3bedc6 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -43,7 +43,6 @@
 #include "qapi/qapi-commands-block-export.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
diff --git a/block/quorum.c b/block/quorum.c
index 8e9f279568..34ebbf4ce0 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/hash.h"
diff --git a/block/snapshot.c b/block/snapshot.c
index eb43e957e1..131b4bd6d0 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -28,7 +28,6 @@
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/option.h"
 #include "sysemu/block-backend.h"
diff --git a/block/vmdk.c b/block/vmdk.c
index 6779a181f0..ed9742f9da 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -28,7 +28,6 @@
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/blockdev.c b/blockdev.c
index 228cebf9a2..5a76bb1498 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -50,7 +50,6 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-output-visitor.h"
 #include "sysemu/sysemu.h"
diff --git a/blockjob.c b/blockjob.c
index f95f73244e..d359ea72e5 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -32,7 +32,6 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block-core.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 7d33b3ccd1..ff4cee00fc 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 
 #include "chardev/char-fe.h"
diff --git a/chardev/char.c b/chardev/char.c
index 447b4d9d06..cc61f3a6e7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -32,7 +32,6 @@
 #include "chardev/char.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
diff --git a/dump/dump.c b/dump/dump.c
index 642b952985..daa0c69305 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-dump.h"
 #include "qapi/qapi-events-dump.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "hw/misc/vmcoreinfo.h"
diff --git a/dump/win_dump.c b/dump/win_dump.c
index 0115a609e0..1772db8530 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -12,7 +12,6 @@
 #include "sysemu/dump.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qerror.h"
 #include "exec/cpu-defs.h"
 #include "hw/core/cpu.h"
 #include "qemu/win_dump_defs.h"
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 7752c5fda5..ec68281b61 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -18,7 +18,6 @@
 #include "qapi/qapi-types-block.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-migration.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 44fc1686e0..5005954b50 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,7 +2,6 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9b62e0573d..165ce95a11 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-qdev.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 4f6ee930e2..991b2efa25 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -41,7 +41,6 @@
 #include "hw/pci/msi.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7f063f5852..a24755c8ff 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -39,7 +39,6 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qerror.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 83bfc9dc19..1147e8d018 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -32,7 +32,6 @@
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/migration/migration.c b/migration/migration.c
index 5703cc34ae..a6b3e83867 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -42,7 +42,6 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
 #include "block.h"
diff --git a/migration/options.c b/migration/options.c
index 7360a22252..777200e65a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "sysemu/runstate.h"
 #include "migration/colo.h"
diff --git a/migration/page_cache.c b/migration/page_cache.c
index d430ce742b..af6683c45e 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -14,7 +14,6 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "page_cache.h"
diff --git a/migration/ram.c b/migration/ram.c
index 0a4a0d7a0e..a5f05c5832 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -47,7 +47,6 @@
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qapi-commands-migration.h"
-#include "qapi/qmp/qerror.h"
 #include "trace.h"
 #include "exec/ram_addr.h"
 #include "exec/target_page.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index c0e0585bc1..3c49f2dbff 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -45,7 +45,6 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
diff --git a/monitor/fds.c b/monitor/fds.c
index 17e9c126e3..4882db3232 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -26,7 +26,6 @@
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "sysemu/runstate.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9d6533643d..912471f419 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -24,7 +24,6 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/cutils.h"
 #include "hw/intc/intc.h"
 #include "qemu/log.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 2d2e71b867..c2d81b2f77 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -27,7 +27,6 @@
 #include "qapi/qapi-init-commands.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/type-helpers.h"
 #include "hw/mem/memory-device.h"
 #include "hw/intc/intc.h"
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 071029a6c7..46738415b7 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -13,7 +13,6 @@
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
 #include "qom/object.h"
 
 #define TYPE_FILTER_BUFFER "filter-buffer"
diff --git a/net/filter.c b/net/filter.c
index 1621513bab..8ff1eae923 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 
 #include "net/filter.h"
diff --git a/net/net.c b/net/net.c
index 5cdbd9c218..fdfe4f8eb1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -37,7 +37,6 @@
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index bf0d8acbd6..7b595bb00b 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/opts-visitor.h"
 #include "qemu/queue.h"
 #include "qemu/option_int.h"
diff --git a/qapi/qapi-forward-visitor.c b/qapi/qapi-forward-visitor.c
index 3fb2c954aa..613e6d0f19 100644
--- a/qapi/qapi-forward-visitor.c
+++ b/qapi/qapi-forward-visitor.c
@@ -17,7 +17,6 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 82c3425566..f144ac1f70 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -14,7 +14,6 @@
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qemu/ctype.h"
-#include "qapi/qmp/qerror.h"
 
 CompatPolicy compat_policy;
 
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 01793d6e74..a3214fa1a1 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/visitor-impl.h"
 #include "trace.h"
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 17e9f3b638..82b33b6b64 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -22,7 +22,6 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 6ea6a0c676..bb1c43a6d7 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -14,7 +14,6 @@
 #include "qapi/error.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/visitor-impl.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 11536f148f..5508bc02ab 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "qga-qapi-commands.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
 #include "commands-common.h"
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index f510add366..6ea8a03e61 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -18,7 +18,6 @@
 #include <dirent.h>
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/host-utils.h"
 #include "qemu/sockets.h"
 #include "qemu/base64.h"
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 5c9f8e0923..db973c2e7e 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -32,7 +32,6 @@
 #include "vss-win32.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/queue.h"
 #include "qemu/host-utils.h"
 #include "qemu/base64.h"
diff --git a/qga/commands.c b/qga/commands.c
index 936634c50a..738d3d9da6 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -15,7 +15,6 @@
 #include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 #include "commands-common.h"
diff --git a/qom/object.c b/qom/object.c
index eea61a5068..66b02c0f22 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -23,7 +23,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "trace.h"
 
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index be04b2c5ab..391ea8561b 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -5,7 +5,6 @@
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 3d014f1bea..67ab1774eb 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -21,7 +21,6 @@
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
diff --git a/softmmu/balloon.c b/softmmu/balloon.c
index d941c6b9c1..f2545a6e58 100644
--- a/softmmu/balloon.c
+++ b/softmmu/balloon.c
@@ -30,7 +30,6 @@
 #include "sysemu/balloon.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qerror.h"
 #include "trace.h"
 
 static QEMUBalloonEvent *balloon_event_fn;
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index f7c743b0ce..bee6afbd6d 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -29,7 +29,6 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
-#include "qapi/qmp/qerror.h"
 #include "exec/gdbstub.h"
 #include "sysemu/hw_accel.h"
 #include "exec/cpu-common.h"
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index b7b2bf18d4..9d608d5d65 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -27,7 +27,6 @@
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/config-file.h"
diff --git a/softmmu/rtc.c b/softmmu/rtc.c
index 4904581abe..dc44576686 100644
--- a/softmmu/rtc.c
+++ b/softmmu/rtc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
diff --git a/softmmu/tpm.c b/softmmu/tpm.c
index 3a7d4b5c67..aee351e896 100644
--- a/softmmu/tpm.c
+++ b/softmmu/tpm.c
@@ -16,7 +16,6 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-tpm.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
 #include "qemu/config-file.h"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 840ac84069..8bfe51fce4 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -129,7 +129,6 @@
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qapi-commands-ui.h"
 #include "block/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3c99fd8222..dabe89e4bc 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -28,7 +28,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/qom-qobject.h"
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 273f865228..53124f5319 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -31,7 +31,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-visit-machine.h"
-#include "qapi/qmp/qerror.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 4507714493..4b3fd70ea1 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -17,7 +17,6 @@
 #include "sysemu/kvm.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qapi-commands-machine-target.h"
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index ecbba4adc2..8df118b440 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -21,7 +21,6 @@
 #include "qom/object.h"
 #include "ui/vnc_keysym.h" /* use name2keysym from VNC as we use X11 values */
 #include "qemu/cutils.h"
-#include "qapi/qmp/qerror.h"
 #include "input-barrier.h"
 
 #define TYPE_INPUT_BARRIER "input-barrier"
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 0e350fc333..a7ce9c1892 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -18,7 +18,6 @@
 #include "io/channel-file.h"
 #include "monitor/qmp-helpers.h"
 #include "qapi/qapi-commands-ui.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/coroutine.h"
 #include "qemu/cutils.h"
 #include "trace.h"
diff --git a/util/block-helpers.c b/util/block-helpers.c
index de94909bc4..85b53e30d2 100644
--- a/util/block-helpers.c
+++ b/util/block-helpers.c
@@ -10,7 +10,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "block-helpers.h"
 
 /**
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9440224e5b..6b86792ae7 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -31,7 +31,6 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 4b4a442383..a21b7b1468 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -356,7 +356,6 @@ def _begin_user_module(self, name: str) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "%(visit)s.h"
 ''',
                                       visit=visit))
-- 
2.41.0


