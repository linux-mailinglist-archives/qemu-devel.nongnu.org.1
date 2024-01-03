Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57309823377
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:38:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL58G-0003iv-RB; Wed, 03 Jan 2024 12:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL58C-0003fM-8L
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:16 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL57u-0002Qc-0c
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d894764e7so25059675e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303236; x=1704908036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SGlJ3OP3ZQJqIGzbf9sUE9qzVbTUWx7/uZllqYVPY0=;
 b=sEzWDJ1D7AIzGZiiY5WIZ82E/huCLNqr7v042FFviiJ576Y0/aXRjZIapeKMFN3/kZ
 GV5kUKEyM6MQ3P9mN2uq7RNSe4slOg/gobbobfHf6gd4AZj7qhuD8x7IyT+qUjcX5fYp
 iLIjIu2lL40DvbbyCncV6G4sH7XPosSQS9je6coL96wuIRksCVxCmFp6VdQ6QZ0DPmDZ
 qHGppcxKJ3OkmQS8HSQzbE7G5K82FUNWuCdeijVAPTW1DUoGhpth6SHRoW9/741PFLH2
 qHi7Hqp8bG6+MKvdFnTRekc2BM343s24S4wcKOKoRw+rQE+Ex5kcOBg9Fat1H6w4MY2v
 lfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303236; x=1704908036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SGlJ3OP3ZQJqIGzbf9sUE9qzVbTUWx7/uZllqYVPY0=;
 b=BJzsppQ1mqscfThGql+a6AiYPkjysLKoqGoOMjjk9cxNcrLQWD0t0XSD1DW+5pvi2K
 EwwCQroEHNjuUD1cJOowXa6B8E5RLk4yrcIJBey1yJJEM6IOrJFee8SMhIoE61MpnnGr
 uC4bZlMazeFO45v7JT/+nJYDHPp8ntCT0QJ5RwDBiAXSvEMvC/aZUSi57HxMm3OJFbSY
 bf2mbN+RzOh9eP5Z2QjU64iXVASTQvdwSBVQJBQnpT22jJ0pIH4JZ3HKGq91+8JPBEtb
 fQrL6mFrXa7gel+RGsjcaJi9ZFzSkcNUiuMf794F9eF36t6OZWLU4Ae2RsMSQ7upSrSG
 qWYQ==
X-Gm-Message-State: AOJu0YwyTc2q895OaEyNMdh9QQY4eZj+2w9pSqbliINsLlKqL1Qnz/Y+
 XHr1hFf63ENeoOPYG5XZIZgxIld/TE9jpA==
X-Google-Smtp-Source: AGHT+IE/yZXkFHwcBc8Q8LFh0vqAOsE9eHgOShAhsrYooeQcfIWldwg750GrqHy32Q3/sZAOkr4FZQ==
X-Received: by 2002:a05:600c:4e94:b0:40d:5f50:1268 with SMTP id
 f20-20020a05600c4e9400b0040d5f501268mr3399125wmq.230.1704303236202; 
 Wed, 03 Jan 2024 09:33:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r10-20020adfce8a000000b00336781490dcsm31126317wrn.69.2024.01.03.09.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:33:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF0895F93C;
 Wed,  3 Jan 2024 17:33:49 +0000 (GMT)
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 07/43] qtest: bump qom-test timeout to 15 minutes
Date: Wed,  3 Jan 2024 17:33:13 +0000
Message-Id: <20240103173349.398526-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The qom-test is periodically hitting the 5 minute timeout when running
on the aarch64 emulator under GitLab CI. With an --enable-debug build
it can take over 10 minutes for arm/aarch64 targets. Setting timeout
to 15 minutes gives enough headroom to hopefully make it reliable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230717182859.707658-4-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f184d051cfe..000ac54b7d6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -2,7 +2,7 @@ slow_qtests = {
   'bios-tables-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 150,
-  'qom-test' : 300,
+  'qom-test' : 900,
   'test-hmp' : 120,
 }
 
-- 
2.39.2


