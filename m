Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D2BF5721
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Ku-0007BC-5t; Tue, 21 Oct 2025 05:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Km-0006v3-4i
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Kf-0004Pv-RM
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXwPk9aTnx2TKggI8roMJ4sw1JMeeb0FGSPfIvdaNn4=;
 b=AAFWBW9q1gtnPfYEutnpNs7jjZv/UR7ArCESGttquqzQ3IGS5DOeG7TPphR8LEu6fzdctO
 9SDAbhEt6Y8jeKOuN7aX06xd8RljY4G5Ukg3ON/nfoXevGojjOysYhqoR32c9yijc0jw6o
 6/NiWqwSXkaaHlA0cg6PDRglwW/jR10=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-xU8zSGhkMLOHiJS5V4Vqeg-1; Tue,
 21 Oct 2025 05:06:58 -0400
X-MC-Unique: xU8zSGhkMLOHiJS5V4Vqeg-1
X-Mimecast-MFC-AGG-ID: xU8zSGhkMLOHiJS5V4Vqeg_1761037615
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EC121800D81; Tue, 21 Oct 2025 09:06:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6730D180057D; Tue, 21 Oct 2025 09:06:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>,
 Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org (open list:Integrator CP),
 qemu-ppc@nongnu.org (open list:PReP)
Subject: [PATCH 38/43] audio: move audio.h under include/qemu/
Date: Tue, 21 Oct 2025 13:03:09 +0400
Message-ID: <20251021090317.425409-39-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 audio/audio_int.h                                   | 2 +-
 hw/audio/lm4549.h                                   | 2 +-
 include/hw/audio/asc.h                              | 2 +-
 include/hw/audio/virtio-snd.h                       | 2 +-
 include/hw/display/xlnx_dp.h                        | 2 +-
 include/hw/isa/vt82c686.h                           | 2 +-
 {audio => include/qemu}/audio.h                     | 0
 include/system/replay.h                             | 2 +-
 ui/vnc.h                                            | 2 +-
 audio/alsaaudio.c                                   | 2 +-
 audio/audio.c                                       | 2 +-
 audio/audio_win_int.c                               | 2 +-
 audio/dbusaudio.c                                   | 2 +-
 audio/dsoundaudio.c                                 | 2 +-
 audio/jackaudio.c                                   | 2 +-
 audio/mixeng.c                                      | 2 +-
 audio/noaudio.c                                     | 2 +-
 audio/ossaudio.c                                    | 2 +-
 audio/paaudio.c                                     | 2 +-
 audio/pwaudio.c                                     | 2 +-
 audio/sdlaudio.c                                    | 2 +-
 audio/sndioaudio.c                                  | 2 +-
 audio/spiceaudio.c                                  | 2 +-
 audio/wavaudio.c                                    | 2 +-
 hw/arm/integratorcp.c                               | 2 +-
 hw/arm/musicpal.c                                   | 2 +-
 hw/arm/realview.c                                   | 2 +-
 hw/arm/versatilepb.c                                | 2 +-
 hw/arm/vexpress.c                                   | 2 +-
 hw/arm/xlnx-zcu102.c                                | 2 +-
 hw/audio/ac97.c                                     | 2 +-
 hw/audio/adlib.c                                    | 2 +-
 hw/audio/asc.c                                      | 2 +-
 hw/audio/cs4231a.c                                  | 2 +-
 hw/audio/es1370.c                                   | 2 +-
 hw/audio/gus.c                                      | 2 +-
 hw/audio/hda-codec.c                                | 2 +-
 hw/audio/lm4549.c                                   | 2 +-
 hw/audio/marvell_88w8618.c                          | 2 +-
 hw/audio/pcspk.c                                    | 2 +-
 hw/audio/sb16.c                                     | 2 +-
 hw/audio/wm8750.c                                   | 2 +-
 hw/core/machine.c                                   | 2 +-
 hw/core/qdev-properties-system.c                    | 2 +-
 hw/ppc/prep.c                                       | 2 +-
 hw/usb/dev-audio.c                                  | 2 +-
 replay/replay-audio.c                               | 2 +-
 system/runstate.c                                   | 2 +-
 system/vl.c                                         | 2 +-
 ui/dbus.c                                           | 3 +--
 audio/coreaudio.m                                   | 2 +-
 scripts/codeconverter/codeconverter/test_regexps.py | 2 +-
 52 files changed, 51 insertions(+), 52 deletions(-)
 rename {audio => include/qemu}/audio.h (100%)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 8c2dae21ab..4207bd0e12 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -29,7 +29,7 @@
 #define FLOAT_MIXENG
 /* #define RECIPROCAL */
 #endif
