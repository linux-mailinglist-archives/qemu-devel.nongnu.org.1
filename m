Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CDC9EDAD9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 00:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVl2-0003DO-1e; Wed, 11 Dec 2024 18:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkx-00038a-7n
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVku-00026G-TM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3863494591bso2378422f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958271; x=1734563071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+4/L4+9GPQca3Ynp9H2GzuGT1XQzOn/jP/hpV92NZU=;
 b=fKgJrvMZpvXa1FAvrauWPhM35j3CnjBlytfeLBMADbmhyWdAJIARj1IG27+Y/ZA4uW
 sfz/D3i6vB+znRddS7qVBOlIqhlQGIHeGQ5olL3U8EWn3sX3yMWdPaPbN0Q+YJsZ5bMY
 5zDFyRjmYn4RtqvoAFgFj2Duj1Mg60n/I/znmuNGoyx1hiaxTxGmMLC2Da1n4XFVDyfC
 Qpx9FsK44Qczmm2Q04GxrM7LjPXP/I7jLSnpnVprl9mgmjsbCL7yibr55ZgaMcQabI6b
 3sUJjrHraOdla7jK/LHjtdHsWkLuel19hD4wBLV39Uk5l6G0+9l6gOPDxZuQUlEvJjJA
 +pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958271; x=1734563071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+4/L4+9GPQca3Ynp9H2GzuGT1XQzOn/jP/hpV92NZU=;
 b=hVRFYsb1V+55Z5Ro/q2xLGdBQ3mZK7Rrph3tQz9UZTw365ZW6jU7/fvEilf4xd1ISK
 XafMqCuI7kjAapSopnikwtyu3zdFwOFz20uYMpLXcGv1b0Twexx9l1SIpFly9/lD2Sig
 FMgaWJg5417xqwKIxsD8U50MSxhw/+uaQ6nuIt3qnnUMsqnmA15MEQobvWpE1BIckLPq
 wYPNVj7YY5wUz4NRZnOZlv/KMbZGzhgpa0O+8oZE9hAEjLqLx3YzZv7itPJYC3zRJPq9
 QktgqsaqNh0d8z7Lr+lwzHhm7mV6x3doiywPKF4Velk0lldx71aCa+BPDHDFj/uaC1/U
 LgPw==
X-Gm-Message-State: AOJu0YxjkB3XkDXgAAucjbNgpNX6fQL5dS5vkYN3Fvd0JxoH19r8QXl4
 3bjPNAXQeGvVYQXl1WWhmnHRN7ZBL7Gj+q8yQxBPZq2YK2iRziuX47YBBZjrGOGWTjuH/4WysUT
 J
X-Gm-Gg: ASbGncuWM9HTCcShqCqqNoVIATYlkgMA/izdYbCQomStPy/NQREEbkhhZfh3UcV3ivq
 16WxE+xts9Drc4Yjp54zlYRS+DBHmijn7p4FdT9suH4DUtEOiGktJhJHgJvrSWHjaxFyvJk3ZxY
 Ofh94N6xchZ4EUEHPEHL8yP5eCy4UtN1CCgKNDrsHX8raNRtqbSHtMSFrpD62gDP+W/Q9mt+Q0T
 T0oOzWRFh5qIxrP2kT7pR8VTN6bZprnLfB9Rsgki4CBQF8NV4Wabe/Ffs2XpxpkBj+vKHnExw1c
 Nx0S9/wP+I4wERFPDcieKFFm9uJWQ4CXtg==
X-Google-Smtp-Source: AGHT+IF3qMRbCL0VgNH7+bQrXp6oZOW0PcG2/8u/3GJ1CWD6wsbyUQMFe6AQCr1M7K48q8hVuUm1Lg==
X-Received: by 2002:a05:6000:2ab:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-3864ce495a8mr3829234f8f.4.1733958270738; 
 Wed, 11 Dec 2024 15:04:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514db8sm2347116f8f.84.2024.12.11.15.04.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/9] hw/mips: Include missing 'exec/tswap.h' header
Date: Thu, 12 Dec 2024 00:03:54 +0100
Message-ID: <20241211230357.97036-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Some files indirectly get "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to remove
the former from the latter, otherwise we get:

  hw/mips/malta.c:674:22: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    674 |                      tswap32((1 << 31) /* ConfigEn */
        |                      ^
  hw/mips/fuloong2e.c:89:23: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     89 |     prom_buf[index] = tswap32(ENVP_VADDR + table_addr);
        |                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/fuloong2e.c | 1 +
 hw/mips/malta.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 7fd8296ccb6..904c10b90e3 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -40,6 +40,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "exec/tswap.h"
 
 #define ENVP_PADDR              0x2000
 #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 198da5ba3d4..834636dae59 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -28,6 +28,7 @@
 #include "qemu/datadir.h"
 #include "qemu/cutils.h"
 #include "qemu/guest-random.h"
+#include "exec/tswap.h"
 #include "hw/clock.h"
 #include "hw/southbridge/piix.h"
 #include "hw/isa/superio.h"
-- 
2.45.2


