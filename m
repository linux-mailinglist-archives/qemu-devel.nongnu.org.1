Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4170C7C809E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpe-0007U8-Mg; Fri, 13 Oct 2023 04:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpR-0007Gt-4S
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:29 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpG-0000jF-MN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso283196f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186837; x=1697791637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoxCBRiQ5GyxpZ9H+p9W0GvU/fTOtPh4UBax5yqghnc=;
 b=GfbHF5XXITtcGtynkWufAj9UlkXZNExiAOkVxYZ1z4xMbF+AOZ035J9KgKz1CgMm8r
 27EWHnVY4N/1qDx35l4k6m4/15QvuKSSElHEa8a2y8lNrrKBMGlXFrVp9+NC8PNcomqF
 LhSkm72xu3X8B7muF+ByNRruYAKTxvGN1vP7BDKmDS+lA7H9sVq1T/+r8XYA4Ce/LrvX
 +udGEXqOzO9Fj8o0DlFgo/S+VOdxYhQpKwu6a/K4bjv6ym6KY/9vG7qbulZj48w3xcLq
 bvXL6XL1vJm1TB6qL/FVShdrA08HjeAx3R+Y6fmhlKQAVaeu0+gsNa8rwizceNtlPBlS
 W0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186837; x=1697791637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NoxCBRiQ5GyxpZ9H+p9W0GvU/fTOtPh4UBax5yqghnc=;
 b=APQRzlngVFsiF5q7P9xmizSbt35UbDwXCNAjgzXF9dKtU9QmabrGXHFJKnPueJlh+P
 vccfwrwdh4UjP3p2OdT56gdemfow8sqlWNuYz9A9PLNHi2P+VRMZ0uwbo/4lk3sRrSFr
 hNgb2McCdUdMjwyYhxbCO/yFj3CstCXA+mFJzKT33s2kXxo+YPZMJebAaW+TLVo11tal
 HsH7ypBdmUwGLXu14nktxtfERuODfRDogLHBXx302lt7xthHBM+9CPfhebRe8za0j3jh
 tBR0TUIOzo2OPFAL/m8cFfo8A05xrMp9QSBFsdSvxw+l/u2RnWlx1mfgPJWqZJByLxiJ
 IBLg==
X-Gm-Message-State: AOJu0YxWTf9NApX3g0Qrm3BUFkctvgs31X+llYaFJjHQ/U2XMpgir+3x
 gqL1umgVm00EV/LhIk44ITwMuqaG7yhEA3G3FGc=
X-Google-Smtp-Source: AGHT+IFiVkn4QLJKtW02PeIK86UmcF3cG2pJ/tr+lSy0y70NiorTGwe4Otb5Mo3bm+G6JW1cT8enhA==
X-Received: by 2002:a5d:56ca:0:b0:319:6e74:1637 with SMTP id
 m10-20020a5d56ca000000b003196e741637mr22031944wrw.27.1697186836779; 
 Fri, 13 Oct 2023 01:47:16 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:16 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Jeff Cody <codyprime@gmail.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [RFC PATCH v3 02/78] block: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:30 +0300
Message-Id: <e54aa70630d6d524886d7950b84d5bda39c3d605.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 block/block-copy.c    |  1 +
 block/file-posix.c    |  1 +
 block/io.c            |  1 +
 block/iscsi.c         |  1 +
 block/qcow2-cluster.c |  5 ++++-
 block/vhdx.c          | 17 +++++++++++++----
 6 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 1c60368d72..b4ceb6a079 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -508,6 +508,7 @@ block_copy_do_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
         trace_block_copy_copy_range_fail(s, offset, ret);
         *method = COPY_READ_WRITE;
         /* Fall through to read+write with allocated buffer */
+        fallthrough;
 
     case COPY_READ_WRITE_CLUSTER:
     case COPY_READ_WRITE:
