Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20C7737E3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDj-0007v9-WB; Tue, 08 Aug 2023 00:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDg-0007oZ-V3; Tue, 08 Aug 2023 00:21:20 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDf-0007p4-B1; Tue, 08 Aug 2023 00:21:20 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686fc0d3c92so3476060b3a.0; 
 Mon, 07 Aug 2023 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468477; x=1692073277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hlH2LR6sixLF4V7zBys/ieYFlsDwDyLaEsz5PY7Muc=;
 b=DTb9lJPo9SeRwaMOb7/gYmj/f9MeFq45kW2nrM2SpxRCXYYuhfEtTgOCNSx+DVPZLM
 69xpl/3dkX7hiTXhO/cNZ67tEZLgV41Iqx06SBjiukPxKAuPABx61FN0kSG0EfyOlVpb
 QaS8x/CRvn/OyeQ/i3YNqzcCPJAgHUf5Qp++HlVlo+w/pZ/DhBKX4gWs5Qpj+nHuIjV0
 e2aAa6Nm5xkUaIFGiBD50jXfQ1ePrMToCqvRoqwtW0VOzR6Rn1KbEMdNyGeU7SKvhxSh
 nyiJj98+CWFp5uLWwG+5uhgbWWhv+DYJDGzJ0c/pXYPeb8fJzxFcHSuuhvnJrUsoFdKG
 RkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468477; x=1692073277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7hlH2LR6sixLF4V7zBys/ieYFlsDwDyLaEsz5PY7Muc=;
 b=NVJPJSPCb5m13/LNW8Ez63hfxzXjruh/gTr8on2a0NpMp5dUV1Lew27FwAAarYo85r
 qN0vM0v6g1bBzQokaXnNgSqFGCuiOyY2RUcoiTaz+Rwt9n2KuGq8WvTOpu9DGbMlIkzx
 W0Std3t3kLSU5Drqknm4Ai2G+uCDxFWLIiXQn+iAWBA39rY534hn3apJkMvXPnAjGb+m
 j41Cpvf4t1MNOwq2X8TQbuGfKNPqs4nSsyExPL2+eEHnxGk3toB2gh2tyQYRzQtGIHtK
 6SSwHidCJDRMjKmJSoE0YEd2PoLdiPE/gFIqmb4Lk+P+hfd4g6QF5MMkgIzelJkbrVVa
 Z5mw==
X-Gm-Message-State: AOJu0Yz/c1IF+nbl0B5MCAm0DpSOo8USGt8FoGxgZ27vMMjEQmAk3sGX
 UTQVrpjyFE7AhzY+SiLMmVU=
X-Google-Smtp-Source: AGHT+IGpMvUMrMRCeZeEIYpHqKdvdM3To54ACaPmaveKGnU+8zwvYhDvadQHMyAgF8578JnihS1clw==
X-Received: by 2002:a05:6a00:841:b0:666:a25b:3788 with SMTP id
 q1-20020a056a00084100b00666a25b3788mr10637967pfk.34.1691468477397; 
 Mon, 07 Aug 2023 21:21:17 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 14/19] target/ppc: Fix timebase reset with record-replay
Date: Tue,  8 Aug 2023 14:19:56 +1000
Message-Id: <20230808042001.411094-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index a0ee064b1d..87df914600 100644
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
@@ -976,8 +977,14 @@ static void timebase_save(PPCTimebase *tb)
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


