Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AF81B3D1
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:39:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGSC-0004QZ-Bi; Thu, 21 Dec 2023 05:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRy-0003t7-J3
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:48 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRn-0004Am-Lu
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d41555f9dso895995e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155114; x=1703759914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeKurO18PT1xLzL5iQamunNBev09YXep7NV+pG6wspo=;
 b=ifgyRZJL0DhDD46WjmnFjNBxBmaxwKB01VbP7WSdHRY0reGfOP64nm+/QUyzXQKqOC
 q5GSVVLHbJwXg/c0AigYft4NsYRh5rRPadn5uC/mxaAn5gh/hOWhLDY21IJ7H9rweQvn
 Gs6yxsd7mhpaPM/No3bfUEplrN/4ZKdyUy/XzYRFtEDiVSWMpirTbDNqvzRG15uGWHSL
 FAMzSR4Vg7UjZPx4gXTrB1m6BBnt4M0KuUeEJ6K6G0+sz6t/Hku6OSXJr1Bm7z51pSY9
 PXLl8FVK+5DiCkYz4l22sJM0WC5xP70qs09r+y3W8DKWNKxtZ7zvFaSrDCVUaHfIy3MX
 hoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155114; x=1703759914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeKurO18PT1xLzL5iQamunNBev09YXep7NV+pG6wspo=;
 b=ETpJ03dcnBnC3eq0SUzU5EwrGuBlM596oMVY0TJ/fKq1y3KLy+3Px34l5kPqHz9UoV
 RFl3ix9pUa3DnynN7ECOzlGeBZC68IA/rtjdGuZ0fmUvuytFqI92wHduOEhHMuJXX5Gf
 26CTMxQbBTUS4vi+zvoFzBR21N2yg1JZwiBuQmEOwJoRTKKwR71wwv1afLfuPySRAwKc
 HF2I3o1GfsPcraewUPf7AsOVoLO9WGJq7dRk8jFiwDbVaZ9H6pQaqQfdhcQ+V1IB73Je
 /7EdPaGGcU1iX7T9jq7DT5RLPFkI+FbaXod8jO27hVdd5/f0gMZqiGKlxq/wehFEvQ6f
 63CA==
X-Gm-Message-State: AOJu0Yy0PaSKpYB/Y0d0nxt6B8YFRIpcChoF6M5TusgBvTEUR9CLXyf+
 r6RYV63pXRWvK55Qdgrf7K5GAA==
X-Google-Smtp-Source: AGHT+IEDw9S3TarblsmJZYT54zqBYySCojx04X6aERE08kCaPWULIdSrrrthFqqDkUid6eRtO2RAUg==
X-Received: by 2002:a1c:7209:0:b0:40d:3823:5e0e with SMTP id
 n9-20020a1c7209000000b0040d38235e0emr586756wmc.140.1703155113939; 
 Thu, 21 Dec 2023 02:38:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p2-20020a05600c1d8200b0040596352951sm11263469wms.5.2023.12.21.02.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B86145F8E1;
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
Subject: [PATCH 19/40] tests/fp: Bump fp-test-mulAdd test timeout to 3 minutes
Date: Thu, 21 Dec 2023 10:37:57 +0000
Message-Id: <20231221103818.1633766-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

When running the tests in slow mode with --enable-debug on a very loaded
system, the  fp-test-mulAdd test can take longer than 2 minutes. Bump the
timeout to three minutes to make sure it passes in such situations, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-16-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/fp/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index cbc17392d67..3b7fc637499 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -124,7 +124,7 @@ test('fp-test-mulAdd', fptest,
      # no fptest_rounding_args
      args: fptest_args +
            ['f16_mulAdd', 'f32_mulAdd', 'f64_mulAdd', 'f128_mulAdd'],
-     suite: ['softfloat-slow', 'softfloat-ops-slow', 'slow'], timeout: 90)
+     suite: ['softfloat-slow', 'softfloat-ops-slow', 'slow'], timeout: 180)
 
 executable(
   'fp-bench',
-- 
2.39.2


