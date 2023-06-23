Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D373B853
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgMQ-0000bO-JE; Fri, 23 Jun 2023 08:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMO-0000YG-Fi; Fri, 23 Jun 2023 08:57:56 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMM-0006St-Rk; Fri, 23 Jun 2023 08:57:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b52d14df27so3232495ad.0; 
 Fri, 23 Jun 2023 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687525073; x=1690117073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfTBS/AlA3Z4eD6Q+vPTYsZBcNTGo2xV3qOIbiykjsY=;
 b=lhTJ7yktpGWkCuu0QTUPYpU84/zB5b+o0KEB18IzaJahsNY7zI+F7Cfav1a1eBssaK
 DNkE59kEYlhNlHEmKT1sZjvCpxUK7ssENMOd8nPQj4q+TjHHCsM5zzM6avPdbBj0MSTl
 SY+c95cgYkfARC18O6TFqGQdwDQT4Sep11lgPUBw11odSV1JSRk3RGRt8kycPHr6L4hC
 ToYZoFkgvpVOz/TgsMhD+kgSl5ubpjfk4pE43z5+nOiAFFJf8ZQNMQN3oF2v526EDgWX
 jnuqCzc7PuzoyF8mg7vixKNEiWU3+1hMAjKQviAE0WwCkBIL3sDEgWh8OvOjqTLR7qHo
 epxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525073; x=1690117073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfTBS/AlA3Z4eD6Q+vPTYsZBcNTGo2xV3qOIbiykjsY=;
 b=JW7Eg9f2/arHxkEkHA/qvV7bh3VJ15aVsGTED80I+Sg/l3zn+Qq8rCWCXNC++78/Wh
 NxCPhDNgj+MNpuyB2JQCZ0bjksqdDqaYzBTRV7ubZrTF4hFGqWbMqCDAELsGd3jE5BFZ
 vP1K6HF75AOBRDVTiOJAxzKnDV1Hqd0AJKUvahOzc0gwJZHFfvOmiOP74zavZFT3DPy/
 jzE6VyqFkxE7JA2RnJur8fvtYldVC1MjKqqX3pnzMIPIt2pOimjc76AVYC0VoYAicozR
 dtcpo1kLkzSsVg7IgVOrWQx9ya07pGkvHw243u352IidcrCQQCEpffPloVEN72LExSzb
 8B1Q==
X-Gm-Message-State: AC+VfDzJW24tCXJHUORx7m6I9FJKi3L5iqJ+ixIH/Vk8emwgSnZ6gUAq
 Rwh/YGasw/PVV+g1sm/+0vQqMcU7Q7s=
X-Google-Smtp-Source: ACHHUZ4jyHWlsnfqFbTdZSFGWCiQDBqIRkLDe7zlDkYXIwEPUo6cWZgUWYN4dJf0mM6mM2sCgAz3oA==
X-Received: by 2002:a17:902:d506:b0:1b6:6c32:598b with SMTP id
 b6-20020a170902d50600b001b66c32598bmr10927209plg.21.1687525073088; 
 Fri, 23 Jun 2023 05:57:53 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001a04d27ee92sm7141795plx.241.2023.06.23.05.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:57:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/7] target/ppc: Fix timebase reset with record-replay
Date: Fri, 23 Jun 2023 22:57:05 +1000
Message-Id: <20230623125707.323517-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623125707.323517-1-npiggin@gmail.com>
References: <20230623125707.323517-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Timebase save uses a random number for a legacy vmstate field, which
makes rr snapshot loading unbalanced. The easiest way to deal with this
is just to skip the rng if record-replay is active.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 82e4408c5c..7b7db30f95 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -32,6 +32,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
@@ -933,8 +934,14 @@ static void timebase_save(PPCTimebase *tb)
         return;
     }
 
-    /* not used anymore, we keep it for compatibility */
-    tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+    if (replay_mode == REPLAY_MODE_NONE) {
+        /* not used anymore, we keep it for compatibility */
+        tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+    } else {
+        /* simpler for record-replay to avoid this event, compat not needed */
+        tb->time_of_the_day_ns = 0;
+    }
+
     /*
      * tb_offset is only expected to be changed by QEMU so
      * there is no need to update it from KVM here
-- 
2.40.1


