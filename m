Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40377BE24
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVaUF-0000X3-H7; Mon, 14 Aug 2023 12:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaUA-0000Wo-Mh
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:32:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaU8-00051J-LY
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:32:06 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc7e65ea44so30439135ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692030723; x=1692635523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cfGugDGU5ubW9njTN7eY8oAlg1UghZNc5pQEAohzDA=;
 b=Wy0bLsAeR7eYKALpOtaVoF1q9QcrGnjTEcXg85QQt+BSEXqcRs5m9b4NakzVS/oZXL
 jz1+9Wd7QVm00WMpZL6uzsD39EwFes+JFLlf3yaQD1DHZuCc0YAJVK7aGCA2vwvABNWt
 XWhYCN9bORtcA5fmWf38wb6W3ROgEUSPTYOrjb+gGd8yIlp6N2Ou9GLHepQ3AUiyQrjN
 GPW9h1I2Lg/6GsMZnm9g0MHezeOZgVTGfQx2DiRCKADKZbo87tQCmlIiDvK9Y96PzVRe
 C3j8PDLnkgMnC0S6/9qEoTWsq+ncr5mwHaw+I59WCBzYpN3bvlMDmIo84YSyaADJIWXf
 UEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692030723; x=1692635523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cfGugDGU5ubW9njTN7eY8oAlg1UghZNc5pQEAohzDA=;
 b=ZdGPdueSaWh4EmMxEk3Guyjl/Pq/yUexP2JLSr2mzdpvfMbPCPNzZUUeyv+UOlccdH
 IgJ1jQJ8RLjFzXeo1wYrw5pqHYTbnhMKieCfUshHC6q7hppcpQupCZfRkc9nQFf0vQdx
 BvlSnkmhnEwNg0HO7MD+Kqc8yuFOeCkvmDjnnczwMIs/t12G1JcZ3ROiOLAx08ZzUz64
 7yfd9TCfRfGrUWGfeae6EATQXrNLMh2urxcS/WYko33Q17KfEWRK/RR56PKU1vOSTber
 DyEiYfztyGTzOEezrpS1+g+KNdg+z0T7JrlE1fu4tUDyBnQahOYbLol6bE82NJC4MAAk
 SjBg==
X-Gm-Message-State: AOJu0YwTJUTfpLxjn/ZExUVJKtT71a7z4z2aQpyjr/A+FGRizUZUlh0k
 pN3ucza8vRuoetTVjlHt7aWQ67O9NOA=
X-Google-Smtp-Source: AGHT+IF2zrjeTAtRN2V1i1rCdYAsGwFiDNoimSas7qPMIg9PClxgue6WJljUGcI4/DoYJYN2G1b9OQ==
X-Received: by 2002:a17:902:c409:b0:1ae:6947:e63b with SMTP id
 k9-20020a170902c40900b001ae6947e63bmr16574012plk.16.1692030722880; 
 Mon, 14 Aug 2023 09:32:02 -0700 (PDT)
Received: from wheely.local0.net ([61.68.161.249])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001b8a3a0c928sm9613263plc.181.2023.08.14.09.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 09:32:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 4/4] replay: simple auto-snapshot mode for record
Date: Tue, 15 Aug 2023 02:31:35 +1000
Message-Id: <20230814163135.187882-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814163135.187882-1-npiggin@gmail.com>
References: <20230814163135.187882-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

record makes an initial snapshot when the machine is created, to enable
reverse-debugging. Often the issue being debugged appears near the end of
the trace, so it is important for performance to keep snapshots close to
the end.

This implements a periodic snapshot mode that keeps a rolling set of
recent snapshots.

Arguably this should be done by the debugger or a program that talks to
QMP, but for setting up simple scenarios and tests, it is convenient to
have this feature.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/system/replay.rst   |  5 ++++
 include/sysemu/replay.h  | 11 ++++++++
 qemu-options.hx          |  9 +++++--
 replay/replay-snapshot.c | 57 ++++++++++++++++++++++++++++++++++++++++
 replay/replay.c          | 25 ++++++++++++++++++
 softmmu/vl.c             |  9 +++++++
 6 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/docs/system/replay.rst b/docs/system/replay.rst
