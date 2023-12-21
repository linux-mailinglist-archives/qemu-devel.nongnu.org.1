Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6281B406
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:43:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGS3-00044z-97; Thu, 21 Dec 2023 05:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRs-0003nb-F9
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRh-00044D-8n
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so6433605e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155107; x=1703759907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaH8a0Z2sktOk6HhcvLcaTrwfzviKqp7ItoU8rNpnow=;
 b=pApkGXFRqSjMP0KpeIQWtscrjohNocGeVJhJ/b7JId/5o5lfwuihlVJKVS9WnC5QlL
 LojyvvABjRVT/3amk3b9jPmZs9lIQwtxSWYCszmvN4wRqdSliqfwqa2TCTrbPLZsaGUo
 O86+IlbwhFDCYMrVWE5X9k3pfdnUacM+F5HH/AdVNR+o/s/7VPk0e64Yxr67/1ODfrNf
 jlE4jOCvJkK+UgYkMHzK3ayQ/+tQcpXB/OyGeDUw4z/gTgaQcPxxqJtBlCjIPoZ4IH3l
 wOi/yKH/xRD8O8xPdxV1JSzWRl4VkGd64lUAqIplS+rCc5/p/7kkLrkWrPGJFAFSeQfo
 ZWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155107; x=1703759907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaH8a0Z2sktOk6HhcvLcaTrwfzviKqp7ItoU8rNpnow=;
 b=NMqmyyZpVPm78iuXS6KU0nx4ZnwOUl5BrnH4XZcqCzOTf/N28mmgwukeYm1LI/PIrO
 b1LMegu5BhFudLqKn2hqFemftXDJjB9ytt1YgALpS/CbQRAjvio9dpgwN5yu2S0n9J6x
 p1QlV4M6JVJeQ60LkSKqL8BR47zynw6AMp8u5JYAGssvNx3nmsY93P5Fjv8GE0QZxo3P
 Tr+88q1A9NUlwMPAAd3U2RF6YoBGaj6qMok0LmrT9BSZfFRwgEOaO8HUThTV9YINvHac
 D5l3sfaWClxe7GTpZPus7/Bu1dPZE6lp5LX0FlvNXNIolTSgmBt2ET8nKS94N+kD0H5u
 3AtQ==
X-Gm-Message-State: AOJu0Yyw8Sjqarjgr3bgXz/ngqogLd3cZllhJVkLtsT5x4O2ky9rCVsJ
 TSjw9OYfw0ZPjHBIxsCOsrzLaQ==
X-Google-Smtp-Source: AGHT+IH9UYY7nDpturwPwVgfN1wQh5wud+cCc1FCBGp1qeGHyRPqqOwQjcUbg93xcGLmfOziL5lR5Q==
X-Received: by 2002:a05:600c:1911:b0:40c:30e8:fc5f with SMTP id
 j17-20020a05600c191100b0040c30e8fc5fmr601578wmq.90.1703155107622; 
 Thu, 21 Dec 2023 02:38:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b003366da509ecsm1712592wrq.85.2023.12.21.02.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0D745F8CF;
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
Subject: [PATCH 08/40] qtest: bump npcm7xx_pwn-test timeout to 5 minutes
Date: Thu, 21 Dec 2023 10:37:46 +0000
Message-Id: <20231221103818.1633766-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The npcm7xx_pwn-test takes 3 & 1/2 minutes in a --enable-debug build.
Bumping to 5 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230717182859.707658-5-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 000ac54b7d6..84cec0a847d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,7 +1,7 @@
 slow_qtests = {
   'bios-tables-test' : 120,
   'migration-test' : 480,
-  'npcm7xx_pwm-test': 150,
+  'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
   'test-hmp' : 120,
 }
-- 
2.39.2


