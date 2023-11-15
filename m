Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C67ED4BE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:59:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3MvX-0004pL-IG; Wed, 15 Nov 2023 15:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvU-0004mT-7Q
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvQ-0008Bx-Cq
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:55 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f70391608so62582f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081750; x=1700686550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7aCt684M/Mo4aPxjDOnz7JyGbXhEmNf+Qyqgmy0nPo=;
 b=C52Y7YO0MFzNY+yqvKHlzRt6hBCLcdSBhgZ7iRyqpGxj03Q03xleco5olf1rLD4pKE
 +ts4qw+mI6Vg5aZd24RBFMYazt6jHlkgqfKZ6cgFy6uGa/1i3qB6qPuLg/WCx2fAF73N
 KGqG8boz2y5t75Izs/UczIOFc/l3myk6ag5rHs28Kb6gWuogWRrwC0wkhipTI/AHdHE9
 c1wtsMWvQQWSAeuFmL2ayS35JWNWoUvr7xo4xpHaa6Y5wrcMpnMCfnCVH19ONxkWn8aa
 09P+IcA7bbrCJmn0d+eIJc1j84JzlKXGgWvJfNr2um5TyCqDaWRlgssgm4xI213IWOYT
 pBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081750; x=1700686550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7aCt684M/Mo4aPxjDOnz7JyGbXhEmNf+Qyqgmy0nPo=;
 b=jr0D4l2+8MiGBM6WlIlM+BswMJXGf2nsMjRZr1FqYFo2LoRs1kXrsNUJx86ec4FHhv
 3JjOydSaPY+YTcSY6P1m9dW6vPN7SRU2YUjQ+ODUS7Dih/E6s9j+gqIVMvxmYgXqLe7l
 cjtf0UmwrenNIPvg+T9I6havi0uG/Hye+0HPNyDTPzCkGzABVYUwNnS5t48qgOHREigB
 2AeeEAepN7jPaTnccs9OLJHTBjc8QA3nMAycx5Snkx2GgFiBSpF2PdGlsyvH2r8CG2xf
 /ERESzzi2dMM8vJ+UazusYX3HrLWwFK3D9ph1sNUWfop9pmQ/ArwGkrUTtrwVXwQblx9
 T2Bg==
X-Gm-Message-State: AOJu0YxCYSsWfdsS7x3pEpJ0t3ho9kBzQULD65p6tNHIqODsDmqhFiq4
 dx48BL7wIoJ76mHeqYgc/yXtgA==
X-Google-Smtp-Source: AGHT+IHEkMmH8ID4OjMSzmSjpKy/0AAy/kyhrV7sh9Hbu0ir33doJ2UI/IRULe2SZGRkwoW9VyghtQ==
X-Received: by 2002:a5d:584c:0:b0:32f:7e1d:f039 with SMTP id
 i12-20020a5d584c000000b0032f7e1df039mr10866947wrf.46.1700081750692; 
 Wed, 15 Nov 2023 12:55:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b11-20020a05600010cb00b0032f9688ea48sm11516899wrx.10.2023.11.15.12.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 636BD5F7B7;
 Wed, 15 Nov 2023 20:55:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 07/10] hw/core: skip loading debug on all failures
Date: Wed, 15 Nov 2023 20:55:39 +0000
Message-Id: <20231115205542.3092038-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115205542.3092038-1-alex.bennee@linaro.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

ELF_LOAD_FAILED is one of many negative return codes we can have. Lets
treat any positive size_t as a success for loading.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 3c79283777..e7a9b3775b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -505,7 +505,7 @@ ssize_t load_elf_ram_sym(const char *filename,
                          clear_lsb, data_swab, as, load_rom, sym_cb);
     }
 
-    if (ret != ELF_LOAD_FAILED) {
+    if (ret > 0) {
         debuginfo_report_elf(filename, fd, 0);
     }
 
-- 
2.39.2


