Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66057CF5A3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZ8-0006r1-Ll; Thu, 19 Oct 2023 06:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYm-0006aI-Gi
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYk-0006Ly-RW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HucFfp4qoLeyj68yJbflzgWXe6rIJtZX6o3+tCqe+xk=;
 b=LqtncQQkSbrZBdFoth4fCiLc2EdfSYGM52ws5fRqc+kNchQnaZ5LdMONlxVYOsjj6258Ms
 2044WSjTbRvZqfSihV/xWLvDZ0yI+BFKu+6ZngGP9NODZ4THZvqtbs6MWiY90LgElEi6/Q
 PCunFz/Ra7vJ0BZEaqacJotwiVHx8M4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-j-sPvKjfOjmtCfCm4emKgQ-1; Thu, 19 Oct 2023 06:47:15 -0400
X-MC-Unique: j-sPvKjfOjmtCfCm4emKgQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a9e12a3093so76124966b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712434; x=1698317234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HucFfp4qoLeyj68yJbflzgWXe6rIJtZX6o3+tCqe+xk=;
 b=VziAe83EKi0Gl+p5EIR27VvpjjWUSd51uMov9xriZ4NLF4lc6V1aQ+Hqx9cZf0bz/b
 P1lymxss2Gb10X6Xpl2Nqhtq5TXsV+IUyLXuXtxgg5y1hL+ITJHg5vtWVrqKWkCtsljB
 FqeYDxRatTljLqcJkZ4NcA6fZKfG4yt20SxAGq/sdhCA3GFkRG8fBnW0mbXp9QvOcNzj
 4kzxgzl4C6fm6W8GJ5Llq8qGEq3yAlZB0abB+qoK/fKS8P9y73BytWe5BSSkqS68XRzO
 JhJDT398aENbIn/Ff2E8S/2ng9/iXnOptdBFOmWaa/pZ//2+umuLYakVacHWGkxPXcQX
 Z9Sw==
X-Gm-Message-State: AOJu0YwiEbTlnO6ohGMDYVK7KoLHMuaU9JbgZ6NvRlCJwlKFInP6Gq+p
 k3l35+Rn7moq03DUyzp79JFa1sp/Tl3/StYnwCtKA5NDVvgSCYKxlnEjsHaw2wMiY3jlTjcwyvq
 sG4DmRhGqPjOolKDVS6Mpi94wq3verqfOyym4Xx4LW1Jn8FhGpl6o3boeChsfU4rtqeBVdlD9Ts
 0=
X-Received: by 2002:a17:907:9490:b0:9ae:5a56:be32 with SMTP id
 dm16-20020a170907949000b009ae5a56be32mr1436738ejc.38.1697712434344; 
 Thu, 19 Oct 2023 03:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQCbrMypby97/T2G03Y9O866GRKqr+rWC+xwmij/CRfYeIjw0pxCYdyaPFufoQsam5jujJ7Q==
X-Received: by 2002:a17:907:9490:b0:9ae:5a56:be32 with SMTP id
 dm16-20020a170907949000b009ae5a56be32mr1436729ejc.38.1697712434039; 
 Thu, 19 Oct 2023 03:47:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a170906d11400b00982a352f078sm3323241ejz.124.2023.10.19.03.47.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:47:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/19] tcg: add negsetcondi
Date: Thu, 19 Oct 2023 12:46:43 +0200
Message-ID: <20231019104648.389942-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This can be useful to write a shift bit extraction that does not
depend on TARGET_LONG_BITS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/tcg/tcg-op-common.h |  4 ++++
 include/tcg/tcg-op.h        |  2 ++
 tcg/tcg-op.c                | 12 ++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2048f92b5e1..2295f2d7085 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -346,6 +346,8 @@ void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
+                             TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -544,6 +546,8 @@ void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
+                             TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 80cfcf8104b..78e474d83e9 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -201,6 +201,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_setcond_tl tcg_gen_setcond_i64
 #define tcg_gen_setcondi_tl tcg_gen_setcondi_i64
 #define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i64
+#define tcg_gen_negsetcondi_tl tcg_gen_negsetcondi_i64
 #define tcg_gen_mul_tl tcg_gen_mul_i64
 #define tcg_gen_muli_tl tcg_gen_muli_i64
 #define tcg_gen_div_tl tcg_gen_div_i64
@@ -319,6 +320,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_setcond_tl tcg_gen_setcond_i32
 #define tcg_gen_setcondi_tl tcg_gen_setcondi_i32
 #define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i32
+#define tcg_gen_negsetcondi_tl tcg_gen_negsetcondi_i32
 #define tcg_gen_mul_tl tcg_gen_mul_i32
 #define tcg_gen_muli_tl tcg_gen_muli_i32
 #define tcg_gen_div_tl tcg_gen_div_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 393dbcd01c3..35dcdd88126 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -291,6 +291,12 @@ void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
     }
 }
 
+void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
+                             TCGv_i32 arg1, int32_t arg2)
+{
+    tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
+}
+
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1602,6 +1608,12 @@ void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
+void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
+                             TCGv_i64 arg1, int64_t arg2)
+{
+    tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
+}
+
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2)
 {
-- 
2.41.0


