Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA77CBB77
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdm6-0007wc-C9; Tue, 17 Oct 2023 02:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdle-0007tk-Ie
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:28 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdld-0001sc-0P
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c871a095ceso36064015ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524882; x=1698129682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESxuAUufQZOaFJVJzjW21Tj1f8ibVF8SktLSFdxgc2A=;
 b=AFZMIs/ryjjc62c4GswLH+YOdyq2HW7ZtkV6Zl0YhoCO+lAkIJ4qKpjQWOaWY4dUy0
 oN6DCQmj8ldemuyERgoPGs3FCPc00UoQtdzxzQZT9+MbDGXbt1wUXV1zbfSSk+u7r3o0
 OKz9u7wKFa7DyixVxkMIJCkI/MVMvEfnNkF477zL9paQPMNgAcRrT/3IPF7m/kXEUnir
 etWDSJBXzjJBO8OpsLNR3LUCZfnGkZyWJzBQ+pIPcjJCCxkuEgZpATGdMjp8xLtx/h1u
 bufeHKQdI8Byii1YidXntz+mo8JWIFVUZAFm8Lfs7XVor0AX+xO1UJxxJW90GN2qPaXi
 nNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524882; x=1698129682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESxuAUufQZOaFJVJzjW21Tj1f8ibVF8SktLSFdxgc2A=;
 b=CD/uLtqfF3DuhwdFJdmCUJuuCNSvUhrJ6sxbpFKj6WnsbHSJBPCiRxBUEpZkoaOCok
 C/wAAiXGw73LHrrKO7mlkneO9UE/Cao+jvb13S/VTVtcz0sYRtCmqZRFF8aucf+jQBkH
 FQ5O6gDUy+Ru92v+MQAlXQ5fDHtYvnHme6AKxGY7lskOMZzuDzzD11maC1ugipAr5hlR
 vcnFyU7GZrNI/yF3uysmgvs162R/wDG3n8epxA+WMmeuOPnEQV1+bcq2abTr9yXSpXrF
 TLjnnKI3V/e0RuYhglV1YXTzMpfyyIITCs8KBX3Ki6IrHa0v/wEso7J+CiAHp0Evs2Wm
 C9AA==
X-Gm-Message-State: AOJu0YxAUgDLngusYs0aF+tbr+vuZ78iVpBfsEt2g8yJaFtFGAObOeFq
 zoICB8kenqoLc9Bg1hx7DXPmfUSZakmBINYnPC0=
X-Google-Smtp-Source: AGHT+IEvqklw5l2ul2FnIDRUZSjroD2MeC39TSliNt+nE+26G1pqsGhNkxKEVJolqwZThvHVzXKz4w==
X-Received: by 2002:a17:903:110d:b0:1c9:e774:58d1 with SMTP id
 n13-20020a170903110d00b001c9e77458d1mr1542367plh.36.1697524882716; 
 Mon, 16 Oct 2023 23:41:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 16/20] target/sparc: Merge gen_op_next_insn into only caller
Date: Mon, 16 Oct 2023 23:41:05 -0700
Message-Id: <20231017064109.681935-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 18546d3bd2..8a92fa4a1a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -953,12 +953,6 @@ static void gen_mov_pc_npc(DisasContext *dc)
     }
 }
 
-static void gen_op_next_insn(void)
-{
-    tcg_gen_mov_tl(cpu_pc, cpu_npc);
-    tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
-}
-
 static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
                         DisasContext *dc)
 {
@@ -2254,7 +2248,8 @@ static bool advance_pc(DisasContext *dc)
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
             dc->pc = dc->npc;
-            gen_op_next_insn();
+            tcg_gen_mov_tl(cpu_pc, cpu_npc);
+            tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
             break;
 
         case JUMP_PC:
-- 
2.34.1


