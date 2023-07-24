Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867A75FB20
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNxm1-0006BP-BR; Mon, 24 Jul 2023 11:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qNxlq-00069c-VW
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qNxle-0007jB-6A
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690213597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQ1pGchcZ7QxprONjlqMwSa2shwVZtdSYF8r13BgIXw=;
 b=h+jl55uCC5zL8iymM7JYLGbl3QdLIVDXEQ14vFZlbJ+8Zn3zA9yB5BjWUFzBldl/H+e25U
 UWxyzRisVywpSABKpIgpjYPqToEy+hCTZR1Q9pqhBvFBC/tEgkIro9IsCGtr90hJbxOPDc
 90zl6OKRxY3a2E/+ys0cBvLaOTnjcso=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-Z4Iof87-PJOiS9JDLHUo5g-1; Mon, 24 Jul 2023 11:46:36 -0400
X-MC-Unique: Z4Iof87-PJOiS9JDLHUo5g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63c566512c0so44636856d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690213595; x=1690818395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQ1pGchcZ7QxprONjlqMwSa2shwVZtdSYF8r13BgIXw=;
 b=cHZU1UTzmstqYQSxJ/S22OEnz+Md2WSrrUlMy0pc5b9GUmWvRPHyrL3P6Ow0GwmRY3
 +FGLUlTXGv/WiE4jBNY/Z3zfseJvC8ZQq1P0DLbhJFCEcGgNaWJhkqSxzX9M2KT+4cto
 4jNc6GeoHUzZJVrcQ0vjOMjWw5I8UUc8+4MMP/k/qD4dpyTAc13z1ySEEoisG5MNX6+y
 BMO2UJEF9xy6wSNlHZl/dLPAMkaBRFZAq3j4i8QFC++LkUoZzEH/Brx+TGNJ2Vjkc23D
 Dkzc+l1c1Z8931m+2JlK9F1474nT2Q1sj5pJhL9QZpMJUlSUICBU+iG0VTNsYOzJwdWG
 i0gA==
X-Gm-Message-State: ABy/qLYESA1uf6vqPF2Bx5H5PxKgdqmSQll2bgoK/QSmzgf81TzGECwD
 3QJvvx0HV7YwPk/TH2DFzk9y/3KkJQynrcXdx5m1QxI39KWij0S+TW4ggF9n76iA9F2uiEPHPaS
 PuEDy6AkvPYLCJ5xQ/MNumwlimSV20XJGMqfiBjg103mpLx0IdH8oq3pZrFYTgECWfh6QKMqriO
 A=
X-Received: by 2002:a05:6214:da9:b0:63c:97df:f6da with SMTP id
 h9-20020a0562140da900b0063c97dff6damr175374qvh.25.1690213595453; 
 Mon, 24 Jul 2023 08:46:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGutVBLQ9M013UyT5pB5PuNbSHMyTkK5JYjONcEUuEYdHgp4HZ9XzoF0deMyFMIcMX6iG6Q6g==
X-Received: by 2002:a05:6214:da9:b0:63c:97df:f6da with SMTP id
 h9-20020a0562140da900b0063c97dff6damr175351qvh.25.1690213595086; 
 Mon, 24 Jul 2023 08:46:35 -0700 (PDT)
Received: from step1.redhat.com ([5.77.105.74])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a0cf445000000b0063004b5482csm3647709qvm.92.2023.07.24.08.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 08:46:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] block/blkio: use blkio_set_int("fd") to check fd support
Date: Mon, 24 Jul 2023 17:46:11 +0200
Message-ID: <20230724154611.178858-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724154611.178858-1-sgarzare@redhat.com>
References: <20230724154611.178858-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

The way the virtio-blk driver is implemented in libblkio,
it's much easier to use blkio_set_int() instead of blkio_get_int()
and have it fail right away to see if `fd` is supported by the
transport. See https://gitlab.com/libblkio/libblkio/-/merge_requests/208

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index ca1149042a..719b19324b 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -665,7 +665,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
     const char *blkio_driver = bs->drv->protocol_name;
     BDRVBlkioState *s = bs->opaque;
     bool fd_supported = false;
-    int fd, ret;
+    int ret;
 
     if (!path) {
         error_setg(errp, "missing 'path' option");
@@ -678,7 +678,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
     }
 
     if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0 &&
-        blkio_get_int(s->blkio, "fd", &fd) == 0) {
+        blkio_set_int(s->blkio, "fd", -1) == 0) {
         fd_supported = true;
     }
 
@@ -688,7 +688,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
      * layer through the "/dev/fdset/N" special path.
      */
     if (fd_supported) {
-        int open_flags;
+        int open_flags, fd;
 
         if (flags & BDRV_O_RDWR) {
             open_flags = O_RDWR;
-- 
2.41.0


