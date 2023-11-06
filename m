Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744237E1F4A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:05:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxPI-0006aL-Ak; Mon, 06 Nov 2023 06:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxP5-0006Ir-IW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:27 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxOs-0003if-Dj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:19 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso2661117f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268647; x=1699873447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=th3yfEu9dsqZLmfk3I95d9IkQeEp24N2k4ODPshVYkY=;
 b=C3qkbzKHqKUp/q4CUgwwYnzNK8GmiuJJTQTYaoQ39Nk3RCg/Y4jsM7Bx3MjCxMZhx8
 /caCjzgDW403J9uBXQXQOzBgKpt0PWTLxmZydvhNSBglbdlZ85S/h73ZO6unbJcC4qYL
 jKopi56eaxG2EORedykf5TVdzGeHILjSCz/X1MKkCcp1yuXX2+lMe8Uofw3zEXFf2BvA
 fyeq0vuq6637lm59BRlhfeobpX6/V/oS5UCSFGHS8LaZ8Olv+swqDNNiUrEebmchQkiH
 73YGL8x6peeAYPpmTp93T9bdaEiiVO+AeYXejDrJn5a5Xjou9V1oOjEf9RJLw1E7Qbsv
 qOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268647; x=1699873447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=th3yfEu9dsqZLmfk3I95d9IkQeEp24N2k4ODPshVYkY=;
 b=Tx+sRlLkKV5KZLkZdtK3DUlKZq4c2FoQA4ddaLdI6rynJvJLWtApWhOL+0XGv+NLWZ
 0UEmbyYbgrcsUKn7GGBFutCO73iE61Yfyk5ZT2CYZvW3kqvlgu+RqSCdCHNkfsjwcbEv
 zVoMWBb0UfWVjKn8gl/SgqjpPZ6DWripk4GOR4tKsxlE4vAe07722ou3iWQfFACo47+X
 QUuqxwN9u0f5wBbh0YJJ2PxpRWbnut39DP++LhKBKEf8cDIAUtn2JTRg6n8EBHOSSpvb
 ksT79hvB1e4xpDAplebj7dlJDTNubVka4JY+lCsarDaE6eQWThLSbxr01sX6051t4dJn
 REKw==
X-Gm-Message-State: AOJu0YxddJNF8MMcSMW4JMl8QoJ6OuB1LiEejfegpYR/kXDl5X4n+1zJ
 w/11aP5KVDhDL+uh8e/RZw06b+pc7D4VUnE0dmE=
X-Google-Smtp-Source: AGHT+IHAXSkBUxdCa+OOuf1KcH7iclZXA5c2IEfRwgd7qngftXdgZjVXH3qTMwMRLHD15LdpD+DqZg==
X-Received: by 2002:adf:fd82:0:b0:32d:9a87:b7a with SMTP id
 d2-20020adffd82000000b0032d9a870b7amr17402964wrr.50.1699268646998; 
 Mon, 06 Nov 2023 03:04:06 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a5d6e8d000000b003196b1bb528sm9094731wrz.64.2023.11.06.03.04.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:04:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/60] tests/unit/test-seccomp: Remove mentions of softmmu in
 test names
Date: Mon,  6 Nov 2023 12:02:36 +0100
Message-ID: <20231106110336.358-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Wether we are using a software MMU or not is irrelevant for the
seccomp facility. The facility is restricted to system emulation,
but such detail isn't really helpful, so directly drop the
'softmmu' mention from the test names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231002145104.52193-3-philmd@linaro.org>
---
 tests/unit/test-seccomp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/unit/test-seccomp.c b/tests/unit/test-seccomp.c
index f02c79cafd..bab93fd6da 100644
--- a/tests/unit/test-seccomp.c
+++ b/tests/unit/test-seccomp.c
@@ -229,26 +229,26 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     if (can_play_with_seccomp()) {
 #ifdef SYS_fork
-        g_test_add_func("/softmmu/seccomp/sys-fork/on",
+        g_test_add_func("/seccomp/sys-fork/on",
                         test_seccomp_sys_fork_on);
-        g_test_add_func("/softmmu/seccomp/sys-fork/on-nospawn",
+        g_test_add_func("/seccomp/sys-fork/on-nospawn",
                         test_seccomp_sys_fork_on_nospawn);
-        g_test_add_func("/softmmu/seccomp/sys-fork/off",
+        g_test_add_func("/seccomp/sys-fork/off",
                         test_seccomp_sys_fork_off);
 #endif
 
-        g_test_add_func("/softmmu/seccomp/fork/on",
+        g_test_add_func("/seccomp/fork/on",
                         test_seccomp_fork_on);
-        g_test_add_func("/softmmu/seccomp/fork/on-nospawn",
+        g_test_add_func("/seccomp/fork/on-nospawn",
                         test_seccomp_fork_on_nospawn);
-        g_test_add_func("/softmmu/seccomp/fork/off",
+        g_test_add_func("/seccomp/fork/off",
                         test_seccomp_fork_off);
 
-        g_test_add_func("/softmmu/seccomp/thread/on",
+        g_test_add_func("/seccomp/thread/on",
                         test_seccomp_thread_on);
-        g_test_add_func("/softmmu/seccomp/thread/on-nospawn",
+        g_test_add_func("/seccomp/thread/on-nospawn",
                         test_seccomp_thread_on_nospawn);
-        g_test_add_func("/softmmu/seccomp/thread/off",
+        g_test_add_func("/seccomp/thread/off",
                         test_seccomp_thread_off);
 
         if (doit_sched() == 0) {
@@ -256,11 +256,11 @@ int main(int argc, char **argv)
              * musl doesn't impl sched_setscheduler, hence
              * we check above if it works first
              */
-            g_test_add_func("/softmmu/seccomp/sched/on",
+            g_test_add_func("/seccomp/sched/on",
                             test_seccomp_sched_on);
-            g_test_add_func("/softmmu/seccomp/sched/on-nores",
+            g_test_add_func("/seccomp/sched/on-nores",
                             test_seccomp_sched_on_nores);
-            g_test_add_func("/softmmu/seccomp/sched/off",
+            g_test_add_func("/seccomp/sched/off",
                             test_seccomp_sched_off);
         }
     }
-- 
2.41.0


