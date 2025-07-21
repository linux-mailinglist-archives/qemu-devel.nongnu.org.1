Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA5B0CC50
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 23:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxsC-0001mw-Cn; Mon, 21 Jul 2025 17:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxm8-0004Mh-Vs
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxm5-0007yy-Li
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753132216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdvTYJfMOU9XEEw0E8ltL4tlN88e9xfHWpswWO88UGM=;
 b=DX02vpPqqFYE/jQ81t8vYpi6Tf211MrfRfYoJudugbqApft5cuDTgDMI/M0ktD6N+gpZPY
 LViUpJrtmleGGogO6+Ji8JWUSenMN9DoCcs+nNRS+qsL50xGdznJoMX/WTgRJ2Uu7GtU6+
 qzQGaeqK5CS04ZC8gB+l1hTqTa+iuCI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-B1ko-f4GMfS4qbKq4Dj5Iw-1; Mon,
 21 Jul 2025 17:10:13 -0400
X-MC-Unique: B1ko-f4GMfS4qbKq4Dj5Iw-1
X-Mimecast-MFC-AGG-ID: B1ko-f4GMfS4qbKq4Dj5Iw_1753132211
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5D5A1800284; Mon, 21 Jul 2025 21:10:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C50618016F9; Mon, 21 Jul 2025 21:10:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, hibriansong@gmail.com, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v3 12/12] block/io_uring: use non-vectored read/write when
 possible
Date: Mon, 21 Jul 2025 17:07:59 -0400
Message-ID: <20250721210759.179709-13-stefanha@redhat.com>
In-Reply-To: <20250721210759.179709-1-stefanha@redhat.com>
References: <20250721210759.179709-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The io_uring_prep_readv2/writev2() man pages recommend using the
non-vectored read/write operations when possible for performance
reasons.

I didn't measure a significant difference but it doesn't hurt to have
this optimization in place.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index dd930ee57e..bbefbddcc0 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -49,12 +49,24 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
 #ifdef HAVE_IO_URING_PREP_WRITEV2
     {
         int luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
-        io_uring_prep_writev2(sqe, fd, qiov->iov,
-                              qiov->niov, offset, luring_flags);
+        if (luring_flags != 0 || qiov->niov > 1) {
+            io_uring_prep_writev2(sqe, fd, qiov->iov,
+                                  qiov->niov, offset, luring_flags);
+        } else {
+            /* The man page says non-vectored is faster than vectored */
+            struct iovec *iov = qiov->iov;
+            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
+        }
     }
 #else
         assert(flags == 0);
-        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+        if (qiov->niov > 1) {
+            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+        } else {
+            /* The man page says non-vectored is faster than vectored */
+            struct iovec *iov = qiov->iov;
+            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
+        }
 #endif
         break;
     case QEMU_AIO_ZONE_APPEND:
@@ -65,8 +77,15 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
         if (req->resubmit_qiov.iov != NULL) {
             qiov = &req->resubmit_qiov;
         }
-        io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov,
-                            offset + req->total_read);
+        if (qiov->niov > 1) {
+            io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov,
+                                offset + req->total_read);
+        } else {
+            /* The man page says non-vectored is faster than vectored */
+            struct iovec *iov = qiov->iov;
+            io_uring_prep_read(sqe, fd, iov->iov_base, iov->iov_len,
+                               offset + req->total_read);
+        }
         break;
     }
     case QEMU_AIO_FLUSH:
-- 
2.50.1


