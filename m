Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B0580EA83
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:38:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD14R-0000G4-Q3; Tue, 12 Dec 2023 06:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14M-0000CG-O3
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:36:59 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14L-0006vi-9S
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:36:58 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso7910768a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702381015; x=1702985815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2w63ljFdqIz1JzgOaJC6yCkuASP8vMkY+wuXlFzHsQ=;
 b=Tnp0MZpMNwrDmGIqWgwtQB+qlderfCoMBQGWXTZEI/BGobZao4P838cgcV/R52O50W
 Aqe6+wyVFYNscxnW0ssPFQlfTCP6nUWKPNouOdQ4qqhyZvZrcuyom1bzuz+LbVieFETv
 f3u9d9qjIvK6IhjuiUp2uI6tAJL/HPaXf0XR3glwEf33kehA9zvnMk7pZMxE4ESlm/Yq
 U0Tu+ysZCRwZudYoy11KsxMMEzG+lU8PvkXTA+XVaMTmq2EZG2jnrlSLAMfWFP8DcRjj
 15sxX/PEP0eeiRClVuSnXNYp25+uKDJEVAAvR4xohcI9BFv8ZC+zHL8Tvgeu/IuVJCBa
 DKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702381015; x=1702985815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2w63ljFdqIz1JzgOaJC6yCkuASP8vMkY+wuXlFzHsQ=;
 b=vh5GGmsndoGsE1kahCgypvqcOKgOIbP6Ynj+QcYVqtdOhnmrYZUqLcEqSXyLlByMCL
 c4d4l0bcn9WUlR8PBfC/Ig/k0qz7zqLyyDMMU0L595h3TkRDEZ8+J9xnQbcK13kkqHi9
 i5Xt1xBR3flx8xyeVj1jxoB20BC01uCW0M+GJOVtvEj1906QBrqFClG1ZzUbPZ8r6P/w
 fPUJClt7DtjD8tFPalvvNqw1iL5JZsTNi+yVJYnI9UUp0Gjiw7K/HzkfSxtuYz6qECKw
 juA4atHlo0mcady1UfEb5H9rYdSYXmBd+e1Cht7Dcucha+Ub52CRAIBTbZgsMmkTVhr8
 ZUPw==
X-Gm-Message-State: AOJu0Yz7vZaqG5YeBAq71JE7Opcvgcbs9PqLa2y6BKRZaRc83KLOAPdL
 2KfZfZANnuH0oOtxLhPYOXQ/E80kcIhb8hAQOxZOhw==
X-Google-Smtp-Source: AGHT+IFnDbLCAy2UGfrrTyUKGiZ95yO461sMGxq7pb3a5TgED5eunTUG2FsH/cGH2xzRFEvnrePcyA==
X-Received: by 2002:a17:907:9815:b0:a08:291c:62c9 with SMTP id
 ji21-20020a170907981500b00a08291c62c9mr3501458ejc.5.1702381015749; 
 Tue, 12 Dec 2023 03:36:55 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vc11-20020a170907d08b00b00a1b6d503e7esm6105964ejc.157.2023.12.12.03.36.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:36:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/4] hw/misc/mips_itu: Remove unnecessary 'exec/exec-all.h'
 header
Date: Tue, 12 Dec 2023 12:36:38 +0100
Message-ID: <20231212113640.30287-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212113640.30287-1-philmd@linaro.org>
References: <20231212113640.30287-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

mips_itu.c only requires declarations from "hw/core/cpu.h"
and "cpu.h". Avoid including the huge "exec/exec-all.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/mips_itu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 5a83ccc4e8..37aea0e737 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -22,9 +22,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "exec/exec-all.h"
+#include "hw/core/cpu.h"
 #include "hw/misc/mips_itu.h"
 #include "hw/qdev-properties.h"
+#include "target/mips/cpu.h"
 
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
 /* Initialize as 4kB area to fit all 32 cells with default 128B grain.
-- 
2.41.0


