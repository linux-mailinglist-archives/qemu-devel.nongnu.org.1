Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 412297DBB77
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:11:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSyS-0006Or-Sa; Mon, 30 Oct 2023 10:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nao.aota@gmail.com>)
 id 1qxMs2-0002nP-Kx; Mon, 30 Oct 2023 03:39:34 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nao.aota@gmail.com>)
 id 1qxMs1-0003Ub-03; Mon, 30 Oct 2023 03:39:34 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-280200949c3so1178187a91.0; 
 Mon, 30 Oct 2023 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698651570; x=1699256370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ej8HqBrqmqJvK47VR/LJCVQrkEeTKvpHVeo1Gm1RpM=;
 b=k7TJ3Q/gUfcPcdoh+/8v90PlsxDGQomvb1QLWWHGb/oOyOUmxFMQmYXq6CP6B1MIvU
 scYp7u9hKxLW18F7bx+eGKaBAWsDVSfvRMwH5n0sNzp7V0xzPO3tqluOG0JYmwLPMyWz
 0CqP6zjEHK52lkX42U5TaT+ayVZgXvXdPhptk5Xuw8KEzpIvrqE0DqjErFQhZv1IiR9N
 zxO9K0P77xqVDQkjxZqjPajjfFMVWpGrn+pKuJQru66gm+j6lCVXOp+Uj82/uLYoDSPO
 APjH//lFn3qERiP/3ejs4Dpc0Po0w4K6YtztZOgAi+tyAt0hkvU//nwmFeXV4Z7eYYNq
 DiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698651570; x=1699256370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ej8HqBrqmqJvK47VR/LJCVQrkEeTKvpHVeo1Gm1RpM=;
 b=wZWUs6FfLxTOFcC1u0RxNTSMpOW10Oy7cv9T9ePioVrMb9kVzKNUJYJYXpjpp3wo5l
 AnbEKpSUYPOnI8v4gywptNfJD20uB0q9mz09raVqE6sqH7aWAdO3QOCQtdw4aV9vc1Md
 Xzt9Hr3EFrmF9ZN7GdX3mgn7EmKv6HhO109zLZzXCffq8RXs25JzFzkdW5TKTlQr1N03
 xSKxFbOax1PRLebvlYclCPmtzydMOkG4hPdY8N1SvPMPju7//+jJ55du+XdR6OyP0u1I
 w6031x3X8+yykTtukUhGBymasuQpsZ9g4ULKHab23XZEByQvRJOHEXfSuujqy33Ebl8l
 In0A==
X-Gm-Message-State: AOJu0YyX8IMqEZ4d/mumKzPJdRGN41YcCy3sGqYnfyY3bLdiKIkx/oHE
 nyy5DT5yKTwjN8guLGk5qYOxkCFhWGEc4A==
X-Google-Smtp-Source: AGHT+IFPR+ikqIofQWllgPafRWxqdmGhPJ9CkIkZu7GixloQ4YZH1CCa/10Urg+Eaq8IQbTg4pSjNg==
X-Received: by 2002:a17:90a:3cc7:b0:27d:546b:4258 with SMTP id
 k7-20020a17090a3cc700b0027d546b4258mr6186199pjd.31.1698651570084; 
 Mon, 30 Oct 2023 00:39:30 -0700 (PDT)
Received: from localhost (fp96936df3.ap.nuro.jp. [150.147.109.243])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a1709029f9700b001cc5225c220sm842969plq.15.2023.10.30.00.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 00:39:29 -0700 (PDT)
From: Naohiro Aota <nao.aota@gmail.com>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] file-posix: fix over-writing of returning zone_append offset
Date: Mon, 30 Oct 2023 16:38:53 +0900
Message-ID: <20231030073853.2601162-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=nao.aota@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Oct 2023 10:10:16 -0400
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

raw_co_zone_append() sets "s->offset" where "BDRVRawState *s". This pointer
is used later at raw_co_prw() to save the block address where the data is
written.

When multiple IOs are on-going at the same time, a later IO's
raw_co_zone_append() call over-writes a former IO's offset address before
raw_co_prw() completes. As a result, the former zone append IO returns the
initial value (= the start address of the writing zone), instead of the
proper address.

Fix the issue by passing the offset pointer to raw_co_prw() instead of
passing it through s->offset. Also, remove "offset" from BDRVRawState as
there is no usage anymore.

Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 block/file-posix.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 50e2b20d5c45..c39209358909 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -160,7 +160,6 @@ typedef struct BDRVRawState {
     bool has_write_zeroes:1;
     bool use_linux_aio:1;
     bool use_linux_io_uring:1;
-    int64_t *offset; /* offset of zone append operation */
     int page_cache_inconsistent; /* errno from fdatasync failure */
     bool has_fallocate;
     bool needs_alignment;
@@ -2445,12 +2444,13 @@ static bool bdrv_qiov_is_aligned(BlockDriverState *bs, QEMUIOVector *qiov)
     return true;
 }
 
-static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
+static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
                                    uint64_t bytes, QEMUIOVector *qiov, int type)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
     int ret;
+    uint64_t offset = *offset_ptr;
 
     if (fd_open(bs) < 0)
         return -EIO;
@@ -2513,8 +2513,8 @@ out:
             uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
             if (!BDRV_ZT_IS_CONV(*wp)) {
                 if (type & QEMU_AIO_ZONE_APPEND) {
-                    *s->offset = *wp;
-                    trace_zbd_zone_append_complete(bs, *s->offset
+                    *offset_ptr = *wp;
+                    trace_zbd_zone_append_complete(bs, *offset_ptr
                         >> BDRV_SECTOR_BITS);
                 }
                 /* Advance the wp if needed */
@@ -2536,14 +2536,14 @@ static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
                                       int64_t bytes, QEMUIOVector *qiov,
                                       BdrvRequestFlags flags)
 {
-    return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
+    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_READ);
 }
 
 static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
                                        int64_t bytes, QEMUIOVector *qiov,
                                        BdrvRequestFlags flags)
 {
-    return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
+    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_WRITE);
 }
 
 static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
@@ -3506,8 +3506,6 @@ static int coroutine_fn raw_co_zone_append(BlockDriverState *bs,
     int64_t zone_size_mask = bs->bl.zone_size - 1;
     int64_t iov_len = 0;
     int64_t len = 0;
-    BDRVRawState *s = bs->opaque;
-    s->offset = offset;
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
@@ -3528,7 +3526,7 @@ static int coroutine_fn raw_co_zone_append(BlockDriverState *bs,
     }
 
     trace_zbd_zone_append(bs, *offset >> BDRV_SECTOR_BITS);
-    return raw_co_prw(bs, *offset, len, qiov, QEMU_AIO_ZONE_APPEND);
+    return raw_co_prw(bs, offset, len, qiov, QEMU_AIO_ZONE_APPEND);
 }
 #endif
 
-- 
2.42.0


