Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D6780DA8
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05n-0004xb-6T; Fri, 18 Aug 2023 10:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoT-0006Lm-DF
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:41 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoQ-0002wl-N9
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31757edd9edso655054f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692354876; x=1692959676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvng4YPVMkWkkh2eZJ6qlqU3fIhQVOx369AKXLs8f1o=;
 b=qiyJDYcFDlEr6qQeCyCJJkeBmKLn8Ygl0Q+qA3Yi1B4L5Y5ERdxx3njPKTo5veWzBF
 cXIKB7uvST+n9WGH9NLvQjfwTbzflyAE4frULIHH6BTYkQQW+ClaWSaYfrBmkjTsZAPF
 SjV61yXSBz3xUAzKzRm1o7OqiLlQuh35ONNqCba64WyqS75LyTNMB1M8iPEMBNbNjkWU
 OuQx3mzg4dZ5J5CjH7Haj/uKKrXcj1G13DiaK9PkvC43+xqwZg3NHJH1RjErEaJw2XI/
 y+dHH5/3xwWdaf9+p6nsF2oAbs33qYSzVqfQGuBSbr9+Ddgxl3YEXD1qgZ2HpDRADZWI
 /1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692354876; x=1692959676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvng4YPVMkWkkh2eZJ6qlqU3fIhQVOx369AKXLs8f1o=;
 b=kja4Sfle9G/FmPqfQCqEJcWtHA/OeFt3qH/c/cknacRxUeVAo3gxFhEu0+bWRU/AjD
 Jfo+hqt4BTzn3b9hNl0HROiPl/9Ol79uzafsbARSl+xGUmTI00uEKeU99DwgmkqMxSST
 RpUkJ9cDpwsRL7NStWVcG2UNdXhl8u8coRR5Ufcxgfy3ewW1x9mcqJUvcOuyco1cHV76
 HeP2FdP5iR1zft/vuJ+Nc9XmFYScX5adbab7qjf7jwdAkcskPnEp6uU4y3thZT0+wW5s
 bJ1nN47mbVlmgqw4787fT11OOtwbpGZzL3Ay6Bw3OaeA4V1ibB1vWAtL7YGqPPCWCnOM
 AWcQ==
X-Gm-Message-State: AOJu0Yz2dByboWyGBsIML2Ucxk3jtCQy57XCOmQe3ZGVU0V1I+65Ginc
 dmdGAEH39b3GM/bq+oVZ3oeYml8ceXUQsY+tZ7M=
X-Google-Smtp-Source: AGHT+IEWeP9u4qmAvb8udtScHkZbRm7x8lFVoMrW69JWYN5YbVYErR8fDpwv5JF0WTV78yMyKaxHXw==
X-Received: by 2002:a5d:50d0:0:b0:317:6965:ef4d with SMTP id
 f16-20020a5d50d0000000b003176965ef4dmr1520039wrt.56.1692354876651; 
 Fri, 18 Aug 2023 03:34:36 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.41])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm2330351wrt.55.2023.08.18.03.34.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 03:34:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] target/loongarch: Log I/O write accesses to CSR registers
Date: Fri, 18 Aug 2023 12:34:22 +0200
Message-ID: <20230818103425.16271-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818103425.16271-1-philmd@linaro.org>
References: <20230818103425.16271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Various CSR registers have Read/Write fields. We might
want to see guest trying to change such registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..7107968699 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -544,6 +544,8 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 static void loongarch_qemu_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned size)
 {
+    qemu_log_mask(LOG_UNIMP, "[%s]: Unimplemented reg 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
 }
 
 static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.41.0


