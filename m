Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0567CF5AA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:49:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZH-0007CV-O8; Thu, 19 Oct 2023 06:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYq-0006aU-63
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYk-0006K6-RX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc1wAytN855M32R5CShLNXtSB0oVJdwxN5lIj8DxbsA=;
 b=MjIRrDEUx3ioOghVof+h8urWbdazm2beTIXCUTUGVzLClhkAxKjynBHcKxNDeUtAUq5FLf
 xTYSnCUURBAkEQqnyeqVW785q/JHeYcp0zMtw+tIcWGiHHzspIR7R9WkdEZPPEDD2kOeSP
 gRpVs6/7H9C6N6UEn4vZuinAWtbsFZA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-eP4CVUTMOFK6IIxgtGWm9w-1; Thu, 19 Oct 2023 06:47:14 -0400
X-MC-Unique: eP4CVUTMOFK6IIxgtGWm9w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53e2acda9d6so5324654a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712432; x=1698317232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yc1wAytN855M32R5CShLNXtSB0oVJdwxN5lIj8DxbsA=;
 b=HMfyjB7AqBIi+bDwA4K9vRNTAeWPfEktBfEEQBLtnK5Dji1XXWGj5z6afYt8WW6Vnh
 foYCLN8Zy1gr/oVhrONovQd9jUaqUMa5/txmFkX9E+atCIb1ZB1BpdSVjxOXSXyHNJ0Y
 tFyVd5OxUh0FjdZSDU+ZGqsUL0iUL41t9PDLSzLpSnKDmDUsuTXAnsD4bdVsxcR4FEhy
 XZLlol6rJFzLmneX2lO9KlnrOhkxwHzaMzGovZkw/VN7sbplOimlg/aUT2QiewuseUAF
 XP5WSq0TMlvbQJWtyRvJ8dQNTE8QiLu228/JNk9u7ULpP3Dci66+2wwTChp7ETHMyxeI
 1gUQ==
X-Gm-Message-State: AOJu0YwQ+s5eeuyNMDJU81FUkQhawiEYeZ/26to5bf79hWgrO5lSJ7D5
 wVd5sRLNyaesUgU+x0ph3/huA/KRuxDo5QjhwN5NZEb+XBFTg/LrjwG4yG8GqWkBY0wyighEiPr
 9vMuWCnr8zZLpk0FtlU5o/3CqCffkTwx6vV8KlAdKxwKu13ci5jC7jEer7gA5JqW9MtGuVbl03g
 M=
X-Received: by 2002:a05:6402:430b:b0:53d:bc68:633d with SMTP id
 m11-20020a056402430b00b0053dbc68633dmr1531994edc.7.1697712432704; 
 Thu, 19 Oct 2023 03:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAK966MZBi3UTq1SDApChVnv8oYaJY9ExHCuYYa4I0GNcfjNCRyJlMOdCG0b/YkmLOOrRG0A==
X-Received: by 2002:a05:6402:430b:b0:53d:bc68:633d with SMTP id
 m11-20020a056402430b00b0053dbc68633dmr1531970edc.7.1697712432295; 
 Thu, 19 Oct 2023 03:47:12 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05640217ce00b0053e4d1cbc6esm4179905edy.55.2023.10.19.03.47.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:47:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/19] target/i386: split eflags computation out of
 gen_compute_eflags
Date: Thu, 19 Oct 2023 12:46:42 +0200
Message-ID: <20231019104648.389942-14-pbonzini@redhat.com>
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


