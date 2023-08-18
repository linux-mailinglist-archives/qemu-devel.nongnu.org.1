Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D28781187
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39U-0004RX-VY; Fri, 18 Aug 2023 13:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39C-0004Jj-MK
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:34 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX399-0001fN-6H
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:29 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so146858366b.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379225; x=1692984025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvng4YPVMkWkkh2eZJ6qlqU3fIhQVOx369AKXLs8f1o=;
 b=N/xlX/0U5f7k4DLrB8XbfHpLf8mI3p/OyDl0Qzv4kpd2xATdEJuxHuWiafAyxQGj0g
 DFC+KSipTcoOdmcey74UlgCF5opDOzEMWInJmkJsaK99Fd1jWG2rnvr3OQrDlJ9TCY61
 8Yyk4v4t2Px8cDMIrk83TO0uSRuLdTfFuzJsv6BohYjA66T8dfLPMz07gTY2mxbZh3e1
 rTeQ+UVH7cuzir8Fu5OrBYQ/mEwv00Jk05npXroOdZqe6kcxV8zFgQo7PQbKL5DO09I4
 lwawbgd/1Y8xSX/yXJ8zjURFdiIli8Spk21pb83f6N87L3bMYtN7k5WpzGCQbHNJd6DE
 UXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379225; x=1692984025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvng4YPVMkWkkh2eZJ6qlqU3fIhQVOx369AKXLs8f1o=;
 b=YKNVpH6Fbm8AouKuFSuFXVcID/u4czndlEowDhwiBZ03AJa5Er/4UBaEWAQZ0SgMK/
 UZxBR2EXqxKyoR6/u3oP9g8MV4nzsnM6hz/pGoHTj80KNVCpt44BHP4+fU7Ig5/cXS/K
 sD5BpMxgf75cb+ZCOa6ZMMJ7DrvZIlmyRbYtq2OZ2xN/5WyIBhmVZ/hslH5Je5dQwgHs
 P2HwBLLN/V/vregmW4OAj9XUErGXniiXaIpuGODLEW212wowb2luuaEYZ8gG0k8iv/Q5
 9vguQjFjuxsVFguFXEeKA0pHwLCyo/uYk2o/VLoNPGjgrWDNaAqAbGuhmDDgSyC/yDwT
 Q6QA==
X-Gm-Message-State: AOJu0Ywkv+2EIiJaF0nShtJopFG99CqmeCQeRI+CtLaove/jAe6ox1ZW
 XlDDOBzJq+W4fBsyDvj5kpH1gXhtmi+OMxiMhJo=
X-Google-Smtp-Source: AGHT+IFPW5IGlCJXSOETdK3KTmwogrhfQIwj9cWQBLDoQJjUupvETyhKHiA99WN8A4hcaMXcQT+IZQ==
X-Received: by 2002:a17:907:75cc:b0:99b:4668:865f with SMTP id
 jl12-20020a17090775cc00b0099b4668865fmr2330966ejc.10.1692379225214; 
 Fri, 18 Aug 2023 10:20:25 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 ja24-20020a170907989800b00992b8d56f3asm1429260ejc.105.2023.08.18.10.20.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:20:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 1/8] target/loongarch: Log I/O write accesses to CSR
 registers
Date: Fri, 18 Aug 2023 19:20:09 +0200
Message-ID: <20230818172016.24504-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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


