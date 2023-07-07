Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CB74B014
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjii-0007gZ-E7; Fri, 07 Jul 2023 07:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjif-0007SU-Ij; Fri, 07 Jul 2023 07:33:49 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjid-000755-W9; Fri, 07 Jul 2023 07:33:49 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b5d7e60015so1679805a34.0; 
 Fri, 07 Jul 2023 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729626; x=1691321626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCkdRPqEQAxVr0sy/Rwt/MUSqIIx/LRBpxLUD+vaQdM=;
 b=rkj2TyiFNZO/2Vv1H5XdTPzGg5/XhIplcXjArMCj8u2AANTwmcFMN3t/wDewfAT3Gn
 5nvn45d5wbv+cdidVYY8uGISzFZZ4A/rvyLDGjDbjvBAmphNsBvEXzKglerKYL0ekdHT
 7L6/vHFoGHJs8/8xZ/EXqZ2ufT70iVoy2bd0lzXLL4BI5K2G2p18ZiDWGqyua2SL+0n9
 tNEvC0nVs2aILq0pvad3pLt9kx2py8ujkx9DcV0uI5lQDgB5vb7rl+r4rm2a5oU7ZTkS
 6C1ext0Vh5ceUzzo7C88L+vk1y643zh4qbxKtbfbtrn4ZmpXbrpmVbeasGUqtBdZ+2al
 ZVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729626; x=1691321626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCkdRPqEQAxVr0sy/Rwt/MUSqIIx/LRBpxLUD+vaQdM=;
 b=THMQQH8fenBMe/kAUfm94LaZfOWGt2z8ll3SoybnJLXxUg6os/WIHK0Be4LXWX/n1N
 8J+DpLEm7mXL7XUnQHDXuhuQFWMAh7HCZm7FLplDYcHgZD7Z94CdJDoxbKD/87Lg21EY
 KiIW26hpUWnRzallhvcoJRBfl+pk1Sieb4/uKJfgQ8lFpvmIdEROYF3NOZh4gEdDQMJU
 QeLr1W6uLD+VRpDSVs+/4tGkuWQRBjaPXglIeWdeujyacTJGG6aMFUQJlHjc1UHybihv
 MVMRny0dWr1rtWBq9G8q5rYOBHPjuuSKzhhrKwUFt+n6dW8mXYpkTj+5NYmJAYHUZ2Pt
 SMTw==
X-Gm-Message-State: ABy/qLbiTh+OBtqR2xjvyF6i8o0I1zYd6fY9nxI6xKCGPSmieEvAryF8
 pjHm0Qhl1N3Gxa/XoAN8JR3J3/HPA8c=
X-Google-Smtp-Source: APBJJlFAYyxpCzBZHIA8zeUg1M2iuwOOQiXoWuL9idI0F9FlTyvFz8kIVMoX5UQkRx5bgmrw+mmjJg==
X-Received: by 2002:a9d:7515:0:b0:6b8:6b70:4848 with SMTP id
 r21-20020a9d7515000000b006b86b704848mr5810116otk.29.1688729625958; 
 Fri, 07 Jul 2023 04:33:45 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:45 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>
Subject: [PULL 57/60] target/ppc: Restrict 'kvm_ppc.h' to sysemu in cpu_init.c
Date: Fri,  7 Jul 2023 08:31:05 -0300
Message-ID: <20230707113108.7145-58-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

User emulation shouldn't need any of the KVM prototypes
declared in "kvm_ppc.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-ID: <20230627115124.19632-6-philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6ac1765a8d..02b7aad9b0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
 #include "gdbstub/helpers.h"
-#include "kvm_ppc.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/tcg.h"
@@ -49,6 +48,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
+#include "kvm_ppc.h"
 #endif
 
 /* #define PPC_DEBUG_SPR */
-- 
2.41.0


