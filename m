Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA404719B2F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqE-0007tW-4W; Thu, 01 Jun 2023 07:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqB-0007mf-OJ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gq9-0000EN-Vb
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agn07WgIImGe8WSxC+U2NsXZbn2bSqLwFUCX6cHFBXY=;
 b=aDNm/HsYXZ4Mx3WJyHPR+/wcgvK71EUfDkvf2birRS6uRVO8TdvF6kG1WQU5LV1XvZtmRU
 7kODdcQixlDpJIWj8HdVVhnnvtvBdIzKAWb9su7D4k7NlyCc/tmnEtQyc5+zsQTcopKFKz
 AFoEcUjeGai5Euzs6UfdhXioS90nCqA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-1QgUmw0MN-yEwd_prlFlwg-1; Thu, 01 Jun 2023 07:51:36 -0400
X-MC-Unique: 1QgUmw0MN-yEwd_prlFlwg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-973c263d727so56142666b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620294; x=1688212294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agn07WgIImGe8WSxC+U2NsXZbn2bSqLwFUCX6cHFBXY=;
 b=lVVHz5F837XQ1rykZI7+V6jLFnr2itW5hPjmmrShBz0kT18DxmKjnPGn6grMnjeyvd
 zKK/P283V1reZ0Ern1QxnS0SKjYrci3kUL5e5skusk0SjN5DTSFQsZBw2QcO86ap6Ohl
 NZuZwMx7U9GWm7rBz+J2o76rMOR28u5IDloKaB5frXLU49svHmRsvOHPbLFtUN8HDdhy
 Ac2+5Z+2IV9cKytPw2KI4QFJWuZKG0YtXccG6gof/3lwO+WmCpnQHLRRFmtG5/ovPCyb
 t3EFuKEWWROAs3gGzkCPydVt3Qhu6XwLxR+hHxt6eHTCTCcKzdVOEG86Yh//2QmllXts
 WR3g==
X-Gm-Message-State: AC+VfDwsQV8QkTNwyndqXraaq8FMj3viQwr8GNberbyxOYCraTn6EB//
 yF/rmHzg+1fYG5Tg55mJU5KwfLJet8gmsoCHgcbJx3JZgdGr5T9O2muBgqkdh4fy9Jxo4ousCIy
 ITJ9vFRyUPmHNsU4ANeVPp4Px/cS8ufkuLZTvtPr2YvipxTScZU+LoZ3Jif+mTyHXpQOS2u+PH8
 I=
X-Received: by 2002:a17:907:3602:b0:94e:46ef:1361 with SMTP id
 bk2-20020a170907360200b0094e46ef1361mr7843836ejc.34.1685620294369; 
 Thu, 01 Jun 2023 04:51:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CxWUnIMyY7PwyrJXxpJImXtRi2XLLqvKQ96huJwj8AWKzT1FnS6pkP+Xgvv5pLtzzNqIVYw==
X-Received: by 2002:a17:907:3602:b0:94e:46ef:1361 with SMTP id
 bk2-20020a170907360200b0094e46ef1361mr7843815ejc.34.1685620294034; 
 Thu, 01 Jun 2023 04:51:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 w5-20020aa7dcc5000000b0050d83a39e6fsm7107585edu.4.2023.06.01.04.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v2 1/4] block: rename the bdrv_co_block_status static function
Date: Thu,  1 Jun 2023 13:51:28 +0200
Message-Id: <20230601115131.196234-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115131.196234-1-pbonzini@redhat.com>
References: <20230601115131.196234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

bdrv_block_status exists as a wrapper for bdrv_block_status_above,
but the name of the (hypothetical) coroutine version, bdrv_co_block_status,
is squatted by a random static function.  Rename it to bdrv_do_block_status.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index 540bf8d26dff..2c2c9656853c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2236,9 +2236,9 @@ int bdrv_flush_all(void)
  * set to the host mapping and BDS corresponding to the guest offset.
  */
 static int coroutine_fn GRAPH_RDLOCK
-bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
-                     int64_t offset, int64_t bytes,
-                     int64_t *pnum, int64_t *map, BlockDriverState **file)
+bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
+                        int64_t offset, int64_t bytes,
+                        int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int64_t total_size;
     int64_t n; /* bytes */
@@ -2397,8 +2397,8 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_block_status(local_file, want_zero, local_map,
-                                   *pnum, pnum, &local_map, &local_file);
+        ret = bdrv_co_do_block_status(local_file, want_zero, local_map,
+                                      *pnum, pnum, &local_map, &local_file);
         goto out;
     }
 
@@ -2425,8 +2425,8 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
         int64_t file_pnum;
         int ret2;
 
-        ret2 = bdrv_co_block_status(local_file, want_zero, local_map,
-                                    *pnum, &file_pnum, NULL, NULL);
+        ret2 = bdrv_co_do_block_status(local_file, want_zero, local_map,
+                                       *pnum, &file_pnum, NULL, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
@@ -2493,7 +2493,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
         return 0;
     }
 
-    ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
+    ret = bdrv_co_do_block_status(bs, want_zero, offset, bytes, pnum, map, file);
     ++*depth;
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
@@ -2509,8 +2509,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     for (p = bdrv_filter_or_cow_bs(bs); include_base || p != base;
          p = bdrv_filter_or_cow_bs(p))
     {
-        ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
-                                   file);
+        ret = bdrv_co_do_block_status(p, want_zero, offset, bytes, pnum, map, file);
         ++*depth;
         if (ret < 0) {
             return ret;
-- 
2.40.1


