Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D442B7CBAFC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK1-0008Nd-Ll; Tue, 17 Oct 2023 02:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJz-0008Mk-I0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:51 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJx-0003oq-U0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:51 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5ab94fc098cso1987635a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523168; x=1698127968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/T5XaZy2rs7d2UUVgUOSmmRBHeDvLpxjj7qjWAVo54c=;
 b=U1Hneme1dZUPUISq7/8N8msYOy1ZbcRWY0XA8c7SHv1xPhgZwMa+8ZTTIR/El+KP4S
 q4VQ19PuoZiqkGofLdNhcIHfIyYLHNPQ7DJecvJhew015/uLwkZmeqEQ3MLPTb5NJmN7
 6KgdsEikJNNxA2naq9FgDEkeVfY05KPAGr/U6/vBligZxXJyyhLEYOHW0sgPZziUpVUn
 OGdqx0Xz7uF62gt4++lo428zWEeKGSeZB6l+SCi2bD7kx+W9JnraUhmnefHHsUKXn/Yj
 74lfR83j7X644IEQfTm2obwq+G+0qmZdl+Eb3A0g/N4RqUk8NxDUO6qV9RpSkLmrDwcS
 +28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523168; x=1698127968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/T5XaZy2rs7d2UUVgUOSmmRBHeDvLpxjj7qjWAVo54c=;
 b=ZLpPgjKRPlrW9tlxlh1YgAi/cCYGAJ2paHFa7O0NQb/5hKeMwAc7WhRVmUtwoQc6Ny
 DUoghDCG3K7y+Wk75LezBXf9qc3IOP8LQWqpXa9YCA4ZruOVI6agBctoiLSUB2A8oWs3
 MNtWqfczrj6CVBZ1kcHdqA0amGrg9tSY4YMBnnCNl5SIPaHqDm/S2D6P3eqMXSxP/vyv
 kn11l4gjG0NbaXe/0C0I+BMqx5IdmnWh/7tfDbs6uKQs0Z6dl3Z2GOiVjCDT4toOv0i4
 PBLyrn3OVuCGB0/pWMFaOaGP2fwFwedakv5PfGZ11zpK4RLJu4qA/Qyp/pjfqlVDQDIQ
 KOcw==
X-Gm-Message-State: AOJu0YxsnoSjmht0+R4GZUdRM3DlPLOuVjceF0euzgV6teiywiKJGsQU
 gV6Qrmx6Y2vmghAKTBPQz4F+eY9tdmMVjSh/QYU=
X-Google-Smtp-Source: AGHT+IFDAjNl8OR81DtNcJzBP6uD2drm8nCXuK/BzzSKhSn+KY+ywx4z56JJIqv1Nz0f6MBzZd8xwA==
X-Received: by 2002:a05:6a21:7802:b0:14d:abc:73dc with SMTP id
 be2-20020a056a21780200b0014d0abc73dcmr1112968pzc.32.1697523168365; 
 Mon, 16 Oct 2023 23:12:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 03/90] target/sparc: Avoid helper_raise_exception in
 helper_st_asi
Date: Mon, 16 Oct 2023 23:11:17 -0700
Message-Id: <20231017061244.681584-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Always use cpu_raise_exception_ra with GETPC for unwind.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/ldst_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 246de86c98..09066d5487 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1650,7 +1650,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->dmmu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x33:
@@ -1662,7 +1662,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->dmmu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x35:
@@ -1679,7 +1679,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->immu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
       break;
     case 0x37:
@@ -1691,7 +1691,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->immu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-          helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case ASI_UPA_CONFIG: /* UPA config */
@@ -1920,6 +1920,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     default:
         sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         return;
+    illegal_insn:
+        cpu_raise_exception_ra(env, TT_ILL_INSN, GETPC());
     }
 }
 #endif /* CONFIG_USER_ONLY */
-- 
2.34.1


