Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 240527ADAB5
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmu4-0001tI-9A; Mon, 25 Sep 2023 10:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtl-0001Pr-6d
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtT-0008HA-3n
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4053d53a1bfso53743265e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653339; x=1696258139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tmt0on2gqtEUKqiKbv0NO0bzg7ahn0zMA7M5ykdCtXI=;
 b=vY1SmGV5G79fgZkVlnyyaHJV6nVLQ4vV1Wx3B0Ud1rV87XGurr3OzpP+bEccFbNA0c
 RCKSYDU4sxKDCTenAnxuRbZvQGj8AbuRwQ1RegzOOSZ066NA7KoF1PXjFxBV/fN9sMhU
 LNIogWKuWEbEl+4jUNI6L7JznNLLQsPdnD9HLK49hATH9YRpdbz5qYKx3bTZAn9M7UM1
 3Jq/m3U1M1lz0US5DNTvGXb2KfGPmyPqL5mDn9/qZPt0ucAtRYoK4nMbJb+60N9X1q2+
 yCRJiDlr9PrUQlcnsoDvAtLRh7PVtiKqgoksT9vBGBkIA27+BCTCFzS+uF3HFR3cF2LN
 ZWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653339; x=1696258139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tmt0on2gqtEUKqiKbv0NO0bzg7ahn0zMA7M5ykdCtXI=;
 b=ltZ5uMA6uGr/AkK6MfJhvOUlXle+AC6YiEjT1vjIZmRi57yLxYTkBWx/6+e8tviffL
 A5ED0hRkDRpFcn/dILzzxzR6upSbETuh+HZy/FddS3KgXF3fOCZx9Wa4B4QnvJOdDd0x
 UIabeCYBCbwRHW6uyVao9f+naKTYM0XQS3XWzFTuEvwRo0m9VAopXu7SQPPER7YOAjvJ
 UYYdwW4xvQErZnWdxmZBz2Qb2eNMFWITug+UVLsL8yt7i6MXj/yPmLN0VlF56nsoEEL9
 id6eYKNiFsB5w1Rdm12yBEAwewHNjd9YZgWh0uG/fxkDG/YQKcshRTSSveZtrZp+iKEN
 5Jxw==
X-Gm-Message-State: AOJu0YyENwUmiYsEYh+9ZvvhHwiQIDty+0m6pr78EdiKD6YcZhtPdrrI
 ObZSJyIrPaLy9AWZUPQASQN8Sw==
X-Google-Smtp-Source: AGHT+IHCrryrBzsPj/q9XxzJDXcaN/RZ559iKlhX9u2qSpA9P1GQgog7di0ZG4gtChK2Ua0luo0V0w==
X-Received: by 2002:a05:600c:3b89:b0:405:9666:5242 with SMTP id
 n9-20020a05600c3b8900b0040596665242mr767794wms.31.1695653339270; 
 Mon, 25 Sep 2023 07:48:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a05600c171600b00405442edc69sm8244128wmn.14.2023.09.25.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:48:57 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA6341FFBC;
 Mon, 25 Sep 2023 15:48:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 07/31] configure: remove gcc version suffixes
Date: Mon, 25 Sep 2023 15:48:30 +0100
Message-Id: <20230925144854.1872513-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

The modern packaging of cross GCC's doesn't need the explicit version
number at the end.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index ebad155d9e..e83872571d 100755
--- a/configure
+++ b/configure
@@ -1334,7 +1334,7 @@ probe_target_compiler() {
         # We don't have any bigendian build tools so we only use this for AArch64
         container_image=debian-arm64-cross
         container_cross_prefix=aarch64-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc-10
+        container_cross_cc=${container_cross_prefix}gcc
         ;;
       alpha)
         container_image=debian-alpha-cross
@@ -1397,7 +1397,7 @@ probe_target_compiler() {
       ppc)
         container_image=debian-powerpc-test-cross
         container_cross_prefix=powerpc-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc-10
+        container_cross_cc=${container_cross_prefix}gcc
         ;;
       ppc64|ppc64le)
         container_image=debian-powerpc-test-cross
-- 
2.39.2


