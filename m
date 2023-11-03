Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B807E09BC
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:01:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0Kq-00082y-KW; Fri, 03 Nov 2023 16:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Kn-00081h-AP
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Kl-0005K7-Ix
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so18074665e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699041597; x=1699646397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8f4GTCXoafF/KsbNQ8bEyDSKUwReC+SK1TUkgZ9c4E=;
 b=yyiUJVCAbWpvx/rF4wb1moai1c8mFga3Qdn+mau3PtxuxulbuUrlrA4eSrEBm3Jc/6
 a0XlFgPW3Tu58stVMrg8/a3yPWiyS3EMymhvrgAOrDk53B64gpI/FgMLmsDB6D9QDClk
 xXgbADJWva4VGlR3Zf1X7pWostwOvuad866Iz8A+9M5nW1H0Xspd5nWXKHTSqz98CceT
 ERO2uVMqyLadT6ZQM82cWsvPXNi8Ajc9h2YKfWB+fmR/M0Mg1UHGTbmTjlc427Itzpw0
 AQ4ra0zcirV2hGajfRbMdBriwDBmZlfYGF8cohWJ0DGaFukCgm0ls9rlynkk1mAWx/y8
 nCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041597; x=1699646397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8f4GTCXoafF/KsbNQ8bEyDSKUwReC+SK1TUkgZ9c4E=;
 b=WMDJ5qA/4S/MRuR2VF1MD5rmhVR3UWx4frlLsrIzIrO21QL/EWXJT2youdaRjwkSmU
 BCybnZfqc5gMF1UUlRflFc61mbM2fgm62vvmljnUTIryBP8imOO7OumO8VZsn03PkMbi
 lNjZhFzJzN0ZPwHhgrlb3PKeKbW88x9FcHFc9e4+0zqDmZcljIjFndj3b5WrtB3n1uJJ
 OVsbDL+LXyFyioBt84Z9fJi1/LCXIxOpV0TrDQv0VgwP+gkpClklAj3GEfFfBLNz174d
 ox5Vb1JE/ueqwDWywSNJYyimmJOdnnpJ8eYufmk3MuYXMkcvsOrGwym7ykMHCKM0PyOY
 VgZg==
X-Gm-Message-State: AOJu0YxJf779/EwvuMKflUyHwHfAfYhLjZ+mfuFWpDRl0+Ws30WYdyDj
 5OxFzbAmIc7DSj2prPmtIVP3FA==
X-Google-Smtp-Source: AGHT+IEK7pd4jyXMt0uxE8PejqcTXUP+gN3FPxdh3K37uWj7HWzaCIc9vgoQMzVLLPcwmwH6//s2TA==
X-Received: by 2002:a05:600c:4e91:b0:408:4918:590e with SMTP id
 f17-20020a05600c4e9100b004084918590emr17896853wmq.39.1699041597490; 
 Fri, 03 Nov 2023 12:59:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r18-20020a05600c35d200b00401e32b25adsm3557288wmq.4.2023.11.03.12.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 12:59:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BDC2A65740;
 Fri,  3 Nov 2023 19:59:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Brian Cain <bcain@quicinc.com>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 01/29] default-configs: Add TARGET_XML_FILES definition
Date: Fri,  3 Nov 2023 19:59:28 +0000
Message-Id: <20231103195956.1998255-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103195956.1998255-1-alex.bennee@linaro.org>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

loongarch64-linux-user has references to XML files so include them.

Fixes: d32688ecdb ("default-configs: Add loongarch linux-user support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231030054834.39145-6-akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/loongarch64-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index 7d1b964020..43b8a2160f 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -1,3 +1,4 @@
 # Default configuration for loongarch64-linux-user
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
+TARGET_XML_FILES=gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
-- 
2.39.2


