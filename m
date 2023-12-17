Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E0815FEF
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:44:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLR-0005Om-St; Sun, 17 Dec 2023 09:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLO-0005OM-HH; Sun, 17 Dec 2023 09:42:14 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLM-0003Kj-8r; Sun, 17 Dec 2023 09:42:14 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a2340c803c6so50136866b.0; 
 Sun, 17 Dec 2023 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824129; x=1703428929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nu6nZvxGn0jdyvmY0vOlKQPzyEv8O1GHa7NdecVZAFo=;
 b=CWW4C8QKQkwbaItU44ACDLYwnYpAb0dnAE60+FtLILucjHW6vfWQdRRqnr1j2wtrpB
 +rcY2mcct88XCZ29cgZzGouWx3JiG63Uip1/eZjK4qOI85jSDAC5RSjUMXR7IBAgWjbt
 ht0NG+iq6NHMY+S8OMCqxep03BjmnQ9LtGcPGxszTEbhx50zFzUDoZRY6JQPLpw2g+eG
 m8OB6+c+aKHzfAMQuVa+q4N1ILneXThegJpG8y0Bm5cCA354mxLgMNkitHH8dOgZ50Og
 VJy36HiTNNKxMylwTtV43eq9qSnOJx7kmQohukh9OglD2jQz5xvz9Vn8Ce97i0Iv8AKi
 8X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824129; x=1703428929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nu6nZvxGn0jdyvmY0vOlKQPzyEv8O1GHa7NdecVZAFo=;
 b=srNpokbpNwRnev/lEz9INd6lNAU2Mrhkf87l6aQbMVVJzeab2qcHnoI+M0JkuuGmhb
 hr+ajfrS15Z7qgPFIrgYYdo5dkzk2514i9BvchsD/de8LnFH9m5at/w3fDvQQkiYzvIH
 59wZ73XgPC1zwO3iniJ6sbJ3xTfyqf3aZY2M7OibSVLGJ6dFGL96/70iSaZjstjXAVh+
 pIDdsiyNn1gWXtPgYiZ67xJ5bwDEAkFYxh/UfnIuwFd7SPbcv9LW+eyiK5xRZKGfEULG
 /JBqF7x/ovIqrulfgPKab9HQIBeha8INUGd+f0XJsaWCAaGwOyf/dBaK/z8oYiyUhj9m
 JK0g==
X-Gm-Message-State: AOJu0YwxOfHjYWKoFS3AeXpZezf85qtqkfw8ERpIfbozGZ2mImU2kbh6
 rd55Gwq+w01WQagQ34KFwpTex11eb8A=
X-Google-Smtp-Source: AGHT+IF7PWv3K4Gh336CSeX8tsyz5GfJZCHWpspdVmdtjFaGNATuicQdBbuutGdYDs78nw0dMEpr1g==
X-Received: by 2002:a17:907:9445:b0:a1d:32c0:fc37 with SMTP id
 dl5-20020a170907944500b00a1d32c0fc37mr6940054ejc.53.1702824128967; 
 Sun, 17 Dec 2023 06:42:08 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:08 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 03/12] hw/block/fdc-isa: Rename header to match source file
Date: Sun, 17 Dec 2023 15:41:39 +0100
Message-ID: <20231217144148.15511-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Rename the header which allows for exposing fdc-internal.h (dropping the
-internal suffix) which in turn allows for exposing struct FDCtrlISABus.
Exposing a device struct is in line with OOM/qdev guidelines.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                           | 2 +-
 hw/block/fdc-internal.h               | 2 +-
 include/hw/block/{fdc.h => fdc-isa.h} | 4 ++--
 hw/block/fdc-isa.c                    | 2 +-
 hw/block/fdc-sysbus.c                 | 2 +-
 hw/block/fdc.c                        | 2 +-
 hw/i386/pc.c                          | 2 +-
 hw/isa/isa-superio.c                  | 2 +-
 hw/mips/jazz.c                        | 2 +-
 hw/sparc/sun4m.c                      | 2 +-
 hw/sparc64/sun4u.c                    | 2 +-
 stubs/cmos.c                          | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)
 rename include/hw/block/{fdc.h => fdc-isa.h} (92%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34f..b4718fcf59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1948,7 +1948,7 @@ F: hw/block/fdc.c
 F: hw/block/fdc-internal.h
 F: hw/block/fdc-isa.c
 F: hw/block/fdc-sysbus.c
-F: include/hw/block/fdc.h
+F: include/hw/block/fdc-isa.h
 F: tests/qtest/fdc-test.c
 T: git https://gitlab.com/jsnow/qemu.git ide
 
diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
index 036392e9fc..1728231a26 100644
--- a/hw/block/fdc-internal.h
+++ b/hw/block/fdc-internal.h
@@ -28,7 +28,7 @@
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "hw/block/block.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "qapi/qapi-types-block.h"
 
 typedef struct FDCtrl FDCtrl;
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc-isa.h
similarity index 92%
rename from include/hw/block/fdc.h
rename to include/hw/block/fdc-isa.h
index 35248c0837..95807fdc65 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc-isa.h
@@ -1,5 +1,5 @@
-#ifndef HW_FDC_H
-#define HW_FDC_H
+#ifndef HW_FDC_ISA_H
+#define HW_FDC_ISA_H
 
 #include "exec/hwaddr.h"
 #include "qapi/qapi-types-block.h"
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 7ec075e470..6387dc94fa 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -28,7 +28,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 86ea51d003..f18f0d19b0 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "hw/sysbus.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "migration/vmstate.h"
 #include "fdc-internal.h"
 #include "trace.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index d7cc4d3ec1..2bd6d925b5 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -28,7 +28,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0d732b7530..aeecf56e72 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/i386/pc.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/hyperv/hv-balloon.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 7dbfc374da..ea6cb4213f 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -17,7 +17,7 @@
 #include "sysemu/blockdev.h"
 #include "chardev/char.h"
 #include "hw/char/parallel.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "hw/isa/superio.h"
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index d33a76ad4d..bc74d1fd96 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -31,7 +31,7 @@
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/isa/isa.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "net/net.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 17bf5f2879..751e52b282 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -34,7 +34,7 @@
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
 #include "hw/sparc/sparc32_dma.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c871170378..9a88772f6f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -39,7 +39,7 @@
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
 #include "hw/input/i8042.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 #include "net/net.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
diff --git a/stubs/cmos.c b/stubs/cmos.c
index 3fdbae2c69..32d921e065 100644
--- a/stubs/cmos.c
+++ b/stubs/cmos.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/block/fdc.h"
+#include "hw/block/fdc-isa.h"
 
 int cmos_get_fd_drive_type(FloppyDriveType fd0)
 {
-- 
2.43.0


