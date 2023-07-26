Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6D763F71
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:21:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjMa-0000Fw-J0; Wed, 26 Jul 2023 14:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMY-0000DB-3z; Wed, 26 Jul 2023 14:35:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMW-0008Fv-L7; Wed, 26 Jul 2023 14:35:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bbc2e1c6b2so567045ad.3; 
 Wed, 26 Jul 2023 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396551; x=1691001351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2fe/M8UI9J0UcMXCBdChCqDBtJH1IsuZYF7E+KEStA=;
 b=CapyTk+GGU7M8EZ/+kdpYqfR0uX0CFgNeBDocHB2GevUicOgP4wUT10Ho3bZu1LObd
 ayIv8yXpedV87MIyyy5zNBLjHAz6zGjYWOgKrNKHg8qr1VWUgAFCvcp16oLOEyeciLvn
 kudcm+OhFP8u1dKeP6p4iWDebcwW1sTLvfrXUZS/5bFzV5ne/JHnc46zgJSrMtfWjiFY
 f9EnCYxbTiMMTj1onASCO0K6MeJVQVmGaIalkPuRaPlnXyzYb70kX86EW+6bcBF7Pj5E
 tG5TtpyOisUSHacAimFBTJnJOZbTlk/cXwiPTGA7J5lsbEfOqBkJBqyAnEWbDlyHNLer
 yNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396551; x=1691001351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2fe/M8UI9J0UcMXCBdChCqDBtJH1IsuZYF7E+KEStA=;
 b=GuC1S52wmYYkVNTmczGQpaWhsUm6XFCUw7PtrgRml2X61FraXGHVRC8Zu65Ml/zsid
 FT8f4w+qpux7DxKmIsEgmiQcpHqNiOtjWMOVz/vRX9ei+/46QxTYoomTvhIY91KzIKnW
 uDLqSRxmCiAe3kOkIT/Ek/zMQfDA3tIvmtWn2tigOg4qzQuIEOOuR1CWdZdDHm0MMKXP
 zxnfXeLZvvx/s72YqX0T9r53nOBctVPIdQDfgkKiV6IJvXK/eVdkh6teX6qZtzMq2E+z
 Kfvq5360qlw39/MUGq3yWtkBO2keciOQmaytT3LVEmDORRaZMFAx0sHCJW5zPpPzEe/y
 SkqA==
X-Gm-Message-State: ABy/qLaRKetU/la3IoaSsxpBAHXPs+t46CGF/C+2EQhOTatkrDZs+LiO
 +nxus7M89qto8snmUO35NYg=
X-Google-Smtp-Source: APBJJlEAhp8lfIZGVqUE9LFsWU2NOn6VDckmOH1sGJcYUeh87CALsgdX+I5ypXCXsyFDYLOUFaGn1g==
X-Received: by 2002:a17:903:481:b0:1bb:7996:b267 with SMTP id
 jj1-20020a170903048100b001bb7996b267mr2045075plb.17.1690396551045; 
 Wed, 26 Jul 2023 11:35:51 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:35:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 2/7] target/ppc: Fix timebase reset with record-replay
Date: Thu, 27 Jul 2023 04:35:27 +1000
Message-Id: <20230726183532.434380-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726183532.434380-1-npiggin@gmail.com>
References: <20230726183532.434380-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index cd1993e9c1..2476c4c4d3 100644
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
@@ -937,8 +938,14 @@ static void timebase_save(PPCTimebase *tb)
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


