Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF0382B69E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:25:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2XD-000606-MW; Thu, 11 Jan 2024 16:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <briggs@gateway.sonic.net>)
 id 1rO1XR-0007HS-6l
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 15:20:29 -0500
Received: from c.mail.sonic.net ([64.142.111.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <briggs@gateway.sonic.net>)
 id 1rO1XP-0002sp-ET
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 15:20:28 -0500
Received: from gateway.sonic.net (173-228-125-44.static.sonic.net
 [173.228.125.44]) (authenticated bits=0)
 by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 40BK7YVm031617
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 12:07:34 -0800
Received: from briggs (uid 1001) (envelope-from briggs@gateway.sonic.net)
 id 49eda6
 by gateway.sonic.net (DragonFly Mail Agent v0.13+ on flap.gateway.sonic.net); 
 Thu, 11 Jan 2024 12:07:34 -0800
From: Nick Briggs <nicholas.h.briggs@gmail.com>
Date: Thu, 11 Jan 2024 14:43:22 -0500
Subject: [PATCH 2/2] qga: Solaris has net/if_arp.h and netinet/if_ether.h but
 not ETHER_ADDR_LEN
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Message-Id: <65a04a86.49eda6.3044c037@gateway.sonic.net>
X-Sonic-CAuth: UmFuZG9tSVa+N6XZ4ri8z/WYU7xhMuHUS0c2ykebt2iAKQlZ7l/VEEHyHmtaNmC47p9wpT3Z+RwL++8g7RrxoNruFhvDm3iPcPQ/a/kP7fo=
X-Sonic-ID: C;trfyDr2w7hGXHrt3R+6Zsg== M;4sc9D72w7hGXHrt3R+6Zsg==
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

Solaris has net/if_arp.h and netinet/if_ether.h rather than net/ethernet.h,
but does not define ETHER_ADDR_LEN, instead providing ETHERADDRL.

Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
---
 qga/commands-posix.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6169bbf7a0..26008db497 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -45,9 +45,12 @@
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <net/if.h>
-#if defined(__NetBSD__) || defined(__OpenBSD__)
+#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(CONFIG_SOLARIS)
 #include <net/if_arp.h>
 #include <netinet/if_ether.h>
+#if !defined(ETHER_ADDR_LEN) && defined(ETHERADDRL)
+#define ETHER_ADDR_LEN ETHERADDRL
+#endif
 #else
 #include <net/ethernet.h>
 #endif
-- 
2.31.1


