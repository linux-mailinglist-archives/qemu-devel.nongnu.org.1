Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00B7C863B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHiz-0003sS-Av; Fri, 13 Oct 2023 08:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHis-0003mM-2Y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:58 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHip-0002aD-1B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:57 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso3687360a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201813; x=1697806613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIq+NNnPEjjdwEwMuihsIXkhuw1xh2LZ59h0H7TW924=;
 b=qpHZEqDD8+sy8g+WKUBGBSCaGmY+eN9DpjF7YxSX89z6mp5VEYSiPn7YqY1HbxFTuz
 tao8UQ6IkaMk8q6Ubl8ddnoM/f04ivYKVHAFOIzckXG1R+fYmSckvWeOF4F7fWZswtYp
 r402UtyXYQ+M8wBkF/WByKgBGxJQWPSVIidTqoa6LRl3s7fYD3IwiX/LcmHmh2QKWjyc
 sVp0BNYD2cqXfL3gvzZy42EH31XtaZyLc/DqFhEyijvVTpOAgSdOxxpYS2PiO9QkVErr
 4SH3DoDsLK49d/ybKnFwv1mMncZTnbFKbvI58luA4zui0qOonh9ZyO+8LGjaUzREy0Hb
 a6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201813; x=1697806613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIq+NNnPEjjdwEwMuihsIXkhuw1xh2LZ59h0H7TW924=;
 b=R/yXnn3ZRHlR/1qy/vT/QgP2p2lUJFCFG/Pai8nzft46udTsk+1rZ2NGzCoJVDdk3V
 WmqnuK5q0wd0feUT3MSC2l/JD+qVL1daZSF/vf5QjVka4/SANjfqo1YdgxQoE83diDFY
 ZxniuYgMU3Q5WZf3nW7mFt33iFN/UBVlqJ116Pi7ms8qpiTSgD0shhe6i8Xrqm1qryra
 bkCz1QN5gxV/QkfqXfbcFi4rVefxUGSFokQ+RT3R0iL06y/pOYFFC4hD1Xs7lM4Soi/V
 2MclP7IX6IWAWwqn3xNsxr4249yekse556g+dykMM4/iONQ8RPgcA9Y5+ZsZoku7Al+R
 kXAw==
X-Gm-Message-State: AOJu0YzncaL5yH7lQfpqwNBZWg0oM6d4JesERDKeBZxXGqpKcQSwvY61
 ISQgGx9nr4JP2R73LD66Oe0LauKGvc//Sf8QJd0=
X-Google-Smtp-Source: AGHT+IH5iXFqUHSsvfxtCi4I7ixU8SzyK4oGPs3H8CYvgUrGGId6iTVeAIGkjOt/iIxGlJfTRM/Z9w==
X-Received: by 2002:a05:6402:518a:b0:53e:4a78:e281 with SMTP id
 q10-20020a056402518a00b0053e4a78e281mr1134348edd.27.1697201812921; 
 Fri, 13 Oct 2023 05:56:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a50d0d6000000b0053e3d8f1d9fsm922774edf.67.2023.10.13.05.56.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:56:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] target/ppc: Move ppc_cpu_class_by_name() declaration to
 'cpu.h'
Date: Fri, 13 Oct 2023 14:56:26 +0200
Message-ID: <20231013125630.95116-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013125630.95116-1-philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

ppc_cpu_class_by_name() is only called in target/ppc/,
no need to expose outside (in particular to hw/).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 2 --
 target/ppc/cpu.h     | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index b86fd46d25..3dc92a852e 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -37,8 +37,6 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
 #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
-ObjectClass *ppc_cpu_class_by_name(const char *name);
-
 typedef struct CPUArchState CPUPPCState;
 typedef struct ppc_tb_t ppc_tb_t;
 typedef struct ppc_dcr_t ppc_dcr_t;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 30392ebeee..8bb66fbea4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1342,6 +1342,7 @@ struct ArchCPU {
 };
 
 
+ObjectClass *ppc_cpu_class_by_name(const char *name);
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
-- 
2.41.0


