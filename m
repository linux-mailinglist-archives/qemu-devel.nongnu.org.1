Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 130EF7D2151
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:07:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW4-0000Vh-Np; Sun, 22 Oct 2023 02:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVv-0000MK-ON
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVt-0001U4-2k
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9b95943beso18507655ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954435; x=1698559235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/T5XaZy2rs7d2UUVgUOSmmRBHeDvLpxjj7qjWAVo54c=;
 b=aWxtnsJNGLl5P9eBIYxTc1+1HL/SIO+lmc1N/glDouyJdWxKuV6QK2A0nvKzVx472S
 2b/rgPZZvuMJk6X7vugujVUO15JyPnm+VsWIQy+PvaGlULV9gI/Gwt3A4WmCRtPLu5+5
 NFUO4npIXjy1jy5QzoFOW7Fj5rcjSOxw7Kneu5MOgjZdMKPajYajyCQUgoZ0eptaFn1p
 2BCwkAuyoUPgqSjMVxDWfra6GdhxJCPHfClFiUiykeexpD4OELrxiDcZ8YAyxgfG41gT
 8eufhu1DPot18gi8fHZCZg7yjW6cHiGvqnjFUK/jCXdAnE4gOsFFtJC/XqF/YyaHLc2e
 kwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954435; x=1698559235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/T5XaZy2rs7d2UUVgUOSmmRBHeDvLpxjj7qjWAVo54c=;
 b=PEUaQY0DlEveHJAHFLuf/sTa9uqiIp2JhB8X+AJRUHjOO5XruIyZIjbHErzk0XBwuo
 49gofqpOU677uoB02rEezOmhJxAgshH7s811LSHdEvtMfngI7BWf1pe6WBy+tERoGA9l
 UVzQeZCZ4KWqRXRQAehi7EYHc2EQMdTiMj91GtBIhFEDXMcTVtEfcTnX8kZto8YPhsSa
 rsclH9id1X8f+zYvBO6IrFmHZ1j56ncyp3Z4L50wNYgm5nI6dXxsjBtWX7E5zUEk3Twm
 xLQZp95Te6wd+ATy1FsPI3ENe00kYhfBBi0eyw1sznlWSbv5syqO7q5sYM5pr46wf/uZ
 0G9w==
X-Gm-Message-State: AOJu0Yw9rRSQz6XrhjMEOHFlJ+bDGmZ/VjxoE5Z1EUKeKfVZJH+AIhY9
 jX/cYr4CiqSzkQZ/UunAVsKEyap6OcgdPwgIcCs=
X-Google-Smtp-Source: AGHT+IHpInKaC91C6v8aM48Fkp+KSekdllBEwvsD09sEddfMyPAZfCa3tCAMPCfqFl5IpF1144eykw==
X-Received: by 2002:a17:903:2285:b0:1c9:b196:d294 with SMTP id
 b5-20020a170903228500b001c9b196d294mr6971960plh.20.1697954435652; 
 Sat, 21 Oct 2023 23:00:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 03/90] target/sparc: Avoid helper_raise_exception in
 helper_st_asi
Date: Sat, 21 Oct 2023 22:59:04 -0700
Message-Id: <20231022060031.490251-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


