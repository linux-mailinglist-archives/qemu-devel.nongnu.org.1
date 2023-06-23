Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85273BF87
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 22:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCnPf-00079X-St; Fri, 23 Jun 2023 16:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dark.ryu.550@gmail.com>)
 id 1qClIQ-0005d7-QU
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 14:14:10 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dark.ryu.550@gmail.com>)
 id 1qClIL-0001pz-Cn
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 14:14:10 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-55e1ae72dceso664314eaf.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687544044; x=1690136044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWM1/DbXUlkqxBzRPSyb1JKeI8r7QGFeNmYPWNpw5Lc=;
 b=KpKiZ1gJG3Qpx3TPcltYLMKT4HZ3xCiUtfvQd3zU/m5ZgbaoyOTAeIlsTtHa8PUVFQ
 SO/K72WIq5Brwi5iJbkfGcy0nIDURDzKWg+ZSGu/tPmRnupQUj4+LbOQ1PD8u95jkeud
 S1pf26VgQThQqwz21Z0ouVasTXMyrVcesRr+QLANlDjHuOoh4FaO7cgbYy0Gf1oWmObG
 kVU/+9XHlIKG00fNpTfh2WZCeS3zx9bGWbPvsuXsQc6cD5CnkkwYX5hlrLy8C0LFMo/J
 XjtQLqFGVZmSOPOot1trhWnE4mn0JAqcs6mIMOwbI5p8sG+pw6dT4s3UzGEABHkMzeuC
 TO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687544044; x=1690136044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZWM1/DbXUlkqxBzRPSyb1JKeI8r7QGFeNmYPWNpw5Lc=;
 b=BBYhudsQTd96O65KOCnZyegGZGjT/dOyWA79nxy5afLYQbeg6YKtEmoUNzK7AASbqe
 CAAh6RMSFBu9OBs2YQxDzGSEcRHsoPgjBSLVzszyUDUEBKiidBJ5Is+D9g+VUJGWsnjv
 2QiSj/WBPzpn84AmozodRvxRWOYpuXmDgW7uEJOmBZlp4SqT3DnNvMs83OgclKeIFHRG
 e8VrA+LtNDt/bKo+p9XhX39ykq/TXJYPPOFk7p26ZtxVLuF8FTz0/8TxI9TyMIFvFaAB
 xqGdqyxGp4OysbDrJweIyE+VWAoBWX+Et2Et+l+WijZnRd3lZ45F0mlyUcOb23cMtW81
 2iHQ==
X-Gm-Message-State: AC+VfDxgkShJPPnmfITUgXYudAlW+NiJ1z9ADVz65rxoekLKb3Ts+Jxf
 xl2RkjZ0uavONZj2dc7IuUusDVRroGCR33H8
X-Google-Smtp-Source: ACHHUZ5jyFfWd3RIYIkHhCZc/U3VKRkw73pk/yINcrFbXWtAJEeIrV0MlwVY15ZaqnH5WcuLJt8Mvw==
X-Received: by 2002:a05:6820:614:b0:55e:5c65:c6cd with SMTP id
 e20-20020a056820061400b0055e5c65c6cdmr14239907oow.6.1687544043669; 
 Fri, 23 Jun 2023 11:14:03 -0700 (PDT)
Received: from localhost.localdomain ([177.200.67.11])
 by smtp.gmail.com with ESMTPSA id
 bb35-20020a056820162300b0054fe8b73314sm3888553oob.22.2023.06.23.11.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 11:14:03 -0700 (PDT)
From: Matheus Branco Borella <dark.ryu.550@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	Matheus Branco Borella <dark.ryu.550@gmail.com>
Subject: [PATCH] gdbstub: fixes cases where wrong threads were reported to GDB
 on SIGINT
Date: Fri, 23 Jun 2023 15:12:57 -0300
Message-Id: <20230623181256.2596-1-dark.ryu.550@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dark.ryu.550@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 Jun 2023 16:29:44 -0400
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1725

This fix is implemented by having the vCont handler set the value of
`gdbserver_state.c_cpu` if any threads are to be resumed. The specific CPU
is picked arbitrarily from the ones to be resumed, but it should be okay, as all
GDB cares about is that it is a resumed thread.

Keep in mind that because this patch overwrites `c_cpu`, it breaks cases where
$vCont is used together with $Hc, so there might be more work to be done here.
It might also be the case that it breaking this, specifically, isn't of
consequence, seeing as single stepping with $vCont already overwrites `c_cpu`
anyway, so you could say the implementation already behaves oddly as far as
mixing $vCont and $Hc is concerned.
---
 gdbstub/gdbstub.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index be18568d0a..4f7ac5ddfe 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -595,6 +595,15 @@ static int gdb_handle_vcont(const char *p)
      *  or incorrect parameters passed.
      */
     res = 0;
+    
+    /* 
+     * target_count and last_target keep track of how many CPUs we are going to
+     * step or resume, and a pointer to the state structure of one of them, 
+     * respectivelly
+     */
+    int target_count = 0;
+    CPUState *last_target = NULL;
+
     while (*p) {
         if (*p++ != ';') {
             res = -ENOTSUP;
@@ -639,8 +648,10 @@ static int gdb_handle_vcont(const char *p)
             while (cpu) {
                 if (newstates[cpu->cpu_index] == 1) {
                     newstates[cpu->cpu_index] = cur_action;
-                }
 
+                    target_count++;
+                    last_target = cpu;
+                }
                 cpu = gdb_next_attached_cpu(cpu);
             }
             break;
@@ -657,6 +668,9 @@ static int gdb_handle_vcont(const char *p)
             while (cpu) {
                 if (newstates[cpu->cpu_index] == 1) {
                     newstates[cpu->cpu_index] = cur_action;
+                    
+                    target_count++;
+                    last_target = cpu;
                 }
 
                 cpu = gdb_next_cpu_in_process(cpu);
@@ -675,10 +689,25 @@ static int gdb_handle_vcont(const char *p)
             /* only use if no previous match occourred */
             if (newstates[cpu->cpu_index] == 1) {
                 newstates[cpu->cpu_index] = cur_action;
+
+                target_count++;
+                last_target = cpu;
             }
             break;
         }
     }
+
+    /* 
+     * if we're about to resume a specific set of CPUs/threads, make it so that 
+     * in case execution gets interrupted, we can send GDB a stop reply with a
+     * correct value. it doesn't really matter which CPU we tell GDB the signal 
+     * happened in (VM pauses stop all of them anyway), so long as it is one of
+     * the ones we resumed/single stepped here.
+     */
+    if (target_count > 0) {
+        gdbserver_state.c_cpu = last_target;
+    }
+
     gdbserver_state.signal = signal;
     gdb_continue_partial(newstates);
 
-- 
2.40.1


