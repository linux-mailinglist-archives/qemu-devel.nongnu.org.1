Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B08881B3DC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:40:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGS3-00044G-2Q; Thu, 21 Dec 2023 05:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRu-0003ow-9m
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:42 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRh-000444-JP
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d2e5e8d1dso7042405e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155107; x=1703759907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQu3dEC4bAAkAiF4vI+JksTKEdmVPQCRZYwFmghpZj8=;
 b=p1fV3QckEZhKSl6FhGGGTj1g3pOZ8NxbQpeUljUAW/SwJjJF8ROSSbRLtbBvon/+KV
 2Q1KxDxcss5KYGcKiAlaoi61lEVGY/Cj/ckEsEI0cgTcF0HLU1OEpK0R78PAqx00GwLM
 jgs9yx5QMEwmEhjUqm8Vgv5qLD+vjqWN447ZtMVxIQjyPlIn50C6PnqspNffebp5JjGA
 GN7sGS1F52KXJAwGB258ONOC238IeIPndfqAAg7UvhwPv5b+LJuGbLG9SnoXi8TzA7V4
 Yy5DLcZWZiMXXyG7N7h5DRa1i2D2BcS8eDHni9qJacubQ0dC18wC0xDht1CTYVXOhEl0
 GOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155107; x=1703759907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQu3dEC4bAAkAiF4vI+JksTKEdmVPQCRZYwFmghpZj8=;
 b=aDLgaX7WvXmo6AefdTNSG/CRFQljZ5F283QayrZk449LzMhQA0ObzZSh8cVIHviPLM
 A+xCrOKF1/1BeZ0zSVE4CtgcSCnM0APXaZ9TV0GA1I/wWdYRtP1EVP0io8VPm4WsAPqQ
 Ky/r4Mz56zSgfz/SK9X+IZ5dqNR1OQBxLVAalxg5JQtNmK2Weg/Ygr7PMUjuzZrTnHIH
 hJhvmblVFC006zAHsf01+CDgBgJ35CK+4aylSyNVKpeopGcWkdCJqoqmGGwdEw+bKw+f
 Wm+9gkEAvWo+lA09CtVj3ZyQRFlCB30wuePxyWRkkTJvm9lI1G1txrsaV8C0xWd81qbj
 xiQg==
X-Gm-Message-State: AOJu0YxrpTLqo/ekoR/cLMYiRhQhbyMd+5zxWgu/P89ExW+mdYjaKLJY
 MAba9ZAS3K4NdmKoajgUICWjXA==
X-Google-Smtp-Source: AGHT+IEbyF9eovfKrh2dj9dnvf7GLL78Pjx/5IVXUDpMh5s/NoIcigeib1Kvd7LWnnmBJdJ9FPHlCA==
X-Received: by 2002:a05:600c:154f:b0:40c:6a86:659f with SMTP id
 f15-20020a05600c154f00b0040c6a86659fmr457661wmg.224.1703155107396; 
 Thu, 21 Dec 2023 02:38:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fa18-20020a05600c519200b0040c4afa027csm2760102wmb.13.2023.12.21.02.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE2DB5F8D1;
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
Subject: [PATCH 10/40] qtest: bump pxe-test timeout to 10 minutes
Date: Thu, 21 Dec 2023 10:37:48 +0000
Message-Id: <20231221103818.1633766-11-alex.bennee@linaro.org>
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


