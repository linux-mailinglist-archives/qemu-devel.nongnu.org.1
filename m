Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75D7B3D8E
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:17:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWS-0000Ju-SR; Fri, 29 Sep 2023 22:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWO-0000HE-He
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWI-00023e-45
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c737d61a00so22244735ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040148; x=1696644948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UahwwM0xSudS8dqnIciSUED/htcAdaM6cKw6bB59fHU=;
 b=iA8VgOSdJj8jrFevw+ZS7oA140GrbyxBVO1AlJkW0KYbDJFJ1aLfj2TjedWjyMXa3y
 a7VBQ6NaH4AvkXWa1XUmgnXEx7vrG9dl5sKgV2Xryz6zBkjldduKTiM5Rmd1rcsXcHJe
 qk05T8E9FSO/kI4R5GLiRRAw7p0dGtE2s6c5gSfACZuTvZp1+QhKz7qBaRrzIt+BlliF
 vn2PgeDwP3aLiNuoykJJqb9qWOpWzgAaOcS/1xJe0NnzwRigeSqDpXbRUMQ2lRirssw3
 xHhk4fFRSSUC+8Q9gT1Y1NBOw8q/9mU5OCS+nesjoDvcPf00bvdUQtK5IJOB49gR0nIU
 dD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040148; x=1696644948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UahwwM0xSudS8dqnIciSUED/htcAdaM6cKw6bB59fHU=;
 b=QpuQcBHOeqQoC/SkulkQkSFBh+SbVQ08OWaMxlzyMMq87T91o+DBSraLYhdt3pWgnm
 /mTOgE/caYOty97MYee2kiqKToZtDrPqSIUYl5HGuKtFEgPgyOiKoaGbtTZM0HeDzS28
 0iSWk8IpyjkmmQTszwyXKKc/BmiFtXPoYCN6a0dO76hZ03YXJkBByb3tcUMlFApS31Ic
 0nrpnrpcfcDh+EJLlHJ5a/ixbWtzu8/NvMV/KIvO5WNSteWeqyrkMPGffE+Iet1hK1BX
 h7HREf++uogGY8S4bSEFjbcmDAOgjdNqRxNaQrLl6GU6MgqNkp+GjDwcQTLjPDra3lRt
 uKKQ==
X-Gm-Message-State: AOJu0YwOf6DreWlMN9/5YZK3Tbpu5moBimlXTl7Z0WXtHN2c1FupBltU
 lwPKrVCEg9iJB4jZqBhpkFGqGI5WbfhCDl6+Y3w=
X-Google-Smtp-Source: AGHT+IGpuCZWTFNhRsaXjOBrir8bKCRRNJS3vtkoKkTPq3fGYFRo4WuC7SsL9A6hpFZPbJx1uVmxkg==
X-Received: by 2002:a17:90a:fb51:b0:274:a021:9383 with SMTP id
 iq17-20020a17090afb5100b00274a0219383mr5889963pjb.17.1696040148477; 
 Fri, 29 Sep 2023 19:15:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v6 19/19] build: Add update-linux-vdso makefile rule
Date: Fri, 29 Sep 2023 19:15:29 -0700
Message-Id: <20230930021529.987950-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


