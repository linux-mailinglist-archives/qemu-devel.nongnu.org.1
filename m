Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9A81B47C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:56:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGal-0004iW-UO; Thu, 21 Dec 2023 05:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGaf-0004ZS-A9
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:47:45 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGa5-0007L2-Np
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:47:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33670b90013so345519f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155624; x=1703760424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7XkKmTa2rk3nK9lrhGULgV33LxXcjUpugmHNR7vUhY=;
 b=tVWf+M/MI6Pe7R445W46vVWxhQu3iFDYJSkxctpwEUfES/bPQJVLTekm7L9rcTuqlt
 +EE5A/qPnICJ40RzlBlGetB8GKQcnBHFBuExzkAvzRhg3ZdJ6wJTy4d7FluUFYiLV63N
 sXGsUeRZv61p6wqADYyfEE5y3OIg54QMBlSUKU+kDKo8uJxRl5Gc6P4Dm5HQZLuKjv8H
 WHcveWTu+kO5Zs+jqSCNCjKArRyWuaSL4gJ4OND7Phk5NL2YtmJ1bs/wdySj0oZoCgaE
 1z5AjCLPdcJKceioq+2H73mA7psuEmuQ3sPpdMGJDYcoDMcQAIsa4qSgbYZydRb/02+W
 EiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155624; x=1703760424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7XkKmTa2rk3nK9lrhGULgV33LxXcjUpugmHNR7vUhY=;
 b=XqoaUUgGJg6pda43i3rn1gdweF3V9s9eJOVJOXOjF8B3ZWg1TmagBfn4E2bvQGaK5r
 iNIYwDvRhQgQnmOVcmWy/1rstrRNchx7RqfghPkvMwBIc5zP7/hlWh+bfkzFMkL2w0UZ
 LxeVCnA13Ol++pykj3+MDp7pADCB+f4WlhsMNoq++140Zw3Hau4QbnAc69FqUNdeCb75
 L+r/unWZUcrFhuFDgTZ1mGyCzQiWUDt1jble720hgd4XfyaxeqYJURp6rZsFFM2UEbwQ
 PMNuT9DUnZcYTWhExB6sIHdmyhwi2qvwct2zRmBWMCflRv29fhL2+W+lOwglPqdqJcZy
 a0Zw==
X-Gm-Message-State: AOJu0YwcHfyGdZ9/RXM6pEFbA2WXunzpsCjvMKm5R5puA00MpWCWcKb0
 sNhv9FhxUH+6AXQ7ji7iBsqPmX4rG4WO1A==
X-Google-Smtp-Source: AGHT+IGeWKWfhPunhkyFZbXt1KPxJqxeHCtEwQz284Bc5N95SdyV0c+Z4+H9I2EMlI52DUKHoQyOvw==
X-Received: by 2002:a5d:58e2:0:b0:336:63f7:380e with SMTP id
 f2-20020a5d58e2000000b0033663f7380emr350526wrd.29.1703155624433; 
 Thu, 21 Dec 2023 02:47:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l2-20020adfe582000000b003366cf8bda4sm1743661wrm.41.2023.12.21.02.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:47:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 764945F8DA;
 Thu, 21 Dec 2023 10:38:20 +0000 (GMT)
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
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 16/40] tests/qtest: Bump the device-introspect-test timeout to
 12 minutes
Date: Thu, 21 Dec 2023 10:37:54 +0000
Message-Id: <20231221103818.1633766-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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


