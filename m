Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C982AD04
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:11:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssj-0001fx-IZ; Thu, 11 Jan 2024 06:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss6-0001Ku-V1
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:15 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss4-0004P0-IE
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:14 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3376555b756so3010278f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971110; x=1705575910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yscuAN2+W6F+E5GdpmQyLDg77dRJm7PXwcNzo7tUEdc=;
 b=PGa+d2ENAu+hfpA/yLS4+K6lpMvx491mlQ0r22T64WeQdY8apOzbrGKDg3nImZpWru
 h24mbNXspVkRflkTLRala0NUGV0N49CDhT/KBUw67tbxolu2iQVRjwU2IHkhOgfawUgy
 iFDH0CPAqY732B5Azvom9/0+DECcvHBI82aSZYbpx8IUkc8Xv2y6HlAg4ysO8Mz24+M2
 wnERQAZVo3nf5qNKKfY2tpa0j9oMNmBSqBwzapjou/G0Ik2xv44XmfW/Xbdm3aCcLlBz
 BbglE7/Qmln5KnnHkbs3jn4E5V171R9AVYvZCIWXpNdzgLl3bXT4M4PRNlBR9JAr3iXb
 ruRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971110; x=1705575910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yscuAN2+W6F+E5GdpmQyLDg77dRJm7PXwcNzo7tUEdc=;
 b=JSm7lbed8mnwABULrgcbLI2VsEwonrnQqhTi8gLzgQhzqfEjcI31iYYuP03PzYOQqj
 dDq15UP0KCQhKbHtwBvMiDUUixXI4kN4PkZ705Uvjic4Uk1MPgV+RKzwhXpxDAjXOjIO
 Dz2Fl8GiSFB4uqd+3U3hCiDjfoT/+sI5VO2KK93D2bGK/gZ8UgcjkwP+vfnMMvQvoWwb
 EDWX4Rr+nmHSN6tE5ibApMfYjbA9peuUOSGf1XZXr3MAoNtW9LTmu/jEZ1Rsdrz7E2bH
 LNvxKCRoKpIYGOMynqP6tQNl3N7qpnBjk4u1p+hgVXnyjSsILiV5LEJCxveItnAKWPUy
 dKhg==
X-Gm-Message-State: AOJu0YwMGigxt94wHBPkCXLVz26yT5fqmnDWcixl1ew6kJfrMb76atDU
 ThXzntlsTIhB2acba1W4TB/z9cBVstAb8pF97ccLKvxF5mU=
X-Google-Smtp-Source: AGHT+IEzeVr7AsJQFCTYxbAjWqPQybHomtJI7ETWz/juZox6lFz3CGmo3jIptZo/x+RG7X2DJoVqpQ==
X-Received: by 2002:adf:a183:0:b0:336:7608:d0f4 with SMTP id
 u3-20020adfa183000000b003367608d0f4mr421626wru.17.1704971110593; 
 Thu, 11 Jan 2024 03:05:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] target/arm: Set CTR_EL0.{IDC,DIC} for the 'max' CPU
Date: Thu, 11 Jan 2024 11:04:32 +0000
Message-Id: <20240111110505.1563291-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The CTR_EL0 register has some bits which allow the implementation to
tell the guest that it does not need to do cache maintenance for
data-to-instruction coherence and instruction-to-data coherence.
QEMU doesn't emulate caches and so our cache maintenance insns are
all NOPs.

We already have some models of specific CPUs where we set these bits
(e.g.  the Neoverse V1), but the 'max' CPU still uses the settings it
inherits from Cortex-A57.  Set the bits for 'max' as well, so the
guest doesn't need to do unnecessary work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/tcg/cpu64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fcda99e1583..40e7a45166f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1105,6 +1105,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     u = FIELD_DP32(u, CLIDR_EL1, LOUU, 0);
     cpu->clidr = u;
 
+    /*
+     * Set CTR_EL0.DIC and IDC to tell the guest it doesnt' need to
+     * do any cache maintenance for data-to-instruction or
+     * instruction-to-guest coherence. (Our cache ops are nops.)
+     */
+    t = cpu->ctr;
+    t = FIELD_DP64(t, CTR_EL0, IDC, 1);
+    t = FIELD_DP64(t, CTR_EL0, DIC, 1);
+    cpu->ctr = t;
+
     t = cpu->isar.id_aa64isar0;
     t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
-- 
2.34.1


