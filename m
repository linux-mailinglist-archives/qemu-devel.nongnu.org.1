Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 013AC804A9E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 07:52:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAPGU-0002e2-R4; Tue, 05 Dec 2023 01:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rAPGR-0002dm-6Q
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 01:50:39 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rAPGO-0001nK-L7
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 01:50:38 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6cbd24d9557so4227923b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 22:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701758912; x=1702363712;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5s6k5u06GezO0EJtSNzZXzT0SrsiRdYLdBsGH9qs3Vg=;
 b=Fc1ct+TMbWBj1iuuv9x3o57hN7GDTu8kI9RPPS7gjlGTjwlyQBPrMjq5tqEpJBaQGC
 cat2NBUb3Hgky99iXcZpWdwSuPsjKoQDiYw4+y6GfnRnfavWvkEq4e/jR7E106T1kbL/
 sclYbXER+jH4He/kT2CtEpEPp0rbbqmP1P3FkaxknL8JVY3pMRITc9P0kGLc7BlGzORx
 Bc7ChbTHMWn/0S/yAkgh3cG4Y178+Up2TFOuqo8xhLY9cZVTBxrI2dftX6WlI+5WXG3o
 /QFRu/YyAColnzK68BzhBmJgURu4qXaWSqMdfCsv5LQW2UHXuLauOypPxyxkf2ybL4SJ
 ZXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701758912; x=1702363712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5s6k5u06GezO0EJtSNzZXzT0SrsiRdYLdBsGH9qs3Vg=;
 b=H/A1E6Zx/cNGP6jBZzXG/OalxXiu1SJcB+kYeZNaWBw/9W2eeeESZ8NeIbhejbnE75
 TfKPU9knMoE04cZaNUI6pBBdPMQfw3dVUn5pI/YvyfU5bEeLHsdBwovJu0cJ3V+2/7Jn
 tCNIkZgfXJD6NlB2f33+ooLvkpHmbNcxLHEVfg0CzLX6EXmN50kCHh4wGNVrxxmJ0SLK
 666On5MVW90yjmQQFBN3tuN7I63cczbR0/mKa08xgz6KjBZgThiskx2hdj/PpQxVlLtm
 K+UwKJsng2fgHIbUycUA3YbkdmPo5AokbmCYtsOwcklvsDroLXP+yfs+LCyev7q345m0
 QJsw==
X-Gm-Message-State: AOJu0YyabNwrBq7aHVacQ0oR1YSJWQCULCLMMcxzNsLBJbieWqtcqb/L
 bgVCvIi41SCC11Firb6Mqwh9mESH6cKMan8B/pZvxaX+H04=
X-Google-Smtp-Source: AGHT+IH1FNmPh4E6ZvPda07aqeY51zw3T/yYgIZa1pSmm7FsFmHKCQqTp+yV4D5/ftvbTsxdMBCrAg==
X-Received: by 2002:a05:6a00:3317:b0:6ce:2731:47b6 with SMTP id
 cq23-20020a056a00331700b006ce273147b6mr872335pfb.22.1701758912004; 
 Mon, 04 Dec 2023 22:48:32 -0800 (PST)
Received: from tianren.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 fj32-20020a056a003a2000b006900cb919b8sm5166926pfb.53.2023.12.04.22.48.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Dec 2023 22:48:31 -0800 (PST)
From: tianren@smartx.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 Tianren Zhang <tianren@smartx.com>
Subject: [PATCH v2] qemu: send stop event after bdrv_flush_all
Date: Tue,  5 Dec 2023 01:48:26 -0500
Message-ID: <20231205064826.5000-1-tianren@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=tianren@smartx.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Tianren Zhang <tianren@smartx.com>

The stop process is not finished until bdrv_flush_all
is done. Some users (e.g., libvirt) detect the STOP
event and invokes some lock release logic to revoke
the disk lock held by current qemu when such event is
emitted. In such case, if the bdrv_flush_all is after
the stop event, it's possible that the disk lock is
released while the qemu is still waiting for I/O.
Therefore, it's better to have the stop event generated
after the whole stop process is done, so we can
guarantee to users that the stop process is finished
when they get the STOP event.

Change-Id: Ia2f95cd55edfdeb71ee2e04005ac216cfabffa22
Signed-off-by: Tianren Zhang <tianren@smartx.com>
---
v2: do not call runstate_is_running twice
---
 system/cpus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index a444a747f0..49af0f92b5 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -262,21 +262,24 @@ void cpu_interrupt(CPUState *cpu, int mask)
 static int do_vm_stop(RunState state, bool send_stop)
 {
     int ret = 0;
+    bool do_send_stop = false;
 
     if (runstate_is_running()) {
         runstate_set(state);
         cpu_disable_ticks();
         pause_all_vcpus();
         vm_state_notify(0, state);
-        if (send_stop) {
-            qapi_event_send_stop();
-        }
+        do_send_stop = send_stop;
     }
 
     bdrv_drain_all();
     ret = bdrv_flush_all();
     trace_vm_stop_flush_all(ret);
 
+    if (do_send_stop) {
+        qapi_event_send_stop();
+    }
+
     return ret;
 }
 
-- 
2.41.0


