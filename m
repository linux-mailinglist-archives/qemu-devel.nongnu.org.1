Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7655F7441F6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFId4-0005UD-Tv; Fri, 30 Jun 2023 14:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcg-0005Nu-WA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcd-0003Vy-P5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc244d3a8so16979615e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148810; x=1690740810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGpbXodwi7eOtwTW0EyiBhg0MRqzyOGDQJmw/dX1YZQ=;
 b=qbpC3mhDVEt4vOC/cNCfXQ7ApVvxwz2j4QDN9+L08kRZB1MAVF36ZMa2vz+RgFQOmc
 jQr1F9ew6n8s1hpS/1IvW14Lq6A50crqjZ8J9fZ/HQbk7zAI6zDHHewvo0KGqrOcbf7M
 U+rMtmSBT9pvCedeXNXwwZBhC9G9tQFg5de/PuaniMCXNDV4qyX1auqVbZVN4J0pyS80
 FZZGPcp/5tRZVpR6u8bajJ+w+MzRaXU96n2onSkusGFACAt+aOsFysxlvP7sMj+MB6Xs
 rkqVhhhjiQfuRn55ZdVmNs61mg6+0mqVoQwSikptmJLvPjAjAPlfQbn3YIeRYkvmokD6
 BB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148810; x=1690740810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGpbXodwi7eOtwTW0EyiBhg0MRqzyOGDQJmw/dX1YZQ=;
 b=BeiIdNd6pycDSET/fLWf6t/QLXlFUrd4Vs/PdRnDIY0P79f3RH4DbE9g7mcYJRS5Wg
 NbHCpKdYwph856kMoGyh0sIXCJQ8wD9PkkpRamKyO4ptvCJHo0Ti2GsUoqBBfz2q5ylK
 JeLiUZaBad6BmWtyCUxJ4nSzizhOryFtyt661temtRiY4413WgS52q042bCcn+ncoNfq
 jdtTwn4C27btrNSBnKSEW/neTKVwKSkzXwvzX4yNmdjzToxSQdVGo+T2v+v1P6P0fmxa
 BVwEddMxpCAtLMNTSc8jSAJJcgm1+C0+IHHdVTUtTeLvM8wLRzaLw8FlJR2cjDln9uF9
 s25w==
X-Gm-Message-State: AC+VfDy/QhiT1uLo5arpqsWH1yP3BS4KOHc1ofIhFwKC9aEQ+OwNDYR8
 eCtCty+PqhAPLcN1rgB11lArAQ==
X-Google-Smtp-Source: ACHHUZ5pgDNwLAxzlMTdGbpPPV7vp7TPZhfyGZY0tg7Z4QT6WooxjgY/DHKJqwK3WOQFPNXGZjNNOg==
X-Received: by 2002:a05:600c:286:b0:3fb:b6f3:e528 with SMTP id
 6-20020a05600c028600b003fbb6f3e528mr2747867wmk.25.1688148810147; 
 Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a7bc399000000b003fa96fe2bebsm14598535wmj.41.2023.06.30.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3742A1FFD1;
 Fri, 30 Jun 2023 19:04:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 28/38] gdbstub: lightly refactor connection to avoid
 snprintf
Date: Fri, 30 Jun 2023 19:04:13 +0100
Message-Id: <20230630180423.558337-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This may be a bit too much to avoid an snprintf and the slightly dodgy
assign to a const variable. But hopefully not.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix checkpatch warning
---
 gdbstub/softmmu.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 99d994e6bf..f509b7285d 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -332,11 +332,9 @@ static void create_processes(GDBState *s)
 
 int gdbserver_start(const char *device)
 {
-    trace_gdbstub_op_start(device);
-
-    char gdbstub_device_name[128];
     Chardev *chr = NULL;
     Chardev *mon_chr;
+    g_autoptr(GString) cs = g_string_new(device);
 
     if (!first_cpu) {
         error_report("gdbstub: meaningless to attach gdb to a "
@@ -350,15 +348,16 @@ int gdbserver_start(const char *device)
         return -1;
     }
 
-    if (!device) {
+    if (cs->len == 0) {
         return -1;
     }
-    if (strcmp(device, "none") != 0) {
-        if (strstart(device, "tcp:", NULL)) {
+
+    trace_gdbstub_op_start(cs->str);
+
+    if (g_strcmp0(cs->str, "none") != 0) {
+        if (g_str_has_prefix(cs->str, "tcp:")) {
             /* enforce required TCP attributes */
-            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
-                     "%s,wait=off,nodelay=on,server=on", device);
-            device = gdbstub_device_name;
+            g_string_append_printf(cs, ",wait=off,nodelay=on,server=on");
         }
 #ifndef _WIN32
         else if (strcmp(device, "stdio") == 0) {
@@ -373,7 +372,7 @@ int gdbserver_start(const char *device)
          * FIXME: it's a bit weird to allow using a mux chardev here
          * and implicitly setup a monitor. We may want to break this.
          */
-        chr = qemu_chr_new_noreplay("gdb", device, true, NULL);
+        chr = qemu_chr_new_noreplay("gdb", cs->str, true, NULL);
         if (!chr) {
             return -1;
         }
-- 
2.39.2


