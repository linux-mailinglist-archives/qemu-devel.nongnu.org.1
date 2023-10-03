Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 806FA7B700A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjJF-0000TI-48; Tue, 03 Oct 2023 13:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIE-0000Ao-Of
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:50 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIB-0007si-Or
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso8614405ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354482; x=1696959282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJpiHuW5NzBqBoQ7rF1AOmovpcCQYs1V1KtFbKMhZnE=;
 b=BAaOd0OpoiKhuMXbR5f4TRMx/CQbls22ybcalcen3fy6qhd3NsQ2SQlxhwY/Q3vEcy
 FK9chUpO65TQNkoUPog2Wf3TjvXOX6aShrFIf2iS8he4jxW3K8BgIdi+heaTTkYXTX5w
 nGpd96JYsOYkclR9DsZZuLv5nGKZ3G6dMkkbewhMCGwbru1VQRd5YpFfjXMLG36wq7GS
 zchpaQQOOEVNSPH+D5dYv3yxqGCK/ZssQ0YwgVUVMZ4K1CKlu86pfFf/8ThVen9YQNKD
 KvlGLq18+pre6X2+q+fxZlKJHwHpVitKq6MhZrFi00h0xs5tgbyYsmFrLhgbG+uEL2UN
 /dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354482; x=1696959282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJpiHuW5NzBqBoQ7rF1AOmovpcCQYs1V1KtFbKMhZnE=;
 b=OYaVpU22uyFCJjhJqECWHnqsjdagCMCvqXVFKdSt/YD90xts+2bsuCFFKnnp3ZiVmO
 izsuVo5//alNB39lji9ezOl7VtVx5xzi/Vocs6yBWBWXGADfdpGytGjvSpTP2+iN/SHI
 wg0DD3zxrniTj9mvErLLN9Hmo+pb2sR/HxVSy6npMCVu3lGKcMGNtBQDspYOgSUfdiWW
 cS7r4p6TB+kufyXrdvEiJS0omMY4ziXBNL7LKbqajrf64uM7YNRoBnU4gzjHJtjZdSSf
 Yw9q5D8wyUBnA8OP6NH6WfY1yvlFoNjPHegO6KwbAQ3Ii6U/hBrfjRL3WpYC72D+rBla
 fI0w==
X-Gm-Message-State: AOJu0YyfekpBS+BCys129TZrw58gEvU7pX7ia/ovoB4ZEjyROVBTWP/v
 ZA3xRrXHRPGiFLoZX4/ANdEXSa/lG+WIjUNq3bA=
X-Google-Smtp-Source: AGHT+IGz8xMk3jG31JWiXdDaSCa2KLOqLGPoCz6bzMzWzLfHDWAdtwh3/bK/p+Uzm6ICz24YVMItVw==
X-Received: by 2002:a17:903:11d2:b0:1b8:8b72:fa28 with SMTP id
 q18-20020a17090311d200b001b88b72fa28mr263280plh.58.1696354482458; 
 Tue, 03 Oct 2023 10:34:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y9-20020a17090322c900b001bc676df6a9sm1855118plg.132.2023.10.03.10.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:34:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/47] linux-user/hppa: Fix struct target_sigcontext layout
Date: Tue,  3 Oct 2023 10:30:49 -0700
Message-Id: <20231003173052.1601813-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Use abi_ullong not uint64_t so that the alignment of the field
and therefore the layout of the struct is correct.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index bda6e54655..ec5f5412d1 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -25,7 +25,7 @@
 struct target_sigcontext {
     abi_ulong sc_flags;
     abi_ulong sc_gr[32];
-    uint64_t sc_fr[32];
+    abi_ullong sc_fr[32];
     abi_ulong sc_iasq[2];
     abi_ulong sc_iaoq[2];
     abi_ulong sc_sar;
-- 
2.34.1


