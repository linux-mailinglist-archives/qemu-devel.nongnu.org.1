Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA87767064
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:22:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPOtq-0000rp-Th; Fri, 28 Jul 2023 10:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qPOtp-0000rc-0t
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qPOtn-0005Hs-LM
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690556218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0grccV+tHsmhdlizM9TiUKQEm4CzEmZusXfYKZaRV4=;
 b=FxD5p+M6f8bRV1A6f75JFpp1VC+A8fnVcq4dTlzznPwAJMqCt1iDIijjTeHItEW1W7cv5M
 nRwkaJkI08XrINr8aVgJeqF6SJPD8xHdfRvSDzFsMqcIyMwZEhhWj8wzOLxbajJZccwry0
 cHCCevJS3rpj6GDk9dqYLkIfc/tJhec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-QTR-kf3qN6GCu7qMwH9Nmw-1; Fri, 28 Jul 2023 10:56:55 -0400
X-MC-Unique: QTR-kf3qN6GCu7qMwH9Nmw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012A21044589;
 Fri, 28 Jul 2023 14:56:55 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3D9492B02;
 Fri, 28 Jul 2023 14:56:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 1/1] qemu-nbd: regression with arguments passing into
 nbd_client_thread()
Date: Fri, 28 Jul 2023 09:55:50 -0500
Message-ID: <20230728145548.1058053-4-eblake@redhat.com>
In-Reply-To: <20230728145548.1058053-3-eblake@redhat.com>
References: <20230728145548.1058053-3-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

Unfortunately
    commit 03b67621445d601c9cdc7dfe25812e9f19b81488
    Author: Denis V. Lunev <den@openvz.org>
    Date:   Mon Jul 17 16:55:40 2023 +0200
    qemu-nbd: pass structure into nbd_client_thread instead of plain char*
has introduced a regression. struct NbdClientOpts resides on stack inside
'if' block. This specifically means that this stack space could be reused
once the execution will leave that block of the code.

This means that parameters passed into nbd_client_thread could be
overwritten at any moment.

The patch moves the data to the namespace of main() function effectively
preserving it for the whole process lifetime.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: <qemu-stable@nongnu.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230727105828.324314-1-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 5b2757920c1..aaccaa33184 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -589,6 +589,9 @@ int main(int argc, char **argv)
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
     BlockExportOptions *export_opts;
+#if HAVE_NBD_DEVICE
+    struct NbdClientOpts opts;
+#endif

 #ifdef CONFIG_POSIX
     os_setup_early_signal_handling();
@@ -1145,7 +1148,7 @@ int main(int argc, char **argv)
     if (device) {
 #if HAVE_NBD_DEVICE
         int ret;
-        struct NbdClientOpts opts = {
+        opts = (struct NbdClientOpts) {
             .device = device,
             .fork_process = fork_process,
             .verbose = verbose,
-- 
2.41.0


