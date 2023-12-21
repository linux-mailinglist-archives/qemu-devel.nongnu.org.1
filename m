Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05D81B462
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:51:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGan-0004km-8o; Thu, 21 Dec 2023 05:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGaX-0004DL-Dg
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:47:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGa5-0007LC-SD
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:47:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3368b9bbeb4so222932f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155624; x=1703760424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1gJobfuOXArDzvCmnHLIGQ5mswWRXVhuXYUXNww838=;
 b=Z1oIcE2YESsPkIZGovtIV/0iazXAaRCG/f+98DrJ+248nPbA+MUSKqth1Yv5oA6LDl
 o0g6FfVYq0LLbkrcbzR8gDIPBc7UixdEZEiOfFNFuUHGl0f6368lvldETorBzFWlUCVj
 /pZ1Wt7XmEledv6miMPBAtdOShm0IINuQD+R3dvNuUMPXZo+kQYFjqcUIxGYhtBPJsKd
 0l9mam36s4JmkLTVlT1RSXbTbshdfVkEhktDuBgYHk2i8yef6dHZntbJZzWXQJrWrgCz
 RYwbysJXOLnA933nZTIaApGhKDyFv4HY/c2G4/vLBzel7OmSF8rpFdHocAI7sY1yQjwq
 ZyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155624; x=1703760424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1gJobfuOXArDzvCmnHLIGQ5mswWRXVhuXYUXNww838=;
 b=tmsP7egIhUTVCmQoYejRXAMoAa/wPGTtt0MRDg5QunQ6Nm/dFMDuVqiwH3lgjG2cvm
 Y2zRuzZFyPlyWNJX/v5zLXvbs0WHWBWJo0shJIV7550Hkxw/JVldvR95pZ6cOVeFCV8x
 er9QeRg9HN0bDdtBKv3GJokRoKF2wolxaNslNZI5sxh1Mk2pmQVazimSI8+0Ef60C4Jp
 ggb7gs6vj2dRqO63RiGG/B4bgGxDaC9nTe0KfelQS5jziuqIl3w9axmisZde4XkRtssS
 gtgaV2KatKYy4ZTcz62poMFLamtRVp+4Cjh5Szl3yk4Vps8pvjwNYbAFRj1qjxZwvvKV
 9aNQ==
X-Gm-Message-State: AOJu0Yzqv9fnqJYm9qL5hhosCltDO4dMeafF6fu5DmgdYrYq5KwyNzro
 BxE/rj+1e1uRSO+DizsIkbbGhg==
X-Google-Smtp-Source: AGHT+IED7W/Wstnfv6IDEwnAT68FgWsu2mPNcb9+bhjBkxHllorFtuGUm+5aJw9r5ocGmDbjgEoOxQ==
X-Received: by 2002:adf:e50e:0:b0:336:79cb:9c3e with SMTP id
 j14-20020adfe50e000000b0033679cb9c3emr319882wrm.98.1703155624292; 
 Thu, 21 Dec 2023 02:47:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p7-20020adfe607000000b00336843ae919sm1571022wrm.49.2023.12.21.02.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:47:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A0115F8DC;
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
Subject: [PATCH 17/40] tests/unit: Bump test-aio-multithread test timeout to 2
 minutes
Date: Thu, 21 Dec 2023 10:37:55 +0000
Message-Id: <20231221103818.1633766-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Thomas Huth <thuth@redhat.com>

When running the tests in slow mode on a very loaded system and with
--enable-debug, the test-aio-multithread can take longer than 1 minute.
Bump the timeout to two minutes to make sure that it also passes in
such situations.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-14-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/unit/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index a05d4710904..0b0c7c14115 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -172,6 +172,7 @@ test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
 test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
 slow_tests = {
+  'test-aio-multithread' : 120,
   'test-crypto-tlscredsx509': 45,
   'test-crypto-tlssession': 45
 }
-- 
2.39.2


