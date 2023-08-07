Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7577309E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT76v-0004K3-KV; Mon, 07 Aug 2023 16:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <werner@carne.de>) id 1qT6d8-0003NQ-3L
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:15:06 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <werner@carne.de>) id 1qT6d6-00060o-8N
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:15:05 -0400
Received: from localhost.localdomain ([84.169.127.92]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsZ7T-1perct0xK7-00u5eB; Mon, 07 Aug 2023 22:15:00 +0200
From: Werner de Carne <werner@carne.de>
To: qemu-devel@nongnu.org
Cc: Werner de Carne <werner@carne.de>
Subject: [PATCH] serial COM: windows serial COM PollingFunc don't sleep
Date: Mon,  7 Aug 2023 22:14:43 +0200
Message-Id: <20230807201443.2668-1-werner@carne.de>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z9pkbbHgOFCuQ/w56CTNg5Dhgdu+2dXJv920u8J6Gt9Q7YII62r
 KabZ7rfW1H/wiPajSIrwIpVWYINH8r1jbD0Tmkfa04eaL1jR5ZHy94K0BHdiAgPEPaFfeRO
 UYfxabIADvFWtBWvbQNCieI8eswBYJm1as1AOm1oji6LSyqiCAUGhrhUfgXPyDxQn6KeTq0
 2dwTi7h0NX75pSAZn42lA==
UI-OutboundReport: notjunk:1;M01:P0:YvZuK8XwGf4=;AKFSlZgtwVM6neoPe6yx4dAldxJ
 azXlyUCUVlerztoRpdaGTl552i2A4EdgCYhwgqFGewAOhMv2k7A3u8BikKX9afEC3na1ur/X9
 givCnsTD6QetX5sLIcukYwcc+NKB1qTbsBCYZtVyQ5NH/gyLv5limL6mRmiZGfSM1UUQ+TAds
 R7NURr6qGEObD6gWH3nWWqWy/GG7GB0N9sV8db3vDwgdt8KfUeQWHJztcq8QzqZImD7fmPMzE
 H5sTIqmaysWa3sYjhNOZV5oPDsxoq26Lss/ovuIxTUionUo8+Hdv5I4k4qwshWDs09uVS/49k
 sz0dT83YnyyawJ+GAaI5RdZeeRXwDgIJk2KbYsVNYvTgrae5L2muLWxxBcTIPzp35BYKXth+U
 /WKZEiG9S1Z8iRdrtEhN7/HROBIHcxH67BlIfUzlX+q1XyoloQgRX2D1Pjhunk9j/849l0tgx
 jfej/zdQSN64YE8ZdM41sdxRBJVXWAjwF/brAB8J9WTps5RrqggS/RFI362oolR8SxX/TkU80
 YQmMGbmqDw0zXkwWSuZ7PvnuR4ElySlToioMDex9iOhznGJ+2owNZQRrUHRmmhfkLbTd7ZK90
 yuAN1pRXKKzsSWUAOYrHUmjcPJmeZpahMG0btAOYNB+63SKUnkX8XoXjRJgN4u2i/xqEBWeI3
 R6c9FO6mMCjyCSqXp1ULnvgz9iKIAlsJROh8HH+B3DXP6j3YDT5JbTKqfEZ0qRqasMsz9POVl
 VO1ecPV/GF/SJLLHmEsmbY/CLPBZi+9/YjnAd1ameOommf+jtixoJDyhNM/cUnXsDL5DVNCbm
 RLBeYcnnzXnbPDg4NqDKoxn2vbXvRQGMJnqXz+epK8m1NpCf7PCz6SjxGUoq2PpmZHrLJkMKi
 MTuDe8spIvlB8eA==
Received-SPF: pass client-ip=212.227.126.135; envelope-from=werner@carne.de;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Aug 2023 16:45:51 -0400
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1802
Signed-off-by: Werner de Carne <werner@carne.de>
---
 chardev/char-win.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/chardev/char-win.c b/chardev/char-win.c
index d4fb44c4dc..92a7016105 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "chardev/char-win.h"
 
-static void win_chr_read(Chardev *chr, DWORD len)
+static int win_chr_read(Chardev *chr, DWORD len)
 {
     WinChardev *s = WIN_CHARDEV(chr);
     int max_size = qemu_chr_be_can_write(chr);
@@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
         len = max_size;
     }
     if (len == 0) {
-        return;
+        return 0;
     }
 
     ZeroMemory(&s->orecv, sizeof(s->orecv));
@@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
     if (size > 0) {
         qemu_chr_be_write(chr, buf, size);
     }
+    
+    return size > 0 ? 1 : 0;
 }
 
 static int win_chr_serial_poll(void *opaque)
@@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)
 
     ClearCommError(s->file, &comerr, &status);
     if (status.cbInQue > 0) {
-        win_chr_read(chr, status.cbInQue);
-        return 1;
+        if (win_chr_read(chr, status.cbInQue)) {
+			return 1;
+		}
     }
     return 0;
 }
@@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)
 
     PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
     if (size > 0) {
-        win_chr_read(chr, size);
-        return 1;
+    	if (win_chr_read(chr, size)) {
+			return 1;
+		}
     }
     return 0;
 }
-- 
2.28.0.windows.1


