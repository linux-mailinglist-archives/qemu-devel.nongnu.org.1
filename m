Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D77807E2
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:03:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvNb-0006tX-5Z; Fri, 18 Aug 2023 05:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qWvNQ-0006qQ-Uz
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:02:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qWvNN-00079M-7J
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:02:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe8a1591c8so6462455e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1692349355; x=1692954155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OFKkjcBDeosvkp0muOridVH6emEAC9aE3w3paOSjtw=;
 b=ObwSe1qcxPwgOq2ql0dWCHmNFAyGBijLq8FvfIt8glbCUmk2o3yW5G1XA7cEs3nugy
 FsZr/N3zwg7kNd4j58gHCjuuxfmDqWNUdJAbvg8iaahEMS34dn4Xy4zinCUqFRGJzP+1
 EVfes5vT7jg7NXCPBuE/xErgTmaIgNb29spejqfE18EUj+d5dmZbdMXx32p+qpV899wA
 17MfEwncWytabZG88ZCUjN9XBcygg5D21yyqONki50OANE5ms+hGyx0qCB4CL5Wj5fYt
 aqvK3A2fF3vO1V7hmKFOJGWN68sqZrldVyw9swaaISLSAddw1KluYzGlIXF+OqxRifEY
 uxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349355; x=1692954155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OFKkjcBDeosvkp0muOridVH6emEAC9aE3w3paOSjtw=;
 b=j7B554Js/jyOdR4fmY4fr+y/yA+S/n+Q7t+60OwK/0mGkBcB+S9OKVNhpP47CyPBu6
 +f3wxMFB4W+THYEHq+NdwbbTPoV+wJsAZ9EXWehTxFKYZRWnkFfJpX2R8PmdazhTgoz7
 EBTGNYbKqWtPhvlzV4gGcZKLrFJl/AkoW030cUWpCruF9NjXTUdQ0yC9kjQpMJOmPfnV
 LPbJGaZGJpFXMlCbSHq2gu+IRiKhrWpJ2J1Q1zrl3Sc8uB/kkXJYtjLjFECGw3IvFXZH
 nsLlM7HXJErTLtdfsg7lPAecZ8QSrZzsUZ6TWh6tWoB33h7IS58TgpHpLHzyvCaYWQnX
 nveA==
X-Gm-Message-State: AOJu0YxZ5wgZGInSD/KyqYH6XUNamgA91Q4Xu0AoDmY/ORtKvgo7fTG9
 Bnfm0PwpoVUzNY5lJP7hf1W7EU6LHU2rUs/vTAI=
X-Google-Smtp-Source: AGHT+IHJdGZLV5PfvHWf5LxLoiKzh6jI4XYxn3bA5anbI9lDmMW1YiLkMN/AhXltE8Zf8R1ZRTBKhA==
X-Received: by 2002:a7b:c4d9:0:b0:3fb:feb0:6f40 with SMTP id
 g25-20020a7bc4d9000000b003fbfeb06f40mr1683758wmk.11.1692349355298; 
 Fri, 18 Aug 2023 02:02:35 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:44f6:7cae:4aa1:4fb7])
 by smtp.gmail.com with ESMTPSA id
 r5-20020adfe685000000b0030647449730sm2085745wrm.74.2023.08.18.02.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:02:34 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 3/3] gdbstub: replace exit(0) with proper shutdown
Date: Fri, 18 Aug 2023 11:02:24 +0200
Message-Id: <20230818090224.409192-4-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818090224.409192-1-chigot@adacore.com>
References: <20230818090224.409192-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This replaces the exit(0) call by a shutdown request, ensuring a proper
cleanup of Qemu. Otherwise, some connections could be broken without
being correctly flushed.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 gdbstub/gdbstub.c |  3 +--
 gdbstub/softmmu.c | 11 +++++++++++
 gdbstub/user.c    |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 5f28d5cf57..358eed1935 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1298,7 +1298,6 @@ static void handle_v_kill(GArray *params, void *user_ctx)
     gdb_put_packet("OK");
     error_report("QEMU: Terminated via GDBstub");
     gdb_exit(0);
-    exit(0);
 }
 
 static const GdbCmdParseEntry gdb_v_commands_table[] = {
@@ -1818,7 +1817,7 @@ static int gdb_handle_packet(const char *line_buf)
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
         gdb_exit(0);
-        exit(0);
+        break;
     case 'D':
         {
             static const GdbCmdParseEntry detach_cmd_desc = {
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index f509b7285d..9ca7ae10bc 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -434,6 +434,17 @@ void gdb_exit(int code)
     }
 
     qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
+
+    /*
+     * Shutdown request is a clean way to stop the QEMU, compared
+     * to a direct call to exit(). But we can't pass the exit code
+     * through it so avoid doing that when it can matter.
+     */
+    if (code) {
+        exit(code);
+    } else {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
 }
 
 /*
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 5b375be1d9..f3d97d621f 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -113,6 +113,8 @@ void gdb_exit(int code)
         gdb_put_packet(buf);
         gdbserver_state.allow_stop_reply = false;
     }
+
+    exit(code);
 }
 
 int gdb_handlesig(CPUState *cpu, int sig)
-- 
2.25.1


