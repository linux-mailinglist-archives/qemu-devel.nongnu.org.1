Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1577E43F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHuh-0000tj-JE; Wed, 16 Aug 2023 10:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWHuZ-0000Wk-DT
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:54:16 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWHuW-0001ff-Q8
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:54:15 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-51b4ef5378bso4934597a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692197651; x=1692802451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06lruvuER2JmmjzWPkvhn7tl3HrqMHtHO/EfWEPYAug=;
 b=Rx1Bfyqj41542uex+VPI4aGu0lvRXaDqdWplXr2QPoOr85I2DcJhaNpSiwxIYeDrXX
 zUae+GVMeLTr+pjLfabmWIbPOOU8pwCi//v2P8wGVrzy8AFGpwnu4A1I67TSwxeBMY3C
 g7tiuCMwMCrBS5xzp2F5NQUDCAgPH2MND5jID2UAjO4YxKWNWTwjZYHfcl+bAzY84Cp4
 DbHKZvbKIm4+zGfTal9r71hx49SE+BSGlSrna4veZvC1d1n+JCI/cDT/2ZqCyBXKVWmB
 ZTvqRwFzShAddVWv+lKADLAgIdVKensSPNoEGMx2ATXi4xpBqzHeN8tpvQGpX7rXJ7uR
 xurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692197651; x=1692802451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06lruvuER2JmmjzWPkvhn7tl3HrqMHtHO/EfWEPYAug=;
 b=ILZfMst/c75RXEUj/QCzeUeABrSeViqsmJx7NQ3d+zfipEbaZDMBHKYcLGVxg6n8rU
 jvQE9WBr0fXMo45eOdcJiLoCSv8LEC8MFTN+NeNpGxDN4uoYfKWV3yfwX1OW8DmAQIxe
 uwbS8fR6u7xTQi4nU9htdxMVB2R10Klh0Uu5wcG11LZdGpmQgosnmBNwhplLIyR5iSFx
 naQxIBgQV6Vd5DER+FVlE37RUKcWL6eYyQARzZL50qOVWKTnC9RzKwwk2SA7lCg3c0oD
 kRCRmcACipZttkAVpGnohIz6QWJWiU9BLCSEBKKUnhigZZJPO1iQDM1jgKFvXaznT/xX
 irNg==
X-Gm-Message-State: AOJu0YxACKQbvrg2bs+iN70H8ZSqBc2Gzd6NrppQ6W7VIUHXk83Qt1Jm
 J3iVtYEOW3oGYvS5onfvB8CRIQ==
X-Google-Smtp-Source: AGHT+IGNi1WnSDyEFaWSAnuE5JXmQGx9lONzm6CcNOGws+VTx0jUXZ9NMfg/hTFNrnDcImP1TBnYwA==
X-Received: by 2002:a05:6a20:7f8f:b0:134:8d7f:f4d9 with SMTP id
 d15-20020a056a207f8f00b001348d7ff4d9mr3395955pzj.52.1692197651399; 
 Wed, 16 Aug 2023 07:54:11 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 fk26-20020a056a003a9a00b0068892c40253sm1156568pfb.216.2023.08.16.07.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:54:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 12/25] gdbstub: Use GDBFeature for GDBRegisterState
Date: Wed, 16 Aug 2023 23:51:33 +0900
Message-ID: <20230816145155.21049-13-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816145155.21049-1-akihiko.odaki@daynix.com>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Simplify GDBRegisterState by replacing num_regs and xml members with
one member that points to GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/gdbstub.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7fa4b8b51f..7a4775633e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -47,10 +47,9 @@
 
 typedef struct GDBRegisterState {
     int base_reg;
-    int num_regs;
     gdb_get_reg_cb get_reg;
     gdb_set_reg_cb set_reg;
-    const char *xml;
+    const GDBFeature *feature;
     struct GDBRegisterState *next;
 } GDBRegisterState;
 
@@ -390,7 +389,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
             pstrcat(buf, buf_sz, "\"/>");
             for (r = cpu->gdb_regs; r; r = r->next) {
                 pstrcat(buf, buf_sz, "<xi:include href=\"");
-                pstrcat(buf, buf_sz, r->xml);
+                pstrcat(buf, buf_sz, r->feature->xmlname);
                 pstrcat(buf, buf_sz, "\"/>");
             }
             pstrcat(buf, buf_sz, "</target>");
@@ -497,7 +496,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     }
 
     for (r = cpu->gdb_regs; r; r = r->next) {
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
             return r->get_reg(env, buf, reg - r->base_reg);
         }
     }
@@ -515,7 +514,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     }
 
     for (r = cpu->gdb_regs; r; r = r->next) {
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
             return r->set_reg(env, mem_buf, reg - r->base_reg);
         }
     }
@@ -538,17 +537,16 @@ void gdb_register_coprocessor(CPUState *cpu,
     p = &cpu->gdb_regs;
     while (*p) {
         /* Check for duplicates.  */
-        if (strcmp((*p)->xml, feature->xmlname) == 0)
+        if ((*p)->feature == feature)
             return;
         p = &(*p)->next;
     }
 
     s = g_new0(GDBRegisterState, 1);
     s->base_reg = cpu->gdb_num_regs;
-    s->num_regs = feature->num_regs;
     s->get_reg = get_reg;
     s->set_reg = set_reg;
-    s->xml = feature->xml;
+    s->feature = feature;
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += feature->num_regs;
-- 
2.41.0


