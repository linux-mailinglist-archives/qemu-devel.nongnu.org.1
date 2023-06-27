Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A98377400E4
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:26:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBVw-0000EQ-7r; Tue, 27 Jun 2023 12:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBVs-0000DR-M4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:25:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBVm-0003Fm-Ph
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:25:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fa99b57a38so23469295e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687883149; x=1690475149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGpbXodwi7eOtwTW0EyiBhg0MRqzyOGDQJmw/dX1YZQ=;
 b=ieTW52GI71BV3KAPofg+uq4vLKo3S4DVx3GgaAW0rs34gp2xa/LYibg+ED7sd91+eS
 zbG2bG9NYQY67ztUI9veIeNj0u9uy0hXUlM7PsrKX+icuhcEog2OL/IMWvPUERvXn1Mb
 GWPFBNX+KeXI18tzU6WObzP2smE/gpJCVrC2FF5vSNm/8xie9iJg+IAG+4R+KfGORfpi
 8tnV6/Iv2ZoQVz3/sE1sFfKOfUf+/2e/Vu6jHknyFl2XOJ2eRVeXMCZLxWSHpANsce/K
 ilQR/ps0lGE4+omJPMXBs1j3FL8zmF0Y05QHultEjd1t4ht0ZXH3XzBZaVUNCfX1CN2S
 DFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883149; x=1690475149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGpbXodwi7eOtwTW0EyiBhg0MRqzyOGDQJmw/dX1YZQ=;
 b=Mx2poXAGUWDKEqiO2JJmzw3+zsnS4BI2RZVxzuz8dKVMCDHzJXsbvg+MnxpCMLwUdi
 pj8mX8psiPIG2TBN1Q7BjrLkRNxK09lPvQWQgJBrSSyPNmCZqScUqq0qpAj/evGcvbo+
 g3FJqaSRTBFUEXrx1IaQ1JNwn91DvhWBOZ8vS04TnXBA04pVi0l4RkmRLNxSaQJeEdjO
 6/QESfmWB1M31gEZpsJpW/8+CRPf0+a3VQT/9pBChMRsmvSzp0RErZ2d+2HId/cgEYC9
 30sxFCbp57MYZhp5gdx1GEJ6FGAaoHIaOlFNUDKJCDc45A8LNwa1Mo3sC0c3PjwA8q14
 hxbw==
X-Gm-Message-State: AC+VfDzgMsjkZx5dPrsQEA12M1gn03A5Y31Y49txFRhhJgJd/aG5TCM6
 42Pu/104Ml2fl6CV4q4gQY+LtQ==
X-Google-Smtp-Source: ACHHUZ7tt3ELO98JChBWdbSNkbvJ67m256SxNElt2CEIsMgMt0Sd8INtj+oNOOja4N2kQuDgvcXTGw==
X-Received: by 2002:a5d:538b:0:b0:30f:c42e:3299 with SMTP id
 d11-20020a5d538b000000b0030fc42e3299mr22882007wrv.60.1687883149054; 
 Tue, 27 Jun 2023 09:25:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u14-20020adfdb8e000000b003112ab916cdsm10991749wri.73.2023.06.27.09.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:25:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 07BDB1FFD2;
 Tue, 27 Jun 2023 17:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 26/36] gdbstub: lightly refactor connection to avoid
 snprintf
Date: Tue, 27 Jun 2023 17:09:33 +0100
Message-Id: <20230627160943.2956928-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


