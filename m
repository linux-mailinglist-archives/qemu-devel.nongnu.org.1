Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D475AC5103
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 16:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvOX-0006BC-2Q; Tue, 27 May 2025 10:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJvOU-000681-SE
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJvOP-0002bc-It
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748356500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1S/kMrOzjZ0NqewxJw8HeRV5XW7Pqs0/t9+vb2zLJE=;
 b=MsycPdDoqDpJQIyBncaoJ1Vh0Ro+CkngnupIt0mjwXcEmPhRJYuq4+dwtgxUK15jvf2JTb
 MIOkPSnJ9OAwrQYXK8QTiKFL5Cbp3bQGC/hW5+h+QKqA7XRyQ8NjB8MPfN7l+thunGRHiK
 ndyd8/fV0YPOF8041QkF4AyalWg3BYE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-4ul9xgFwOIWEKhj-QFU6xQ-1; Tue,
 27 May 2025 10:34:57 -0400
X-MC-Unique: 4ul9xgFwOIWEKhj-QFU6xQ-1
X-Mimecast-MFC-AGG-ID: 4ul9xgFwOIWEKhj-QFU6xQ_1748356496
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7A26180035C; Tue, 27 May 2025 14:34:55 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 178911944DFF; Tue, 27 May 2025 14:34:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 2/2] qcow2,
 vmdk: Restrict creation with secondary file using protocol
Date: Tue, 27 May 2025 09:32:45 -0500
Message-ID: <20250527143446.3397017-6-eblake@redhat.com>
In-Reply-To: <20250527143446.3397017-4-eblake@redhat.com>
References: <20250527143446.3397017-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Ever since CVE-2024-4467 (see commit 7ead9469 in qemu v9.1.0), we have
intentionally treated the opening of secondary files whose name is
specified in the contents of the primary file, such as a qcow2
data_file, as something that must be a local file and not a protocol
prefix (it is still possible to open a qcow2 file that wraps an NBD
data image by using QMP commands, but that is from the explicit action
of the QMP overriding any string encoded in the qcow2 file).  At the
time, we did not prevent the use of protocol prefixes on the secondary
image while creating a qcow2 file, but it results in a qcow2 file that
records an empty string for the data_file, rather than the protocol
passed in during creation:

$ qemu-img create -f raw datastore.raw 2G
$ qemu-nbd -e 0 -t -f raw datastore.raw &
$ qemu-img create -f qcow2 -o data_file=nbd://localhost:10809/ \
  datastore_nbd.qcow2 2G
Formatting 'datastore_nbd.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2147483648 data_file=nbd://localhost:10809/ lazy_refcounts=off refcount_bits=16
$ qemu-img info datastore_nbd.qcow2 | grep data
$ qemu-img info datastore_nbd.qcow2 | grep data
image: datastore_nbd.qcow2
    data file:
    data file raw: false
    filename: datastore_nbd.qcow2

And since an empty string was recorded in the file, attempting to open
the image without using QMP to supply the NBD data store fails, with a
somewhat confusing error message:

$ qemu-io -f qcow2 datastore_nbd.qcow2
qemu-io: can't open device datastore_nbd.qcow2: The 'file' block driver requires a file name

Although the ability to create an image with a convenience reference
to a protocol data file is not a security hole (unlike the case with
open, the image is not untrusted if we are the ones creating it), the
above demo shows that it is still inconsistent.  Thus, it makes more
sense if we also insist that image creation rejects a protocol prefix
when using the same syntax.  Now, the above attempt produces:

$ qemu-img create -f qcow2 -o data_file=nbd://localhost:10809/ \
  datastore_nbd.qcow2 2G
Formatting 'datastore_nbd.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2147483648 data_file=nbd://localhost:10809/ lazy_refcounts=off refcount_bits=16
qemu-img: datastore_nbd.qcow2: Could not create 'nbd://localhost:10809/': No such file or directory

with datastore_nbd.qcow2 no longer created.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 2 +-
 block/vmdk.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index f1ed03c543e..bcf4d920946 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3969,7 +3969,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     /* Create and open an external data file (protocol layer) */
     val = qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
     if (val) {
-        ret = bdrv_co_create_file(val, opts, true, errp);
+        ret = bdrv_co_create_file(val, opts, false, errp);
         if (ret < 0) {
             goto finish;
         }
diff --git a/block/vmdk.c b/block/vmdk.c
index 576af241e59..c655899fda1 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2332,7 +2332,7 @@ vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
     int ret;
     BlockBackend *blk = NULL;

-    ret = bdrv_co_create_file(filename, opts, true, errp);
+    ret = bdrv_co_create_file(filename, opts, false, errp);
     if (ret < 0) {
         goto exit;
     }
-- 
2.49.0


