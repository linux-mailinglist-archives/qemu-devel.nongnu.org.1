Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A5D790AC6
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 06:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcem9-0002IB-H7; Sun, 03 Sep 2023 00:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcem0-0002Ep-RP
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:45 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcely-00070G-BH
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:44 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-56c2e840e70so268747a12.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 21:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693715501; x=1694320301;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEpkefa+vwrcbEzUpVuiGVWFL+7pW2dZSw9F43I190M=;
 b=piHSXw+43F7E7TGvLNqsL84Tg8UAHzpuxPzUuyBQSAPvdXkj1AbZf55qxtQwqCcM1z
 nB1QODNUHV86by+FPyPulWdQsYwnbEswq+PKbGQzsvg+b+hjFEsXEQb96WbGyLR13h8g
 Jz+vNt9u7CrUjbBsAkb5Yba8ruhDz9APRg/PiVqSVUWXj0YTbzqplhoCa3NT8VJq+hGA
 y49j7mYtV8eHWYjMh/KiEWKiLGJrsq79as31PfGXqEJ8pCCuXtMFzw52SeC/HMwB7bPa
 ZYaJXuVKA/SLIaa36aNpg/CUgLl4x36un5ATbHBYkzZFkh01CGMjNffM+gQ7uG/goAKm
 Ch2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693715501; x=1694320301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEpkefa+vwrcbEzUpVuiGVWFL+7pW2dZSw9F43I190M=;
 b=JTGxcsK2QuCOmmJYraWVcz3Pc5iXE+7NuavYWWpHaWC7JKT4n7omPfSfHZ1RQeLlkN
 t2nPZ0cudc69UjCq/dUJGYh6yH1TFhFbyC5tVguGQy03f/JwzUE5hQHIlsPTtT7ZjnC7
 a9l48mBj24ILSRtyWxj2dMyASD8/qecH4K9AaZaleoJ39ZT5Twg/4bXXWLvScfeD4lJG
 mNrk/5gGaPmR0Vwc1aoU9cZv/O2A1Q/MGLDo6evMBvZUjThCmPhBTnhe5YN+VTSdkPE4
 CV9JTEmajwVEXk4dcRfyEBl2laEcR1KdZeMSexPlqjunTmfvVfFoQot5MrzDylC+aayC
 Nv5Q==
X-Gm-Message-State: AOJu0YxRnUN4/EXoam6gavqQDvvvR5Z0HErxlAWeSe1bgD08PcTRPeqL
 J6o1gAGHRip0Sfzhv5QhBzwLrw==
X-Google-Smtp-Source: AGHT+IGgh+1VfKLQaHmCsegaxJ/N/F1rIFb0Lzv4WKdJJBl902/x/DzzoZawowmQ7cAg86Skg0i2QA==
X-Received: by 2002:a17:902:d3d5:b0:1b6:c229:c350 with SMTP id
 w21-20020a170902d3d500b001b6c229c350mr7414253plb.18.1693715501143; 
 Sat, 02 Sep 2023 21:31:41 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bb9f104328sm5295792plb.146.2023.09.02.21.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 21:31:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] gdbstub: Remove gdb_has_xml variable
Date: Sun,  3 Sep 2023 13:30:18 +0900
Message-ID: <20230903043030.20708-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903043030.20708-1-akihiko.odaki@daynix.com>
References: <20230903043030.20708-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h |  8 --------
 gdbstub/gdbstub.c      | 13 -------------
 gdbstub/softmmu.c      |  1 -
 gdbstub/user.c         |  1 -
 4 files changed, 23 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 3f08093321..ecbc60a934 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -35,14 +35,6 @@ int gdbserver_start(const char *port_or_device);
 
 void gdb_set_stop_cpu(CPUState *cpu);
 
-/**
- * gdb_has_xml:
- * This is an ugly hack to cope with both new and old gdb.
- * If gdb sends qXfer:features:read then assume we're talking to a newish
- * gdb that understands target descriptions.
- */
-extern bool gdb_has_xml;
-
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 3f97dc66e5..61c811f42b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -75,8 +75,6 @@ void gdb_init_gdbserver_state(void)
     gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
 }
 
-bool gdb_has_xml;
-
 /* writes 2*len+1 bytes in buf */
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len)
 {
@@ -1054,11 +1052,6 @@ static void handle_set_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
-        gdb_put_packet("");
-        return;
-    }
-
     if (params->len != 2) {
         gdb_put_packet("E22");
         return;
@@ -1075,11 +1068,6 @@ static void handle_get_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
-        gdb_put_packet("");
-        return;
-    }
-
     if (!params->len) {
         gdb_put_packet("E14");
         return;
@@ -1542,7 +1530,6 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
         return;
     }
 
-    gdb_has_xml = true;
     p = get_param(params, 0)->data;
     xml = get_feature_xml(p, &p, process);
     if (!xml) {
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 5282324764..42645d2220 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -97,7 +97,6 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
 
         vm_stop(RUN_STATE_PAUSED);
         replay_gdb_attached();
-        gdb_has_xml = false;
         break;
     default:
         break;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 5b375be1d9..7ab6e5d975 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -198,7 +198,6 @@ static void gdb_accept_init(int fd)
     gdbserver_state.c_cpu = gdb_first_attached_cpu();
     gdbserver_state.g_cpu = gdbserver_state.c_cpu;
     gdbserver_user_state.fd = fd;
-    gdb_has_xml = false;
 }
 
 static bool gdb_accept_socket(int gdb_fd)
-- 
2.42.0


