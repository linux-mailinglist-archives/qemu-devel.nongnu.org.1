Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E97CF544
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQFK-0001FV-FU; Thu, 19 Oct 2023 06:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQFH-0001FK-SC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:27:16 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQFG-0006KL-4N
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:27:15 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-581cb88f645so1735284eaf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697711233; x=1698316033;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5iKyNrMNpb32xwXmKX8FoAKMAx545fFQbRP901F9ZY=;
 b=eIIObw6sAiOIFO5XAEV996gw5QaMUEq3lsQ4zrp8xESZGiSYi+8UWs6O4levz6tHMj
 oZhtEiL2cw9R09tfSQQVOxK0QV3ZGXyAhfoA1RhfsjwWomfTG9BAXFaa6McZqYMxRogb
 zhgVRpgIYjfc6D7JETyQ6PDdWr/L3nheOSPetW6YVhAaDKJT4e2Ow6GScfRdfcAjnPCt
 NebW5dbOqzZxQ1OJ4dLg36l6bUyMvc+LgMEEPjM4T6j1oBXUlO/sdmTbr9AtFWthAXQZ
 MBoDKlvomlUnE2nQWpJ61Fg3L8tlC+0Z8UJHFqarRo6LE588b3PbAKjoJmzU4cqWMni8
 1nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697711233; x=1698316033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5iKyNrMNpb32xwXmKX8FoAKMAx545fFQbRP901F9ZY=;
 b=ZHKfWygv9aX/kl+ubSZXz0s+WZ5i/EKzGsbPKLVWbkIa58Csah7JZ8NpWwZDpj/wVU
 fg5of1aaMHPC0oMpXMpBBb83EEol91U1wRSN68rw+R5bURltJ0AO5sj3UZRmTH1BXns6
 3yb5FK72jJ0Vea/XqYAVbg1wJ9lDaV333QrG2IYBPduEGbh5M/ipgs5v10eMqpvqeKpM
 JpQJECz7L+nPVjr46iSQbIOJf+L+8jbSV8xqsvSMGep4LZSG0Ifi+biAktuZ0rtneaLe
 uI4oExOkFspQEh/zw8o4RNZJOqt+6gEcL2zzmTFo0P4uAYaOunrGJfq6lIRpLtpCO5PU
 rqCw==
X-Gm-Message-State: AOJu0YwEk3ifMTPa4yaZpdUO3ILRRWL4e+F5evUj5jVCrrNBwWMqqZRd
 aDUPttlrCcDqXGRoxgK9ZMPmoCp+b2koQWAO9CRixA==
X-Google-Smtp-Source: AGHT+IFQiq6ekE5z4XU7pQ1wFTk4k6IV+2+QXNpCRR9WAAMWAi/sTNDnqJvBb0uihEG28VfTky6Fiw==
X-Received: by 2002:a05:6359:6699:b0:166:a7ff:afbe with SMTP id
 so25-20020a056359669900b00166a7ffafbemr1242317rwb.0.1697711233012; 
 Thu, 19 Oct 2023 03:27:13 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 i126-20020a639d84000000b005b83bc255fbsm1955832pgd.71.2023.10.19.03.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:27:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v14 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Thu, 19 Oct 2023 19:26:37 +0900
Message-ID: <20231019102657.129512-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019102657.129512-1-akihiko.odaki@daynix.com>
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc30.google.com
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

This function is useful to determine the number of registers exposed to
GDB from the XML name.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gdbstub.h |  2 ++
 gdbstub/gdbstub.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index a43aa34dad..071021415a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -44,6 +44,8 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 29540a0284..ae24c4848f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -422,6 +422,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return NULL;
 }
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname)
+{
+    const GDBFeature *feature;
+
+    for (feature = gdb_static_features; feature->xmlname; feature++) {
+        if (!strcmp(feature->xmlname, xmlname)) {
+            return feature;
+        }
+    }
+
+    g_assert_not_reached();
+}
+
 static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-- 
2.42.0


