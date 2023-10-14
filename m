Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D54047C93FF
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:02:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbT6-0002Xj-U5; Sat, 14 Oct 2023 06:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSy-0002XR-Gt
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSx-00040e-1j
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc1wAytN855M32R5CShLNXtSB0oVJdwxN5lIj8DxbsA=;
 b=gGJGGClZ5bVKOsZ0MlY79Y6uzKF7vJymLbCZNfa2Ldg+LRZjXiuI9vtVoCop+yoOscZIsY
 1xaTZHM3WN8NXMeH5noBzhVe7dkSy44Ml23b47YAEw5iSg5YOnNml7Cin6AZMOnzdiQrVf
 NVx3Nl7RjcwilmIi11LV2vV4CRGu/a0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-5FpdqlobN3e6SfKXHJL0LQ-1; Sat, 14 Oct 2023 06:01:47 -0400
X-MC-Unique: 5FpdqlobN3e6SfKXHJL0LQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso211608966b.3
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277706; x=1697882506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yc1wAytN855M32R5CShLNXtSB0oVJdwxN5lIj8DxbsA=;
 b=Xyg9yR6nnjW9YbSPk9tKXa2q88Zt/WsDur+FjT77+f+6iz1GpevcFTuPl7d/7dq027
 kS89J+EC3+bfLFjfkauwfWlzJPmPtuaPYcYRZo09j0YQA5KvqlLaSuvl7/zcfnU0ZtoT
 IxfaqJ8lo2SbGjoRsgfFyPfRDfqVURMgEdhEFyFaFz1rNmBvPJ8h+D1ZboGFhvmjY8+m
 gI3822stOpZjciUYnYaJgTxRrrp+Kx3115gJmZqH06BX1cxCo3xQYDe0VSfvn5RIa2UB
 S6iMWS5XOO1TXc6cB3nisR8MM8O0M8eAIvJMJlJ5Ffo3eU5hxyt+OSU373fkrqO9cvyO
 dAyw==
X-Gm-Message-State: AOJu0Yyv+rQ48w5CttaVMr2B+YC4pVXGC35gQ1AaNq9CZ5NxzcsQZSlS
 xv0pNfwtPXNm6mD5wz4Q13Eb6hywtotKW75zEpPtnJVo+3LQ5xT6if52se3crU5KXfyiFJLSDcX
 7rx00MN/Tia3QIKn07xFzL4rS6Df5XXeCj9aI0sVu+Qa3E+NKGNFYcuAtcJdb7Aim7AoP6D/eLM
 A=
X-Received: by 2002:a17:906:da:b0:9ae:5253:175b with SMTP id
 26-20020a17090600da00b009ae5253175bmr26270638eji.34.1697277706431; 
 Sat, 14 Oct 2023 03:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwNbB0x/EFvtYhV/DPO8c5XrDQmjjEd7DrNOFqwVBo793TV6rfBEOlqqKGuT6JgV20DrtWLA==
X-Received: by 2002:a17:906:da:b0:9ae:5253:175b with SMTP id
 26-20020a17090600da00b009ae5253175bmr26270622eji.34.1697277706138; 
 Sat, 14 Oct 2023 03:01:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 ck22-20020a170906c45600b009b2d46425absm728488ejb.85.2023.10.14.03.01.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/18] target/i386: split eflags computation out of
 gen_compute_eflags
Date: Sat, 14 Oct 2023 12:01:15 +0200
Message-ID: <20231014100121.109817-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
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

The new x86 decoder wants to compute EFLAGS before writeback, which
can be an issue for some instructions such as ARPL.  Extract code
to compute the EFLAGS without clobbering CC_SRC, in case the ARPL
memory write causes a fault.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e13bf7df591..2da7c357cdc 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -872,18 +872,20 @@ static void gen_op_update_neg_cc(DisasContext *s)
     tcg_gen_movi_tl(s->cc_srcT, 0);
 }
 
-/* compute all eflags to cc_src */
-static void gen_compute_eflags(DisasContext *s)
+/* compute all eflags to reg */
+static void gen_mov_eflags(DisasContext *s, TCGv reg)
 {
     TCGv zero, dst, src1, src2;
     int live, dead;
 
     if (s->cc_op == CC_OP_EFLAGS) {
+        if (reg != cpu_cc_src) {
+            tcg_gen_mov_tl(reg, cpu_cc_src);
+        }
         return;
     }
     if (s->cc_op == CC_OP_CLR) {
-        tcg_gen_movi_tl(cpu_cc_src, CC_Z | CC_P);
-        set_cc_op(s, CC_OP_EFLAGS);
+        tcg_gen_movi_tl(reg, CC_Z | CC_P);
         return;
     }
 
@@ -909,7 +911,13 @@ static void gen_compute_eflags(DisasContext *s)
     }
 
     gen_update_cc_op(s);
-    gen_helper_cc_compute_all(cpu_cc_src, dst, src1, src2, cpu_cc_op);
+    gen_helper_cc_compute_all(reg, dst, src1, src2, cpu_cc_op);
+}
+
+/* compute all eflags to cc_src */
+static void gen_compute_eflags(DisasContext *s)
+{
+    gen_mov_eflags(s, cpu_cc_src);
     set_cc_op(s, CC_OP_EFLAGS);
 }
 
-- 
2.41.0