index 3105327423..bef9ea4171 100644
--- a/docs/system/replay.rst
+++ b/docs/system/replay.rst
@@ -156,6 +156,11 @@ for storing VM snapshots. Here is the example of the command line for this:
 ``empty.qcow2`` drive does not connected to any virtual block device and used
 for VM snapshots only.
 
+``rrsnapmode`` can be used to select just an initial snapshot or periodic
+snapshots, with ``rrsnapcount`` specifying the number of periodic snapshots
+to maintain, and ``rrsnaptime`` the amount of run time in seconds between
+periodic snapshots.
+
 .. _network-label:
 
 Network devices
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 08aae5869f..a83e54afc6 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -45,6 +45,17 @@ typedef enum ReplayCheckpoint ReplayCheckpoint;
 
 typedef struct ReplayNetState ReplayNetState;
 
+enum ReplaySnapshotMode {
+    REPLAY_SNAPSHOT_MODE_INITIAL,
+    REPLAY_SNAPSHOT_MODE_PERIODIC,
+};
+typedef enum ReplaySnapshotMode ReplaySnapshotMode;
+
+extern ReplaySnapshotMode replay_snapshot_mode;
+
+extern uint64_t replay_snapshot_periodic_delay;
+extern int replay_snapshot_periodic_nr_keep;
+
 /* Name of the initial VM snapshot */
 extern char *replay_snapshot;
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 29b98c3d4c..0dce93eeab 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4530,13 +4530,13 @@ SRST
 ERST
 
 DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
-    "-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=<filename>[,rrsnapshot=<snapshot>]]\n" \
+    "-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=<filename>[,rrsnapshot=<snapshot>][,rrsnapmode=initial|periodic][,rrsnaptime=secs][,rrsnapcount=N]\n" \
     "                enable virtual instruction counter with 2^N clock ticks per\n" \
     "                instruction, enable aligning the host and virtual clocks\n" \
     "                or disable real time cpu sleeping, and optionally enable\n" \
     "                record-and-replay mode\n", QEMU_ARCH_ALL)
 SRST
-``-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=filename[,rrsnapshot=snapshot]]``
+``-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=filename[,rrsnapshot=snapshot][,rrsnapmode=initial|periodic][,rrsnaptime=secs][,rrsnapcount=N]]``
     Enable virtual instruction counter. The virtual cpu will execute one
     instruction every 2^N ns of virtual time. If ``auto`` is specified
     then the virtual cpu speed will be automatically adjusted to keep
@@ -4578,6 +4578,11 @@ SRST
     name. In record mode, a new VM snapshot with the given name is created
     at the start of execution recording. In replay mode this option
     specifies the snapshot name used to load the initial VM state.
+    ``rrsnapmode=periodic`` will additionally cause a periodic snapshot to
+    be created after ``rrsnaptime=secs`` seconds of real runtime. The last
+    ``rrsnapcount=N`` periodic snapshots (not including the initial) will
+    be kept (0 for infinite). Periodic snapshots are useful to speed
+    reverse debugging operations near the end of the recorded trace.
 ERST
 
 DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 10a7cf7992..38eac61c43 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -69,6 +69,53 @@ void replay_vmstate_register(void)
     vmstate_register(NULL, 0, &vmstate_replay, &replay_state);
 }
 
