Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10A7334C3
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABNs-0006B4-PO; Fri, 16 Jun 2023 11:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABNp-00069x-GA
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:29:05 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABNn-0000uV-9Q
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:29:05 -0400
X-QQ-mid: bizesmtp84t1686929270t60oiv8o
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 16 Jun 2023 23:27:49 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: 90EFqYDyPxAadufHtL43FjIlVtvePuzH9FZHXO8miEAY9G+nVafLL5Y6i1iBB
 m/FRQFCEV+iIJbO/bdxZdaQsaKNYxXjd4BDTXr+FEzwIL5ltCq6ntX5SS4eRKeH0gUHKIKD
 EwmOkpzGpu+/mVLfUpdn+U88UBYy+VlvSLSRp4gE3ejzXIuKA4/glLpg0Cx9+S/vzOv6eRb
 qHW3SE0FeTAMLf5G+9jB1cXjdSuI+2d8FlWThMJ6dmCJM9oX52LT1ZM6qOxr5W47tIioFQa
 nE/2CK9ffVdxqg1ul53M5o4vU8/hN+pSJFFwK4p57EM8KPramtlFDCLlouriyl/X2UYs65H
 iXmCko9IitjSzJr7OGppG+8QpqheorIMA9HGnwZtje31QAK5f4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11881041971104729125
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 3/6] util/async-teardown: Fall back to close fds one by one
Date: Fri, 16 Jun 2023 23:27:34 +0800
Message-Id: <20230616152737.23545-4-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616152737.23545-1-bmeng@tinylab.org>
References: <20230616152737.23545-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When opening /proc/self/fd fails, current codes just return directly,
but we can fall back to close fds one by one.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 util/async-teardown.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/async-teardown.c b/util/async-teardown.c
index 3ab19c8740..7e0177a8da 100644
--- a/util/async-teardown.c
+++ b/util/async-teardown.c
@@ -48,7 +48,11 @@ static void close_all_open_fd(void)
 
     dir = opendir("/proc/self/fd");
     if (!dir) {
-        /* If /proc is not mounted, there is nothing that can be done. */
+        /* If /proc is not mounted, close fds one by one. */
+        int open_max = sysconf(_SC_OPEN_MAX), i;
+        for (i = 0; i < open_max; i++) {
+                close(i);
+        }
         return;
     }
     /* Avoid closing the directory. */
-- 
2.34.1