diff --git a/block/file-posix.c b/block/file-posix.c
index 50e2b20d5c..31c7719da5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1013,6 +1013,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
                               bs->filename);
         }
         /* fall through to unlock bytes. */
+        fallthrough;
     case RAW_PL_ABORT:
         raw_apply_lock_bytes(s, s->fd, s->perm, ~s->shared_perm,
                              true, &local_err);
diff --git a/block/io.c b/block/io.c
index e7f9448d5a..cc05457d02 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2034,6 +2034,7 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
         case BDRV_TRACKED_WRITE:
             stat64_max(&bs->wr_highest_offset, offset + bytes);
             /* fall through, to set dirty bits */
+            fallthrough;
         case BDRV_TRACKED_DISCARD:
             bdrv_set_dirty(bs, offset, bytes);
             break;
diff --git a/block/iscsi.c b/block/iscsi.c
index 5640c8b565..2fb7037748 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1461,6 +1461,7 @@ static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
                 break;
             }
             /* Fall through and try READ CAPACITY(10) instead.  */
+            fallthrough;
         case TYPE_ROM:
             task = iscsi_readcapacity10_sync(iscsilun->iscsi, iscsilun->lun, 0, 0);
             if (task != NULL && task->status == SCSI_STATUS_GOOD) {
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f4f6cd6ad0..c50143d493 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1333,13 +1333,16 @@ static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
 {
     switch (qcow2_get_cluster_type(bs, l2_entry)) {
     case QCOW2_CLUSTER_NORMAL:
+        fallthrough;
     case QCOW2_CLUSTER_ZERO_ALLOC:
         if (l2_entry & QCOW_OFLAG_COPIED) {
             return false;
         }
-        /* fallthrough */
+        fallthrough;
     case QCOW2_CLUSTER_UNALLOCATED:
+        fallthrough;
     case QCOW2_CLUSTER_COMPRESSED:
+        fallthrough;
     case QCOW2_CLUSTER_ZERO_PLAIN:
         return true;
     default:
diff --git a/block/vhdx.c b/block/vhdx.c
index a67edcc03e..9000b3fcea 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1201,10 +1201,14 @@ vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
 
             /* check the payload block state */
             switch (s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK) {
-            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
+            case PAYLOAD_BLOCK_NOT_PRESENT:
+                fallthrough;
             case PAYLOAD_BLOCK_UNDEFINED:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED_v095:
+                fallthrough;
             case PAYLOAD_BLOCK_ZERO:
                 /* return zero */
                 qemu_iovec_memset(&hd_qiov, 0, 0, sinfo.bytes_avail);
@@ -1222,6 +1226,7 @@ vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
             case PAYLOAD_BLOCK_PARTIALLY_PRESENT:
                 /* we don't yet support difference files, fall through
                  * to error */
+                fallthrough;
             default:
                 ret = -EIO;
                 goto exit;
@@ -1373,10 +1378,13 @@ vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                  * data that is not part of this write, so we must pad
                  * the rest of the buffer to zeroes */
                 use_zero_buffers = true;
-                /* fall through */
-            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
+                fallthrough;
+            case PAYLOAD_BLOCK_NOT_PRESENT:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED_v095:
+                fallthrough;
             case PAYLOAD_BLOCK_UNDEFINED:
                 bat_prior_offset = sinfo.file_offset;
                 ret = vhdx_allocate_block(bs, s, &sinfo.file_offset,
@@ -1431,7 +1439,7 @@ vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                     }
                 }
 
-                /* fall through */
+                fallthrough;
             case PAYLOAD_BLOCK_FULLY_PRESENT:
                 /* if the file offset address is in the header zone,
                  * there is a problem */
@@ -1457,6 +1465,7 @@ vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
             case PAYLOAD_BLOCK_PARTIALLY_PRESENT:
                 /* we don't yet support difference files, fall through
                  * to error */
+                fallthrough;
             default:
                 ret = -EIO;
                 goto exit;
-- 
2.39.2


