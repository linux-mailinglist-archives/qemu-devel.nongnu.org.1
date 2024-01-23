Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD3838C04
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:30:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSE1n-0006s0-Eg; Tue, 23 Jan 2024 05:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSE1k-0006rc-W4; Tue, 23 Jan 2024 05:29:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSE1j-0005NS-9V; Tue, 23 Jan 2024 05:29:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9DCD446753;
 Tue, 23 Jan 2024 13:29:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3E93069AEF;
 Tue, 23 Jan 2024 13:28:44 +0300 (MSK)
Received: (nullmailer pid 3831728 invoked by uid 1000);
 Tue, 23 Jan 2024 10:28:43 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nick Briggs <nicholas.h.briggs@gmail.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 20/24] migration/rdma: define htonll/ntohll only if not
 predefined
Date: Tue, 23 Jan 2024 13:28:34 +0300
Message-Id: <20240123102843.3831660-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240123123057@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240123123057@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Nick Briggs <nicholas.h.briggs@gmail.com>

Solaris has #defines for htonll and ntohll which cause syntax errors
when compiling code that attempts to (re)define these functions..

Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
Link: https://lore.kernel.org/r/65a04a7d.497ab3.3e7bef1f@gateway.sonic.net
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 44ce1b5d2fc77343f6a318cb3de613336a240048)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/rdma.c b/migration/rdma.c
index ca430d319d..8212fa6a5a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -268,6 +268,7 @@ static const char *control_desc(unsigned int rdma_control)
     return strs[rdma_control];
 }
 
+#if !defined(htonll)
 static uint64_t htonll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
@@ -275,13 +276,16 @@ static uint64_t htonll(uint64_t v)
     u.lv[1] = htonl(v & 0xFFFFFFFFULL);
     return u.llv;
 }
+#endif
 
+#if !defined(ntohll)
 static uint64_t ntohll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
     u.llv = v;
     return ((uint64_t)ntohl(u.lv[0]) << 32) | (uint64_t) ntohl(u.lv[1]);
 }
+#endif
 
 static void dest_block_to_network(RDMADestBlock *db)
 {
-- 
2.39.2


