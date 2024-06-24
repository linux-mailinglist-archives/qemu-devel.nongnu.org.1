Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C0D91563A
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jun 2024 20:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLo8E-0002aC-Qd; Mon, 24 Jun 2024 14:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8D-0002Zz-5y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8B-0005VP-Kp
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7067272245aso1391661b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719252570; x=1719857370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwmLeN19cPTq+BAPLXBZ+5P2B0cE6/NsDfoUArM3iy8=;
 b=Tf5fi8Td3TpDgjfdQt3rk/bcDl9mMhxNvlFkfpZqVCLmN3/YSEthXDuZ7Blb/CBZbU
 S6Zsxt41yke+wOia348yIc9fArIj1QxkTD4NZ0i3XENW2O8av7RIAssHvo1rCCE8VYHH
 FuqScYHw+CX8zGQUf1YhWC9mV9B8xlOIXizjgInC4UQpTE/TWjG/qVCG5MPz3gukgcWy
 3wkqNZkb5Lp8HSemo7IO5Lm1EbO++mWhanS1e4QRr4O6Zza9+ZqNOETsPDTXQ9zg2GR2
 SrIhL17o3avXBomBqKuyi27NRjtNrgEXIjPSchsQGm2zDEF7gzA2sW4k6TGBv0fl+mcT
 c9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252570; x=1719857370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwmLeN19cPTq+BAPLXBZ+5P2B0cE6/NsDfoUArM3iy8=;
 b=X6sUx2ts4zvxfhFSdeq3pQv6zIXoscOsTXCk25apdB/zwEO97oU5XiAMv+0i4Vow50
 bEKKJVCkt7wCC7utwmUkKSuSKQZQh74lnlG5jFzI7z6AvtupV/uJpoHHCVGkhXWf/ZUU
 LvQaRFF2OTAgZ3PQ/KXfIH0LNftIpYZaquGDNnHuci3q48sLG/aK3AnNllXADnNtStoX
 pno00vBgYKkcSx93ar/AOuvL+4IflQLdImsjXNLN1CJzBwxnn+4mgGYiFUpMNzVSQg7y
 tCSCjM/38aTM9P3WhPF8HZZ6V252hB0NpNK8+MkseozZaDoq+NnZEBER15SRvRxvrkt7
 Lqew==
X-Gm-Message-State: AOJu0Yx5JRArChYZJV9QiNXp3ohYautMxeoklx4HVvUaPE/yEe9ZeKuD
 1wYdAD1btXiZsLX0yNyPet50sv1+F/H4Yf3vdbstUkDwewE/AwOttEs0fgZ2otMb0adfvlPndX2
 c
X-Google-Smtp-Source: AGHT+IEQCLqp64nYVz6tefDKQYXjLpEmIwJnW2ig0T+iXL6qGymB21V9Y3kGpuQAwAw621g+dLd/UQ==
X-Received: by 2002:a05:6a20:be1c:b0:1b6:98ba:8de9 with SMTP id
 adf61e73a8af0-1bcf7e31a2bmr4127927637.7.1719252569838; 
 Mon, 24 Jun 2024 11:09:29 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706666e9708sm4974942b3a.121.2024.06.24.11.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:09:29 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Cc: philmd@linaro.org,
	alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 1/3] target/arm: Fix indentation
Date: Mon, 24 Jun 2024 18:09:13 +0000
Message-Id: <20240624180915.4528-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624180915.4528-1-gustavo.romero@linaro.org>
References: <20240624180915.4528-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
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

Fix comment indentation adding a missing space.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0899251eef..71e1bfcd4e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,7 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar2;
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
-    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     cpu->isar.id_aa64isar2 = t;
 
-- 
2.34.1


