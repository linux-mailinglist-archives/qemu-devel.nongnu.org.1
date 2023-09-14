Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367347A0D97
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrXY-0008CM-1l; Thu, 14 Sep 2023 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXV-0008Ba-Px
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:09 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXU-0007gN-55
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:09 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a9d82d73f9so163797366b.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717884; x=1695322684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERgMDJMkahr3XFEFhk4ErfsRHoVl4er/YInzsDCH4Z4=;
 b=WXVUVxvTCu8foWnNo9BRqqrz3tSdDe9Jre13jXMoN9/U3MunVIUWvg/RLDCSxeoC2y
 ZQlAcGCX+OzZwS65zQIxt6Eh83hkRZ3Wnrhs+/QE1Rmsq/Nc/wTxHNr1P35Mlh72/dkb
 T8w9y/1/M4cNxGmp30pxZ4wk8Rv+rj3c0xZHF4kQXuzJXad0uTEiDrn9HTU5oXlVdeoo
 OeIueVg3AdjAdU0pS/pBugKXToSmG3+hB/0Zx2I8UybD5x6WFgQ19rHZ1Kb7hDqYIkEL
 F6RCaQhzVhdQU9IUSFhesHm2aC+rbA0AI+b0nAmc9ujtFSVWq+MnsHXNmTa8DSLcrPy1
 d0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717884; x=1695322684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERgMDJMkahr3XFEFhk4ErfsRHoVl4er/YInzsDCH4Z4=;
 b=dR1kfpcGh+XWlOp35VlcTRa0fywLWZvhKepwgtZgniRAw5/uI09fhcNv1r2jI43lVZ
 uCaTcmt9wYJlCMVTV60ThMl/nrL2nUkCJ4AndMdmbpSnx90CvIGG7FDYqLIXzWxbRGSF
 UQ5Z/jd5KqvEMI+Eil4jyL+5W+GKvFDauvulNEp/bT6Sky+et2Gkm3Yi0eWbRMqNpBQj
 /B/IF3qVGztSvshcq1PKhPk2OXDgtgVtgoY7tehmZ19DSczs+/mOUzA9fPOhDeOZmAZN
 egNI8TSTqX6eGlnuOW7DT05o47zV+/1aKQ+DQlJpo6MzjNCLodIAj3ghnBnELmNBAFJJ
 Zb9A==
X-Gm-Message-State: AOJu0YzZvEy+l6H/VFpQY5wIwHqiwIbUmZVAvcWcT2qxjvRPUar8u7vu
 +9WBE+29EASNi4Xm/nCPH5SZupiODJL7uREjDvI=
X-Google-Smtp-Source: AGHT+IHmyV5+Uwpjq0FECFfVEiJ+NUP9C4xz1sxWkddBeIjyo/HJzPQ58NjmnNTkluGiYtrjjhCy6A==
X-Received: by 2002:a17:907:1de0:b0:9a1:bcf9:4f99 with SMTP id
 og32-20020a1709071de000b009a1bcf94f99mr5196658ejc.36.1694717884400; 
 Thu, 14 Sep 2023 11:58:04 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1709067e5200b0099d798a6bb5sm1358721ejr.67.2023.09.14.11.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:58:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/11] exec: Rename target specific page-vary.c ->
 page-vary-target.c
Date: Thu, 14 Sep 2023 20:57:13 +0200
Message-ID: <20230914185718.76241-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
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

This matches the target agnostic 'page-vary-common.c' counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                       | 2 +-
 meson.build                       | 2 +-
 page-vary.c => page-vary-target.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename page-vary.c => page-vary-target.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12261d8eaf..ff436dbf21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -141,7 +141,7 @@ F: softmmu/cpus.c
 F: softmmu/watchpoint.c
 F: cpu-common.c
 F: cpu-target.c
-F: page-vary.c
+F: page-vary-target.c
 F: page-vary-common.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
diff --git a/meson.build b/meson.build
index 3e86a6cebf..3282f888a3 100644
--- a/meson.build
+++ b/meson.build
@@ -3439,7 +3439,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-vary.c'))
+specific_ss.add(files('page-vary-target.c'))
 
 subdir('backends')
 subdir('disas')
diff --git a/page-vary.c b/page-vary-target.c
similarity index 100%
rename from page-vary.c
rename to page-vary-target.c
-- 
2.41.0


