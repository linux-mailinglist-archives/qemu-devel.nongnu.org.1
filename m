Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F117400B0
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMN-0001BT-Kh; Tue, 27 Jun 2023 12:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMI-00012z-MP
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:02 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMA-00088J-Gs
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:02 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f865f0e16cso6543638e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882551; x=1690474551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvgukf2r/kz3Y+kIcG+gDWEsWDEFvjX8X24ODyGYeGY=;
 b=ErM9F2iwYIT4I5Wc99hl/3FeC3hQTqGEZZYKxHbe870Iyn6HivIDKLhWoQZb/XMu7M
 HsmmJ4I/dtEZtWkVLe/tAMkU6HQ4I42RWB5Se/TZQUXCNGd179pOZiQ9FRSqXKyLKqfW
 eZpXQnerd9kx88wLIp/SOLQ6F5XdXgCAmoqIVoLhLnopOeLCvmOg9Qmj+JiACikFbReA
 qPO2i9NMTcFjStxEJC/aveHuJO/yO27BbTDdXctcA9goIH8ZeA7IigeAy5jxIjN+mENh
 ueYLKtB1helOX5/ksEgRdWDiy7GjBM3pb9igtwDSMLNaMVzy1InDc5+TCIiAtRm35Kfg
 FsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882551; x=1690474551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvgukf2r/kz3Y+kIcG+gDWEsWDEFvjX8X24ODyGYeGY=;
 b=X6UUw4YrOqmu1zOz17d0ftnysn14yteESrA+qBiFqepjiyRp99Ens8DsooblTn1IlK
 8HnoajCbCaAvnXeSN1xbkxdDmBbF7YsfoDJYzdqX37qrZNygAbSC7MlHOHd3/JXhIXAc
 7I2QIlXARCmtIiyKiNetrOZhN5x3Fiyt4yA71rhCVOwPkSKx9ZKXwRdejDGek1o2pBNS
 rmF2gE2fbGxzQLWP3erMYRTZjv6SXrg/z9mLkqY6PtKacA7sEM+oA3aMs6otcdWdHaOd
 8szjWoUAcGOCSBwzS4DBEZl7cwf+Pp8u3qyAQ7h184rudZ8saMi9UD5QapfWhMfDZwGT
 HYQg==
X-Gm-Message-State: AC+VfDzfnytzaTYub4+YkqzE0rrp8n4/cxFpUMErY9x8mj31QMI+YUAY
 jpLpKy/xt/U7DzgVvaj3Y9dk9A==
X-Google-Smtp-Source: ACHHUZ4Fn4K+L5jQAlbc6d8zmu2TjY55wT3xFYSP9PrmwCZIQwuiB/OKAOkZIO5vssO9LKtBf2vH+w==
X-Received: by 2002:a19:c206:0:b0:4fa:3a0:2257 with SMTP id
 l6-20020a19c206000000b004fa03a02257mr5139619lfc.5.1687882551301; 
 Tue, 27 Jun 2023 09:15:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a05600c364c00b003f7f249e7dfsm14308607wmq.4.2023.06.27.09.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3AAB01FFC6;
 Tue, 27 Jun 2023 17:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 28/36] gdbstub: clean-up vcont handling to avoid goto
Date: Tue, 27 Jun 2023 17:09:35 +0100
Message-Id: <20230627160943.2956928-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

We can handle all the error exit cases by using g_autofree() for the
one thing that needs cleaning up on the exit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9496d7b175..49143c7d83 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -573,7 +573,6 @@ static int gdb_handle_vcont(const char *p)
 {
     int res, signal = 0;
     char cur_action;
-    char *newstates;
     unsigned long tmp;
     uint32_t pid, tid;
     GDBProcess *process;
@@ -581,7 +580,7 @@ static int gdb_handle_vcont(const char *p)
     GDBThreadIdKind kind;
     unsigned int max_cpus = gdb_get_max_cpus();
     /* uninitialised CPUs stay 0 */
-    newstates = g_new0(char, max_cpus);
+    g_autofree char *newstates = g_new0(char, max_cpus);
 
     /* mark valid CPUs with 1 */
     CPU_FOREACH(cpu) {
@@ -597,8 +596,7 @@ static int gdb_handle_vcont(const char *p)
     res = 0;
     while (*p) {
         if (*p++ != ';') {
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         cur_action = *p++;
@@ -606,13 +604,12 @@ static int gdb_handle_vcont(const char *p)
             cur_action = qemu_tolower(cur_action);
             res = qemu_strtoul(p, &p, 16, &tmp);
             if (res) {
-                goto out;
+                return res;
             }
             signal = gdb_signal_to_target(tmp);
         } else if (cur_action != 'c' && cur_action != 's') {
             /* unknown/invalid/unsupported command */
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         if (*p == '\0' || *p == ';') {
@@ -625,14 +622,12 @@ static int gdb_handle_vcont(const char *p)
         } else if (*p++ == ':') {
             kind = read_thread_id(p, &p, &pid, &tid);
         } else {
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         switch (kind) {
         case GDB_READ_THREAD_ERR:
-            res = -EINVAL;
-            goto out;
+            return -EINVAL;
 
         case GDB_ALL_PROCESSES:
             cpu = gdb_first_attached_cpu();
@@ -649,8 +644,7 @@ static int gdb_handle_vcont(const char *p)
             process = gdb_get_process(pid);
 
             if (!process->attached) {
-                res = -EINVAL;
-                goto out;
+                return -EINVAL;
             }
 
             cpu = get_first_cpu_in_process(process);
@@ -668,8 +662,7 @@ static int gdb_handle_vcont(const char *p)
 
             /* invalid CPU/thread specified */
             if (!cpu) {
-                res = -EINVAL;
-                goto out;
+                return -EINVAL;
             }
 
             /* only use if no previous match occourred */
@@ -679,12 +672,9 @@ static int gdb_handle_vcont(const char *p)
             break;
         }
     }
+
     gdbserver_state.signal = signal;
     gdb_continue_partial(newstates);
-
-out:
-    g_free(newstates);
-
     return res;
 }
 
-- 
2.39.2


