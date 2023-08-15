Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E077D3CA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0B0-0005Dy-QC; Tue, 15 Aug 2023 15:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ay-0005CZ-SS
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:58:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Av-00016v-SL
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:58:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so4570598b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129476; x=1692734276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pWJR/i0qFrHbOc7VrOLRnKZxmQspNrgrC7qAbkO0lE=;
 b=DTMYnhgOAiNDXW4Xth/rKNHm5oPoXmAj4BATxWHK6Vqp25vvq8JnbHJgk15+wQfmHu
 EnY7sGc7wOm5oyPv2HgpNDRMaquZPrqjlHLy4lE7rfRGgtxYNWLEhkA9MRtkIl8KsgbW
 UNAwFlPI38+X6OlOcuoLM8WK9/nwA2wQkPPOzVO7Z32nBYtukhOH4bfiZ4taq+9fMr7v
 kkjaopvFLgEXvRVXd6jKvZLskydXUdSQ8NkFXbtHF0QngaM8nKG/p1owRQ6HUPV69lhe
 VxIFfnyjmsLzBLmRT2gpCZVmTMFgXYubxdLz7lgD4DQjBTpjf1BbBn5WmEFqe0XvJuMy
 +TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129476; x=1692734276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pWJR/i0qFrHbOc7VrOLRnKZxmQspNrgrC7qAbkO0lE=;
 b=M7KZNHv4p+qiTNmsSN8sY31yfG/5Zn7OYMttUwkFkXVQLSXzhOWHt11Rp00THm1kqn
 G3aXm3jlIOTQqICsI5LYqHufFH4bmRpEX656Nzt98n08QSCm/DNruXcYMs61FDRIsTJL
 bynHJswNXctISPGjVSmmgmqDieaFl/0ESd3AkJEPkiBd2LvRXrGRDiUcJbQQ9wMiyVop
 iltjeLET4n5SoFGThtgxW9i8sTC7Uf3galphScbgyAJfP2CfNrr//ifkhoAqla83Rzx0
 TYM2rYeQr3QV5WyKPC1zrWMHyOmc8IAYAG+yACa7s/oreKvFRXVVE4W2/r9+jAgjqbGP
 fTHw==
X-Gm-Message-State: AOJu0Ywc23O+RqUi2+jjwgV7HtyIr+/HQgVAhW0sC6iQBv6bfSkTl+5a
 6Df6MGJaJ2SBLxq5Mx8iWwoWjmN9cVRUoH1ZKF4=
X-Google-Smtp-Source: AGHT+IFhWrjPFkRgHZ/HsHtjaf2Aa/OZ8HfEAsvbvwQq/IJlOTvUDqCFDrEdSjs6ps9iKly3j7QlDw==
X-Received: by 2002:a05:6a21:3295:b0:12e:caac:f263 with SMTP id
 yt21-20020a056a21329500b0012ecaacf263mr3594015pzb.20.1692129476627; 
 Tue, 15 Aug 2023 12:57:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 14/14] RFC tcg/ppc: Disable TCG_REG_TB for Power9/Power10
Date: Tue, 15 Aug 2023 12:57:41 -0700
Message-Id: <20230815195741.8325-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

This may or may not improve performance.
It appears to result in slightly larger code,
but perhaps not enough to matter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 20aaa90af2..c1e0efb498 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -83,7 +83,7 @@
 #define TCG_VEC_TMP2    TCG_REG_V1
 
 #define TCG_REG_TB     TCG_REG_R31
-#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
+#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_00)
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
-- 
2.34.1


