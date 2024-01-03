Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A2F82337E
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:39:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL58M-0003sR-PB; Wed, 03 Jan 2024 12:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL58K-0003qD-RB
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:24 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL580-0002UV-6g
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:24 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3367632ce7bso9138318f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303240; x=1704908040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqrDXpkh9FjMlfAgHrjndIlqPg75eovfRGnZr9OF3KY=;
 b=px/1BEMAA58Anby4kBk1fpNqIQu/skQnoxsX1HHLsckmUbsUm+ENf8i/dT9np1uNv/
 yAfUdVe+XfbYuV+bKsXOrbXEVnuNCPFbkq/JrgMVsTebKo7JhdBo//tjyQwU3letusBd
 PgEdyBqU/Ug5MORXkCwvXCzxVkrjMR4y5lIQDWxUX1u7hrYTE/5VriOqd2j8Op4LC3yC
 PAzV7uKa2Y+mMWKJ2ug3TU0NbIqnnakSTX9yaA5TDaD5U11yqPOB+CK4lg2gYwhYsbSL
 nUpkK9Ovo32R1nb8pL0tfp+fPgQPOnh1f/qXVEZR5t6TJO0mszIhkUv/BVMM9ld1rDln
 ZMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303240; x=1704908040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqrDXpkh9FjMlfAgHrjndIlqPg75eovfRGnZr9OF3KY=;
 b=KNeaOh+Kpa7eJB+IQs1HdHSxoEjUSdMkE3RvYQsMz2il0GdrgGQKxYru4kyTDD0Q2r
 edfn0B900MMI9M4UM0V7Il+Jw2o7g3MPjg49T7WnO4qQ3U5yrbFKIVp+sH/Gqr8r5tlh
 mkc7BQfRR6mDpYBrVfZoCbwd1etfEQEglokVl/bNh1Qbjqm6Q8cE2rOC9n4v42SZwsef
 KR7iMBW/s6oBhmTtB0SO08uNnKS0cJpwYcmwyJTfHhwBgfkbr90Fk/IkztTACKbTZP1f
 yJgvZ/yMSSAsQkpH9UeBjqYN6MhRn4svJtpzOkIf88xkGbBQri33hP07tJaIe34ogeOw
 349A==
X-Gm-Message-State: AOJu0Yzv/auAN6BCFACQbsMQlGWTYaiLkozm+Iy8K9hykC79MbHQLcSA
 z5fjj5AfOf5lL0D3JTd61ZIoKRYJWh8vag==
X-Google-Smtp-Source: AGHT+IEnYc36seB1PpcGJ/mV+1AvJpNac6K8FWM/1UmeDuOkWOqd5bHXuF6GN7+Wd+OGJrM9o3XEQA==
X-Received: by 2002:a5d:684a:0:b0:336:1182:6475 with SMTP id
 o10-20020a5d684a000000b0033611826475mr10980107wrw.34.1704303240708; 
 Wed, 03 Jan 2024 09:34:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a18-20020a5d53d2000000b0033671314440sm31256414wrw.3.2024.01.03.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:33:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95FEB5F926;
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
Subject: [PATCH v2 14/43] qtest: bump aspeed_smc-test timeout to 6 minutes
Date: Wed,  3 Jan 2024 17:33:20 +0000
Message-Id: <20240103173349.398526-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

On a loaded system with --enable-debug, this test can take longer than
5 minutes. Raising the timeout to 6 minutes gives greater headroom for
such situations.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Increase the timeout to 6 minutes for very loaded systems]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-11-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b02ca540cff..da53dd66c97 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,4 +1,5 @@
 slow_qtests = {
+  'aspeed_smc-test': 360,
   'bios-tables-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
-- 
2.39.2


