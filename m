Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A838233D2
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:50:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Mo-00018F-Cs; Wed, 03 Jan 2024 12:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5Mh-0000cs-6J
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:49:15 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5Ma-0000Jn-JD
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:49:14 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso674714f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704304146; x=1704908946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1gJobfuOXArDzvCmnHLIGQ5mswWRXVhuXYUXNww838=;
 b=SaCp47LbCwAVkTak62+mpkkEGyubiX6BGsENvQdKc8JjBElw8RHDfkb6MGHo7td/Q4
 RKs9uoiA/ANQynfbnX5QaJOURSR00k6UusgOaPrzZ/q70/2uQImFpqzkD5PGhjHjy4mA
 L0UdAorTwjjOQGtQvT5p1EcnLgT4NlCvAZXMfMwmVM5ujl2zEy0++q0o4SuUiAOVA5p2
 bRcpx9qVV00CnwHeIvof2Vmz3I9htkIS/WS8v0P8YyiaEAELee+DDvKflMULZr06tFUl
 CVNC3iQm89UElHdvQYntWItp3340lwL98wBuF4WT9Qy24hjgfT6uEaXQTL5+oRQGbCPK
 fY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704304146; x=1704908946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1gJobfuOXArDzvCmnHLIGQ5mswWRXVhuXYUXNww838=;
 b=EC8HVdPDepX4e6Oowr+w4Os0N+wu1etvAI/F6I59gFBexogjKYRMxrq02NE3Wc/EJp
 k76/+Ci4v/3M8D7LBthf1g0StqKt14Lw69H2kAwzKqZK9q38T9B9hr+It17TVSJkjtzk
 kpnFTuVnCupF+nR4xMfh2qKgEgaeKAbTx/QvHKspNHT6tE7OfKJUDk/kF8E/kQskIxHu
 wKZgeE/6BC1vvRcDRshA5accD4H17LJYHy2B68egJYoNefrReyxTsXyTzFttZYNJ+dHU
 xjJYXtKT4htIpqptvHRkfPfaaqP2AbSfRyfarccPP2B4EMevY/rh/HkkWLfU4l6ZTlg0
 r1Tw==
X-Gm-Message-State: AOJu0Yym2zSnUsLjGRR4cdrFcUZwM7263ew0SBW+DUHrYMzLcHQyX5a3
 HauPOIqmQndcvwzXPMfWI9pyBq9EqUnn5g==
X-Google-Smtp-Source: AGHT+IGBTYNZSeJJFlrDUsZAC7ZX18VaF73k3nmFtB4HTAJAnT+qiuiHp3e6xy5HCWK1xoAdWaJkyA==
X-Received: by 2002:a05:600c:538c:b0:40d:7b73:68bb with SMTP id
 hg12-20020a05600c538c00b0040d7b7368bbmr4470553wmb.131.1704304146689; 
 Wed, 03 Jan 2024 09:49:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4152000000b0033609b71825sm31007316wrq.35.2024.01.03.09.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:49:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9EC15F949;
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
Subject: [PATCH v2 17/43] tests/unit: Bump test-aio-multithread test timeout
 to 2 minutes
Date: Wed,  3 Jan 2024 17:33:23 +0000
Message-Id: <20240103173349.398526-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
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


