Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 791E7823375
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:38:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL58Q-0003w1-Ek; Wed, 03 Jan 2024 12:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL58M-0003u4-Ut
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL584-0002VP-2o
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d76fefd6bso43399935e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303242; x=1704908042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7XkKmTa2rk3nK9lrhGULgV33LxXcjUpugmHNR7vUhY=;
 b=yQmaCTOxAA97+kToksODq+xb0wCXfjKjCPEdeBxbtMN9nNfaEoWIRb7uAKHqyXGltn
 PiyKbQYsNklSQPr/2cE7rKk80csblUVmfsJhptagho71CgsoChpOz5P+i8fRaTWgN5ia
 AUkJfSQfN4Poq/YJjku5/LbB8MCdPC/vByfCcjeV5TkxYRrHSvohJj5WaPSxz3z3dBt+
 Kc48QltoegTshq78iGpeNDui5YE93ldbJdjhgoM41XEWKzm2T+AVwgj9WH/9gvAl7MjU
 Cywvj/K8778C0mODFxJtQogUS3kNlnzApP9MM2BRcT0AzOL168iePdiQioMD+ePbvF3b
 GAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303242; x=1704908042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7XkKmTa2rk3nK9lrhGULgV33LxXcjUpugmHNR7vUhY=;
 b=jWk8x8567/NDokpN0t9H//BNT64mlD2R/P+IOmYNfE1IsT/gtGy/9ai5VeyUR+dGMY
 TDg3+QhtnW/ol0dV7VjylV0gvpbAM/87xwsO9QVNW8e0g6WvLv9J7R2gsQmaiZovR0g5
 H31IKWcEepYDQPLobZYABdgxlwzYjLami8XM267cCOyKJFOh0mOvtLPFrKI4DkYySpc5
 zTwyqCYSW7Wr3kmj/zPhPLG/B10hXZKKwz4SDxvlRhB8lRFLWqSYkRiV3+0Hp1OyqTUp
 AH9HSVSydgvYBGmQGySNMHT+G3XKEJ1RIsWJwOgQ9n9y7qbO/fGDmj65/ZfdaXP+2oR1
 LXRQ==
X-Gm-Message-State: AOJu0Yw09D7BkLhLQtNUhhpBAgozROaefmy4ue5Wm0qq5wexucqhH7w1
 2ppPW/pc5zmLiPhVg4d7qRxxcoFjC9B6Dg==
X-Google-Smtp-Source: AGHT+IF/L2p0zQ5EsxWm/ZeewITkxLw43+Hum/+1n38RYmruA0nJMBDcBTcvxGZi4eR6abvI1/ZlBA==
X-Received: by 2002:a05:600c:154f:b0:40d:5f55:663 with SMTP id
 f15-20020a05600c154f00b0040d5f550663mr3068051wmg.94.1704303242496; 
 Wed, 03 Jan 2024 09:34:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q17-20020adff951000000b0033718210dd3sm14497665wrr.103.2024.01.03.09.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:33:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C30C35F948;
 Wed,  3 Jan 2024 17:33:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 16/43] tests/qtest: Bump the device-introspect-test timeout
 to 12 minutes
Date: Wed,  3 Jan 2024 17:33:22 +0000
Message-Id: <20240103173349.398526-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When running the test in slow mode on a very loaded system with the
arm/aarch64 target and with --enable-debug, it can take longer than
10 minutes to finish the introspection test. Bump the timeout to twelve
minutes to make sure that it also finishes in such situations.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-13-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6e8d00d53cb..16916ae857b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,7 @@
 slow_qtests = {
   'aspeed_smc-test': 360,
   'bios-tables-test' : 540,
+  'device-introspect-test' : 720,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
-- 
2.39.2


