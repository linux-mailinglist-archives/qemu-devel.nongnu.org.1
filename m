Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EB47BE6E7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:48:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptPZ-0005Dm-KV; Mon, 09 Oct 2023 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptOw-0003Bt-EK
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:46:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptOk-0003WM-3J
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:46:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso48166555e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869973; x=1697474773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/BY4Yx13cWmH/QDWd4SZAmL532vLBHSSsqb5C4YehM=;
 b=gZQlEySB2gTqve2R4v/XmkPBPwIX7moLYj9in3SlByJhdIxnbMH9AEgMLdQXMTJ2Xc
 gqvsk++Tx7mZrLv+LQ3Ufci1riqcDo/M+ax14RMpREbDMYCkIhPapuaN5ul+R3x8Hvyt
 6/Qv7cT+X6OePkQcgvYmKbHjplpInn3ydiS/tHEOGT4JTQzOsS3h4HmOL98ZEZnp+S1L
 i6pe6tWiURIOMIpOmsEXqMjTww6T/Y4xYVRGOc1R5jwe1QMPQaSkR/2LRlUiofZE8JLS
 N8lm6i/NpBvhxxIuMd/NyBdlzzL0I5J+S0rBaIkMYTHlSDBUhpoRiQOJFruF+BURsPQa
 V+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869973; x=1697474773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/BY4Yx13cWmH/QDWd4SZAmL532vLBHSSsqb5C4YehM=;
 b=ZB11xLT4XRt2WylsfqBMgJXiCpefYzzw5d2L2IZW/gboJ8H3hDLNI/QJrlBoWIdFJG
 XwRVLRxz5ylzG4LyclojPZd5lqWaHO4wRQow8mb3yObHY82NA+fzgPhNp8eb3ANmgaag
 7rTnvDrrHRmwe8UVVQO0p+oK6zKCw0x66g2TsZNMvHNRElsoRAylwZ7OvJlRG7JxHgtS
 mWQ7h/zlbXFWvCj5EG6qZsqdl8NEyNLudrQh9XqTJLp49BdrEcEmkw54G/yDc39paYuJ
 1TQgR4S1ueqIPJCWF3D8CR8RpI1OX/nA0XE5125muTyKgXjM03pJTySoeCMhXYNdsVSd
 icMQ==
X-Gm-Message-State: AOJu0YzUfke5UFbwoGbPsC8ayS2eCgO5MkDqQIac/lrNbPnVHQF56Dav
 t6yDSuA8yq5XkEwDIqxzJmK23w==
X-Google-Smtp-Source: AGHT+IFqldlgnqN3jgu1alUf3POF5hhU2Ykvir4ajPIebSISlXbelhquj4K9A3V5nk/cref4PeNXgA==
X-Received: by 2002:a1c:7917:0:b0:3fb:feb0:6f40 with SMTP id
 l23-20020a1c7917000000b003fbfeb06f40mr14863202wme.11.1696869973491; 
 Mon, 09 Oct 2023 09:46:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b6-20020adfee86000000b0031f300a4c26sm10071422wro.93.2023.10.09.09.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:46:12 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 433DE1FFCA;
 Mon,  9 Oct 2023 17:41:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 18/25] gdbstub: Remove gdb_has_xml variable
Date: Mon,  9 Oct 2023 17:40:57 +0100
Message-Id: <20231009164104.369749-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164104.369749-1-alex.bennee@linaro.org>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230912224107.29669-12-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index 3dc847f835..62608a5389 100644
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
2.39.2


