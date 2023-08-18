Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6B7804D6
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJG-0003lt-3D; Thu, 17 Aug 2023 23:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJE-0003hZ-8v
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJB-00065n-Ra
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-688779ffc0aso404329b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329876; x=1692934676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OY7HRBFAZboaxxDdEUdUwlvHSDXXinOq0T6JoRQL0io=;
 b=32rAx3o8OL324gpvQKaNchgOFHnoXAR+w3vPxbgHc893JO03+LceIo8bYYxjwSXO+I
 t8sI5d4+e0229oaYQl7OjbYpVfn+0z/2E5vCoubntUAdUuTAF2pMxCGRqscP5MI6ZrQd
 GF9YxUvyHX6hU+OiY1D0d0KHi243C4+yrzYnZYw/OAiD+PdOGikTIz4W902ml6aVay6K
 OgLXLw2+Vld94Kjurk8hchn/e2n1AeCQwoskXM2tkRVkmuGNhfeWKNl8eC5FBwA45729
 Ib7AW57yiHFDQt6rq3fa4U76lPC4sIwKi0YM9QnvZRQECnwQtQLcs3W59Su2B9+mOaRt
 wwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329876; x=1692934676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OY7HRBFAZboaxxDdEUdUwlvHSDXXinOq0T6JoRQL0io=;
 b=fGBEuQc6b76uhaLAHHEbuZi1r34nR52UAPHEBK4E0I+msjzKJOI5/hek/UP09T8kNG
 BP99MQxMbhM7y1ylK7mGBYdkQZISBj45yc6tgV6CfgrOOLo7VHJSsZTB6/2bJla3fVv5
 zowB8io/sQmJcqwaL6a1D4uvhWgkH084wENsbaI0xIOXjzfHonR4ltv+eHlaVN9G6XGC
 35P/RcdlkkANdekZx5Rjjgon63HD8eDD39LqcV3G9Aaw8nLd3+L/4fdpz6uY2VdAkoTi
 LbdltBo80V94ZTTcsI8IBtpoedfTOKz8KTMyGm7cZh/WSsAMvqu1xYaho5nzF0MQzXMp
 S6Dw==
X-Gm-Message-State: AOJu0YwKIGD/AprDV8CsC53dKfUWBzPFY2aiXTyi3whmaA46JTtF5uoa
 0jQKBFPhSBjfnVflW5eskli0fH9TooPcfFfzDls=
X-Google-Smtp-Source: AGHT+IGeCEx+EQAxvCg5l1bklH8UMDveaXUzftlMXpDUbqG7PUqPRk5dhwPi9v8vgb+uefiRNfDRyQ==
X-Received: by 2002:a05:6a20:8f22:b0:13c:9317:ad78 with SMTP id
 b34-20020a056a208f2200b0013c9317ad78mr2057561pzk.46.1692329876720; 
 Thu, 17 Aug 2023 20:37:56 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 20/26] gdbstub: Remove gdb_has_xml variable
Date: Fri, 18 Aug 2023 12:36:39 +0900
Message-ID: <20230818033648.8326-21-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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
index f3f2c40b1a..5cba2933d2 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -61,14 +61,6 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
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
index e52a739491..55819f4aba 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -74,8 +74,6 @@ void gdb_init_gdbserver_state(void)
     gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
 }
 
-bool gdb_has_xml;
-
 /* writes 2*len+1 bytes in buf */
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len)
 {
@@ -1121,11 +1119,6 @@ static void handle_set_reg(GArray *params, void *user_ctx)
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
@@ -1142,11 +1135,6 @@ static void handle_get_reg(GArray *params, void *user_ctx)
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
@@ -1609,7 +1597,6 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
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
2.41.0


