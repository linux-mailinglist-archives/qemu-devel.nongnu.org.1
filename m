Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 977787DAE6E
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1s-0002h8-FZ; Sun, 29 Oct 2023 17:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1q-0002gP-7i
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:02 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1l-0005EN-5N
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:00 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b9af7d41d2so3253237b3a.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613736; x=1699218536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k76lMQ9gF2I2cgoCmO42IheoM7A9wwvMwftWBPc86XM=;
 b=XSO0Gh5E22nv8abhpChjvnwnTeVzzNOScoPnac9xEFV+OzL9XTC6Hnb78upcA7On52
 GW7r1VneknGkvqg9Z3wKjEMKXkdMylGKyf+wltnuD+VzbE6sbgilrmNHKnGPNimNUDw6
 9JC26ESfyaGJOGs8ja2IucAajevsEj0UPDfkqTopvMHOJvRZlApPbPNYU6HT+Zdi7WJe
 mpp0sCYbO+wS0o8o1CVWihg+iKXiU00SkMBKomMGt1PPVq5OJ18LAFo6rJUmSeAwWRji
 h2PDsKy+MxScKrH3y+IkjjLJPOwDajokU0YuhEYcFt15tg3l2/SBuW8boAzLkICWTZWf
 h/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613736; x=1699218536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k76lMQ9gF2I2cgoCmO42IheoM7A9wwvMwftWBPc86XM=;
 b=J49FpjeDuDl1vyBC4MhDNGaU4ZxY1U7HDiKPx55NKtGsbb/5m7lzHsogCOkd1NQSbt
 G9MkxyCmrYbxwpEVxPXzfXj3M/0BxsH9m/wA3lYSkoiojmEyHYsM1XKZmUMuZgxB4Uqz
 Z5vzFcUJc+0mKf1LoPqGdw9Tvh5OywRH4lEHPM2ElckGsdIP1B9LIW4G2cDsFaNjm9/p
 PIDpYEYysxMafRvQE7WJds46jPxWOOqACu4/e8cLX4WnQcC2sfivzFIvdVrywYfEYuXY
 xJSw8zMaSBfblw3O/f903Yn27dfy9qKj437SgrxnRcO23a1y8uwIiO84M/EzVB9R+VUK
 r8oA==
X-Gm-Message-State: AOJu0Yz34TLOFuSyI18xbGC5B9k2LMFYUO/UzTGpnl+8As74VeI26huW
 CBZZnoDeuf7gvsoCcqtiExDPOaBagpZbHO+DxH0=
X-Google-Smtp-Source: AGHT+IFPFnZ8K9PQ99hjnBRodJ84N+GiqKs3nFaGAKBozVkQgQpkpvJS6aAz6xxNXmG+DiTR+Zag3A==
X-Received: by 2002:a05:6a00:244b:b0:691:2d4:23a2 with SMTP id
 d11-20020a056a00244b00b0069102d423a2mr7272936pfj.31.1698613735774; 
 Sun, 29 Oct 2023 14:08:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/11] tcg: Move vec_gen_* declarations to tcg-internal.h
Date: Sun, 29 Oct 2023 14:08:43 -0700
Message-Id: <20231029210848.78234-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

These are used within tcg-op-vec.c and tcg/host/tcg-target.c.inc.
There are no uses outside tcg/.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 4 ----
 tcg/tcg-internal.h          | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f5ec54f874..3f8b214376 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -21,10 +21,6 @@ void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
 void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 
-void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
-void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
-void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
-
 void tcg_gen_op1_i32(TCGOpcode, TCGv_i32);
 void tcg_gen_op1_i64(TCGOpcode, TCGv_i64);
 void tcg_gen_op1i(TCGOpcode, TCGArg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 40a69e6e6e..f18d282abb 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -83,4 +83,8 @@ static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
+void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
+void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
+void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
+
 #endif /* TCG_INTERNAL_H */
-- 
2.34.1


