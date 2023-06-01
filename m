Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A9719B46
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:55:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqT-0000jq-Te; Thu, 01 Jun 2023 07:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqP-0000Wr-Oe
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqO-0000JH-18
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMWulZHTaScQd9/JU/TApJQLCHaMO0Wjq3Q9vGaYfHU=;
 b=JlUOC+ZdN3qTLJ4TbjCvNhmOpqbT5jbwlmAIFRbxeIiW7zAdbatjczz76FFBymNglpueGg
 HnwepURF0CO5oVcgObfdaAwLNr800kH98fxhlT+hrfrvWcrW1ieFmVbRYQck6x3/gXx/vC
 6IJqd+vFulIV+o2oeXe8WL0ZbqTnWt0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-zMNzUBFnNzyf2wUMBTAsMg-1; Thu, 01 Jun 2023 07:51:50 -0400
X-MC-Unique: zMNzUBFnNzyf2wUMBTAsMg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f4d917e06so249380066b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620308; x=1688212308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMWulZHTaScQd9/JU/TApJQLCHaMO0Wjq3Q9vGaYfHU=;
 b=fjCbUnnY+Xs0VFhdSjiFVNVZuGEpt56jK1Hkk+3Q1ZlDQ8zeeAArrjBw8JgahAh7pF
 WmJgpzvsWlrxB1HadH8+BcmMCC268wGEwJWFzPw1tZh3I97iRbqjI5qH5OOFPqgyw23k
 0HlGPnD/GGP0hm5zeQNrNbaGka7zsrIhY9N1D2OMtVcoZ2UoOBmtBGqg2fZgZbCVuOob
 J4cQqeGU7i90ynIidabmN/UMmBfcPRVta6JVwCsMgAokMww8oTUmfVOqJZbBSas/zRsq
 AGcHO65g4QNm7xj/xq/y6arNJc4rE5IehptI+BQamgv5aEyjKUYUuQ4jDZLJ/NZttZMM
 Gq+w==
X-Gm-Message-State: AC+VfDw7jTASFs45dzt886ygsBK3s6+sF3NB6QKYO9u1DRiK21/EASKA
 wSPE0A3U5rnAOXZG/rVCE9Vj5Iurgh82CLmDiiT9yEv/ICe7LlPAdODUzSRW6/QRSJc8sBzNq0i
 SKylgq/AAcseMrFew9XYJfBhSQ8SPp3PODUOzkPjlD5MkvNrn4YF2Xjun5YbQ5IiTz+N950ZLU4
 o=
X-Received: by 2002:a17:907:9445:b0:973:84b0:b077 with SMTP id
 dl5-20020a170907944500b0097384b0b077mr1379959ejc.33.1685620308679; 
 Thu, 01 Jun 2023 04:51:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5q6mOFXZ5qDaaNBM34xR8MAFtmYRDWlkHbcC7yg+C8gMTlR/lLhGueChez+D0/QCux86Y0Bw==
X-Received: by 2002:a17:907:9445:b0:973:84b0:b077 with SMTP id
 dl5-20020a170907944500b0097384b0b077mr1379942ejc.33.1685620308416; 
 Thu, 01 Jun 2023 04:51:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a170906561a00b009664e25c425sm10558794ejq.95.2023.06.01.04.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 01/12] file-posix: remove incorrect coroutine_fn calls
Date: Thu,  1 Jun 2023 13:51:34 +0200
Message-Id: <20230601115145.196465-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
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

raw_co_getlength is called by handle_aiocb_write_zeroes, which is not a coroutine
function.  This is harmless because raw_co_getlength does not actually suspend,
but in the interest of clarity make it a non-coroutine_fn that is just wrapped
by the coroutine_fn raw_co_getlength.  Likewise, check_cache_dropped was only
a coroutine_fn because it called raw_co_getlength, so it can be made non-coroutine
as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 942f529f6ffc..5e0afaba69a5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -193,7 +193,7 @@ static int fd_open(BlockDriverState *bs)
     return -EIO;
 }
 
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs);
+static int64_t raw_getlength(BlockDriverState *bs);
 
 typedef struct RawPosixAIOData {
     BlockDriverState *bs;
@@ -1974,7 +1974,7 @@ static int handle_aiocb_write_zeroes(void *opaque)
 #ifdef CONFIG_FALLOCATE
     /* Last resort: we are trying to extend the file with zeroed data. This
      * can be done via fallocate(fd, 0) */
-    len = raw_co_getlength(aiocb->bs);
+    len = raw_getlength(aiocb->bs);
     if (s->has_fallocate && len >= 0 && aiocb->aio_offset >= len) {
         int ret = do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->aio_nbytes);
         if (ret == 0 || ret != -ENOTSUP) {
@@ -2696,7 +2696,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
-        int64_t cur_length = raw_co_getlength(bs);
+        int64_t cur_length = raw_getlength(bs);
 
         if (offset != cur_length && exact) {
             error_setg(errp, "Cannot resize device files");
@@ -2714,7 +2714,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
 }
 
 #ifdef __OpenBSD__
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int fd = s->fd;
@@ -2733,7 +2733,7 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
         return st.st_size;
 }
 #elif defined(__NetBSD__)
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int fd = s->fd;
@@ -2758,7 +2758,7 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
         return st.st_size;
 }
 #elif defined(__sun__)
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     struct dk_minfo minfo;
@@ -2789,7 +2789,7 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
     return size;
 }
 #elif defined(CONFIG_BSD)
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int fd = s->fd;
@@ -2861,7 +2861,7 @@ again:
     return size;
 }
 #else
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int ret;
@@ -2880,6 +2880,11 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
 }
 #endif
 
+static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+{
+    return raw_getlength(bs);
+}
+
 static int64_t coroutine_fn raw_co_get_allocated_file_size(BlockDriverState *bs)
 {
     struct stat st;
@@ -3245,7 +3250,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
          * round up if necessary.
          */
         if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
-            int64_t file_length = raw_co_getlength(bs);
+            int64_t file_length = raw_getlength(bs);
             if (file_length > 0) {
                 /* Ignore errors, this is just a safeguard */
                 assert(hole == file_length);
@@ -3267,7 +3272,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
 
 #if defined(__linux__)
 /* Verify that the file is not in the page cache */
-static void coroutine_fn check_cache_dropped(BlockDriverState *bs, Error **errp)
+static void check_cache_dropped(BlockDriverState *bs, Error **errp)
 {
     const size_t window_size = 128 * 1024 * 1024;
     BDRVRawState *s = bs->opaque;
@@ -3282,7 +3287,7 @@ static void coroutine_fn check_cache_dropped(BlockDriverState *bs, Error **errp)
     page_size = sysconf(_SC_PAGESIZE);
     vec = g_malloc(DIV_ROUND_UP(window_size, page_size));
 
-    end = raw_co_getlength(bs);
+    end = raw_getlength(bs);
 
     for (offset = 0; offset < end; offset += window_size) {
         void *new_window;
@@ -4504,7 +4509,7 @@ static int cdrom_reopen(BlockDriverState *bs)
 
 static bool coroutine_fn cdrom_co_is_inserted(BlockDriverState *bs)
 {
-    return raw_co_getlength(bs) > 0;
+    return raw_getlength(bs) > 0;
 }
 
 static void coroutine_fn cdrom_co_eject(BlockDriverState *bs, bool eject_flag)
-- 
2.40.1


