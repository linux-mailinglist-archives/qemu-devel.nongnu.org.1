Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D87B79C0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:11:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsi-000372-Iw; Wed, 04 Oct 2023 04:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrz-00087g-VM; Wed, 04 Oct 2023 04:04:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrv-0001Hl-0k; Wed, 04 Oct 2023 04:04:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88AA9275A3;
 Wed,  4 Oct 2023 11:02:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CDF772CBDF;
 Wed,  4 Oct 2023 11:02:26 +0300 (MSK)
Received: (nullmailer pid 2702825 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 25/45] ui/vnc: fix handling of VNC_FEATURE_XVP
Date: Wed,  4 Oct 2023 11:01:46 +0300
Message-Id: <20231004080221.2702636-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Paolo Bonzini <pbonzini@redhat.com>

VNC_FEATURE_XVP was not shifted left before adding it to vs->features,
so it was never enabled; but it was also checked the wrong way with
a logical AND instead of vnc_has_feature.  Fix both places.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 477b301000d665313217f65e3a368d2cb7769c42)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index 538581929a..293ba5db5f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2205,7 +2205,7 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             break;
         case VNC_ENCODING_XVP:
             if (vs->vd->power_control) {
-                vs->features |= VNC_FEATURE_XVP;
+                vs->features |= VNC_FEATURE_XVP_MASK;
                 send_xvp_message(vs, VNC_XVP_CODE_INIT);
             }
             break;
@@ -2454,7 +2454,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         vnc_client_cut_text(vs, read_u32(data, 4), data + 8);
         break;
     case VNC_MSG_CLIENT_XVP:
-        if (!(vs->features & VNC_FEATURE_XVP)) {
+        if (!vnc_has_feature(vs, VNC_FEATURE_XVP)) {
             error_report("vnc: xvp client message while disabled");
             vnc_client_error(vs);
             break;
-- 
2.39.2


