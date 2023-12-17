Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB343815FF0
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:44:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLV-0005Ts-FC; Sun, 17 Dec 2023 09:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLT-0005TI-GA; Sun, 17 Dec 2023 09:42:19 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLR-0003Ly-Li; Sun, 17 Dec 2023 09:42:19 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ca1e6a94a4so24722471fa.0; 
 Sun, 17 Dec 2023 06:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824134; x=1703428934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/yfz/Oz7PgaZpg2L46eI+iLvMEK6kukMkwMnMerSK4=;
 b=Mv2oX/AkBxy3jABEZKtargcgDhn6hmq+TIsEShnB4yp5zQnMSCNuceNUtc7sD+MxI+
 CnjdU8L11WldyxwNg6VwxIEF+/Wxd++3CzQBgSnRyuJAuCSCKk0cakwOLHfwe26s7Ibj
 TMyLvKQCgZqHYHxB8MT3bFJs5snqHwf/6QcyPLasBJGd1EZbmJCMwGYytPnnNtObrnvs
 /9ru4lAF2DjFgwNKFDh4TbaPzVhY1WOTzU7u3RwygDv56qY2AnZIQQlVEJNvfeKQ+HmQ
 h6iniEXL1o0cv+goPO4vDijXi6wK6wS9SELXd28SP7ykwnH77962gRdtpYOR6PqdTFB/
 xqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824134; x=1703428934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/yfz/Oz7PgaZpg2L46eI+iLvMEK6kukMkwMnMerSK4=;
 b=BP44yBom9Uq8nopRbATINirxSztcVP/uGe+48bJZaAW60k61Hi1/NTP9oJfUaVJ15x
 IsMXz75G/19cosuXp8LcNUn1c0plO4hnh/3ugR7U4Pip95Zcn6KuDlSSiZFuZAaVfX4M
 J8PqAB3buuWK1esQtAJ1n/GlT9sORsr/wJXhos7kj4e3K4V4acBWpVznpbL0xEyB/RTp
 006gV5Wvr3lN5gQOZTE5JHfSugSJNQ9LrTosJ6As5QuhYeW49RWCZOTT92wwlOBClUDf
 4bvzqfyA9vnthIF0OggVfmDbIcB+qBtO+xAPTYJ6EEif8HmcxEyMQzRdTxt+WJ+aTuJ6
 msmg==
X-Gm-Message-State: AOJu0YwkPZNLLBB3tXMIvN7JJuespGWbISeBXHqAkz946h3HZPC+ykmx
 6Z9dr7qS0Sw9y6+ourcJmm/xFrh6Amw=
X-Google-Smtp-Source: AGHT+IGwQFp+2ZoKu1kPsnNFzs6UAXoQ2ya/KiKwWJiOkbc9x7Q8tvkMBb6BvlZMpFFDjp+dureYAQ==
X-Received: by 2002:a05:6512:3086:b0:50e:1ac0:c97c with SMTP id
 z6-20020a056512308600b0050e1ac0c97cmr3764003lfd.66.1702824133974; 
 Sun, 17 Dec 2023 06:42:13 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:13 -0800 (PST)
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
Subject: [PATCH 05/12] hw/block/fdc: Move constant #define to where it is
 imposed
Date: Sun, 17 Dec 2023 15:41:41 +0100
Message-ID: <20231217144148.15511-6-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x229.google.com
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

The MAX_FD is a limitation of struct FDCtrl which is defined in fdc.h. Now that
this header is exposed the definition can be moved there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/block/fdc-isa.h | 3 ---
 include/hw/block/fdc.h     | 3 ++-
 hw/block/fdc.c             | 1 -
 hw/i386/pc.c               | 1 +
 hw/isa/isa-superio.c       | 1 +
 hw/mips/jazz.c             | 1 +
 hw/sparc64/sun4u.c         | 1 +
 7 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/block/fdc-isa.h b/include/hw/block/fdc-isa.h
index 95807fdc65..42abd001dd 100644
--- a/include/hw/block/fdc-isa.h
+++ b/include/hw/block/fdc-isa.h
@@ -4,9 +4,6 @@
 #include "exec/hwaddr.h"
 #include "qapi/qapi-types-block.h"
 
-/* fdc.c */
-#define MAX_FD 2
-
 #define TYPE_ISA_FDC "isa-fdc"
 
 void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds);
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index acca7e0d0e..0484280939 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -28,9 +28,10 @@
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "hw/block/block.h"
-#include "hw/block/fdc-isa.h"
 #include "qapi/qapi-types-block.h"
 
+#define MAX_FD 2
+
 typedef struct FDCtrl FDCtrl;
 
 /* Floppy bus emulation */
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 0e2fa527f9..7f58cf1c1f 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -28,7 +28,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/block/fdc-isa.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index aeecf56e72..a8051feacd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/i386/pc.h"
+#include "hw/block/fdc.h"
 #include "hw/block/fdc-isa.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index ea6cb4213f..99d2aa491b 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -17,6 +17,7 @@
 #include "sysemu/blockdev.h"
 #include "chardev/char.h"
 #include "hw/char/parallel.h"
+#include "hw/block/fdc.h"
 #include "hw/block/fdc-isa.h"
 #include "hw/isa/superio.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index bc74d1fd96..646b5eb3f1 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -31,6 +31,7 @@
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/isa/isa.h"
+#include "hw/block/fdc.h"
 #include "hw/block/fdc-isa.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 9a88772f6f..0d7b539ace 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -39,6 +39,7 @@
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
 #include "hw/input/i8042.h"
+#include "hw/block/fdc.h"
 #include "hw/block/fdc-isa.h"
 #include "net/net.h"
 #include "qemu/timer.h"
-- 
2.43.0


