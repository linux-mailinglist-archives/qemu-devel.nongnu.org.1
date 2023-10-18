Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3777CEB58
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:33:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzP-00083P-6p; Wed, 18 Oct 2023 18:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzO-00082l-10
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzM-0002SU-IA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so47679365ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667963; x=1698272763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kj+TKk2K3WfpkaNPPr/v3KoLmzqb4EREhy9sjMrwx20=;
 b=kgclcjKjGpKX0mfJVjaY/mYewiKc5IEHi45CWnd2X5DzL97pBF7bvYQGj7oR/N8HHU
 ocvb2uWUY2px3F1j+0uSpUhUNtci6pMr7GFioBeTRbr9qzX8n7rNpz+RSBnZrIRBpLcx
 MCrjKxQmAYK6X2ciYDYDWWWNXJ3rj1o7NVRzHd3L6ZfbOkP1G/WfhjSKLKSV6QsAedRJ
 YsPepejo5KTG+nolUIXppo9ukicJsGxYjvC2dA7qrhZtvfhs/XDtsCzoo84ohvr4+20l
 BMY75r4oiRS6i18oiPFdKTBAAUd/UetQdtp4JQWknINbe08xosLKXCpzrIHRMCxE28AA
 +Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667963; x=1698272763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kj+TKk2K3WfpkaNPPr/v3KoLmzqb4EREhy9sjMrwx20=;
 b=YNdKIKUcs5pNOBGiJOl3Fq4qnS8PAvfM7yt4JRzonTLrMxFsilqPQ4gjHy+XKIx7ZF
 J4nHQMamyAwfW93rA/z/UR5on7EjpO/zaT/Qbd9RTq0yKXnItEVm5J8iXdlqmFLf9mxm
 r+Q5HaTM1rAqWtMPyW8be6AKTDxS5KSyrqT5Xj9WOS8vIfKyxQhXJnNZXb985p0i6Rzf
 XSr3WKymaKEPe4wpmf24Ce5ezWa86LS1vNOWvrW5v42rNtxPTZc0dBHYiAR0R81PNYxZ
 DQhHNA/zmyAcREN6MhUx5xwV7eEMxszKmX92UC2o9EQ49MTqXh9tgjKqQ8TqrZp9BWeG
 FshQ==
X-Gm-Message-State: AOJu0YxOnE4dZjn1ROc/pa6P32S906LOn6Ue152FvzdaMoKdfQaTwrVi
 meEuVjCimHTxnD42FnFQfz/N1tUvK1JAorGb5Xg=
X-Google-Smtp-Source: AGHT+IEeOHV4OCUfAySv1Lg3Udi4BkNJDNymVf3N8DsuMaRKeZP6IaRTuywlasO9aEVXPOglzIN8XA==
X-Received: by 2002:a17:903:32d2:b0:1c7:443d:7419 with SMTP id
 i18-20020a17090332d200b001c7443d7419mr706332plr.29.1697667963264; 
 Wed, 18 Oct 2023 15:26:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] tcg/ppc: Use ADDPCIS in tcg_out_movi_int
Date: Wed, 18 Oct 2023 15:25:33 -0700
Message-Id: <20231018222557.1562065-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/ppc/tcg-target.c.inc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b0b8cd2390..226b5598ac 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1055,6 +1055,19 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /* Load addresses within 2GB with 2 insns. */
+    if (have_isa_3_00) {
+        intptr_t hi = tcg_pcrel_diff(s, (void *)arg) - 4;
+        int16_t lo = hi;
+
+        hi -= lo;
+        if (hi == (int32_t)hi) {
+            tcg_out_addpcis(s, TCG_REG_TMP2, hi);
+            tcg_out32(s, ADDI | TAI(ret, TCG_REG_TMP2, lo));
+            return;
+        }
+    }
+
     /* Load addresses within 2GB of TB with 2 (or rarely 3) insns.  */
     if (!in_prologue && USE_REG_TB && tb_diff == (int32_t)tb_diff) {
         tcg_out_mem_long(s, ADDI, ADD, ret, TCG_REG_TB, tb_diff);
-- 
2.34.1


