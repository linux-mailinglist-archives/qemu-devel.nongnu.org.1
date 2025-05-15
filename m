Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68FAB7E28
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 08:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRP3-0004Hf-0z; Thu, 15 May 2025 01:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFROn-000407-JZ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:44:53 -0400
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFROl-0008JK-Uq
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:44:53 -0400
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout10.t-online.de (Postfix) with SMTP id 79536169E;
 Thu, 15 May 2025 07:44:39 +0200 (CEST)
Received: from linpower.localnet ([84.175.230.13]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uFROW-3vuNc10; Thu, 15 May 2025 07:44:36 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 6E8862006C9; Thu, 15 May 2025 07:44:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 4/7] hw/audio/asc: fix SIGSEGV in asc_realize()
Date: Thu, 15 May 2025 07:44:26 +0200
Message-ID: <20250515054429.7385-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
References: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747287876-BDFF94E5-B7FD30BC/0/0 CLEAN NORMAL
X-TOI-MSGID: 059305e8-ef0e-4daf-882d-811905b25ee4
Received-SPF: pass client-ip=194.25.134.21;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout10.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AUD_open_out() may fail and return NULL. This may then lead to
a segmentation fault in memset() below. The memset() behaviour
is undefined if the pointer to the destination object is a null
pointer.

Add the missing error handling code.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/asc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 18382ccf6a..6721c0d9fb 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "audio/audio.h"
@@ -653,6 +654,12 @@ static void asc_realize(DeviceState *dev, Error **errp)
 
     s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s, asc_out_cb,
                             &as);
+    if (!s->voice) {
+        AUD_remove_card(&s->card);
+        error_setg(errp, "Initializing audio stream failed");
+        return;
+    }
+
     s->shift = 1;
     s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
     s->mixbuf = g_malloc0(s->samples << s->shift);
-- 
2.43.0


