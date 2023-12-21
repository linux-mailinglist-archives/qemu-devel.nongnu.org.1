Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E149081B40D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:44:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGS1-000403-Sy; Thu, 21 Dec 2023 05:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRo-0003jm-Bx
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRd-0003ub-Ib
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so7497505e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155103; x=1703759903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SGlJ3OP3ZQJqIGzbf9sUE9qzVbTUWx7/uZllqYVPY0=;
 b=UO323iXmOmh5yE6j0ejVtPe5o99qF8o89J9VMfZA+ItjvxD/LRVyuhGTFVg20a0yei
 jYK8f/GIxd9NMc2EEtuaRySHAkZD3tIapH5QOjWie2JlMwD43XlasRtuJYre6f0v4/Fq
 y2FuEviB6Ra3NKprdifuzwCziROWUudQLfMBxDePzE89mSwp1CB4BTBMBP9W9P43ridL
 6i5Knj5wNRQFVzs+iefdoT0NNsTeZp30yihZnD0OryQa2UwjpOeugd5JmxzFltSRsRY7
 ICpPQZh1MLwetFLJosB9RL1v7C0ee4m22F2Pk9irM+PAgAJvJHvYQLHmXC/ZaWE/k9St
 jXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155103; x=1703759903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SGlJ3OP3ZQJqIGzbf9sUE9qzVbTUWx7/uZllqYVPY0=;
 b=OQmYjFYxnVPB6M/bwJAdAdlQzQ6VRla1zGpmecILJ0nE1yHks3qgCHaVSz012cGelO
 30ipxlnwLWYsPXrwixE5jBlDZL5YN5ajH/0vuR4TNNOD2og/X4j8z6+HqRWJuPC5eufL
 6fNrUs1yH9hi1OGH/nkNb+pl8UVZsmoymONWhFD3+wcwMUPesmszYAcr4qJ4DPigjKxw
 1vf8uULw5Ree2ZLzwedargr4WxmDyNHPY1Y16mEXoCj4Uw86YoGOS3mAndavFcaqysfV
 U+B7Lrk7uu5O0wKQ2Ae3T9FQYd4H27ldowrRGpxViwno3CgVdr8drfRm6zFJ/HukwFJp
 nY5Q==
X-Gm-Message-State: AOJu0Yz9k19BYZAy1vPBFc0tWxAKBf/KicYYuQadjZI+FY0MEYEy/NTi
 oOhWL1m6BGmH0z/UY+dKq6KDEQ==
X-Google-Smtp-Source: AGHT+IGzJv9S1fGxxqDGAioWCTZZnAHT+eEN3Nvlx6N8WGUGOAIae5FBAMLZ8ea9qlDbj4MITf/SSw==
X-Received: by 2002:a05:600c:22ce:b0:40c:532b:7a30 with SMTP id
 14-20020a05600c22ce00b0040c532b7a30mr557054wmg.202.1703155103330; 
 Thu, 21 Dec 2023 02:38:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q21-20020adfb195000000b0033674734a58sm1744728wra.79.2023.12.21.02.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B5FE5F8CE;
 Thu, 21 Dec 2023 10:38:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/40] qtest: bump qom-test timeout to 15 minutes
Date: Thu, 21 Dec 2023 10:37:45 +0000
Message-Id: <20231221103818.1633766-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


