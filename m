Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302D719B3B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqP-0000W8-Mp; Thu, 01 Jun 2023 07:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqN-0000Ja-5t
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqK-0000IQ-Vt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0dtoDna82+jGvTTbAjDQ/EMDiDJX2YjJKQvonAYv2Q=;
 b=X+fsBRDQ0YZJl5GTxaBm6GRBBsR4uZszBr79Vq6e4n3Y8QnhuNBuqtZVxD6iXmEpIr7OgG
 IfgCW6UF/I5qL/knoYSALSJs7468SM4sLJfYruMGogRDGI+P+ex18aa6pW0oEFkyGMfBoU
 OFgNyp+1ZflYQI5+hFuukEMhYJv28Kc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156--HEtoTGwOoulQOBnxgXY9g-1; Thu, 01 Jun 2023 07:51:47 -0400
X-MC-Unique: -HEtoTGwOoulQOBnxgXY9g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9737cde2ce8so103201666b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620305; x=1688212305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0dtoDna82+jGvTTbAjDQ/EMDiDJX2YjJKQvonAYv2Q=;
 b=bt52fblVOLphzrcbYRSD9FFAUAAXCiJvxdtI92+5XZOymE4ISzey91b/0Co37jiBEc
 5pGqLp/LtJrgmZ1qjFxq73suspCvzTONS/a5PupBWee1O8nWxFc3LxRKzPLGnphkNEOJ
 mTJXXe3D9UotzwZtiO/xhCQHK1PJi9GY8JSpSUwqRbaSFae14Yx5nx7DX1ouSptnmvxT
 rXRCpF5c4KPQwjOr7OwWvY2+MJQHYFht/QukQQgju76k0CYC+5o8kWna1x+Fvx9j2wMb
 xjNQy1GWhWMCT3pywWLZpnpPVd7RQcXWR7rXEuyww1mYMKrYSeIKqS+3Um2YPv4CT9o5
 jwng==
X-Gm-Message-State: AC+VfDyiFK3fuD/PoXHwceusyX8Jq7Y6C3qHFeO6X6Y7P9WesARRNNn7
 s/5ysBOADrKuV+E+HTX9b9rdLDgxUrCRBzVsx+d0Fj0Tbew4R9Vz9L6UFNByeszamBKGDbwnhnb
 nhxGL9uYVQj/L/Im81A5nvLJ3RanWcsU1Q1LKG+MfVcvjugCJn7iTe9A3FBAJBbNb4ifpqr29kU
 c=
X-Received: by 2002:a17:907:3eaa:b0:96f:add6:c1ed with SMTP id
 hs42-20020a1709073eaa00b0096fadd6c1edmr1279590ejc.38.1685620305517; 
 Thu, 01 Jun 2023 04:51:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7F8NIw6Tx6ZlWGVNjxl21AXHHWhajRIE5+KjMa2MrLMZon6RHMciY+ZTZtdXpnlIyJ9m+z4A==
X-Received: by 2002:a17:907:3eaa:b0:96f:add6:c1ed with SMTP id
 hs42-20020a1709073eaa00b0096fadd6c1edmr1279577ejc.38.1685620305172; 
 Thu, 01 Jun 2023 04:51:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a1709063a4600b00973fac6065esm6372778ejf.223.2023.06.01.04.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v2 3/3] block: remove separate bdrv_file_open callback
Date: Thu,  1 Jun 2023 13:51:39 +0200
Message-Id: <20230601115139.196369-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115139.196369-1-pbonzini@redhat.com>
References: <20230601115139.196369-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

bdrv_file_open and bdrv_open are completely equivalent, they are
never checked except to see which one to invoke.  So merge them
into a single one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                          | 4 +---
 block/blkdebug.c                 | 2 +-
 block/blkio.c                    | 2 +-
 block/blkverify.c                | 2 +-
 block/curl.c                     | 8 ++++----
 block/file-posix.c               | 8 ++++----
 block/file-win32.c               | 4 ++--
 block/gluster.c                  | 8 ++++----
 block/iscsi.c                    | 4 ++--
 block/nbd.c                      | 6 +++---
 block/nfs.c                      | 2 +-
 block/null.c                     | 4 ++--
 block/nvme.c                     | 2 +-
 block/rbd.c                      | 3 ++-
 block/ssh.c                      | 2 +-
 block/vvfat.c                    | 2 +-
 include/block/block_int-common.h | 3 ---
 17 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/block.c b/block.c
