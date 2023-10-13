Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB67C8759
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIlk-0000Rx-Sk; Fri, 13 Oct 2023 10:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIjw-0006l2-7h
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:02:10 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIjt-0002FF-0l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:02:07 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53db3811d8fso4352068a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205721; x=1697810521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoUpF/tcrnIyHCTbzMglqeDjmRuZtQK69UeLuQY2xSo=;
 b=iaq4QFiiM79y1DPjBcq/zrbamQ56JbE8OMVsuSMfvxbA1cGszCHXZ3bF1NXaw0j2f+
 ERZR7c3uTHAn3nHUMcMta+EWrfCFoesW9+vhNxc5FumKgYbBUwaAENrnshxQJ6dZJhUM
 CRq1Cmp5SaDZaq7Y3pw7k31XHxSv6lPCtmVU90upivFAeL27fpLA9bP/xk7lOx78k8qw
 PXyQahDvvj9d8lX5dWtbbSzqxdFNTTAVqZW7G+hy/A2JCKEfeXJDIDpYdS2v8nMWTxQv
 Yn0KWnZfTHkHZsYpWS0oMRGtguQ3ftSwtl5gToUVdmIC+rLRz2RFLUXOP8b5HH9yKUwX
 BG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205721; x=1697810521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoUpF/tcrnIyHCTbzMglqeDjmRuZtQK69UeLuQY2xSo=;
 b=vBNPXO195tSPdAeuqKmrpfLBAcO9ccWQOGlu0fwqsYvvNKaKNZ2pcav5DOtsHxCJYq
 lKNU71obIXY8Ddii+QLyX4ysxJ2rO4q0PDjUWkSW5Oohl50HaWE2O6Ozg9sGQPINC+i7
 nJhz2PkjLV3eXfRGbFBVE1zVfsD9whozRo0JjMc9MInSMsnjX5LKWtXfMXuXbanmTzZE
 WHqgTvHJTVslcKU6oHv8MI1Bf7diq1fw2zKvXiGvBj0IG9S5OyZ1QOS3m2Airz5vqW9Y
 5obkDeCEylLFMiST9K/upd7Gaq2+Slpq1ZuSNxefQP+HfZ3B4VuzaugsS5PMNmadyTn0
 wVvg==
X-Gm-Message-State: AOJu0YxabQY/0nsjoJ57Rgwjngu58Lc5ude8sJRNRY5/4VeDbVgS/2Wg
 mcoZQaN9VxaEkXg4B9zyKUyibp4bXGbA3VxxMDs=
X-Google-Smtp-Source: AGHT+IF0XA2HQYdU0a5D9guwgtyAxteWCI1vO7DXw0FamPA6Jp5pReM2s2N+/AfRVrSKhPjdcBnvLg==
X-Received: by 2002:a05:6402:5c4:b0:531:14c4:ae30 with SMTP id
 n4-20020a05640205c400b0053114c4ae30mr193149edx.0.1697205721359; 
 Fri, 13 Oct 2023 07:02:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a056402125000b00536159c6c45sm11321292edw.15.2023.10.13.07.01.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:02:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yanan Wang <wangyanan55@huawei.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Marek Vasut <marex@denx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 04/16] target/ppc: Remove CPU_RESOLVING_TYPE from
 'cpu-qom.h'
Date: Fri, 13 Oct 2023 16:01:03 +0200
Message-ID: <20231013140116.255-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013140116.255-1-philmd@linaro.org>
References: <20231013140116.255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CPU_RESOLVING_TYPE is a per-target definition, and is
irrelevant for other targets. Move it to "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu-qom.h | 3 +--
 target/ppc/cpu.h     | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 6d39ad451c..a8e0dcf2de 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU PowerPC CPU
+ * QEMU PowerPC CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -32,7 +32,6 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
-#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
 #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cf4629036d..f8101ffa29 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -27,6 +27,8 @@
 #include "qom/object.h"
 #include "hw/registerfields.h"
 
+#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #define TARGET_PAGE_BITS_64K 16
-- 
2.41.0


