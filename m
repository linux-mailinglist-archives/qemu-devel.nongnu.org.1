Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDFF82339C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:41:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5DU-0007p7-4h; Wed, 03 Jan 2024 12:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5DJ-0007Ca-Ef
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5Cw-0000ds-B3
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d5aefcc2fso65609555e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303548; x=1704908348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAHZvQIZNHRqbyqy5ojwPgGxK/S007kBQEH3xZgSzNs=;
 b=TDFCMMZTrSMtw1Ixt3J3XH9U3jQ1qft9BHp9UsT4G3pUHYjFxudIC8xK8NQEJydraY
 zNFg5QtOGt9ulUMo1BqET7wBf94mqXFyzR/Wyp2PCy3xmW1RPWF7P5t/apIe8uVIZgHT
 Ih66NnnkwUMZuxr1Px4QvWwOGHYsmvo1F4oXx5fj6athtJTgHWZ1FNs3q8/al+h5uOiW
 zL72ctkzX/3iEl+IItt9RUl6PJ8dQCD4ozZDlzH1Jz1thhQ7zi3DTDMITiUY3pZ3a31X
 jEEcUNFP017TvzdULLasaDBRw97ga0KY+vcKPjVJxvB55ADAKTXhMgDmnu6YwGILbfd6
 Pnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303548; x=1704908348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAHZvQIZNHRqbyqy5ojwPgGxK/S007kBQEH3xZgSzNs=;
 b=VbyohOmyEmmXsDTzqes0y6FgxqfPKzX3Xj8fG4pLvbktWC/dzEYWEYpRPuIBC7ptoZ
 26vNMRxF3V078km4fkDLqvluKJSU+ubVTpgX0TboDKG+7fWMtvsByqFZbbVF/gzDviHb
 Q9KVvEe0ZTBTALS+3Wk05/rVfTxU4ncNoZoG1PnAqS4ZbQUuTflKjcfhCvVV5InwvNhY
 TR3VWOTbBa9TWxpJSRChfTGJ5X7PWJ1QHguhSShdbfsz7z0MJMyB6Qt68zytekRnndj6
 WCl/PRCyzo1Ts/iFSus94Gpemk6bsgFnRB+SjivZagqpUjTrPRLg+1TPjE+rZR1Pkok+
 rY2w==
X-Gm-Message-State: AOJu0YwEfZ4uOUgVLZ3G7f4KSgtKKref9mb1Ra5cMau9kRFcVCZE+wJq
 NQ9XwroJdO+ELuUwuCe486oxjfofGniRtA==
X-Google-Smtp-Source: AGHT+IH+4maMIBzTJ7N1PEvrhxWa7T7vfFwtaWKzwHjzicWz5J/l15SGoM3cw1O5Yh0uqgYYBdQYRQ==
X-Received: by 2002:a05:600c:3d8c:b0:40d:83c4:ff2a with SMTP id
 bi12-20020a05600c3d8c00b0040d83c4ff2amr3311366wmb.55.1704303548649; 
 Wed, 03 Jan 2024 09:39:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b13-20020a056000054d00b0033739c1da1dsm9906876wrf.67.2024.01.03.09.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:39:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1D055F94A;
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
Subject: [PATCH v2 18/43] tests/unit: Bump test-crypto-block test timeout to 5
 minutes
Date: Wed,  3 Jan 2024 17:33:24 +0000
Message-Id: <20240103173349.398526-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

When running the tests in slow mode on a very loaded system and with
--enable-debug, the test-crypto-block can take longer than 4 minutes.
Bump the timeout to 5 minutes to make sure that it also passes in
such situations.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-15-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/unit/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 0b0c7c14115..a99dec43120 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -173,6 +173,7 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
 slow_tests = {
   'test-aio-multithread' : 120,
+  'test-crypto-block' : 300,
   'test-crypto-tlscredsx509': 45,
   'test-crypto-tlssession': 45
 }
-- 
2.39.2


