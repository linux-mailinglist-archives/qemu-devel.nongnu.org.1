Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109782336F
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:37:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL58L-0003qH-EF; Wed, 03 Jan 2024 12:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL58I-0003mT-8s
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL57z-0002T9-0W
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:21 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3368d1c7b23so9280287f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303239; x=1704908039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQu3dEC4bAAkAiF4vI+JksTKEdmVPQCRZYwFmghpZj8=;
 b=GKCNt6pyYd5wN7PxyfxpueM2/VJ0Vu34VBAa3MNKUABjv/ZZtKbZVYcxOcbUT/BdD3
 +MjaSeGcFMOXd1bgur4vaUqj8Kn3cSGeFAW+wXzd2Lh2PNjoR6nweXMHkEr0w1+ffBbb
 wKmAFEw1l16QZ3RQhUu30C0lNx8lg9P8kucZpehoOwqDbJPrhe2Dmdslt2BxVmqacocZ
 ZQKOJVHX5vKywvdDvo7mqA9Gl+yywytDMfxkEDzcMBS1t/rW+AdHQracy7YNgeAJh9CZ
 IZkfjhQbxNyXiaizE6EbeYMuFBUO10C/tAOGM7coS4PR4f6KLYs7RYJoPAGaIfTQj/BZ
 rGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303239; x=1704908039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQu3dEC4bAAkAiF4vI+JksTKEdmVPQCRZYwFmghpZj8=;
 b=AFUd4skiesKs9iQiSfoxrV5QmB2bsL9sARqyOblEi3jyran5d0Ck9xZWvfFKv4M7Le
 Md7v4G+jE2tN5VsJ6iretMXjBBEDBecTl5qJAUp3HU1xaD5lzPy5+X+qRwRPYCJsvFxS
 GIqOAlaZxba8Gidkasay5orq107QgdKeupmphU3qJX+vPUVafgke6Ixq6/ZLhr7JqMdF
 H7HqWmPxxUPe1cjurPKYisNiS0dJIY7LaF5a5pLAZVC5FiwCaW47BgIgq/3kT/ida+gN
 RFBLpaMKsLS/q9LtuC0dhlZ7HCLWQH5P0Q1mYpueMHrYQhBiGuP6uuFB4IJgXAmsEizl
 i3Ag==
X-Gm-Message-State: AOJu0YyxJHewVp/nzv8jiyrBo/wUmmaKAji++uKjlrivLM+OugJycfbp
 EfecsTNVKjPNSw5X+2H2kR+FMntIemsa6g==
X-Google-Smtp-Source: AGHT+IHvYycIZso0+RNoX8bRrVZuyBR3PSZbo6WxRH0B5gzJyTbCgXGQtXc87zbj/WxsWkkJLPXsCA==
X-Received: by 2002:a05:6000:1369:b0:336:6e22:672e with SMTP id
 q9-20020a056000136900b003366e22672emr8708289wrz.38.1704303239019; 
 Wed, 03 Jan 2024 09:33:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b7-20020adfe307000000b0033674734a58sm15715029wrj.79.2024.01.03.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:33:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CB4D5F92D;
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 10/43] qtest: bump pxe-test timeout to 10 minutes
Date: Wed,  3 Jan 2024 17:33:16 +0000
Message-Id: <20240103173349.398526-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

The pxe-test uses the boot_sector_test() function, and that already
uses a timeout of 600 seconds. So adjust the timeout on the meson
side accordingly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Bump timeout to 600s and adjust commit description]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-7-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 7a4160df046..ec93d5a384f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -4,6 +4,7 @@ slow_qtests = {
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
   'test-hmp' : 240,
+  'pxe-test': 600,
 }
 
 qtests_generic = [
-- 
2.39.2


