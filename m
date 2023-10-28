Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F087DA908
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG6-00059F-Ra; Sat, 28 Oct 2023 15:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFh-0004kr-H9
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFe-00048g-Kx
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c8a1541232so28455345ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522341; x=1699127141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zu3IwXhRqKjvVQc9/ToEW3nFAd+p4tbm1VkVHoUThRc=;
 b=Er2ShF5njLEfdqycdJzI8O/5bKxLi2QaxAKhjLvtg9gu8cpDioB6ekeodxatInVw3s
 9oR5ZS97CD/IusYw1t4fKjnGavQwqdgtyPexwWumrXYRAc4sNQkmlPYNRT3eY8cOoWNf
 gQ9yQpEeIEVVRKLHa8hnPEevugQ5/ZpLukr8irmeqo8HJakSt4JhEq8FrO4EeZ7gcwSy
 FVt9CAQRid7JUmcjtGP9wDAL+DKotEi6QIZmrrKrR/jWUfOlBJG6G6EI97PVTiSohfAP
 L5JNfodQgxK2pEGZfysCMrvNr98C+6araLD5iFZ25RCZWaUG+WpOqLv4J+YcQTr4CV6J
 BylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522341; x=1699127141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zu3IwXhRqKjvVQc9/ToEW3nFAd+p4tbm1VkVHoUThRc=;
 b=onaIxwNwbv9F2VW3iI/zmVwUR5JdK2OqZ8ORLxqwMUdDXmwSbWAjJNBMBBOAdR2yrn
 pLyWaH641XlXuAFgR9JxHH7zHEmMQgwJpqj/6LOLTQMDPV1XlTRIKqrE6jGjYXdQgm6E
 AMqNOrCtOEbbejvM4wfzSQexmDpIHgrOZFdFbjK011wNGL9FyKI8FdzX6PO+b75mg2Jr
 A5W0rx+p955WfbFXQ74gxOpG1w1rDgRt3AMUejGB1KtHb/DCSc5gnqRUiLM2IB5/IxDq
 /UEwq8U+fxEbNgjxPAGpAcP/gEYMXVtFhSA5aNLJ8IBcO1H/kgG1XyubJI9JlV4Vj8OI
 zF4Q==
X-Gm-Message-State: AOJu0Yz78YgiwPCfu1EQkAvyXmTbN0oNGgX85VZd15vo/x3ZbOIY/rQw
 atqOUMb4LKj7qepKTCZC1hl9ZYgyR/5l2aKOc/Q=
X-Google-Smtp-Source: AGHT+IECsyHKtpcMwiluSfaMk+0Kc0gMEoFB1BKGK4bF/7wKAtnoAsN5yvwB1sFVWaSO/wkz4gp2rg==
X-Received: by 2002:a17:902:fac4:b0:1cc:40eb:79ae with SMTP id
 ld4-20020a170902fac400b001cc40eb79aemr280063plb.63.1698522341493; 
 Sat, 28 Oct 2023 12:45:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH v2 19/35] tcg/sparc64: Implement tcg_out_extrl_i64_i32
Date: Sat, 28 Oct 2023 12:45:06 -0700
Message-Id: <20231028194522.245170-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 386f51f29e..ac86b92b75 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -530,6 +530,11 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
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


