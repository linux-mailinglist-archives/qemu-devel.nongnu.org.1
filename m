Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043B81CE51
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4o-000157-0t; Fri, 22 Dec 2023 13:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4k-000139-KQ
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4i-0006E4-L6
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703269004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNaCfmFWwccashUJv3EROArCvHyzG0Ka6PM7LhfAcOM=;
 b=CudfjKYVYBgfHymF5IeiMDtytHWfm37NzchMGEyTxW/eJzpt5Zu1/DpNnSyHWAH9CMaaFg
 rcdqwdzE7xbgGBcrcuCBcK9P1ohG658PVa7iYTwcQsPtkVFzrKSPvThoC/HXAjGitNIuzP
 uJ5Lm6L3/P4xY5Fbzp6zPZ/GlPsXK6w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-QSRUPHb7Ml6E0zwbIJcLqA-1; Fri, 22 Dec 2023 13:16:42 -0500
X-MC-Unique: QSRUPHb7Ml6E0zwbIJcLqA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50e50724029so2056541e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703269000; x=1703873800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNaCfmFWwccashUJv3EROArCvHyzG0Ka6PM7LhfAcOM=;
 b=PyTsD++wQxDbSKolPnyfHCefYSlQjrUp+IW3cnvgy3+xc4onaQEOuAf6eiQkACs/Fx
 T9AgbzK4MQZHAk31QWe+NYNyYJkMsi/yxtz8pqEd6OrDMbNbSrL5kwRDtwt1L7E2zD6N
 JouYIxUid/vLRn/gHT3neMW0EzDBpPchOR+flraryWSMX03n+uar5WSTEhrSSETrZ/qs
 AiBPm3AXnqEBCj+nlWh6Ac0SvEly9JPEkPwkY6XEcPvEOy9031Xuxd7dieOOaGcXQnTR
 7I8b5D5I2FENaJ9SYKQ4wJTkuP2avlxxTdyz8uOeDt8EAkVobAxC+Hi75dD7l4OZgaqU
 WpEA==
X-Gm-Message-State: AOJu0YymRzvdiS1qJqtSuHFpM1FRvh/cEdEJ79QQgQTefLfOeI4MlY5V
 gj+wHfeW4sDhVxNOqHPGlUDdS345tsOiTuImSmmGY/UfcDTY3C7gEfuTrkl9fNPvDBfbeZuYDLy
 HG8jpkYSITgDBGZpyfjEbZFyIsnOBu23DM/gJSKc6xSwIeb689M66hnx1YxdIx1xOxik/c9n5g8
 ROpet36OQ=
X-Received: by 2002:a05:6512:788:b0:50e:6ec4:9f3e with SMTP id
 x8-20020a056512078800b0050e6ec49f3emr249665lfr.129.1703269000248; 
 Fri, 22 Dec 2023 10:16:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAE6qx4vPvBRZYXwEHyhpGtoaZs3nqH3rzF2697LK+Oh0hX8EpN4gBMhgWrgdZbWo+766KFA==
X-Received: by 2002:a05:6512:788:b0:50e:6ec4:9f3e with SMTP id
 x8-20020a056512078800b0050e6ec49f3emr249662lfr.129.1703268999858; 
 Fri, 22 Dec 2023 10:16:39 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k26-20020a170906129a00b00a2332116b3esm2304893ejb.152.2023.12.22.10.16.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/22] target/i386: prepare for implementation of STOS/SCAS in
 new decoder
Date: Fri, 22 Dec 2023 19:15:59 +0100
Message-ID: <20231222181603.174137-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

Do not use gen_op, and pull the load from the accumulator into
disas_insn.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index edbad0ad746..c7d48088418 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1264,7 +1264,6 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *s)
 
 static void gen_stos(DisasContext *s, MemOp ot)
 {
-    gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
     gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
@@ -1282,7 +1281,11 @@ static void gen_scas(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
-    gen_op(s, OP_CMPL, ot, R_EAX);
+    tcg_gen_mov_tl(cpu_cc_src, s->T1);
+    tcg_gen_mov_tl(s->cc_srcT, s->T0);
+    tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
+    set_cc_op(s, CC_OP_SUBB + ot);
+
     gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
 }
 
@@ -4960,6 +4963,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0xaa: /* stosS */
     case 0xab:
         ot = mo_b_d(b, dflag);
+        gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_stos(s, ot);
         } else {
@@ -4978,6 +4982,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0xae: /* scasS */
     case 0xaf:
         ot = mo_b_d(b, dflag);
+        gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_scas(s, ot, 1);
         } else if (prefixes & PREFIX_REPZ) {
-- 
2.43.0


