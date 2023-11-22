Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC70D7F4747
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 14:00:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mot-00052m-Pr; Wed, 22 Nov 2023 07:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r5mor-000523-GF; Wed, 22 Nov 2023 07:59:05 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r5mop-0006uk-Kp; Wed, 22 Nov 2023 07:59:05 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5EF24427C6;
 Wed, 22 Nov 2023 13:58:51 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com,
 mcascell@redhat.com
Subject: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
Date: Wed, 22 Nov 2023 13:58:26 +0100
Message-Id: <20231122125826.228189-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit d921fea338 ("ui/vnc-clipboard: fix infinite loop in
inflate_buffer (CVE-2023-3255)") removed this hunk, but it is still
required, because it can happen that stream.avail_in becomes zero
before coming across a return value of Z_STREAM_END in the loop.

This fixes the host->guest direction of the clipboard with noVNC and
TigerVNC as clients.

Fixes: d921fea338 ("ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023-3255)")
Reported-by: Friedrich Weber <f.weber@proxmox.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 ui/vnc-clipboard.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index c759be3438..124b6fbd9c 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -69,6 +69,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
         }
     }
 
+    *size = stream.total_out;
+    inflateEnd(&stream);
+
+    return out;
+
 err_end:
     inflateEnd(&stream);
 err:
-- 
2.39.2



