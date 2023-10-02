Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3337B5576
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKGa-0004hq-Fr; Mon, 02 Oct 2023 10:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnKGY-0004fr-U1
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:51:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnKGX-0002j7-9k
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:51:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32799639a2aso1777265f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696258278; x=1696863078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8S39qzZ9AC0fGmB7PeI+z6F8myTw3Ni1jGr5MISvYF4=;
 b=CG830PvXx7eBclj7HJcXkhwRvidsQo8OGm0jlg5rvqLE7wWraSr6CGZ9GBcMKnEvZW
 AKqv2+DCMxoJoAaxiOw3wt0LG/v7beyvQ4aYj9tvkMU72Em68ImYGMiV1yx9ppZ9O9hs
 tY85nGNHaJiCOxU0l+mC84InajqJQ7z9wFwKjTPPG8kp5PG3Nov/8M+DltYT/8tDEFZA
 /KkNkNhde8e5Zd0JNHo9x8VU4aMEIUfU3aM8XEVXXfH1RM+36vznunmckhjDPRixVrd4
 EEG7qB/NSt1fG67ho5SBP/uQeQE+r6iiWEzQPQGZznyPdcczFb8z3AOKAI64jqCQsAwL
 XSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258278; x=1696863078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8S39qzZ9AC0fGmB7PeI+z6F8myTw3Ni1jGr5MISvYF4=;
 b=VOA/eBYC2NnoIs12sAPEZKaeE9n+8qRwdW3HgTA2pBFi3odvGqc/LfHB25Q821zr7R
 DuBZqvtegqeOcEfYyRgnxnmwF8MnFXirZzYJAtl/WbWmr+hv1ffkXxVtx6sSLlOKc2sj
 6JuypTmm5XLY9w0fzZFJs4nxcdhq13gPtQ/8zyNJZxjpW6hlSzIHAH0bOuDVOsUumxsz
 nZ/dZWQaCWshS06XEy9W6GaWNymMe5Z0c7T0V4/Ny3KqcJAHKQ+Z9mFKpsr6LNozZeZc
 kNjVTeeVZ2lpUgclB1nFrGpqYDvU68O3xYEVskynKakuWM7XIhSFfuaizcYhK8W7UQ9F
 2ByA==
X-Gm-Message-State: AOJu0YxWiiolmTQTqKrSpC1y43WH6Xi4je7hxgxbbxB2Y3peArM/1+Tx
 Gu8WyojK7h1a6SSidwWRvuiCv1RSBemjmE5aA+QtMQ==
X-Google-Smtp-Source: AGHT+IErXSuebXqaNepVVRGrLC9LF63GNBVcqgjVWi1fu1Um3zz2d5CNj3NzYJ+LXXLq+5wh8CrIog==
X-Received: by 2002:adf:fe42:0:b0:317:5747:b955 with SMTP id
 m2-20020adffe42000000b003175747b955mr10109226wrs.17.1696258278351; 
 Mon, 02 Oct 2023 07:51:18 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 d29-20020adfa41d000000b003197869bcd7sm23226580wra.13.2023.10.02.07.51.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:51:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] tests/unit/test-seccomp: Remove mentions of softmmu in
 test names
Date: Mon,  2 Oct 2023 16:51:04 +0200
Message-ID: <20231002145104.52193-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145104.52193-1-philmd@linaro.org>
References: <20231002145104.52193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Wether we are using a software MMU or not is irrelevant for the
seccomp facility. The facility is restricted to system emulation,
but such detail isn't really helpful, so directly drop the
'softmmu' mention from the test names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


