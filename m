Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67DE87866C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Mar 2024 18:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeL-0002WU-0W; Mon, 11 Mar 2024 13:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeI-0002Vm-TJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:18 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeH-0007M4-9F
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so4060141a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178874; x=1710783674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCWjPm6O2sZUf84fzY2+POh+rCGK8+L6glbo6RMshm0=;
 b=mB1n85aSaOXTnFSC2rk2VEp1vhGMlVEQKzYQnapI2fIIwyCbbGgjGmM7SAJe9ZNfdB
 79gCUlfEKFlSR3K1XRcaqRv9mhG3NV15mwGutDtVQ52MlSnNjKGcg6uy+VRo/hRf6cG8
 xNbLN0rexiZXkzJQpc/On1lZcwZrxyqme7NwkFaRwlGHZSl+0k7lIjpH/70sXnLiRXpU
 MSgAbSLGyfTMSt7DX0iTFFpeJiEwXi9letief63QoR4pMJucpJNitqe57vOrBKGyJ22c
 r08U0rGOg+I+vi8T5pRcprZ71yPtq3ZH+tf2RMEF13KVAV5XDn0rhj8nTKsQEnU1Pn5y
 A+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178874; x=1710783674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCWjPm6O2sZUf84fzY2+POh+rCGK8+L6glbo6RMshm0=;
 b=ey9951eivi3iER6qegCGj7Cv2kbRls99uz9UyxTCYCqUW4ToXJZPJPXFuxnm0eIydF
 2EdYOGSRMNDt4vRFePBPjUK6EzIsxF8jDvZWecLSpCxejwtRQ8DZgDawb/olbLkj8q0e
 Y6INlzNWWRUD6gj6lt/TrLlYlBm2iNGiW9R3Z2gweRncZO4KyzSOB5quRP8bABkLGkbh
 qJVwt0pMT9DI7lNDiaugFDZOv+VnSbGaRbwF8h+jc9notFtIJ894HkzX6DRG4mmsNglS
 o2cJhnyTCuNNQOSeFfLfYyAasM4a36fZDa3x1H06T7+ujNkVHE8EjZqY3LT0fPtMVbb/
 bTEQ==
X-Gm-Message-State: AOJu0Yw2TXjo57zBckImK6hMkXzfWyQ4elIOFHlQchOAv3YU5OLpoQ50
 OxnTpV4G1Rdcrlj/wfdfpQzIQhE/UnB5AbglbpMexLL2hGlcXV3NSVF/TnviCQM=
X-Google-Smtp-Source: AGHT+IHQBGyuI0PNkFMEaTgllzTwa4TPWe5n+d7d1RG6Pyc/HDM56oFNYNpSexglzhk1h25RW0q5Cg==
X-Received: by 2002:a05:6a21:788f:b0:1a1:3ecb:5316 with SMTP id
 bf15-20020a056a21788f00b001a13ecb5316mr9034133pzc.0.1710178874472; 
 Mon, 11 Mar 2024 10:41:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 07/24] replay: Fix migration use of clock
Date: Tue, 12 Mar 2024 03:40:09 +1000
Message-ID: <20240311174026.2177152-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Migration reads host clocks when not holding the replay_mutex, which
asserts when recording a trace. It seems that these migration times
should be host times like other statistics in MigrationState. These
do not require the replay_mutex.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/migration.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a49fcd53ee..86093b34bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3405,7 +3405,7 @@ static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
     MigrationThread *thread = NULL;
-    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     MigThrError thr_error;
     bool urgent = false;
 
@@ -3457,7 +3457,7 @@ static void *migration_thread(void *opaque)
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
 
@@ -3536,7 +3536,7 @@ static void *bg_migration_thread(void *opaque)
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
-    setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     /*
      * We want to save vmstate for the moment when migration has been
      * initiated but also we want to save RAM content while VM is running.
@@ -3569,7 +3569,7 @@ static void *bg_migration_thread(void *opaque)
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
 
-- 
2.42.0


