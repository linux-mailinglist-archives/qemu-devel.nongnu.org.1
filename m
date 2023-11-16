Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBF7EDDF5
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 10:48:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Yyo-000070-Nj; Thu, 16 Nov 2023 04:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <zhouyang@zhouyang-HP-Pro-Tower-480-G9-PCI-Desktop-PC.mioffice.cn>)
 id 1r3XFX-0001iD-NR
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:57:19 -0500
Received: from [1.202.162.39]
 (helo=zhouyang-HP-Pro-Tower-480-G9-PCI-Desktop-PC.mioffice.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <zhouyang@zhouyang-HP-Pro-Tower-480-G9-PCI-Desktop-PC.mioffice.cn>)
 id 1r3XFT-0004P0-Sr
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:57:19 -0500
Received: by zhouyang-HP-Pro-Tower-480-G9-PCI-Desktop-PC.mioffice.cn (Postfix,
 from userid 1000)
 id DC74DCC0C36; Thu, 16 Nov 2023 15:50:20 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	zhouyang23 <zhouyang23@xiaomi.com>
Subject: [PATCH] hw/audio: Fix logic error in hda audio
Date: Thu, 16 Nov 2023 15:50:19 +0800
Message-Id: <20231116075019.296115-1-zhouyang23@xiaomi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 1.202.162.39 (failed)
Received-SPF: none client-ip=1.202.162.39;
 envelope-from=zhouyang@zhouyang-HP-Pro-Tower-480-G9-PCI-Desktop-PC.mioffice.cn;
 helo=zhouyang-HP-Pro-Tower-480-G9-PCI-Desktop-PC.mioffice.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Nov 2023 04:48:08 -0500
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
Reply-to:  zhouyang23 <zhouyang23@xiaomi.com>
From:  zhouyang23 via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Commit b7639b7dd0 introduced a logic error about mixer and nomixer.
Cause use micro_mixemu when there is no mixer in HDAAudioState, but
use micro_nomixemu wehen there has a mixer in HDAAuditState.

Signed-off-by: zhouyang23 <zhouyang23@xiaomi.com>
---
 hw/audio/hda-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index b9ad1f4c39..87bacb3bee 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -857,7 +857,7 @@ static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
     HDAAudioState *a = HDA_AUDIO(hda);
     const struct desc_codec *desc = &output_nomixemu;
 
-    if (!a->mixer) {
+    if (a->mixer) {
         desc = &output_mixemu;
     }
 
@@ -869,7 +869,7 @@ static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
     HDAAudioState *a = HDA_AUDIO(hda);
     const struct desc_codec *desc = &duplex_nomixemu;
 
-    if (!a->mixer) {
+    if (a->mixer) {
         desc = &duplex_mixemu;
     }
 
@@ -881,7 +881,7 @@ static void hda_audio_init_micro(HDACodecDevice *hda, Error **errp)
     HDAAudioState *a = HDA_AUDIO(hda);
     const struct desc_codec *desc = &micro_nomixemu;
 
-    if (!a->mixer) {
+    if (a->mixer) {
         desc = &micro_mixemu;
     }
 
-- 
2.34.1


