Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A681B40B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:43:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGS1-0003uL-47; Thu, 21 Dec 2023 05:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRo-0003k2-Gx
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:37 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRd-0003tZ-J2
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d3dfcc240so4403085e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155103; x=1703759903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aeln3++ASlFUfIwMVf5xyvW2uMLaZ4UxQn5nypBC6DU=;
 b=NKD2Ez6IAmFr05FeeXK4CX6Z4J8594d+Y2rQN0oreqZVaz8BytbCGzYa4VwzbO66EE
 NMBjm3NwY9qsEkRco2LKHOYZ/V2k2XWZelrX0QMQaLzR0MBbhB76zWWsQZwdVavMFVZD
 2b4lTGG99a5WbC4tGphH66hkqoLE42wMRUVk45jgPp8RAFXVhrh7wF7B49n++cmGQG6i
 4/omNF34F1ftnUuLHXztipWG5BL3+YLrwUufLd8NYRpUcd99UAbQCwzfIfVkAUZD8z+q
 Tkowq/oR1E/n1b0mLHbuEPPZ1ZXNqqTkNWrzUM7kDo++BzTqwcsyeRRQXWY1V2GaG6oj
 H6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155103; x=1703759903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aeln3++ASlFUfIwMVf5xyvW2uMLaZ4UxQn5nypBC6DU=;
 b=IhxfUKQqiIE793CjWNqcN/boLpMyO7hbUrfs/Tr2WOSp6s2/BfeDG/P9gVTEzIl3+a
 Um02GPPEULfXA/Gp0nY3xoBe6FdUCWvs90xFZ9X6IRlMRSCZISVqJBMtMjTM5rv9UV7D
 x5tErZIRCPwhQR0iLoorwdjxO5szRnhPreLTYmN8dy6WF/tfCwxh+Wmb8kwDMR+4vSKh
 qClSTP5JtoD7QEOFzpIOMNh/ovmjvch8BHFAQUO1YO+bT5MgoPQwwPbe/WDCts09LPC7
 VOUNyswDGT4hyuf5VA40GFDaOpXQUy+hrsjPiABMt3PX+4TVr8gCxavC5p5Kog7Zbr6/
 iFhQ==
X-Gm-Message-State: AOJu0Yy2NaVSlVt2s3DVOmectp0USurna5gHz1rHQU4S6ijuP6v/OZds
 ZGX6Ra6XwrDYWKTmEpAbnoFeUw==
X-Google-Smtp-Source: AGHT+IFcq0T5Z98tX6SIlpTXxPt9bNtf3KlNwS0GjFBr1+sNNC4KpClDXxvEGFjmeO6fPuhDG4Tq2Q==
X-Received: by 2002:a05:600c:4704:b0:40c:6b5c:6432 with SMTP id
 v4-20020a05600c470400b0040c6b5c6432mr404313wmo.184.1703155102748; 
 Thu, 21 Dec 2023 02:38:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c4f8500b0040b36050f1bsm2768757wmq.44.2023.12.21.02.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C7585F8C5;
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
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 03/40] gitlab: include microblazeel in testing
Date: Thu, 21 Dec 2023 10:37:41 +0000
Message-Id: <20231221103818.1633766-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

This reverts aeb5f8f248e (gitlab: build the correct microblaze target)
now we actually have a little-endian test in avocado thanks to this
years advent calendar.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91663946de4..ef71dfe8665 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -41,7 +41,7 @@ build-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs
-    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
+    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
@@ -61,7 +61,7 @@ avocado-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     MAKE_CHECK_ARGS: check-avocado
-    AVOCADO_TAGS: arch:alpha arch:microblaze arch:mips64el
+    AVOCADO_TAGS: arch:alpha arch:microblazeel arch:mips64el
 
 build-system-debian:
   extends:
-- 
2.39.2


