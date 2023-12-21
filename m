Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFBB81B401
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:43:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGS5-0004B7-Ch; Thu, 21 Dec 2023 05:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRy-0003sw-GG
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:46 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRn-00049M-Lf
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c48d7a7a7so4717625e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155111; x=1703759911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1rMPXmtlBiD25TB/VWS9sZqi6o6l7wGlXBsxO0xhRU=;
 b=UI3Gny10WU2cOPbqSB2J35dNTnW8WmK2s6JH4jjhl0vc7VY5zPjUg6VFP3Ct1Mon55
 2wYoWG68ZyFK1J1ylBqEGJ0t3lyEvEBt/WnZ14SYO0jhXu4eay2YLHNDWTyYd66fiMbz
 J1y9gFVHWSPrfWglVKEj19YZzt8+g0pAZghLbdzMJO3M2yyCO6YOYYHwhdNIzgxtloSO
 eBVrNPQ8DgF97RuBdlH49eQ9hJrM6iIUILLvQ6+wFoboE90hvgaNb6s9jwNi8QHzenDt
 rMPtwni3usQvmhbRYmi+eB+69o4yxKtyOuIm6Au4gdpRpT/26wmt1T+PS5NxmJlSUixD
 cPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155111; x=1703759911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1rMPXmtlBiD25TB/VWS9sZqi6o6l7wGlXBsxO0xhRU=;
 b=AJ33eSBF40YAcJe8h3yu9o78OHTHoHoAp0+F00ER7NrCeCS5wxw12MqWDknFSU/Y6F
 3kduzSGCfwWLx0Qp/WHYA47/VMPTt10BFSDAN2b0524cu7o2m7DJ9Ynl2GHS41ZApNZK
 vcTK3T7lVdD3RkAyTxIiIEAYV5KhBhu41Tq3Rxz6unCDqm8amDF2H+n49pvgjKgsEPQ+
 jawiWTh0GkoIepwI3/u0klqz2HjVGx+SMLEgQP64/yMNZsxtTBFhvx7eu0xEO2z6PJOe
 ziMWSTXaxlSbneckhwUjF6P9DyGHaHa3SuQJtGcrFtAbsFYF2eFOOekAzCqBzkx8U790
 HBpA==
X-Gm-Message-State: AOJu0YyN+1Tru47qvQWfEJqQ7AqaVocj6XCx6EkNSAECD62y5Croan3z
 1BK2SIfKBZk6kx6A1UixKNFc8A==
X-Google-Smtp-Source: AGHT+IHchdjaZxIVcpXZCqwsxrWDDGyyBFoOdoVJphoVXuiHBroghEa6tpia2nGcsyS0Jx7Uegt6pA==
X-Received: by 2002:a05:600c:3c8a:b0:40c:3820:efe6 with SMTP id
 bg10-20020a05600c3c8a00b0040c3820efe6mr636677wmb.107.1703155110845; 
 Thu, 21 Dec 2023 02:38:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l10-20020a05600c1d0a00b0040b2c195523sm10866240wms.31.2023.12.21.02.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02CA65F8D4;
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
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/40] qtest: bump prom-env-test timeout to 6 minutes
Date: Thu, 21 Dec 2023 10:37:49 +0000
Message-Id: <20231221103818.1633766-12-alex.bennee@linaro.org>
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

The prom-env-test can take more than 5 minutes in a --enable-debug
build on a loaded system. Bumping to 6 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Bump timeout to 6 minutes instead of 3]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-8-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ec93d5a384f..c7944e8dbe9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -5,6 +5,7 @@ slow_qtests = {
   'qom-test' : 900,
   'test-hmp' : 240,
   'pxe-test': 600,
+  'prom-env-test': 360,
 }
 
 qtests_generic = [
-- 
2.39.2


