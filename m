Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61461C0EE0C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 16:17:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOvC-0003dK-Fr; Mon, 27 Oct 2025 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOub-0003M0-S5
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOuM-0003w8-UZ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iLaV5sOzsrYZ2P/ISRx0e0VIrZYAK4Ckmnkuj06O+s=;
 b=hackpA2JMG+PWjvqpHmwuVurfJdnzMwqq7Bsjq4+oBVOeluXJsyoYxXkZ07Y7qpE+/BdYb
 dI67P6um5C5CI6HrBV5UqJ81c4JqgaegbYih1oyoB4yx87/zXO9eSBbmWaJsFfE31qy1WH
 kv1TUyDbhFp1Wh0Xn0Pj2dkv0izR9HY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-LT09HOJFPS2jzKHCjmy0TQ-1; Mon,
 27 Oct 2025 11:13:13 -0400
X-MC-Unique: LT09HOJFPS2jzKHCjmy0TQ-1
X-Mimecast-MFC-AGG-ID: LT09HOJFPS2jzKHCjmy0TQ_1761577990
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19530196E0B1; Mon, 27 Oct 2025 15:13:10 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D30119560AD; Mon, 27 Oct 2025 15:13:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 21/35] audio: remove some needless headers
Date: Mon, 27 Oct 2025 19:10:28 +0400
Message-ID: <20251027151045.2863176-22-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h       | 1 -
 audio/audio.c       | 3 ---
 audio/dbusaudio.c   | 2 --
 audio/dsoundaudio.c | 1 -
 audio/mixeng.c      | 4 +++-
 audio/noaudio.c     | 2 --
 audio/wavaudio.c    | 3 ---
 audio/wavcapture.c  | 1 -
 8 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index e41c5bc55a..3be0c4f24f 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -27,7 +27,6 @@
 
 #include "qemu/queue.h"
 #include "qapi/qapi-types-audio.h"
-#include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 typedef void (*audio_callback_fn) (void *opaque, int avail);
diff --git a/audio/audio.c b/audio/audio.c
index bdaee7855f..f334030d96 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "audio.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
@@ -33,7 +32,6 @@
 #include "qapi/qapi-visit-audio.h"
 #include "qapi/qapi-commands-audio.h"
 #include "qobject/qdict.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -41,7 +39,6 @@
 #include "system/system.h"
 #include "system/replay.h"
 #include "system/runstate.h"
-#include "ui/qemu-spice.h"
 #include "trace.h"
 
 #define AUDIO_CAP "audio"
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index b44fdd1511..908214a170 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -24,9 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu/host-utils.h"
 #include "qemu/module.h"
-#include "qemu/timer.h"
 #include "qemu/dbus.h"
 
 #ifdef G_OS_UNIX
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index d476e9b441..bd00c50e80 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -31,7 +31,6 @@
 
 #define AUDIO_CAP "dsound"
 #include "audio_int.h"
-#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 703ee5448f..be38617e9b 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -24,11 +24,13 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "qemu/error-report.h"
 #include "audio.h"
 
 #define AUDIO_CAP "mixeng"
 #include "audio_int.h"
+#ifdef FLOAT_MIXENG
+#include "qemu/error-report.h"
+#endif
 
 /* 8 bit */
 #define ENDIAN_CONVERSION natural
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 1b60d8518a..34ff1d2a27 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -23,10 +23,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "audio.h"
-#include "qemu/timer.h"
 
 #define AUDIO_CAP "noaudio"
 #include "audio_int.h"
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index a8798a1c42..a098b20cad 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -23,10 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/host-utils.h"
 #include "qemu/module.h"
-#include "qemu/timer.h"
-#include "qapi/opts-visitor.h"
 #include "audio.h"
 
 #define AUDIO_CAP "wav"
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index c60286e162..b990844d48 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "qemu/qemu-print.h"
-#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "audio.h"
 
-- 
2.51.0