+static QEMUTimer *replay_snapshot_timer;
+static int replay_snapshot_count;
+
+static void replay_snapshot_timer_cb(void *opaque)
+{
+    Error *err = NULL;
+    char *name;
+
+    if (!replay_can_snapshot()) {
+        /* Try again soon */
+        timer_mod(replay_snapshot_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                  replay_snapshot_periodic_delay / 10);
+        return;
+    }
+
+    name = g_strdup_printf("%s-%d", replay_snapshot, replay_snapshot_count);
+    if (!save_snapshot(name,
+                       true, NULL, false, NULL, &err)) {
+        error_report_err(err);
+        error_report("Could not create periodic snapshot "
+                     "for icount record, disabling");
+        g_free(name);
+        return;
+    }
+    g_free(name);
+    replay_snapshot_count++;
+
+    if (replay_snapshot_periodic_nr_keep >= 1 &&
+        replay_snapshot_count > replay_snapshot_periodic_nr_keep) {
+        int del_nr;
+
+        del_nr = replay_snapshot_count - replay_snapshot_periodic_nr_keep - 1;
+        name = g_strdup_printf("%s-%d", replay_snapshot, del_nr);
+        if (!delete_snapshot(name, false, NULL, &err)) {
+            error_report_err(err);
+            error_report("Could not delete periodic snapshot "
+                         "for icount record");
+        }
+        g_free(name);
+    }
+
+    timer_mod(replay_snapshot_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+              replay_snapshot_periodic_delay);
+}
+
 void replay_vmstate_init(void)
 {
     Error *err = NULL;
@@ -81,6 +128,16 @@ void replay_vmstate_init(void)
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
+
+            if (replay_snapshot_mode == REPLAY_SNAPSHOT_MODE_PERIODIC) {
+                replay_snapshot_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                                     replay_snapshot_timer_cb,
+                                                     NULL);
+                timer_mod(replay_snapshot_timer,
+                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                          replay_snapshot_periodic_delay);
+            }
+
         } else if (replay_mode == REPLAY_MODE_PLAY) {
             if (!load_snapshot(replay_snapshot, NULL, false, NULL, &err)) {
                 error_report_err(err);
diff --git a/replay/replay.c b/replay/replay.c
index e64f71209a..fa5930700d 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -29,6 +29,10 @@
 ReplayMode replay_mode = REPLAY_MODE_NONE;
 char *replay_snapshot;
 
+ReplaySnapshotMode replay_snapshot_mode;
+uint64_t replay_snapshot_periodic_delay;
+int replay_snapshot_periodic_nr_keep;
+
 /* Name of replay file  */
 static char *replay_filename;
 ReplayState replay_state;
@@ -313,6 +317,27 @@ void replay_configure(QemuOpts *opts)
     }
 
     replay_snapshot = g_strdup(qemu_opt_get(opts, "rrsnapshot"));
+    if (replay_snapshot && mode == REPLAY_MODE_RECORD) {
+        const char *snapmode;
+
+        snapmode = qemu_opt_get(opts, "rrsnapmode");
+        if (!snapmode || !strcmp(snapmode, "initial")) {
+            replay_snapshot_mode = REPLAY_SNAPSHOT_MODE_INITIAL;
+        } else if (!strcmp(snapmode, "periodic")) {
+            replay_snapshot_mode = REPLAY_SNAPSHOT_MODE_PERIODIC;
+        } else {
+            error_report("Invalid rrsnapmode option: %s", snapmode);
+            exit(1);
+        }
+
+        /* Default 10 host seconds of machine runtime per snapshot. */
+        replay_snapshot_periodic_delay =
+                           qemu_opt_get_number(opts, "rrsnaptime", 10) * 1000;
+
+        /* Default 2, to cover at least the last 10 host seconds of runtime. */
+        replay_snapshot_periodic_nr_keep =
+                           qemu_opt_get_number(opts, "rrsnapcount", 2);
+    }
     replay_vmstate_register();
     replay_enable(fname, mode);
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..e032eb45e8 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -446,6 +446,15 @@ static QemuOptsList qemu_icount_opts = {
         }, {
             .name = "rrsnapshot",
             .type = QEMU_OPT_STRING,
+        }, {
+            .name = "rrsnapmode",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "rrsnaptime",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "rrsnapcount",
+            .type = QEMU_OPT_NUMBER,
         },
         { /* end of list */ }
     },
-- 
2.40.1


