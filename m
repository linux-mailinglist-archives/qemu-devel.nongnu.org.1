Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C90804D82
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:22:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rARcK-0007MH-VF; Tue, 05 Dec 2023 04:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rARcE-0007Ll-33
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:21:19 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rARcB-0002cv-7C
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:21:17 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5c66988c2eeso1825963a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701767950; x=1702372750;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrjIWuVTon5cUmZo726CAd50U+w4Y2gWMhU0w/nYYzM=;
 b=JWmNGMbnKYjij3Codwg1ftZhaUdqvPvdafdXdO7f+9w9ok1dLHA/6/l5PgVAIDfmG4
 dMugA+roTc5/gh1sbvHTc2gF3Oq6cUxFGNbJ80FHN981cQeiRG3UMkXtGeQavKJcfXUx
 saSF3BRCPQzdlRYMNsZUv/qlKDXp5MAvALXYDnN9TstH0zIJCHhf8vdEwhIqGD2NY8tQ
 zvR50JpfkNj/WXdmZgqBrlC6kFnJDFrhL+KOuNUx8H+gbohq07VM0XEdoo73Xz031Tuu
 eWza3fzPuLMEy8mI1iE8zInf74v5NXC+dpht1Krh9JFzqyrF0SwiJy6qHyf/VRrPsXIt
 YBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701767950; x=1702372750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZrjIWuVTon5cUmZo726CAd50U+w4Y2gWMhU0w/nYYzM=;
 b=TCnmUXtTW5w0niisq14Q4J1yfhwzhwR2y3gRMIfcC9KxJVx5SdEDLdB3l+1vtZgROJ
 TrioT6XklRSkWW00sVbxHGca6a+UkZHwXOdS5ivsPPG4euGG2CorfHVqmzMTaJAeQogu
 uThoqTUSbkZhuFroR9KNK6LdZN0c7umq6FnmUCMWXG9szWydybVPC/6GQfuO1YbprNwk
 f1sybaqsZkgztLi/RNMtdRQHnu5xbYRsh3j0wuaPR8srMJfFQKYPgYNCHkKYBYkaPcnx
 QQNByASYtWm/thLSnVsrG4e01ikvzc/vVDCqP8zGX6UVcFeAme90yKvhkw3iqdPvdd0+
 VPjA==
X-Gm-Message-State: AOJu0Yz8NMni6zPbK4Tq4qmN7MfCx7UoKvPM1h0RGnKePEFr9k4rPCdW
 lFpfNVTx16xv7J4iQT+MnmM5GZpzKA9CgDLYev/t0AWkOyE=
X-Google-Smtp-Source: AGHT+IGOojDKUOHYP9HSd3OHmsPGFh01Zokgs6ygKPewmLNV5QWIwcsUjhlQ4r02akjeLA/wfsI8Ew==
X-Received: by 2002:a17:90b:f85:b0:286:99a9:f4d4 with SMTP id
 ft5-20020a17090b0f8500b0028699a9f4d4mr1197234pjb.9.1701767949667; 
 Tue, 05 Dec 2023 01:19:09 -0800 (PST)
Received: from tianren.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170902ed8c00b001d0915435f8sm4052272plj.16.2023.12.05.01.19.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Dec 2023 01:19:09 -0800 (PST)
From: tianren@smartx.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org, pbonzini@redhat.com,
 Tianren Zhang <tianren@smartx.com>
Subject: [PATCH v3] qemu: send stop event after bdrv_flush_all
Date: Tue,  5 Dec 2023 04:19:03 -0500
Message-ID: <20231205091903.3640-1-tianren@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=tianren@smartx.com; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Tianren Zhang <tianren@smartx.com>
---
v2: do not call runstate_is_running twice
v3: remove irrelevant info from commit msg
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


