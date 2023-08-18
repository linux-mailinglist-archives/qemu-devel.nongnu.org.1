Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74A7804DB
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:40:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJR-00046D-Pg; Thu, 17 Aug 2023 23:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJP-00042a-R7
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:11 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJM-00068w-MQ
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68879c7f5easo417874b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329887; x=1692934687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3o76KcQlFp/MuUPscQNwseGhYtySE7hW349U50r8SMs=;
 b=nESUpj2s91OOZEVxjO+tv79Nz9Em+KEWPuCLHPL6Xmw0UKiAwtXStfzeqaANwFvhxT
 cqS+42Vw7xDSAKt65oEVW8cr3xelYi9bNHgzgX4gEbizmXW7LXuWoEYbjmy6Rn3qMM4a
 rPk1ycQ4OQoPgNo189zH1J77fgqf9yeQV4ZU5RxSu82YojZ7wmePun+5LlU8gg4cA1bf
 Enuge0mKR9+kivriFnw75hGp0vIYMQF25r6MIOhb1ppy4fbfdbsiSEfJ3frCPUThP8D4
 4ZYQFA9KK3+1w9nI8/ZZC6RCTPG4TcbRAE68mKwKMPnK0WzjieMvqwDv9XRjyQxIEN8s
 OvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329887; x=1692934687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3o76KcQlFp/MuUPscQNwseGhYtySE7hW349U50r8SMs=;
 b=fL3WI4dZRgYFTv6mcCJFEEkTkfiyUEdab6DdNsI+2qhliosJcpKmZBrpRV4R/7CJdu
 WWEQeTCu3+Ca0QOc+n0Kb1uSJPhw20ik57t7XM0WpBqMkKdEwh0ICNYG6qMBBUYMfOVt
 pkg4/t6HuOnouxRSLMTah8vGsG+saDHun6XievSj7rP7P1GFfKwrfcIK1dfTyB0CHbFT
 eev+j81FxBhqVkNJM0pyEMK7Qa60D2aamSeCPwHMULEr5j83nhR2wFhr50RHaAIq2mvX
 pF4SMhWYJy30xu2MWbefij10iSI2jfYS4rgZApeA5Cje1+xfABWIGLNAPkxFgTdI50yx
 pLrg==
X-Gm-Message-State: AOJu0Yz/F2jwopA2mP79cGL22sB9mPadivzkkdA9uYDY5Y4YSFzxH6eC
 vfJkRo8OzwDb0Yb79DxNPTVIiw==
X-Google-Smtp-Source: AGHT+IEkdhE3nI0eS/6QsydBibmKq7ud6kpnGHn3rMlvO26mWcxPIfUkTSzMQ92r8e4c/mdFbpbrtw==
X-Received: by 2002:a05:6a20:9719:b0:134:40f0:5d04 with SMTP id
 hr25-20020a056a20971900b0013440f05d04mr1571770pzc.13.1692329887542; 
 Thu, 17 Aug 2023 20:38:07 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:38:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v5 25/26] plugins: Support C++
Date: Fri, 18 Aug 2023 12:36:44 +0900
Message-ID: <20230818033648.8326-26-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Make qemu-plugin.h consumable for C++ platform.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/qemu-plugin.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 214b12bfd6..8637e3d8cf 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,8 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+G_BEGIN_DECLS
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -723,4 +725,6 @@ qemu_plugin_get_register_files(unsigned int vcpu_index, int *size);
  */
 int qemu_plugin_read_register(GByteArray *buf, int reg);
 
+G_END_DECLS
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.41.0


