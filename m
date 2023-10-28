Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A847DA8FD
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFw-0004pz-M5; Sat, 28 Oct 2023 15:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFl-0004lI-NY
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:51 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFk-00049w-2D
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1e9ac336589so2124010fac.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522347; x=1699127147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ajiz1bDFNjKojGZgG2uqP1JdM6uHPJtL3w2kXcO5r5w=;
 b=lXo5BSW03gu389XMTcBHm7o2qbDjmCURDS+yww+VfOliizxBkIcEtZ+jrECJY41Eap
 u9mCg6Ky3p0jU4bAGtbus28rgDgPoNv060zf5fyiDHZP2z+UFVWGc4rPL0atJixAtWyg
 +AH6ILJnXpA9DTcBWP0+mTajJ8oaYWWekdiYu4ox6T6a9GriocykPx4rCpWe3+qxtdqz
 4wEbYR0vGGZ7GgTuouCuVPH96we9TcJV6YvTxKEY5L9sY+Z4s4dj+mq8LHYvncy9cwo1
 Yg1FkCbdKT8n9ZAU2Bc/UkM7kR2RUmSLurgl2t3DM5EpDKajUiEtKNnV181BLWdhIOQf
 MQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522347; x=1699127147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ajiz1bDFNjKojGZgG2uqP1JdM6uHPJtL3w2kXcO5r5w=;
 b=ZpXIXFd115nPXplefZpLeGD29vGFjzyjNrk7AUmZPSQkTcGJ62oUnUbyj+SvdxaMtv
 0LGKcmo7rtKaM5MVMDpzF6c7jeUoZ3H0VnqFMTwIc8TJxIbBaMUSe8+EpkHSBDz+Qdr7
 AXzsuqm6+9ZZmfORM7J9o9b49orgJTvvLpjKHjZQT5DlrpOe8BABFeMLI4omFl12uPgp
 PdYromiuRrzw5EGBA1KCyfHwpQOBOfyzYWMwY8MxU0ixkP68GpB0GYv6D/utu6mlj4iO
 T1BrZwZIiSFvhf4GA8QCjhiUC+NbMLXA6XAknywXWAnR5t2wdcfZLPKrIKMtlbmSoDg6
 3vtA==
X-Gm-Message-State: AOJu0YztXtj1UdyKf9io1l7P9yf2PkFOfOls/c4KkC7TiphpxnwIxHhN
 OFtNBN0Gfapyqu9P4ayTrvZQqo68dRlo8+4Nz38=
X-Google-Smtp-Source: AGHT+IGY9nA3kzAV4qvh9tMrla85xGPo2cIuXmmyEf0JZQtUHA0lDWVLk1w8MjYSxor5L6Iy6hujZg==
X-Received: by 2002:a05:6358:e497:b0:168:e887:2646 with SMTP id
 by23-20020a056358e49700b00168e8872646mr7273805rwb.29.1698522346735; 
 Sat, 28 Oct 2023 12:45:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 25/35] tcg/ppc: Tidy up tcg_target_const_match
Date: Sat, 28 Oct 2023 12:45:12 -0700
Message-Id: <20231028194522.245170-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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
 tcg/ppc/tcg-target.c.inc | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 1ac11acc7c..13d43ef9ba 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -282,31 +282,36 @@ static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, int ct,
+static bool tcg_target_const_match(int64_t sval, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
+    uint64_t uval = sval;
+
     if (ct & TCG_CT_CONST) {
         return 1;
     }
 
-    /* The only 32-bit constraint we use aside from
-       TCG_CT_CONST is TCG_CT_CONST_S16.  */
     if (type == TCG_TYPE_I32) {
-        val = (int32_t)val;
+        uval = (uint32_t)sval;
+        sval = (int32_t)sval;
     }
 
-    if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
+    if ((ct & TCG_CT_CONST_S16) && sval == (int16_t)sval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
+    }
+    if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
+    }
+    if ((ct & TCG_CT_CONST_U32) && uval == (uint32_t)uval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && sval == 0) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_MONE) && val == -1) {
+    }
+    if ((ct & TCG_CT_CONST_MONE) && sval == -1) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_WSZ)
-               && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
+    }
+    if ((ct & TCG_CT_CONST_WSZ) && sval == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
     }
     return 0;
-- 
2.34.1


