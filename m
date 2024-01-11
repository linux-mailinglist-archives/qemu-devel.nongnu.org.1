Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9F82B69F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:25:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2XE-000620-Cq; Thu, 11 Jan 2024 16:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <briggs@gateway.sonic.net>)
 id 1rO1XS-0007Hc-Jk
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 15:20:30 -0500
Received: from c.mail.sonic.net ([64.142.111.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <briggs@gateway.sonic.net>)
 id 1rO1XP-0002sq-GK
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 15:20:30 -0500
Received: from gateway.sonic.net (173-228-125-44.static.sonic.net
 [173.228.125.44]) (authenticated bits=0)
 by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 40BK7Pfd031436
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 12:07:26 -0800
Received: from briggs (uid 1001) (envelope-from briggs@gateway.sonic.net)
 id 497ab3
 by gateway.sonic.net (DragonFly Mail Agent v0.13+ on flap.gateway.sonic.net); 
 Thu, 11 Jan 2024 12:07:25 -0800
From: Nick Briggs <nicholas.h.briggs@gmail.com>
Date: Thu, 11 Jan 2024 13:20:17 -0500
Subject: [PATCH 1/2] migration/rdma: define htonll/ntohll only if not
 predefined
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>
Message-Id: <65a04a7d.497ab3.3e7bef1f@gateway.sonic.net>
X-Sonic-CAuth: UmFuZG9tSVZKWSkUCUOazsGSSlBGC99iG/39DSaxxC7uyCBJBInJUAfSHv562w9JLhaNLXjABk5bzdCvIYH+6BV7CjE1alT55mJ/mpEXkxM=
X-Sonic-ID: C;yprdCb2w7hGq9rt3R+6Zsg== M;oh4iCr2w7hGq9rt3R+6Zsg==
X-Sonic-Spam-Details: 2.2/5.0 by cerberusd
Received-SPF: none client-ip=64.142.111.80;
 envelope-from=briggs@gateway.sonic.net; helo=c.mail.sonic.net
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NML_ADSP_CUSTOM_MED=0.9,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 SPOOFED_FREEMAIL=0.001, SPOOF_GMAIL_MID=1, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jan 2024 16:24:17 -0500
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

Solaris has #defines for htonll and ntohll which cause syntax errors
when compiling code that attempts to (re)define these functions..

Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
---
 migration/rdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 94c0f871f0..a355dcea89 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -238,6 +238,7 @@ static const char *control_desc(unsigned int rdma_control)
     return strs[rdma_control];
 }
 
+#if !defined(htonll)
 static uint64_t htonll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
@@ -245,13 +246,16 @@ static uint64_t htonll(uint64_t v)
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
2.31.1


