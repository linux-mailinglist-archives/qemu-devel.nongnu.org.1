Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9E8D25DF
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 22:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3TQ-0002lw-U5; Tue, 28 May 2024 16:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TG-0002kr-Hh
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:30:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3T9-0003ZP-Ux
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:30:57 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f8eba8dcfcso1028415b3a.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928248; x=1717533048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jALWZYrKF/ot8fbYRyvXV5GabFNfHPD7NP0qPjugKwQ=;
 b=uB/5GwOGCC5fZK+bvcaHxHprq39xwdw9mNyTVcyvg3Hu2/v0SAn5uECuOWIcqYQ7gz
 5DQJq2y2R671IoqWxkac7SeMcPiyt7lQ7ZVKiERDbyzYBRK6dQs4eO4HhNFu9/xK3Oaa
 EGRedHjO4AHGKYpcjBGm6aiZLCIw429xE8Yw6Va7P9ma0GWXeWZ3RiKXRLdK83pWPfrh
 5JQgbzgCdtYtg391+yOZWjl9IglcHudjWdqqozMG398ncGhRPwk5GDVB64Red7CuPdPF
 l6R7/ZtY8ungAa1PSYD5s4lN7qxxvGIenK5DDsnGQTCRNzO8N9Fo0vzNNmJZma30txfm
 yncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928248; x=1717533048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jALWZYrKF/ot8fbYRyvXV5GabFNfHPD7NP0qPjugKwQ=;
 b=QFX9aFwpVgu/6Jp8A+BHBT+MjkPdlsM3Ko3lhXkGPb8vpnmDkVkmyPuywupl3XzZSl
 WjvR2TyLvbS+4qAh4z0oZN44ntm5ra9gwvU2NXIZKRFR0kHPGxVklw8ZVDzv5xZzvTaV
 gAHXHeDkN4060VTEC9r0S/qLJOiPi9d2XtkilCfYpIYrHdeanWbXGGJpNfRjafFgPhOv
 2NiuvHqZAbweHVllH9VHQyLLy3bZ6YiBReAh4UFam+jA9pu7n5y83bgz07Kw+uP8dngM
 DlpDsZkiU/rtVp9jkXEbHm9T5w4h+EEEDqGfC3PY1WVr6rvZ/RMzG13rbfZpA5gXJJoL
 GcTQ==
X-Gm-Message-State: AOJu0YxUoKhl5qM2F4bAQVrRLW1lAG40G0/T1MQBhNLVwzY5VNX1l/Gp
 npX7vPZzp1dw1yGeLG5WxFyR5Oh/o/NWemB0tWQaw0FUl0/F091U9tiRirjT2Y6GUwkWq0hbDyE
 n
X-Google-Smtp-Source: AGHT+IEoW/7ZGwWGD+648jdNFM76Vqi4EqaJFHcBu1YC2Nob2H4blC22o+cXp90SmtYJ3QdSw1ZXdw==
X-Received: by 2002:a05:6a00:1d8f:b0:6ed:21bc:ed8c with SMTP id
 d2e1a72fcca58-6f8f36f6f75mr15684163b3a.18.1716928248580; 
 Tue, 28 May 2024 13:30:48 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:30:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 03/33] target/arm: Assert oprsz in range when using vfp.qc
Date: Tue, 28 May 2024 13:30:14 -0700
Message-Id: <20240528203044.612851-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index bfe6885a01..3e2d3c21a1 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -29,6 +29,7 @@ static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
 {
     TCGv_ptr qc_ptr = tcg_temp_new_ptr();
 
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_addi_ptr(qc_ptr, tcg_env, offsetof(CPUARMState, vfp.qc));
     tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, qc_ptr,
                        opr_sz, max_sz, 0, fn);
@@ -1255,6 +1256,8 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .opt_opc = vecop_list,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
@@ -1297,6 +1300,8 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
@@ -1339,6 +1344,8 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
@@ -1381,6 +1388,8 @@ void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
-- 
2.34.1


