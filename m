Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D1706FE9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDk-00075s-Hh; Wed, 17 May 2023 13:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDZ-00070D-NX
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDY-00041q-85
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYIgHKkXiwxtH3/oSlQBUrXOjLZvBMixiKEGCXviiBE=;
 b=Z5oLmvPQvTFWJPfuyIdE+K2ldszBTdAWEmZ339RsqhWEOYBF+vegWZeIyIAar8ltpadKBj
 JKAhBfqxzuBLQFo/gNPMgPxMiR7xXFGYHyuib+m4wsmJ7+WZ96HVL1rm12O0yNByliOzf7
 kWmMUKsyEA7bPI3RGUaEaln/2khQDNA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-RW43ElxfOIyMSPSVlpktGQ-1; Wed, 17 May 2023 13:45:31 -0400
X-MC-Unique: RW43ElxfOIyMSPSVlpktGQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4fa463282so7683745e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345530; x=1686937530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYIgHKkXiwxtH3/oSlQBUrXOjLZvBMixiKEGCXviiBE=;
 b=Gtp/Fqh+jb9FnitS6g+N8fzxiA94QSiDUJYFr66dGgYa9mB8Gnjxa7Kgq8LW20qUK/
 CoWLl+3sJaJDr0SoiEg4uv+2aqGxOkiZS7oxX1sbiiOV7jzU6SEE9DLSzNWLtGTXrp13
 Fa2jrdR/JuY1F3AS36EHoXFeNIV1TIVBK0E7G9UyGPWEpiKszKXqnR4CKroBMt3gJdzL
 2pq1Xy3wu+gUjkolnUtC77pQEvLW8e3nLN+kfprIUPoqWOene1GNPBlyfAerTAMBQsnZ
 FoZxnE1jOzKb+l2ZBx+rwvCzknB/3jhQXiRWBC+Zu3/MZtAi9V7SJTo1JOoSeGA+jqLk
 x7Pw==
X-Gm-Message-State: AC+VfDzHwG14p2P6H1Ikbm8Z1WCRhulhZchEz51pFeKNBnRmtGpDPOuH
 wShszSNZtS6hKGMYA0i18/MQVrSfkYtljpcAvoC+6UeA+DtfF4C/VDA2B1478h3Ll3iWWEKSokv
 9S8CjXmEXbXnLoc928N1VYLdLIYLaMK1K13gCQxLGhimD5pH3DiLQc4cNc/oLHtt1J/NIZ3XA3+
 A=
X-Received: by 2002:a1c:750a:0:b0:3f4:2bce:eef8 with SMTP id
 o10-20020a1c750a000000b003f42bceeef8mr19346756wmc.16.1684345530076; 
 Wed, 17 May 2023 10:45:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CQT7dIAZfym1JfMtFnZpmD20V6UFfDrKNwPIREmT9oD69qGEp2A3HkRQg1NVktn9uPxi+Cg==
X-Received: by 2002:a1c:750a:0:b0:3f4:2bce:eef8 with SMTP id
 o10-20020a1c750a000000b003f42bceeef8mr19346739wmc.16.1684345529620; 
 Wed, 17 May 2023 10:45:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a1c6a1a000000b003f4272c2d0csm2868598wmc.36.2023.05.17.10.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xinyu Li <lixinyu20s@ict.ac.cn>,
	qemu-stable@nongnu.org
Subject: [PULL 04/68] target/i386: fix avx2 instructions vzeroall and vpermdq
Date: Wed, 17 May 2023 19:44:16 +0200
Message-Id: <20230517174520.887405-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Xinyu Li <lixinyu20s@ict.ac.cn>

vzeroall: xmm_regs should be used instead of xmm_t0
vpermdq: bit 3 and 7 of imm should be considered

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
Message-Id: <20230510145222.586487-1-lixinyu20s@ict.ac.cn>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h      | 8 ++++++++
 target/i386/tcg/emit.c.inc | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 0bd6bfad8a17..fb63af7afa21 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2497,6 +2497,14 @@ void helper_vpermdq_ymm(Reg *d, Reg *v, Reg *s, uint32_t order)
     d->Q(1) = r1;
     d->Q(2) = r2;
     d->Q(3) = r3;
+    if (order & 0x8) {
+        d->Q(0) = 0;
+        d->Q(1) = 0;
+    }
+    if (order & 0x80) {
+        d->Q(2) = 0;
+        d->Q(3) = 0;
+    }
 }
 
 void helper_vpermq_ymm(Reg *d, Reg *s, uint32_t order)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 95fb4f52fabe..4fe8dec42746 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2285,7 +2285,7 @@ static void gen_VZEROALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
 {
     TCGv_ptr ptr = tcg_temp_new_ptr();
 
-    tcg_gen_addi_ptr(ptr, cpu_env, offsetof(CPUX86State, xmm_t0));
+    tcg_gen_addi_ptr(ptr, cpu_env, offsetof(CPUX86State, xmm_regs));
     gen_helper_memset(ptr, ptr, tcg_constant_i32(0),
                       tcg_constant_ptr(CPU_NB_REGS * sizeof(ZMMReg)));
 }
-- 
2.40.1


