Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A097D62DB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:32:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIc-0000Hp-KQ; Wed, 25 Oct 2023 03:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIZ-0000Fc-Fl
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIX-0004hQ-VS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cab2c24ecdso35343835ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218844; x=1698823644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBPTcXjS3BRZCWCMtUYgvGDiz0Qe0sy2s6yIUrx8ZMk=;
 b=bCKcNMNjVU3aa5wVxMt1l67FcRA19B77yZIBTpt/dIlAouExLVeyRTaGfWbUQnAV57
 HuMxGMdVP8YkgHQ7JpLJ5ZLRyOlXNSLbxTpLSdxtdtVQTemceZTncahJqwtzU++EhS/e
 ld2KrbIp7NRORJgrZWRw80DBN7/cId/kmdLfL00+ZjJFOIGxe/NyltG+GqDE1evc/EE/
 4q+Td0CMtoF2GF7llNCJLUAsv3pvkyBkf0l5c7dIc268H6KDOyepSJkUmJtH+BctNAE9
 2T2MNzr3PQsS4bqjlqVPWLxFaXVnQoy7W08in9QyTueoI2qS7bYRHeGOmQWbsz1stOGP
 0vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218844; x=1698823644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBPTcXjS3BRZCWCMtUYgvGDiz0Qe0sy2s6yIUrx8ZMk=;
 b=iyd/FLUYCnteUx3emYJ3ViZ0XfHk3LYv8qTLBNIY1ONXzO4f7ayl2dToHwhvIM2xCV
 ox6edkoMhmTNLnMqS27LBcEee/CYno+T88Us8PTj0QDkakANoT5MqfRslXi2IWaR/RjN
 ztjXt8xcAdy2t+n9sfYBYibPLdRUS8P6Rxg9/ZNPzUc68BXhh52tepnizDTUNNzu8/h4
 MT2FzQlsuOkbL2BC9VFlWfhYp7vj5H+S3/iMzsa2AMH7OEcBD1V3bi5IrpzNIpdF+eEP
 7At/+QljTWk2z4KIGr1IsuG6EVdQcmmAIB/W+SiB0kegDxOtzG5DdTg6yWHfuHk7W53/
 U/GA==
X-Gm-Message-State: AOJu0YyKPa29sWDaRbgbFG1m9tjXlz2wnILyxJMIGTj6RCRRYYEljD2H
 3SkwgNrFULP1pWno9CGWVki8BZuFTIHByIql698=
X-Google-Smtp-Source: AGHT+IHifys0U0wwfyD40xYmq9S6aCYU4E9H5dsnX0Z03NK3ghOlRR4NK6eQv9mib5Oq9Pdem+4yPg==
X-Received: by 2002:a17:902:d042:b0:1bb:b30e:4364 with SMTP id
 l2-20020a170902d04200b001bbb30e4364mr10569034pll.39.1698218844645; 
 Wed, 25 Oct 2023 00:27:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH 17/29] tcg/sparc64: Implement tcg_out_extrl_i64_i32
Date: Wed, 25 Oct 2023 00:26:55 -0700
Message-Id: <20231025072707.833943-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Build fix for missing symbol.

Cc: qemu-stable@nongnu.org
Fixes: b8b94ac6753 ("tcg: Split out tcg_out_extrl_i64_i32")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 19d9df4a09..a91defd0ac 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -529,6 +529,11 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
     tcg_out_ext32u(s, rd, rs);
 }
 
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32u(s, rd, rs);
+}
+
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
 {
     return false;
-- 
2.34.1


