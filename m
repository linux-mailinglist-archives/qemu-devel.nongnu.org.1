Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E47DC1B8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:18:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeW-0001hz-R5; Mon, 30 Oct 2023 17:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdy-00011d-CE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdt-0006WX-8K
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so13095195ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700667; x=1699305467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzOKgXKNazfyfA2z+XajHEvJf0Lhv9Mg5pIKTCDChLE=;
 b=eoK05KaYsuuASKPFVrffE/XMDupUEytnQwOYFHpfFFDCODOtwzV7tKUfV424DuUB4Y
 0+A54cOMfT2NJK2jLf0BXH3IBo/Dx6DGLbcdwwwIeAvviEeV7ju+i57U0LxY12GcAvu8
 O6gbv0flNQmieA786VoPyVK0GjBVK1b0nr1VRYUKFjB979JLu+Xq2YhWEk+9tXOWPrD9
 wHFf+Pg9HAu9rZOnIFY+U75HyjZDyD0dcvL/yH7jakQVAZwBFEM6ao7nVmzt7qx5vOIq
 G+HZ+eoP+42xpjIDIOiDiFeCum9CIX3rFzwMgh+yK0ZfkINhGceS++4UVyuwffpaIaW5
 dwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700667; x=1699305467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzOKgXKNazfyfA2z+XajHEvJf0Lhv9Mg5pIKTCDChLE=;
 b=WOt7zxPtU9IttLXPH5LuXhbBPrk/rZNC3qDq4fM4VLiN4G0xLZOq1m55xRFq0HcQC4
 wB5iaBOEAM24e6SSdK9DybLnKaeqIcRfdkFQHHUbU/r49jEzzwaSx79dx4Ysbx5KBEwK
 BmeGeC3d/ci4oYWotdxa3DOcCdohOhRdIhyEQWW8msz1RxoGRShyuzTXiIsRliIIYWxj
 CCxFTlq70JxxdfxOZ2ttQKyYLWrWKLXq+1N9PrAvCx4yVp8s0E4RHgM/Pt8AQ0k5XA1K
 B527xx2ewcmr9eSUJBpGdz9zXbPTjIWMwAGftxYnniW25GDAMmVCW8rYOttU083dUG4+
 gyaQ==
X-Gm-Message-State: AOJu0YzNgM+knfiOH1pytwFAsNT1+RyaD8UI+WfUSuFYqr0CTiKHeun0
 a/WRuzme+J1O6O4ANUdjq/NQ5jYx0/ahaG64tTc=
X-Google-Smtp-Source: AGHT+IGLwe/8TNQKY9c5C8DbCsxrRd5X55Uxk6/j7YSZGnaoJ1v3ciSIgoal3x9XIc3J4nJ/8nsBpg==
X-Received: by 2002:a17:903:30c9:b0:1cc:373b:f0e6 with SMTP id
 s9-20020a17090330c900b001cc373bf0e6mr3776430plc.67.1698700667087; 
 Mon, 30 Oct 2023 14:17:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/21] build: Add update-linux-vdso makefile rule
Date: Mon, 30 Oct 2023 14:17:27 -0700
Message-Id: <20231030211727.165090-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This is not ideal, since it requires all cross-compilers
to be present rather than a simple subset.  But since it
is only run manually, should be good enough for now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index bfc4b2c8e9..676a4a54f4 100644
--- a/Makefile
+++ b/Makefile
@@ -283,6 +283,13 @@ include $(SRC_PATH)/tests/vm/Makefile.include
 print-help-run = printf "  %-30s - %s\\n" "$1" "$2"
 print-help = @$(call print-help-run,$1,$2)
 
+.PHONY: update-linux-vdso
+update-linux-vdso:
+	@for m in $(SRC_PATH)/linux-user/*/Makefile.vdso; do \
+	  $(MAKE) $(SUBDIR_MAKEFLAGS) -C $$(dirname $$m) -f Makefile.vdso \
+		SRC_PATH=$(SRC_PATH) BUILD_DIR=$(BUILD_DIR); \
+	done
+
 .PHONY: help
 help:
 	@echo  'Generic targets:'
@@ -303,6 +310,9 @@ endif
 	$(call print-help,distclean,Remove all generated files)
 	$(call print-help,dist,Build a distributable tarball)
 	@echo  ''
+	@echo  'Linux-user targets:'
+	$(call print-help,update-linux-vdso,Build linux-user vdso images)
+	@echo  ''
 	@echo  'Test targets:'
 	$(call print-help,check,Run all tests (check-help for details))
 	$(call print-help,bench,Run all benchmarks)
-- 
2.34.1


