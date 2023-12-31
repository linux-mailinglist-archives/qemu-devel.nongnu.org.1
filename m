Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56114820A7B
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSJ-0004Mg-Gy; Sun, 31 Dec 2023 03:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSG-0004Fw-UV
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSF-0000ki-3F
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+eGaivxgxxuwgRxyPAihwfI4xNVtda+8GH8RU0PMw0=;
 b=ABxWjtuvLB/zGuwt120raDsDV9Kq5Kx51nz6puE7GVJijBTnrO9yjdKvGC2cJme3yOY7TV
 9kpWhoeXFTx/q7UQJItW47hC3hBgDbeR7PR3BIfI7zonXweUiwL/9rETvtcA5OmeOItSXs
 B5NRsQyD/KhmvIs1rL46TvBRK0V1tkI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Cj-K5j8_OLi11MgeIPn8iA-1; Sun, 31 Dec 2023 03:45:47 -0500
X-MC-Unique: Cj-K5j8_OLi11MgeIPn8iA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-55641f6437fso15924a12.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012346; x=1704617146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+eGaivxgxxuwgRxyPAihwfI4xNVtda+8GH8RU0PMw0=;
 b=dvdxej/cBoY1TKV6D1XjKh7rndQ6VuOv7rCJVTq1/F4hD6xlfsU9AKz1F9ijmhkXu8
 aNv89qHwFMTeXpPKjQxGypjhg/93Sfo/hykrXnTeR5qJQTB41mMw2gSL+Kk+GA4OHVlc
 NhyWtly/VHj2qQMRHb37iL4YcfwBB1CM0+WpOjm8ZUyqhWS3kl2uEeu9Gxut2rffx78W
 PaFv179qIAKUx8OFkYpUvanGmDdqKGwWoXHR7mTjTkM0tSS7SmxHLZBArn6knTzeFAL9
 v4nnEr77GOQRi0u6B043jUxVOwiYod7RASzu1nT7jU5g++7/doNfyvT1Skd/hMtoTQ0E
 hDHQ==
X-Gm-Message-State: AOJu0Yy41qOG5FVmBAtNtos9y5lFtdXMyICC5pRL42h9U+i022iEdBcK
 K1OvtVIDxnWfnRAv5xkHD9QpmXTvw0eup5TcxBQbH+7P1507RZT1KmGIi3NrQFbOfFQndiqP3kM
 Gc6mfRBUf/fPL7YIW21vivjWbIKL6pNeFjO6HvnzjOhQZQ0OG+WukH1Sb7KbNpLJrXd1gi1pPsx
 RJV86WzRQ=
X-Received: by 2002:a50:ab5d:0:b0:554:1af:fe11 with SMTP id
 t29-20020a50ab5d000000b0055401affe11mr8927826edc.12.1704012345893; 
 Sun, 31 Dec 2023 00:45:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAxzV7A6FRgymOn6hxm1CR8F1iCFVnmEgS98/JWpAbHUxtKZL5ECvHceqVWCkwEbXvt0HZjw==
X-Received: by 2002:a50:ab5d:0:b0:554:1af:fe11 with SMTP id
 t29-20020a50ab5d000000b0055401affe11mr8927818edc.12.1704012345531; 
 Sun, 31 Dec 2023 00:45:45 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a05640240c200b005527c02c1d6sm13143688edb.50.2023.12.31.00.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/46] target/i386: split eflags computation out of
 gen_compute_eflags
Date: Sun, 31 Dec 2023 09:44:31 +0100
Message-ID: <20231231084502.235366-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The new x86 decoder wants the gen_* functions to compute EFLAGS before
writeback, which can be an issue for instructions with a memory
destination such as ARPL or shifts.

Extract code to compute the EFLAGS without clobbering CC_SRC, in case
the memory write causes a fault.  The flags writeback mechanism will
take care of copying the result to CC_SRC.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 00ed0cc9a31..b79c312465b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -862,22 +862,22 @@ static void gen_op_update_neg_cc(DisasContext *s)
     tcg_gen_movi_tl(s->cc_srcT, 0);
 }
 
-/* compute all eflags to cc_src */
-static void gen_compute_eflags(DisasContext *s)
+/* compute all eflags to reg */
+static void gen_mov_eflags(DisasContext *s, TCGv reg)
 {
-    TCGv zero, dst, src1, src2;
+    TCGv dst, src1, src2;
+    TCGv_i32 cc_op;
     int live, dead;
 
     if (s->cc_op == CC_OP_EFLAGS) {
+        tcg_gen_mov_tl(reg, cpu_cc_src);
         return;
     }
     if (s->cc_op == CC_OP_CLR) {
-        tcg_gen_movi_tl(cpu_cc_src, CC_Z | CC_P);
-        set_cc_op(s, CC_OP_EFLAGS);
+        tcg_gen_movi_tl(reg, CC_Z | CC_P);
         return;
     }
 
-    zero = NULL;
     dst = cpu_cc_dst;
     src1 = cpu_cc_src;
     src2 = cpu_cc_src2;
@@ -886,7 +886,7 @@ static void gen_compute_eflags(DisasContext *s)
     live = cc_op_live[s->cc_op] & ~USES_CC_SRCT;
     dead = live ^ (USES_CC_DST | USES_CC_SRC | USES_CC_SRC2);
     if (dead) {
-        zero = tcg_constant_tl(0);
+        TCGv zero = tcg_constant_tl(0);
         if (dead & USES_CC_DST) {
             dst = zero;
         }
@@ -898,8 +898,18 @@ static void gen_compute_eflags(DisasContext *s)
         }
     }
 
-    gen_update_cc_op(s);
-    gen_helper_cc_compute_all(cpu_cc_src, dst, src1, src2, cpu_cc_op);
+    if (s->cc_op != CC_OP_DYNAMIC) {
+        cc_op = tcg_constant_i32(s->cc_op);
+    } else {
+        cc_op = cpu_cc_op;
+    }
+    gen_helper_cc_compute_all(reg, dst, src1, src2, cc_op);
+}
+
+/* compute all eflags to cc_src */
+static void gen_compute_eflags(DisasContext *s)
+{
+    gen_mov_eflags(s, cpu_cc_src);
     set_cc_op(s, CC_OP_EFLAGS);
 }
 
-- 
2.43.0


