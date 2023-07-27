Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D2765CF6
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7BE-0000nm-Nw; Thu, 27 Jul 2023 16:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Ao-0000gC-Aa
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Ak-0002jV-Br
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsxiWqVUN4b/jGAtlTYnRiq+MCbYH2vLoTyH/YKZ3Gc=;
 b=dH3gkSq1ZnQmgs/vWoKFPYnyfwRyhy9MRJX+NUdz+yjwN/OOUHJK/rZ7g6CyT29sa+ncpW
 fmn8CLNDImX8Hki+6xotO7wbi+0LGaMS5161ZZEzVMCHAFdxdvcud/ZXAlmuJpBfjfiRan
 EcPkOFmdCCgomKAkx5cPjTR3Cy21mmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-SZ-bJ80iPMCPYhZZSr-Efw-1; Thu, 27 Jul 2023 16:01:12 -0400
X-MC-Unique: SZ-bJ80iPMCPYhZZSr-Efw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5469185A78F;
 Thu, 27 Jul 2023 20:01:09 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FAD540C2063;
 Thu, 27 Jul 2023 20:01:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL for-8.1 3/8] block/file-posix: fix g_file_get_contents return
 path
Date: Thu, 27 Jul 2023 16:00:53 -0400
Message-ID: <20230727200058.1071776-4-stefanha@redhat.com>
In-Reply-To: <20230727200058.1071776-1-stefanha@redhat.com>
References: <20230727200058.1071776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sam Li <faithilikerun@gmail.com>

The g_file_get_contents() function returns a g_boolean. If it fails, the
returned value will be 0 instead of -1. Solve the issue by skipping
assigning ret value.

This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230727115844.8480-1-faithilikerun@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9e8e3d8ca5..b16e9c21a1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1232,7 +1232,6 @@ static int hdev_get_max_hw_transfer(int fd, struct stat *st)
 static int get_sysfs_str_val(struct stat *st, const char *attribute,
                              char **val) {
     g_autofree char *sysfspath = NULL;
-    int ret;
     size_t len;
 
     if (!S_ISBLK(st->st_mode)) {
@@ -1242,8 +1241,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
     sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
                                 major(st->st_rdev), minor(st->st_rdev),
                                 attribute);
-    ret = g_file_get_contents(sysfspath, val, &len, NULL);
-    if (ret == -1) {
+    if (!g_file_get_contents(sysfspath, val, &len, NULL)) {
         return -ENOENT;
     }
 
@@ -1253,7 +1251,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
     if (*(p + len - 1) == '\n') {
         *(p + len - 1) = '\0';
     }
-    return ret;
+    return 0;
 }
 #endif
 
-- 
2.41.0


