Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF426825720
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:51:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmR5-0002YA-ES; Fri, 05 Jan 2024 10:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQE-0007VR-6B
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQB-0004R6-3U
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so4035035e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469661; x=1705074461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxNkugF37b5fEcbJO0/Zfbyy2DcJjrIhzRUUZIZhOZ4=;
 b=yYLmrPiFphG60m57lWmC4wzmjjC5wVNp3yXqvYn5hD2n/4yIBy7JfY251rW0btPeVh
 K8jX2XUEbDcJJsBNOYaM33TPegWCZy6Db1d2U7ge6EKZQ6H9yhtAPOwYGJJrwdWAdDyJ
 SSksFTsyvOlezel6aiee7zY+Pfsf0aDX4C0W2Aa4/J9dgq96kepL0zHsxZC7lcN3bpNM
 ZuxqOz63Yr5gIr/EuCp6YDRSBvOFOVcf1FVuneMfxkwwqxVxLi3W5PXHJPtpW6Cbidis
 9xLUSHsHjlTeVj4cJIb5Hhg1xKaJFikrm/5YS773otLAsL4Yt7do9EUMZoHQJZI3ocj7
 uFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469661; x=1705074461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxNkugF37b5fEcbJO0/Zfbyy2DcJjrIhzRUUZIZhOZ4=;
 b=VfE+dowLyZ7XABI5RPTHm5/qm7ffZLTxHv/OcV/XVx6EJwq4qC920DB7HDTC9zmxpJ
 za0kof+EXDpKj4wNb//DNdYB8RmInNeBkPpOScLq8dfKQVuG7j1b6v0gSrICn/pRVa7y
 Sw2JIjOrJ+oqdurEE+V9wmpRPi6q8OSM4lLmE4qbhDBX76pxXWFyJ45OYUvppyuYU9h0
 70RSVVsK3CtG1It6G+KDNPM48yUtUohke3juBJGYqBDiezbx9dmzidoZ1SMRVrf3P1UQ
 Bm700qODbjkE/9rWxfdkcNuFHhnFhH+fu3nHBtE/BBrlwP98x67K9Qb3gUVp7hL5wPFN
 u94w==
X-Gm-Message-State: AOJu0Yx8HrEkvJJVjm5C3HJMf56GpAZ4zLSCUfRN4jKCRguj7SkLW2pT
 ol4SAda6PGMOT8YgSrg+lSysmzcu8JGy8Q3bq4nPPo5JwdU=
X-Google-Smtp-Source: AGHT+IGM7TSXyvi6nTWIU+c3D2escNz9iFzkqR69cwYwMN9KqtMPqAbvVdgqTB5wSmv0ub17vOgY9A==
X-Received: by 2002:a05:600c:1d0a:b0:40d:81bd:9d12 with SMTP id
 l10-20020a05600c1d0a00b0040d81bd9d12mr1310560wms.147.1704469661441; 
 Fri, 05 Jan 2024 07:47:41 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b003365fcc1846sm1605027wrm.52.2024.01.05.07.47.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:47:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 42/71] hw/ppc/xive2_regs: Remove unnecessary 'cpu.h' inclusion
Date: Fri,  5 Jan 2024 16:42:35 +0100
Message-ID: <20240105154307.21385-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

xive2_regs.h only requires declarations from "qemu/bswap.h".
Include it instead of the huge target-specific "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id:  <20231122183920.17905-1-philmd@linaro.org>
---
 include/hw/ppc/xive2_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index b7adbdb7b9..816f5d0e84 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -10,7 +10,7 @@
 #ifndef PPC_XIVE2_REGS_H
 #define PPC_XIVE2_REGS_H
 
-#include "cpu.h"
+#include "qemu/bswap.h"
 
 /*
  * Thread Interrupt Management Area (TIMA)
-- 
2.41.0


