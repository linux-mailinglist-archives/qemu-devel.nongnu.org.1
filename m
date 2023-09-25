Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0117ADFB9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:43:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSO-0002kD-WC; Mon, 25 Sep 2023 15:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSK-0002iU-LM
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:20 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSG-0004nN-0r
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 36D8360188;
 Mon, 25 Sep 2023 22:41:14 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-NTf36TY1; Mon, 25 Sep 2023 22:41:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670873;
 bh=cIe/0IKk7zt6P9c5SCbqZyb8mymi/x8y4y8A0MEOJsI=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=gjWvtdOFip8oifB7phrIXrVItMbRM8KVnIsMXzfw9fvWJ6MJ5fq8xA3m6BNpjZHxB
 UfYWxgCN4A3vEeK56eIJbdz+S+EfDL9R+iWrmxKBNQTowSbbLzhb/B+yGMtSuTdMVF
 ipFv22QD139TY0fStYMwLf5fXb8sroyCPoxOSDiI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [PATCH 09/12] kvm-all: introduce limits for name_size and num_desc
Date: Mon, 25 Sep 2023 22:40:37 +0300
Message-Id: <20230925194040.68592-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925194040.68592-1-vsementsov@yandex-team.ru>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Coverity doesn't like when the value with unchecked bounds that comes
from fd is used as length for IO or allocation. And really, that's not
a good practice. Let's introduce at least an empirical limits for these
values.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 accel/kvm/kvm-all.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ff1578bb32..6d0ba7d900 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3988,6 +3988,9 @@ typedef struct StatsDescriptors {
 static QTAILQ_HEAD(, StatsDescriptors) stats_descriptors =
     QTAILQ_HEAD_INITIALIZER(stats_descriptors);
 
+
+#define KVM_STATS_QEMU_MAX_NAME_SIZE (1024 * 1024)
+#define KVM_STATS_QEMU_MAX_NUM_DESC (1024)
 /*
  * Return the descriptors for 'target', that either have already been read
  * or are retrieved from 'stats_fd'.
@@ -4021,6 +4024,18 @@ static StatsDescriptors *find_stats_descriptors(StatsTarget target, int stats_fd
         g_free(descriptors);
         return NULL;
     }
+    if (kvm_stats_header->name_size > KVM_STATS_QEMU_MAX_NAME_SIZE) {
+        error_setg(errp, "KVM stats: too large name_size: %" PRIu32,
+                   kvm_stats_header->name_size);
+        g_free(descriptors);
+        return NULL;
+    }
+    if (kvm_stats_header->num_desc > KVM_STATS_QEMU_MAX_NUM_DESC) {
+        error_setg(errp, "KVM stats: too large num_desc: %" PRIu32,
+                   kvm_stats_header->num_desc);
+        g_free(descriptors);
+        return NULL;
+    }
     size_desc = sizeof(*kvm_stats_desc) + kvm_stats_header->name_size;
 
     /* Read stats descriptors */
-- 
2.34.1


