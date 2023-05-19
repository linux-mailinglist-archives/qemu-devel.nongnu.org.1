Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70372709D86
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03Xe-0002IP-Qp; Fri, 19 May 2023 13:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XR-0002CY-EB
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XI-0005Ur-H1
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f4271185daso34052855e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684515898; x=1687107898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CR/oWYkskBmS5+T6RF3T/y2a8OCs1JuDOn7YbNsQaig=;
 b=Ntkube46iK/SQXofhWnm3aYeLHicpuKXe2wRqdt1L5U2mtNuALzpy3teICPKEoGViV
 Ugs5l9LUOMQoegfVXA6IDaCW8G687yk32cRkS8r4U3lHif2ZRw2WS0K5DA3Ba5yneZih
 HtaUq7aQcIO1vjaXiZ+Xe38HedSPIJ77kT5naaOXDV2n98fSjXh5mcOlk1ukrsdTgiIF
 0uL+3hPFVOi747xqN9PzSiWbGDQ5quOx9h/8kewbiQqOGpsY9z7HpPFp9C2Uz+62XaQH
 j1aNCb8houjuqQq2t6Sic+PY+oHsmEZK+YLkVq77JNIgfHd72l6sMfdzIvTS+OwpU/W2
 kIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515898; x=1687107898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CR/oWYkskBmS5+T6RF3T/y2a8OCs1JuDOn7YbNsQaig=;
 b=YYASWQG6xV94oLVpXh9kNDnb/hhLagZzx038RfGDrmC8R81Cd7UKMuj1QMvtFYWbtE
 4ZsqvqzjGlh4L1T65np7CFq7k/iyzXV5kduvwCEXefTXXv71Q7EpxOfdFdW8zZY3ngr0
 iMBznVcPSpZ0vVPne/64SpSOmpKHcfE+ZE0bg3PNjBvMIS3ZNY++bbuEbF1ejR3j7wvr
 9KouzGMSR0VXalpaI1PgnewxhMz7AO1hUN0agd7UIslIWyLzHCZzIJvo3l/Tb5pJ79PB
 A/51ms6SiS3JUU47ERYcAnZ4y5SX6VAE24cx9y0h3bwGEWqYjZVMI92Dar8MwII5heLy
 aqVA==
X-Gm-Message-State: AC+VfDxSg1ju6wxwrQAi2rg87cqS8SXrLmNKL4+Evp3Ks28MFKEf1BXv
 uK10o68dQurQcMzaL7yXV+v0aA==
X-Google-Smtp-Source: ACHHUZ4iXNgH6avS1EFDStKadWpq4otGGfrS004ap8PuzUPeqYmhs5cmg8Y//xIYnop7Sk8tq8j9gQ==
X-Received: by 2002:a05:600c:245:b0:3f5:4e1:2a89 with SMTP id
 5-20020a05600c024500b003f504e12a89mr1874830wmj.34.1684515898115; 
 Fri, 19 May 2023 10:04:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f182a10106sm2979974wmd.8.2023.05.19.10.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 10:04:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 656491FFC0;
 Fri, 19 May 2023 18:04:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [RFC PATCH 5/8] qtest: use cpu interface in qtest_clock_warp
Date: Fri, 19 May 2023 18:04:51 +0100
Message-Id: <20230519170454.2353945-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519170454.2353945-1-alex.bennee@linaro.org>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

This generalises the qtest_clock_warp code to use the AccelOps
handlers for updating its own sense of time. This will make the next
patch which moves the warp code closer to pure code motion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/qtest.h | 1 +
 accel/qtest/qtest.c    | 1 +
 softmmu/qtest.c        | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 85f05b0e46..e1f69783d6 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -35,5 +35,6 @@ void qtest_server_set_send_handler(void (*send)(void *, const char *),
 void qtest_server_inproc_recv(void *opaque, const char *buf);
 
 int64_t qtest_get_virtual_clock(void);
+void qtest_set_virtual_clock(int64_t count);
 
 #endif
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index f6056ac836..53182e6c2a 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -52,6 +52,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, void *data)
 
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
     ops->get_virtual_clock = qtest_get_virtual_clock;
+    ops->set_virtual_clock = qtest_set_virtual_clock;
 };
 
 static const TypeInfo qtest_accel_ops_type = {
diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index f8d764b719..34bc9e1f49 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -331,14 +331,14 @@ int64_t qtest_get_virtual_clock(void)
     return qatomic_read_i64(&qtest_clock_counter);
 }
 
-static void qtest_set_virtual_clock(int64_t count)
+void qtest_set_virtual_clock(int64_t count)
 {
     qatomic_set_i64(&qtest_clock_counter, count);
 }
 
 static void qtest_clock_warp(int64_t dest)
 {
-    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t clock = cpus_get_virtual_clock();
     AioContext *aio_context;
     assert(qtest_enabled());
     aio_context = qemu_get_aio_context();
@@ -347,7 +347,7 @@ static void qtest_clock_warp(int64_t dest)
                                                       QEMU_TIMER_ATTR_ALL);
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
-        qtest_set_virtual_clock(qtest_get_virtual_clock() + warp);
+        cpus_set_virtual_clock(cpus_get_virtual_clock() + warp);
 
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
-- 
2.39.2


