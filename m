Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56E7D73C9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvj6u-0008EP-Jc; Wed, 25 Oct 2023 15:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvj6s-0008A7-2g
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvj6q-0005aE-1s
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698260400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WRL6kAn36fVmOR6KxcGpbIpAfba7wUv0jD24R5u7Qdo=;
 b=B77g7Zb8bpYGTwbQLIhviJVZjDt1E0pwrpydrliqb8jDFQdiPnEVfaFhDFcg5dWTzZ4DOJ
 nlK8p4D2XqG9ZDWlvAjpBx34Q8mQoKecM+HntNoaqiigd4q8os3zlmPem7LFYz5arr72xY
 w9JUSR5Fo5lxyLbk+csQvu5ONCiOlVI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ZzHKvnY2NsGHxjj0KDT73w-1; Wed, 25 Oct 2023 14:59:58 -0400
X-MC-Unique: ZzHKvnY2NsGHxjj0KDT73w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d026cae6eso940236d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 11:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698260397; x=1698865197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WRL6kAn36fVmOR6KxcGpbIpAfba7wUv0jD24R5u7Qdo=;
 b=ZteZec+DSnLiou/ru67WPOPXfrl0KfBvbtZnzdtqWiEdfVop3gyvVNPqNzaNEJg3Nt
 ODYM3ev5c94uUAW5PFn6h/7M3BJwCeMTXLxtH/o9SUXBG/pBGLAIaBFX/ikJ8IKBKR5w
 HW5qeWUyeZRrOB4LgziV/3DEVy3HRisZhiF+IhYLw9UliEN7I3xIyYIRLq06UsE84cqp
 W5JDjNA6APbbE0r9ShDWY5SpWn6TbLNakGCnRLdtq+pzw82oHMYbPOhGd5CbDDlGhFHG
 38u+OcJLeVRtwcWVLgXDnTd6UwYTn1wqhOei3A7vsyH7pDcZjqzy0SM5LQRcL6vv3E9r
 WbqA==
X-Gm-Message-State: AOJu0Yy7eGx2h9EWuwhc2DhMean18ayB9DQaU0Qw2aQ/EP08I7YB98Pe
 Yuoc/Jy+B7v+8+RqpZVPTbCAr7RUY27vFn0aXpOC8EBZt4MZ1NaiwXonhT4/x9HQgfkU0MhCf2z
 OR98HqOuDVk3pk3XtaAT+LbQTZENlvVkG7lqTcNPLegKQig7MlLixlKMu4F4WMNmxn8GcZHazBw
 4=
X-Received: by 2002:a05:6214:2586:b0:66d:1d22:42d8 with SMTP id
 fq6-20020a056214258600b0066d1d2242d8mr21103364qvb.11.1698260397780; 
 Wed, 25 Oct 2023 11:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjXd9O9+6Byg3AkPsQwvarXANBbpeltN5+WBm1g23uv9ef/ecZThtaz5a5y9aHWUA0eva0Eg==
X-Received: by 2002:a05:6214:2586:b0:66d:1d22:42d8 with SMTP id
 fq6-20020a056214258600b0066d1d2242d8mr21103347qvb.11.1698260397429; 
 Wed, 25 Oct 2023 11:59:57 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a05620a124800b0076cb3690ae7sm4397513qkl.68.2023.10.25.11.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 11:59:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [RFC PATCH] tcg: allow a target to request canonicalization of SUBI
 to ADDI
Date: Wed, 25 Oct 2023 20:59:56 +0200
Message-ID: <20231025185956.72677-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On x86, this is more efficient because it enables generation of
more LEA instructions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/tcg/tcg.h     |  4 ++++
 tcg/i386/tcg-target.h |  2 ++
 tcg/tcg-op.c          | 20 ++++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a9282cdcc60..48e5aeef173 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -109,6 +109,10 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
+#ifndef TCG_TARGET_PREFERS_addi
+#define TCG_TARGET_PREFERS_addi         0
+#endif
+
 #ifndef TCG_TARGET_deposit_i32_valid
 #define TCG_TARGET_deposit_i32_valid(ofs, len) 1
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 8417ea4899e..452c6eba2d6 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -227,6 +227,8 @@ typedef enum {
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
 #define TCG_TARGET_HAS_cmpsel_vec       -1
 
+#define TCG_TARGET_PREFERS_addi         1
+
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
      (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 828eb9ee460..48c667032de 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -151,6 +151,8 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
+    } else if (TCG_TARGET_PREFERS_addi) {
+        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(-arg2));
     } else {
         tcg_gen_sub_i32(ret, arg1, tcg_constant_i32(arg2));
     }
@@ -1369,11 +1371,21 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_sub_i64(ret, arg1, tcg_constant_i64(arg2));
+        if (TCG_TARGET_PREFERS_addi) {
+            tcg_gen_add_i64(ret, arg1, tcg_constant_i64(-arg2));
+        } else {
+            tcg_gen_sub_i64(ret, arg1, tcg_constant_i64(arg2));
+        }
     } else {
-        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
-                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
+        if (TCG_TARGET_PREFERS_addi) {
+            tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                             TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                             tcg_constant_i32(-arg2), tcg_constant_i32(-arg2 >> 32));
+        } else {
+            tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                             TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                             tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
+        }
     }
 }
 
-- 
2.41.0