-#include "audio.h"
+#include "qemu/audio.h"
 #include "mixeng.h"
 
 #ifdef CONFIG_GIO
diff --git a/hw/audio/lm4549.h b/hw/audio/lm4549.h
index 45023b6535..cd772ed945 100644
--- a/hw/audio/lm4549.h
+++ b/hw/audio/lm4549.h
@@ -12,7 +12,7 @@
 #ifndef HW_LM4549_H
 #define HW_LM4549_H
 
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "exec/hwaddr.h"
 
 typedef void (*lm4549_callback)(void *opaque);
diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index 5c8c4ef4ec..b17ba8df41 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -14,7 +14,7 @@
 #define HW_AUDIO_ASC_H
 
 #include "hw/sysbus.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 
 #define ASC_FREQ 22257
 
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index f9a434fe26..09ecb5555a 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -17,7 +17,7 @@
 #define QEMU_VIRTIO_SOUND_H
 
 #include "hw/virtio/virtio.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_snd.h"
 
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index 196f325f52..2d0e7384c0 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -33,7 +33,7 @@
 #include "qemu/fifo8.h"
 #include "qemu/units.h"
 #include "hw/dma/xlnx_dpdma.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "qom/object.h"
 #include "hw/ptimer.h"
 
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index 9948daaefb..20e479be2b 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -2,7 +2,7 @@
 #define HW_VT82C686_H
 
 #include "hw/pci/pci_device.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 
 #define TYPE_VT82C686B_ISA "vt82c686b-isa"
 #define TYPE_VT82C686B_USB_UHCI "vt82c686b-usb-uhci"
