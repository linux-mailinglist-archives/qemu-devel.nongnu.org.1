Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F478BAE3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakUe-00062K-9y; Mon, 28 Aug 2023 18:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakUc-00061N-8J
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:13:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakUY-0004DY-8I
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:13:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so33519705e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693260828; x=1693865628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STcIHwCIBIKUCaEpCEknsa0AU+E9EbnqQ4Grrl8BIeU=;
 b=sx/Ti0MzB4D+mnn4vcd1ju1B/lQqGn8iyX9DEPQlsXmjszhY64zs96kVSsZcyC8fn6
 NDU4Jgj/ZFceaAB7D8VQjXf/8+lZfjxWj/CmaN/dwUYLATGx87WYoO88S6kcdjSWpesu
 Yn/bUCrFJdJ3GXaDZdkxlyoNZYGQa4MUZHQTxGw5h236QH4iqrjhZXrnGZGgxiYqeV2Z
 5V94rtejl6DY4ItCtOkT+YR2iz1pubOm5UjkSYSY35JsfX4O87ziYVM7iKd7a3MjlVT7
 5r8kwkLEgIsrxsvstfiA2EHVfPdra0J6enS0CFqXCOEUVbsLN3Qdv8iY+zmIx/VgmJl2
 5aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260828; x=1693865628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STcIHwCIBIKUCaEpCEknsa0AU+E9EbnqQ4Grrl8BIeU=;
 b=lM2JqZwhFJiiYevd0Bm4WYgoNZxf9FXLs5+XxbORYVoEffiosPqfnKRBALvf37HfQw
 C/kzFjETf03zORASpyuMrwfbB4AL/OvR2UIkBVUA6HwYUPkxEeH/+yofKolb8zrFHMEd
 VtpHagffkvyx8DtW1jW+lYoKkzd9CipNE9VUD+/tvrwskKdsaezwodab8OAu9mqYxiQw
 tihVKEQTPVVveWJp2Um2SlUQWyoU8OyHeie5cNDF7PeduOunUGLIAJiw6vHVx5krbN3d
 aJ8MatZ/Nib3hYzI2WMhtyKad9qSkcFwHdLl6Tf9kcWJyt66FB8irpViRd9S21KLCu/U
 op4w==
X-Gm-Message-State: AOJu0Yzbdezu/jet81HwQ5l5cdOUvizkcFCHPTCftpwkP6ozyAaG2GK1
 JyeUrliN99qQVnknRvNFX8PExhC5cHf9PSehoIA=
X-Google-Smtp-Source: AGHT+IE/tAFoSsquEvYWcpYmxVcv1YgIcYx6nr2FcYU7DyKfrj5kr6yBJ7DN7sXe47CAgXsufLvGJw==
X-Received: by 2002:a7b:c4d3:0:b0:3fb:feb0:6f40 with SMTP id
 g19-20020a7bc4d3000000b003fbfeb06f40mr21915514wmk.11.1693260828802; 
 Mon, 28 Aug 2023 15:13:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a7bc7ca000000b003fe1fe56202sm12031404wmk.33.2023.08.28.15.13.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 15:13:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 05/11] target/translate: Restrict 'exec/cpu_ldst.h' to user
 emulation
Date: Tue, 29 Aug 2023 00:13:08 +0200
Message-ID: <20230828221314.18435-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828221314.18435-1-philmd@linaro.org>
References: <20230828221314.18435-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Only handle_sigsegv_accerr_write(), declared with user
emulation, requires "exec/cpu_ldst.h" (for the abi_ptr
typedef).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d02517e95f..b2f5cd4c2a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -21,7 +21,7 @@
 #define EXEC_ALL_H
 
 #include "cpu.h"
-#ifdef CONFIG_TCG
+#if defined(CONFIG_USER_ONLY)
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/translation-block.h"
-- 
2.41.0


