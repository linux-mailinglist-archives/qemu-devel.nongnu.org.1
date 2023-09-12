Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EA79DC01
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4p-0002hE-Hr; Tue, 12 Sep 2023 18:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4n-0002gk-QM
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4l-0001Bd-Im
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c39bc0439bso2599215ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558502; x=1695163302;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pN7w6OyUOseMxgrm0jA21wfUfRH3D26uspX8jJXC++8=;
 b=Q60p8DG4JWoNgvGTyUdmUla3kipLyPwVruWYbGSdlmAeMcbmlxIUc3FfUiaFd13ADX
 FU1iKfXJo4akWyPb9UBOHT8ikNIimYNZA7VBQA59kqwR9fN2HCItxYkgUL0MOgRSkduJ
 zQxxAmp7KnnXb3Gw2SeGWkTPmNlgDPS7dXeNAZ2niiHiJmsRKj1R9hxJxfYX9FbJe/r2
 H0Pkwm33cpbodxXsB7p885dFM7HcUXSTzNnYrTjgpi1Vmc1XtxCRMX3bmsu0wc10UA0T
 NcJDnBtWY4hadc705ASzYm+oMvYc7fTu11zzq8lMtFh4WLYoY1sitX1RNUzOeCPE3HdL
 Agpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558502; x=1695163302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pN7w6OyUOseMxgrm0jA21wfUfRH3D26uspX8jJXC++8=;
 b=o4ClISXP2F7D+/54BIwnYZVv9qA/HidppbnaQLLHY0DdOm3OMoE/S2FPS8ylHATbge
 rBb97yfUAzx/BPszDNa2s2bUaQvtpf0ZsKjQ+rzQiPJYS3hP0sfUF8HNb1h0MmFZk7n1
 ATYy8sKC0Os5d3tIq5vLjWY57QADTJCnmoDZJiLe4tEI9WJFQ7wiks89KedtuKwQTLYo
 ysMS2SHcjtH7UNlEAEUWB+zrNrjQ0kv2uotqAhoLMLtt/LpWbwA7koKltUbgdlh2H9VC
 pNgWFRcx81CSIv/jq+BRDM4OqKz0rX9uVgrV9uILKWAfWhstwXbmhffQmHR+6C9kXzy9
 6heA==
X-Gm-Message-State: AOJu0Yw6fsqV6un4UvnUAYqXhZDmdKyYixApU4hl4ga/ygcZR9KJx6hb
 SXXFwSHjUng7XToQMMn7RABhLQ==
X-Google-Smtp-Source: AGHT+IGKyxNuIoxO+lAiXbOH/iH1tw5pO5jQBwiOW4+7PXjxTle7iHVk+KTyKhLNKHUOWFV4aZjxag==
X-Received: by 2002:a17:902:ea04:b0:1bd:d510:78fb with SMTP id
 s4-20020a170902ea0400b001bdd51078fbmr4740470plg.3.1694558502503; 
 Tue, 12 Sep 2023 15:41:42 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 11/12] gdbstub: Remove gdb_has_xml variable
Date: Wed, 13 Sep 2023 07:41:00 +0900
Message-ID: <20230912224107.29669-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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