diff --git a/audio/audio.h b/include/qemu/audio.h
similarity index 100%
rename from audio/audio.h
rename to include/qemu/audio.h
diff --git a/include/system/replay.h b/include/system/replay.h
index 1e63c0784c..68f91bdfbf 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -16,7 +16,7 @@
 #include "qapi/qapi-types-run-state.h"
 #include "qapi/qapi-types-ui.h"
 #include "block/aio.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 
 /* replay clock kinds */
 enum ReplayClockKind {
diff --git a/ui/vnc.h b/ui/vnc.h
index a6aac50ec3..8ebf9901bc 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -31,7 +31,7 @@
 #include "qemu/thread.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "qemu/bitmap.h"
 #include "crypto/tlssession.h"
 #include "qemu/buffer.h"
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 1c762e0e24..46798069e6 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -26,7 +26,7 @@
 #include <alsa/asoundlib.h>
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "trace.h"
 
 #pragma GCC diagnostic ignored "-Waddress"
diff --git a/audio/audio.c b/audio/audio.c
index 2207cad5d7..60d4cfa2d2 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
diff --git a/audio/audio_win_int.c b/audio/audio_win_int.c
index 316f118f50..44a8ff24a6 100644
--- a/audio/audio_win_int.c
+++ b/audio/audio_win_int.c
@@ -7,7 +7,7 @@
 #include <mmreg.h>
 #include <mmsystem.h>
 
-#include "audio.h"
+#include "qemu/audio.h"
 #include "audio_int.h"
 #include "audio_win_int.h"
 
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 3344cbb030..972c0b9c7f 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -35,7 +35,7 @@
 #include "ui/dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "audio_int.h"
 #include "trace.h"
 
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 003ef27365..fbb8890f5c 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "audio.h"
+#include "qemu/audio.h"
 
 #define AUDIO_CAP "dsound"
 #include "audio_int.h"
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 974a3caad3..28face9989 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -26,7 +26,7 @@
 #include "qemu/module.h"
 #include "qemu/atomic.h"
 #include "qemu/main-loop.h"
-#include "audio.h"
+#include "qemu/audio.h"
 
 #define AUDIO_CAP "jack"
 #include "audio_int.h"
diff --git a/audio/mixeng.c b/audio/mixeng.c
index af9ec3d4d2..e63c76e021 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -24,7 +24,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "audio.h"
+#include "qemu/audio.h"
 
 #define AUDIO_CAP "mixeng"
 #include "audio_int.h"
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 34ff1d2a27..b136b74e26 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "qemu/audio.h"
 
 #define AUDIO_CAP "noaudio"
 #include "audio_int.h"
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index f202e743ff..7ae28c99bc 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -29,7 +29,7 @@
 #include "qemu/module.h"
 #include "qemu/host-utils.h"
 #include "qapi/error.h"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "trace.h"
 
 #define AUDIO_CAP "oss"
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 93030f3fc8..8eb80ede45 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -2,7 +2,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "qapi/error.h"
 
 #include <pulse/pulseaudio.h>
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 8e13b58286..8f6c0900c8 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <spa/param/audio/format-utils.h>
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 641357e5ee..4ef73c8dfb 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -27,7 +27,7 @@
 #include <SDL_thread.h>
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "audio.h"
+#include "qemu/audio.h"
 
 #ifndef _WIN32
 #ifdef __sun__
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 8eb35e1e53..f4f53b1c6f 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -18,7 +18,7 @@
 #include <poll.h>
 #include <sndio.h>
 #include "qemu/main-loop.h"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "trace.h"
 
 #define AUDIO_CAP "sndio"
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 7e737bff9a..77ba89ffaa 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -26,7 +26,7 @@
 #include "ui/qemu-spice.h"
 
 #define AUDIO_CAP "spice"
-#include "audio.h"
+#include "qemu/audio.h"
 #include "audio_int.h"
 
 #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index a098b20cad..4d9c921305 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "qemu/audio.h"
 
 #define AUDIO_CAP "wav"
 #include "audio_int.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b1d8fbd470..81ed051b98 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -26,7 +26,7 @@
 #include "hw/irq.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 329b162eb2..6032301bb6 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -36,7 +36,7 @@
 #include "qemu/cutils.h"
 #include "qom/object.h"
 #include "hw/net/mv88w8618_eth.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "qemu/error-report.h"
 #include "target/arm/cpu-qom.h"
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 5c9050490b..892bdc8db2 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -29,7 +29,7 @@
 #include "hw/irq.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 5cf1a70d10..cba77864e8 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -25,7 +25,7 @@
 #include "hw/char/pl011.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 #include "qemu/log.h"
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 35f8d05ea1..14d38cea8b 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -44,7 +44,7 @@
 #include "hw/sd/sd.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 14b6641a71..4ed346a88d 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -25,7 +25,7 @@
 #include "system/device_tree.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 
 struct XlnxZCU102 {
     MachineState parent_obj;
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 9520c6884c..13f9fab11a 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index a1eb356acc..ffc5e704db 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 791c4372ec..124929d82d 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/audio/asc.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 01c1cd171e..47843e4af6 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index e606bdb622..52c8f48a12 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index dcf936a85d..565935fef3 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 760fa7680e..2658a73f46 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -25,7 +25,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "intel-hda-defs.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index 21e848ef24..f24426c7f1 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "lm4549.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index c5c79d083a..a483f4e70d 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -16,7 +16,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/audio/wm8750.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 6e510f0be7..30eb22941a 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 85f859a461..cbef45722c 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index d24fca37e1..acdd1f93d0 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -12,7 +12,7 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/audio/wm8750.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "qom/object.h"
 
 #define IN_PORT_N	3
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2de8b89606..a82eb86415 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,7 @@
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 701f6553c5..d871863fcb 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qdev-prop-internal.h"
 
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "chardev/char-fe.h"
 #include "system/block-backend.h"
 #include "system/blockdev.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 982e40e53e..8e4ee71c0a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -46,7 +46,7 @@
 #include "trace.h"
 #include "elf.h"
 #include "qemu/units.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 2eb49a5e33..22f025d6b2 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -35,7 +35,7 @@
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "qom/object.h"
 
 static void usb_audio_reinit(USBDevice *dev, unsigned channels);
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index 3413801062..1b614f4137 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -13,7 +13,7 @@
 #include "qemu/error-report.h"
 #include "system/replay.h"
 #include "replay-internal.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 
 void replay_audio_out(size_t *played)
 {
diff --git a/system/runstate.c b/system/runstate.c
index 32467aa882..e3ec16ab74 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "block/block.h"
 #include "block/export.h"
 #include "chardev/char.h"
diff --git a/system/vl.c b/system/vl.c
index 9245ec986c..7bc6c44ebe 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -87,7 +87,7 @@
 #include "system/tpm.h"
 #include "system/dma.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "system/cpus.h"
 #include "system/cpu-timers.h"
 #include "exec/icount.h"
diff --git a/ui/dbus.c b/ui/dbus.c
index 7d44287673..096595cbcd 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -34,8 +34,7 @@
 #include "ui/egl-helpers.h"
 #include "ui/egl-context.h"
 #endif
-#include "audio/audio.h"
-#include "audio/audio_int.h"
+#include "qemu/audio.h"
 #include "qapi/error.h"
 #include "trace.h"
 
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index cadd729d50..8b3cd6db16 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -28,7 +28,7 @@
 
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "qemu/audio.h"
 
 #define AUDIO_CAP "coreaudio"
 #include "audio_int.h"
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index fe7354b473..b00e9ef15b 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -265,7 +265,7 @@ def test_initial_includes():
 
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
-#include "audio/audio.h"
+#include "qemu/audio.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.51.0


