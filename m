Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E1719B40
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqX-0000m8-MR; Thu, 01 Jun 2023 07:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqS-0000jN-8P
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqQ-0000KN-FO
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:55 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-qVoCfgtUPji0155Mk3Nygw-1; Thu, 01 Jun 2023 07:51:45 -0400
X-MC-Unique: qVoCfgtUPji0155Mk3Nygw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96fa4c724fdso251622866b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620304; x=1688212304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=td+aVHnUrsWpkhBWzhnvbYh0/myIf5m6/5vEaonDHfM=;
 b=AwqiYSO/csHpkxPiOMxVyHhSS/F4a+TqXCecidV8iag9k1/77gsCojxNFkRB/8G9U9
 XhglrpiI4iTwVECbB4hUFIdZtaPNW4Gx/6pi6VAnq7lP8naS0SjTZIm4Y/d1EKYeaZr5
 TU/tRkcH68lXwX/tk2VhhPtTPMw4AASY/dHYmPUU1KZeEQLfvJ0ewyjtyW6nq/FHk422
 J2QsfbBc5IkkCNS5AFT9y1dtbr/4/KO/Nspp3/erEGUBpueqbNYibeEXH6D/FnUOFAc1
 LHWFFhX2872zfsFVnWDW1FzIAAIn5ijz1nq905bkv8UT/ov8swgg59OFM41svmuNiE5m
 3f4Q==
X-Gm-Message-State: AC+VfDy1HKf7E28yYb6FHu/nRpUVxftHO5Fh0bmiFYZR8cJ3x5hj97St
 quEpbdydb5HRRtNxRN5aiFEpC7WFWBJ1I8u+MvsrbN0p/K9bGExE/hIgM4ZEjRNqBUJkFGWF1Ox
 AQ+WnrQOSwdUdkDdgycq6KLw5Ed/Ob4p1wcfg8DdJjXa66mTodFdrys4Ct2m80bEUF6pawuSGVw
 o=
X-Received: by 2002:a17:907:7f9e:b0:969:df2e:d7d1 with SMTP id
 qk30-20020a1709077f9e00b00969df2ed7d1mr1666433ejc.24.1685620303906; 
 Thu, 01 Jun 2023 04:51:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SlMLA2HpvzGikCqbqvjVSKgxa2K/sQxt0EGp5hqnV7bFj7dOJgsY29puBJA9iZlyYm0qhgQ==
X-Received: by 2002:a17:907:7f9e:b0:969:df2e:d7d1 with SMTP id
 qk30-20020a1709077f9e00b00969df2ed7d1mr1666422ejc.24.1685620303729; 
 Thu, 01 Jun 2023 04:51:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170906960f00b00966069b78absm10390641ejx.192.2023.06.01.04.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v2 2/3] block: do not check bdrv_file_open
Date: Thu,  1 Jun 2023 13:51:38 +0200
Message-Id: <20230601115139.196369-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115139.196369-1-pbonzini@redhat.com>
References: <20230601115139.196369-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

The set of BlockDrivers that have .bdrv_file_open coincides with those
that have .protocol_name and guess what---checking drv->bdrv_file_open
is done to see if the driver is a protocol.  So check drv->protocol_name
instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index a1452e747b62..40eeda213666 100644
--- a/block.c
+++ b/block.c
@@ -913,7 +913,6 @@ BlockDriver *bdrv_find_protocol(const char *filename,
     int i;
 
     GLOBAL_STATE_CODE();
-    /* TODO Drivers without bdrv_file_open must be specified explicitly */
 
     /*
      * XXX(hch): we really should not let host device detection
@@ -1949,7 +1948,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     open_flags = bdrv_open_flags(bs, bs->open_flags);
     node_name = qemu_opt_get(opts, "node-name");
 
-    assert(!drv->bdrv_file_open || file == NULL);
+    assert(!drv->protocol_name || file == NULL);
     ret = bdrv_open_driver(bs, drv, node_name, options, open_flags, errp);
     if (ret < 0) {
         goto fail_opts;
@@ -2049,7 +2048,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
         }
         /* If the user has explicitly specified the driver, this choice should
          * override the BDRV_O_PROTOCOL flag */
-        protocol = drv->bdrv_file_open;
+        protocol = drv->protocol_name;
     }
 
     if (protocol) {
@@ -4017,7 +4016,7 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     }
 
     /* BDRV_O_PROTOCOL must be set iff a protocol BDS is about to be created */
-    assert(!!(flags & BDRV_O_PROTOCOL) == !!drv->bdrv_file_open);
+    assert(!!(flags & BDRV_O_PROTOCOL) == !!drv->protocol_name);
     /* file must be NULL if a protocol BDS is about to be created
      * (the inverse results in an error message from bdrv_open_common()) */
     assert(!(flags & BDRV_O_PROTOCOL) || !file);
@@ -5816,7 +5815,7 @@ int64_t coroutine_fn bdrv_co_get_allocated_file_size(BlockDriverState *bs)
         return drv->bdrv_co_get_allocated_file_size(bs);
     }
 
-    if (drv->bdrv_file_open) {
+    if (drv->protocol_name) {
         /*
          * Protocol drivers default to -ENOTSUP (most of their data is
          * not stored in any of their children (if they even have any),
@@ -7932,7 +7931,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          *   Both of these conditions are represented by generate_json_filename.
          */
         if (primary_child_bs->exact_filename[0] &&
-            primary_child_bs->drv->bdrv_file_open &&
+            primary_child_bs->drv->protocol_name &&
             !drv->is_filter && !generate_json_filename)
         {
             strcpy(bs->exact_filename, primary_child_bs->exact_filename);
-- 
2.40.1


