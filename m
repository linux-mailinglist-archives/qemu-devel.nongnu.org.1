Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1887E1573
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 18:26:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzgsy-0001Nx-P9; Sun, 05 Nov 2023 12:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qzgsu-0001Ng-00
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 12:26:06 -0500
Received: from mailout08.t-online.de ([194.25.134.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qzgss-0006vM-Ch
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 12:26:03 -0500
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout08.t-online.de (Postfix) with SMTP id 33F7524DB6;
 Sun,  5 Nov 2023 18:25:58 +0100 (CET)
Received: from linpower.localnet ([93.236.156.187]) by fwd84.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qzgsl-35krVh0; Sun, 5 Nov 2023 18:25:55 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id C17A52002D9; Sun,  5 Nov 2023 18:25:52 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 2/2] hw/audio/hda-codec: reenable the audio mixer
Date: Sun,  5 Nov 2023 18:25:52 +0100
Message-Id: <20231105172552.8405-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <6f8b1f96-4520-49d5-8a09-b2935ab4bd9d@t-online.de>
References: <6f8b1f96-4520-49d5-8a09-b2935ab4bd9d@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699205155-00C0DDFA-4DBD9A30/0/0 CLEAN NORMAL
X-TOI-MSGID: fa94c755-be14-4a97-8529-afce9466d633
Received-SPF: pass client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Commit b7639b7dd0 ("hw/audio: Simplify hda audio init") inverted
the sense of hda codec property mixer during initialization.
Change the code so that mixer=on enables the hda mixer emulation
and mixer=off disables the hda mixer emulation.

With this change audio playback and recording streams don't start
muted by default.

Fixes: b7639b7dd0 ("hw/audio: Simplify hda audio init")
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/hda-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index f756e419bb..0bc20d49f6 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -868,10 +868,10 @@ static Property hda_audio_properties[] = {
 static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    const struct desc_codec *desc = &output_nomixemu;
+    const struct desc_codec *desc = &output_mixemu;
 
     if (!a->mixer) {
-        desc = &output_mixemu;
+        desc = &output_nomixemu;
     }
 
     hda_audio_init(hda, desc, errp);
@@ -880,10 +880,10 @@ static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
 static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    const struct desc_codec *desc = &duplex_nomixemu;
+    const struct desc_codec *desc = &duplex_mixemu;
 
     if (!a->mixer) {
-        desc = &duplex_mixemu;
+        desc = &duplex_nomixemu;
     }
 
     hda_audio_init(hda, desc, errp);
@@ -892,10 +892,10 @@ static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
 static void hda_audio_init_micro(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    const struct desc_codec *desc = &micro_nomixemu;
+    const struct desc_codec *desc = &micro_mixemu;
 
     if (!a->mixer) {
-        desc = &micro_mixemu;
+        desc = &micro_nomixemu;
     }
 
     hda_audio_init(hda, desc, errp);
-- 
2.35.3


