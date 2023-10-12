Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBA7C6ECC
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvQ2-0003MN-6W; Thu, 12 Oct 2023 09:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvPd-0002ie-VX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvPa-0005KH-WE
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso1055945ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697116053; x=1697720853;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWuKUcnNqKUWxMqg1EexrTswIw3aaRaQhxy6IrnDyPU=;
 b=beuItA8QA84n99/tSvcYI8xe1zANeClWWNcw6bjGu4cJiSn0hE9muu9Bjj8hCVNWqS
 NBLrWtUcpftdlOLCIBUgm2x1rh93dVUt/0HOrWOZCtOBo3h6cjGSyOUANbZ3VpcpVNx4
 oX0YKzKznzVvLEw6Bhq0cSdcm7oD85B8El9Fs4RVY2Symp2A4U4MvTKaAmDYY3bQETAa
 pLt0bKF+vfeLyFGWEkUSyxoF9YhIC0WA2+l2kkn1vu7K0dSZgwtvoyJlWE82jWfS3sVm
 3fGbL40DdtGV5NyKr76+WxaEzqYXgzhyV42HpMqXkFeY6Ry+R1/a/N5YlObHvq7AR/Yz
 hsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697116053; x=1697720853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWuKUcnNqKUWxMqg1EexrTswIw3aaRaQhxy6IrnDyPU=;
 b=YSG7JBZSsE7ucYzmhqnq2rqBRjX2qHYAP3b3Es9RzqjCkB44ORINlQmkisnRhSbR4S
 rJ7+2qPGKPc5VOdj4L7dMg+JBM/XhNnHCmb0nuM2zr+inm7AzkbpxEtpoqblpKQWro8X
 k4/kxjHEU1/ptJgdRWfG57bzNUIyh/ViUj6PrW1n5R9dF10TK4axIwH5I3STwMs2VzdY
 mvBFiSseveRGo+fV0l8aG/hT3LejzdDAzot6eyy62PgUV7JmSElvi/VTM1xvNM3o/5Ys
 paIyJjoM6o572086MHFT8j0MNK0PJUbSvg+OYYQF2yDtMJS+NcY/pRpR910ixlfJ4T/5
 QXQw==
X-Gm-Message-State: AOJu0Yxt/3GyS7HUkjCzabHLxL/mZyW4wzugFJeNcgYCIbDPfXLp/zIM
 xvZpxC7fyiqMK/v3l6Bk/vByPA==
X-Google-Smtp-Source: AGHT+IGW38tm8YnbB2HlM3Ka9UwyNKHMV+l3GH4nF8/X8nR8cfK3V7+n9LyX+QcBp8fXF/CV5FZqZQ==
X-Received: by 2002:a17:902:c952:b0:1c5:d8a3:8783 with SMTP id
 i18-20020a170902c95200b001c5d8a38783mr35015419pla.11.1697116053388; 
 Thu, 12 Oct 2023 06:07:33 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 g15-20020a1709029f8f00b001c9c879ee4asm1928260plq.17.2023.10.12.06.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:07:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v11 14/18] gdbstub: Expose functions to read registers
Date: Thu, 12 Oct 2023 22:06:08 +0900
Message-ID: <20231012130616.7941-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012130616.7941-1-akihiko.odaki@daynix.com>
References: <20231012130616.7941-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

gdb_find_feature() and gdb_find_feature_register() find registers.
gdb_read_register() actually reads registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h |  5 +++++
 gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 229fa382bc..b85f700c5f 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -71,6 +71,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+int gdb_find_feature(CPUState *cpu, const char *name);
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 987af2298c..a3fc65ec86 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -484,7 +484,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+int gdb_find_feature(CPUState *cpu, const char *name)
+{
+    GDBRegisterState *r;
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (!strcmp(name, r->feature->name)) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name)
+{
+    GDBRegisterState *r;
+
+    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, feature);
+
+    for (int i = 0; i < r->feature->num_regs; i++) {
+        if (r->feature->regs[i] && !strcmp(name, r->feature->regs[i])) {
+            return r->base_reg + i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.42.0


