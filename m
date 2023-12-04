Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF718803695
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:27:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA9uL-0001Xr-07; Mon, 04 Dec 2023 09:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rA6VH-00063l-B1
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 05:48:43 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rA6VD-0006v5-NX
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 05:48:41 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6cda22140f2so4231466b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 02:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701686794; x=1702291594;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OAWc6clR/laPKYDA7XTFiRSDi0wLvmh/mXsGOTF/fbs=;
 b=lMpJyoKsQvEtzoO0I29FCUS/KX2nAL8M1zO5qVI+wyTFr2PLNsi29yUXILcc/RIxKs
 hD+z6g4MSi5i1TPgu9NIRrYYQQrXGQ+P28VUQRgp4D6EHkvJJhwykSkgrThgk1/V+b5x
 GIU41sc22WzN5Yl68QfasnH7kp9+66VyLBEmfnV7B4L1yE1JB/vGQE8hjcJ13ZyIW1ef
 xKOfqdmVhCpoC9H2roVpK3ITtBbOFVZB7243x4CUgCU1q53T3JX8GSJpw6LglGeRVIqg
 ljWBFF5kzLmFSZzx7Qjm33kF8pEHlxNf4JC9Al7S/74l6gCljda2mzXj3SnAjtYeefzX
 D3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701686794; x=1702291594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OAWc6clR/laPKYDA7XTFiRSDi0wLvmh/mXsGOTF/fbs=;
 b=tn8bo2pwFF6lP1bZzpcMAAdbPjj2gi6gMMm2IUZdG2OIJUnkU5N0771iODXcOlNDp2
 GAe94SYRxpOM1WwgtsoRYQ9dYilNCoHfHldt8hh5aOXafTIrPqeIay11MZ2JD2VvIczR
 BChQHOkkdWhyxRDfR37g7aMFxCIn7buAHfGxrFlrHRA0MH73ibWBy3BOZ2PPv3aCA9cX
 domcLHLWVUKNm7z1udeFupn0md8rTbgvKIhvJ5l1SEqLogDuJ9VsmnGzAbv9OW79bj8x
 bMvcQA3LdRdcLHrFDmDwAVQLfQpaMr07rSbVQwIjJEXTYRCwoCQgXHAyLvKs14+mNVte
 F6PQ==
X-Gm-Message-State: AOJu0Yy9M2rnGvZDL26sebhBxbN7e/q5+0n6JhYTc4sgxZOFISLqug8h
 s4jampA15sEULdb9hoVdTHB64y9vBcipfNJ8pHzv5LYaO00rtA==
X-Google-Smtp-Source: AGHT+IGlhGfAQS7GKjksi9QV0yMtsmOOMsfBKi4BY6aqHOT2ZRDGa7KeEV3t8ro+RDqaMikx+Re1Fw==
X-Received: by 2002:a05:6a00:2305:b0:6ce:2731:a091 with SMTP id
 h5-20020a056a00230500b006ce2731a091mr4809527pfh.64.1701686794278; 
 Mon, 04 Dec 2023 02:46:34 -0800 (PST)
Received: from localhost.localdomain ([1.202.18.10])
 by smtp.gmail.com with ESMTPSA id
 bm10-20020a056a00320a00b006c4d128b71esm7537551pfb.98.2023.12.04.02.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 02:46:33 -0800 (PST)
From: tianren <tianren@smartx.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 Tianren Zhang <tianren@smartx.com>
Subject: [PATCH] qemu: send stop event after bdrv_flush_all
Date: Mon,  4 Dec 2023 18:45:59 +0800
Message-Id: <20231204104559.10243-1-tianren@smartx.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=tianren@smartx.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Dec 2023 09:26:44 -0500
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
is done. Some users (e.g., libvirt) detects the STOP
event and invokes some lock release logic to revoke
the disk lock held by current qemu when such event is
emitted. In such case, if the bdrv_flush_all is after
the stop event, it's possible that the disk lock is
released while the qemu is still waiting for I/O.
Therefore, it's better to have the stop event generated
after the whole stop process is done.

Change-Id: Ia2f95cd55edfdeb71ee2e04005ac216cfabffa22
Signed-off-by: Tianren Zhang <tianren@smartx.com>
---
 system/cpus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index a444a747f0..b0421f3e22 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -268,15 +268,16 @@ static int do_vm_stop(RunState state, bool send_stop)
         cpu_disable_ticks();
         pause_all_vcpus();
         vm_state_notify(0, state);
-        if (send_stop) {
-            qapi_event_send_stop();
-        }
     }
 
     bdrv_drain_all();
     ret = bdrv_flush_all();
     trace_vm_stop_flush_all(ret);
 
+    if (runstate_is_running() && send_stop) {
+        qapi_event_send_stop();
+    }
+
     return ret;
 }
 
-- 
2.38.1


