Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9472B7D5941
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKl1-0000dQ-RX; Tue, 24 Oct 2023 12:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKky-0000cb-9q
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:52 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkt-0002sb-By
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:48 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so610945366b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166785; x=1698771585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJKbQ/KzB5PU6j23DLpfBbyLDRsAcidVy6b/XXutwa4=;
 b=BME1diKCgyCx7ql7Tq+fXLdJ/5dZvsiMrn5cRVKXZlR0zfzU9h6RNyR80RFGmXtNNA
 Y/PDba6gYIRrAx9dg1yoa/qCNNXdYwj41ZO6PSTQWLBPNqRsUfjH7+kOcuhaK4QJYbRP
 F0ruzltH1uVnXf/h5B02xm5zzPSwsbtdeFBY9y4q373IHcm77YFAl1oDINfgqtJOObaK
 2+j8ZqOdYO/NBGX2d0XCzcF+vSlQjgA3dyOTckOoxuMKWLXLXEff8hc9V/ocErA9T5Z/
 l0ePpKqAtAEEckixyo50pwDQEv6i/VSRjzM4X3rZtSxcP6r4sWQdc1wGMg+/oaBFiOtP
 MnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166785; x=1698771585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJKbQ/KzB5PU6j23DLpfBbyLDRsAcidVy6b/XXutwa4=;
 b=WrPY/zS4gAVl29+jcO425B2qFvesziL+xjmcpjG4icz7kR4YicuZ/lBCAqGVUNwKnr
 qBpZvTd/qRMVQflxZZuUcYQaWk4m+h65S4EOwzHPo8Wul7zgWoSIWkuLCDYxJrm+9brW
 REiHaAYMof63kRa8/rMTetdPK0ZnsHiLpIUyi5nJmli1ur0/9GoqIipJEFXxuZ/JwDuX
 YRMSK1ZkWGZ29jv5rIzubInO/TMLEQCmWdV5gMhe8E4HcXxZk6hotU7qJcnuTena3/Zp
 ZPIv1EFdNLZ/tAysuIEIDlvqmmePKmNlTj3YqTi0QByS3GBWWg0726gZYJ/omYXspQBP
 UpAQ==
X-Gm-Message-State: AOJu0YwTdRvp1EDZ8wmyIw4mbCgwLa8MKB328cCJqA7/lm+F98Dt/WJN
 xfTj259xovEIDPEeyVfxkjUxs8zVXlfGjRuyDWc=
X-Google-Smtp-Source: AGHT+IFoFpuVoyL6QXMvsD8DMg1FijeaYnfZJfwhVOaIwmkcxvTqKYF/Z4uVNFyNud9xBDNi9q2YqA==
X-Received: by 2002:a17:907:25c3:b0:9bf:39f3:f11a with SMTP id
 ae3-20020a17090725c300b009bf39f3f11amr9750219ejc.74.1698166785749; 
 Tue, 24 Oct 2023 09:59:45 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 v26-20020a17090610da00b00993a37aebc5sm8477875ejv.50.2023.10.24.09.59.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 7/9] target/xtensa: Use tcg_gen_extract_i32
Date: Tue, 24 Oct 2023 18:59:00 +0200
Message-ID: <20231024165903.40861-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index de89940599..cbc564c020 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1595,11 +1595,7 @@ static void translate_entry(DisasContext *dc, const OpcodeArg arg[],
 static void translate_extui(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    int maskimm = (1 << arg[3].imm) - 1;
-
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i32(tmp, arg[1].in, arg[2].imm);
-    tcg_gen_andi_i32(arg[0].out, tmp, maskimm);
+    tcg_gen_extract_i32(arg[0].out, arg[1].in, arg[2].imm, arg[3].imm);
 }
 
 static void translate_getex(DisasContext *dc, const OpcodeArg arg[],
-- 
2.41.0


