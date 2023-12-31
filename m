Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5B5820A7C
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSP-0004gI-7c; Sun, 31 Dec 2023 03:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSM-0004fT-8Q
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSF-0000kn-Qj
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHqfKMbRQrVj8WKXfN8TWZ9hw6GezKe5eBtmfGKO85M=;
 b=OrZB1H6l9/5z/y9QmUEmv4Fk3nmFwkVN1EKMBFOdzrsayR2WXSAWmRWf/Jm2Ls41wiJa+m
 RWNJo0bQA+syTJiPsbd/6tIxSMOhYbG7O4otZAobIT7LjyZ7N60YZiEWTxFJbMmRESun24
 xGq57Aa/646FXd8id9Eq3usgOZgIvCg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-IAIkjVhpPjafPpL5mjRhSQ-1; Sun, 31 Dec 2023 03:45:53 -0500
X-MC-Unique: IAIkjVhpPjafPpL5mjRhSQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a275f860d04so110378266b.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012351; x=1704617151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHqfKMbRQrVj8WKXfN8TWZ9hw6GezKe5eBtmfGKO85M=;
 b=cWvlw78ameQmgZCC+qozRLr5oRbbCgBByRw58GpO/f82bIG7mnzlr7o8hAblGsLQwF
 bpP1Fj5hm7oKQ2uMkLXdem6hgSx2m41Oc0z8Xplz+zRppue6MevAE30+Ed+N4qnnu8E4
 NpmoPGHdx3t3bWbP6uvVDUfyf2yjA/aqoeeMt8npc5pGVkIu6oEISqqKet7mab8eBQsR
 Tf3EsDqKjsYa1PFdudr3AOOuQ80Jzsrl/pfk0OetD0eVh0VdOhuDur2TnwA+YuRNKfQ4
 339GMfWuwdpWEhCQWqy4Yucf/N/2FDZ+UIr+s5UK5QQSuNmNfUORj8ysbk3o9iUBdmsH
 G9Tg==
X-Gm-Message-State: AOJu0Yxod0klDGfsMS0nJnyhDuhJ7Y5/CyvL2Ra4MoqRlx9Hvx+uEdV9
 l7VTVKZ6PKKO7CDE/3PUIkXAryo4vDTqDo2+cMBhNthG3g93EKZ4wNvWV5U0vwLvUrhFRALyEgH
 wiImiWaaY/twPzJQmR0TjVG8ik2E/vGCHZyniuekQ5K/WPwb9HRyriHkkOFJNG5Oleao8nCvx7j
 LGB5KdvII=
X-Received: by 2002:a17:906:3cc:b0:a27:f950:4586 with SMTP id
 c12-20020a17090603cc00b00a27f9504586mr99996eja.129.1704012351380; 
 Sun, 31 Dec 2023 00:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvFzL2zfZfIqCh/blI18oMWx4gxleqxAkLAlWPW8xDHUfIzgdSsOfwnwyNjn86Jj035MGJaQ==
X-Received: by 2002:a17:906:3cc:b0:a27:f950:4586 with SMTP id
 c12-20020a17090603cc00b00a27f9504586mr99992eja.129.1704012351177; 
 Sun, 31 Dec 2023 00:45:51 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 fr1-20020a170906890100b00a26f5e9506fsm5671605ejc.109.2023.12.31.00.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/46] target/i386: do not use s->tmp0 for jumps on ECX ==/!= 0
Date: Sun, 31 Dec 2023 09:44:33 +0100
Message-ID: <20231231084502.235366-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a new temporary, to ease the register allocator's work.

Creation of the temporary is pushed into gen_ext_tl, which
also allows NULL as the first parameter now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index afe0fa6c65f..e5f71170967 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -720,6 +720,9 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
     if (size == MO_TL) {
         return src;
     }
+    if (!dst) {
+        dst = tcg_temp_new();
+    }
     tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
     return dst;
 }
@@ -736,9 +739,9 @@ static void gen_exts(MemOp ot, TCGv reg)
 
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
-    tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);
-    gen_extu(s->aflag, s->tmp0);
-    tcg_gen_brcondi_tl(cond, s->tmp0, 0, label1);
+    TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
+
+    tcg_gen_brcondi_tl(cond, tmp, 0, label1);
 }
 
 static inline void gen_op_jz_ecx(DisasContext *s, TCGLabel *label1)
-- 
2.43.0


