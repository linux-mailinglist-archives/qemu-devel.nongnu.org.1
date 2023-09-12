Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A479C768
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxMR-00013B-4z; Tue, 12 Sep 2023 02:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMI-0000p5-45
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMF-0007aK-QG
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:49 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-564b6276941so4072448a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501926; x=1695106726;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pN7w6OyUOseMxgrm0jA21wfUfRH3D26uspX8jJXC++8=;
 b=V/di7ZQzwZ6VlCbpoeLRglt/Y2thEM2CmZJc9GlfylVEozx9p8eNoMY01MhuLlhtxU
 4XfF8ec5nukWmdSnomimU34QuKDm6WdC/1rJwNOAAB+pdQqsfezfMTE7unGHTsWpEdL6
 SVRR5YosxddgGZb2m5E6+6A6YyTk1X2ZPHaI6/+J8uaVPqkhvIAclMNMuho/xYXds7uO
 5BQRM1cQIujUvQPTrO3FEBeGPPoprG33/gbi0o/Vs+ph6y0Wx0j/2dvK6PG45Tvabfp4
 XMmInA0NuN229Oa4kQ+Qd3mlrxCQIOrALsrEnxG7ipcxy1PDAR8pzJ57P1adwKs8+qoV
 KWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501926; x=1695106726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pN7w6OyUOseMxgrm0jA21wfUfRH3D26uspX8jJXC++8=;
 b=DGe7WEFRoZ4P2P/1TpcmKYHOIdrRzHhdWFo0tT4Ui9zJLPnYDpT+/zqlmJ/gejyztB
 ZAwkEtrezn0bu+5Rbxqx14fudraedvAcd4vpKBTST7pHqJelisUXUjEsb/pN51PdDZVe
 63n5pdM2YF9bZ/Fy0al6lkYHgUa1ZkOaLc3uOUbvRS0PDHOuW/BIDxuSnlmns3Dug3tt
 LJw57AhEaDUrenYlMFujH56zCGW06W1sOWenIrZHSP6b21DiBLVNyQwdctK3v+tgNFIn
 R9qe58RVw4nYZdBfZrLDeEPz9Mx3Reaajcq3vosInqBuACBhdXzwDzSkYSQ2+e2kxdbZ
 l/Cw==
X-Gm-Message-State: AOJu0YykFYL3RvjXdQuywn92/UC+KGS5d+DZOJEK7knAT8dckv37INzR
 wRObgcEddSqmqbGoRoM+djw7TA==
X-Google-Smtp-Source: AGHT+IGwECa4TMfyHURoPKAeqQiZd40WRnQmltCATfeIioh4Bn3UiIZnRadk+Zl5lfBhu3EVEBHvfw==
X-Received: by 2002:a17:90a:8b8b:b0:262:fe45:860b with SMTP id
 z11-20020a17090a8b8b00b00262fe45860bmr10921372pjn.0.1694501926407; 
 Mon, 11 Sep 2023 23:58:46 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/11] gdbstub: Remove gdb_has_xml variable
Date: Tue, 12 Sep 2023 15:58:05 +0900
Message-ID: <20230912065811.27796-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
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
 gdbstub/internals.h    |  2 --
 include/exec/gdbstub.h |  8 --------
 gdbstub/gdbstub.c      | 15 ---------------
 3 files changed, 25 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index fee243081f..7128c4aa85 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -32,8 +32,6 @@ enum {
 typedef struct GDBProcess {
     uint32_t pid;
     bool attached;
-
-    /* If gdb sends qXfer:features:read:target.xml this will be populated */
     char *target_xml;
 } GDBProcess;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 705be2c5d7..1a01c35f8e 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -45,14 +45,6 @@ int gdbserver_start(const char *port_or_device);
 
 void gdb_set_stop_cpu(CPUState *cpu);
 
-/**
- * gdb_has_xml() - report of gdb supports modern target descriptions
- *
- * This will report true if the gdb negotiated qXfer:features:read
- * target descriptions.
- */
-bool gdb_has_xml(void);
-
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index a4f2bf3723..177dce9ba2 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -349,11 +349,6 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
     }
 }
 
-bool gdb_has_xml(void)
-{
-    return !!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml;
-}
-
 static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
@@ -1086,11 +1081,6 @@ static void handle_set_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
-        gdb_put_packet("");
-        return;
-    }
-
     if (params->len != 2) {
         gdb_put_packet("E22");
         return;
@@ -1107,11 +1097,6 @@ static void handle_get_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
-        gdb_put_packet("");
-        return;
-    }
-
     if (!params->len) {
         gdb_put_packet("E14");
         return;
-- 
2.42.0