index 40eeda213666..113e3d90fd52 100644
--- a/block.c
+++ b/block.c
@@ -1627,9 +1627,7 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
     bs->opaque = g_malloc0(drv->instance_size);
 
     assert(!drv->bdrv_needs_filename || bs->filename[0]);
-    if (drv->bdrv_file_open) {
-        ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
-    } else if (drv->bdrv_open) {
+    if (drv->bdrv_open) {
         ret = drv->bdrv_open(bs, options, open_flags, &local_err);
     } else {
         ret = 0;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index addad914b3f7..c9ae3cb6ae3d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -1072,7 +1072,7 @@ static BlockDriver bdrv_blkdebug = {
     .is_filter              = true,
 
     .bdrv_parse_filename    = blkdebug_parse_filename,
-    .bdrv_file_open         = blkdebug_open,
+    .bdrv_open              = blkdebug_open,
     .bdrv_close             = blkdebug_close,
     .bdrv_reopen_prepare    = blkdebug_reopen_prepare,
     .bdrv_child_perm        = blkdebug_child_perm,
diff --git a/block/blkio.c b/block/blkio.c
index 72117fa0059b..202cf20ca4bb 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -992,7 +992,7 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
         .format_name             = name, \
         .protocol_name           = name, \
         .instance_size           = sizeof(BDRVBlkioState), \
-        .bdrv_file_open          = blkio_file_open, \
+        .bdrv_open               = blkio_open, \
         .bdrv_close              = blkio_close, \
         .bdrv_co_getlength       = blkio_co_getlength, \
         .bdrv_co_truncate        = blkio_truncate, \
diff --git a/block/blkverify.c b/block/blkverify.c
index 7326461f30e0..263166046ea6 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -313,7 +313,7 @@ static BlockDriver bdrv_blkverify = {
     .instance_size                    = sizeof(BDRVBlkverifyState),
 
     .bdrv_parse_filename              = blkverify_parse_filename,
-    .bdrv_file_open                   = blkverify_open,
+    .bdrv_open                        = blkverify_open,
     .bdrv_close                       = blkverify_close,
     .bdrv_child_perm                  = bdrv_default_perms,
     .bdrv_co_getlength                = blkverify_co_getlength,
diff --git a/block/curl.c b/block/curl.c
index 0fc42d03d777..cd2dee3f0a8b 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -1032,7 +1032,7 @@ static BlockDriver bdrv_http = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
@@ -1051,7 +1051,7 @@ static BlockDriver bdrv_https = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
@@ -1070,7 +1070,7 @@ static BlockDriver bdrv_ftp = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
@@ -1089,7 +1089,7 @@ static BlockDriver bdrv_ftps = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 0ab158efba28..942f529f6ffc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3904,7 +3904,7 @@ BlockDriver bdrv_file = {
     .bdrv_needs_filename = true,
     .bdrv_probe = NULL, /* no probe for protocols */
     .bdrv_parse_filename = raw_parse_filename,
-    .bdrv_file_open = raw_open,
+    .bdrv_open      = raw_open,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit = raw_reopen_commit,
     .bdrv_reopen_abort = raw_reopen_abort,
@@ -4278,7 +4278,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_needs_filename = true,
     .bdrv_probe_device  = hdev_probe_device,
     .bdrv_parse_filename = hdev_parse_filename,
-    .bdrv_file_open     = hdev_open,
+    .bdrv_open          = hdev_open,
     .bdrv_close         = raw_close,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
@@ -4420,7 +4420,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
-    .bdrv_file_open     = cdrom_open,
+    .bdrv_open          = cdrom_open,
     .bdrv_close         = raw_close,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
@@ -4549,7 +4549,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
-    .bdrv_file_open     = cdrom_open,
+    .bdrv_open          = cdrom_open,
     .bdrv_close         = raw_close,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
diff --git a/block/file-win32.c b/block/file-win32.c
index 48b790d91739..7e1baa1ece6a 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -746,7 +746,7 @@ BlockDriver bdrv_file = {
     .instance_size	= sizeof(BDRVRawState),
     .bdrv_needs_filename = true,
     .bdrv_parse_filename = raw_parse_filename,
-    .bdrv_file_open     = raw_open,
+    .bdrv_open          = raw_open,
     .bdrv_refresh_limits = raw_probe_alignment,
     .bdrv_close         = raw_close,
     .bdrv_co_create_opts = raw_co_create_opts,
@@ -920,7 +920,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_needs_filename = true,
     .bdrv_parse_filename = hdev_parse_filename,
     .bdrv_probe_device	= hdev_probe_device,
-    .bdrv_file_open	= hdev_open,
+    .bdrv_open     	= hdev_open,
     .bdrv_close		= raw_close,
     .bdrv_refresh_limits = hdev_refresh_limits,
 
diff --git a/block/gluster.c b/block/gluster.c
index 185a83e5e533..6b25aa2516ab 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1553,7 +1553,7 @@ static BlockDriver bdrv_gluster = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster",
     .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
+    .bdrv_open                    = qemu_gluster_open,
     .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
@@ -1582,7 +1582,7 @@ static BlockDriver bdrv_gluster_tcp = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster+tcp",
     .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
+    .bdrv_open                    = qemu_gluster_open,
     .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
@@ -1611,7 +1611,7 @@ static BlockDriver bdrv_gluster_unix = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster+unix",
     .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
+    .bdrv_open                    = qemu_gluster_open,
     .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
@@ -1646,7 +1646,7 @@ static BlockDriver bdrv_gluster_rdma = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster+rdma",
     .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
+    .bdrv_open                    = qemu_gluster_open,
     .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
diff --git a/block/iscsi.c b/block/iscsi.c
index 34f97ab64605..926b19e16749 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2426,7 +2426,7 @@ static BlockDriver bdrv_iscsi = {
 
     .instance_size          = sizeof(IscsiLun),
     .bdrv_parse_filename    = iscsi_parse_filename,
-    .bdrv_file_open         = iscsi_open,
+    .bdrv_open              = iscsi_open,
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = bdrv_co_create_opts_simple,
     .create_opts            = &bdrv_create_opts_simple,
@@ -2465,7 +2465,7 @@ static BlockDriver bdrv_iser = {
 
     .instance_size          = sizeof(IscsiLun),
     .bdrv_parse_filename    = iscsi_parse_filename,
-    .bdrv_file_open         = iscsi_open,
+    .bdrv_open              = iscsi_open,
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = bdrv_co_create_opts_simple,
     .create_opts            = &bdrv_create_opts_simple,
diff --git a/block/nbd.c b/block/nbd.c
index a3f8f8a9d5ef..141a403f738c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -2112,7 +2112,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_co_create_opts        = bdrv_co_create_opts_simple,
     .create_opts                = &bdrv_create_opts_simple,
-    .bdrv_file_open             = nbd_open,
+    .bdrv_open                  = nbd_open,
     .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
@@ -2140,7 +2140,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_co_create_opts        = bdrv_co_create_opts_simple,
     .create_opts                = &bdrv_create_opts_simple,
-    .bdrv_file_open             = nbd_open,
+    .bdrv_open                  = nbd_open,
     .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
@@ -2168,7 +2168,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_co_create_opts        = bdrv_co_create_opts_simple,
     .create_opts                = &bdrv_create_opts_simple,
-    .bdrv_file_open             = nbd_open,
+    .bdrv_open                  = nbd_open,
     .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
diff --git a/block/nfs.c b/block/nfs.c
index 8f89ece69fa1..d21bd93e4a40 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -890,7 +890,7 @@ static BlockDriver bdrv_nfs = {
 #endif
     .bdrv_co_truncate               = nfs_file_co_truncate,
 
-    .bdrv_file_open                 = nfs_file_open,
+    .bdrv_open                      = nfs_file_open,
     .bdrv_close                     = nfs_file_close,
     .bdrv_co_create                 = nfs_file_co_create,
     .bdrv_co_create_opts            = nfs_file_co_create_opts,
diff --git a/block/null.c b/block/null.c
index 4808704ffd3a..6fa64d20d865 100644
--- a/block/null.c
+++ b/block/null.c
@@ -283,7 +283,7 @@ static BlockDriver bdrv_null_co = {
     .protocol_name          = "null-co",
     .instance_size          = sizeof(BDRVNullState),
 
-    .bdrv_file_open         = null_file_open,
+    .bdrv_open              = null_file_open,
     .bdrv_parse_filename    = null_co_parse_filename,
     .bdrv_co_getlength      = null_co_getlength,
     .bdrv_co_get_allocated_file_size = null_co_get_allocated_file_size,
@@ -304,7 +304,7 @@ static BlockDriver bdrv_null_aio = {
     .protocol_name          = "null-aio",
     .instance_size          = sizeof(BDRVNullState),
 
-    .bdrv_file_open         = null_file_open,
+    .bdrv_open              = null_file_open,
     .bdrv_parse_filename    = null_aio_parse_filename,
     .bdrv_co_getlength      = null_co_getlength,
     .bdrv_co_get_allocated_file_size = null_co_get_allocated_file_size,
diff --git a/block/nvme.c b/block/nvme.c
index 17937d398db5..c6ec19484f21 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1641,7 +1641,7 @@ static BlockDriver bdrv_nvme = {
     .create_opts              = &bdrv_create_opts_simple,
 
     .bdrv_parse_filename      = nvme_parse_filename,
-    .bdrv_file_open           = nvme_file_open,
+    .bdrv_open                = nvme_file_open,
     .bdrv_close               = nvme_close,
     .bdrv_co_getlength        = nvme_co_getlength,
     .bdrv_probe_blocksizes    = nvme_probe_blocksizes,
diff --git a/block/rbd.c b/block/rbd.c
index 978671411ec7..9ea00d82930d 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1811,8 +1811,9 @@ static const char *const qemu_rbd_strong_runtime_opts[] = {
 static BlockDriver bdrv_rbd = {
     .format_name            = "rbd",
     .instance_size          = sizeof(BDRVRBDState),
+
     .bdrv_parse_filename    = qemu_rbd_parse_filename,
-    .bdrv_file_open         = qemu_rbd_open,
+    .bdrv_open              = qemu_rbd_open,
     .bdrv_close             = qemu_rbd_close,
     .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
     .bdrv_co_create         = qemu_rbd_co_create,
diff --git a/block/ssh.c b/block/ssh.c
index 2748253d4a36..3e45a98d94ec 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1357,7 +1357,7 @@ static BlockDriver bdrv_ssh = {
     .protocol_name                = "ssh",
     .instance_size                = sizeof(BDRVSSHState),
     .bdrv_parse_filename          = ssh_parse_filename,
-    .bdrv_file_open               = ssh_file_open,
+    .bdrv_open                    = ssh_file_open,
     .bdrv_co_create               = ssh_co_create,
     .bdrv_co_create_opts          = ssh_co_create_opts,
     .bdrv_close                   = ssh_close,
diff --git a/block/vvfat.c b/block/vvfat.c
index 5df2d6b1c64d..2ff98af6a42c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3257,7 +3257,7 @@ static BlockDriver bdrv_vvfat = {
     .instance_size          = sizeof(BDRVVVFATState),
 
     .bdrv_parse_filename    = vvfat_parse_filename,
-    .bdrv_file_open         = vvfat_open,
+    .bdrv_open              = vvfat_open,
     .bdrv_refresh_limits    = vvfat_refresh_limits,
     .bdrv_close             = vvfat_close,
     .bdrv_child_perm        = vvfat_child_perm,
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index b1cbc1e00cdb..371d7aaa697f 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -245,9 +245,6 @@ struct BlockDriver {
     int GRAPH_UNLOCKED_PTR (*bdrv_open)(
         BlockDriverState *bs, QDict *options, int flags, Error **errp);
 
-    /* Protocol drivers should implement this instead of bdrv_open */
-    int GRAPH_UNLOCKED_PTR (*bdrv_file_open)(
-        BlockDriverState *bs, QDict *options, int flags, Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
 
     int coroutine_fn GRAPH_UNLOCKED_PTR (*bdrv_co_create)(
-- 
2.40.1


