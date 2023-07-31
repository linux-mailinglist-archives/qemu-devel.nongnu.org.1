Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFEB7690BB
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOYx-0006dI-Jr; Mon, 31 Jul 2023 04:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOYa-0005oc-3V
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:47:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOYX-0005BU-6D
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:47:11 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686b879f605so2741782b3a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690793227; x=1691398027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMFQkURIt+B7Z40RIh76WBFgtW+t214r6i/VW2pjKYA=;
 b=vX/uDG/V67JjXpDvQqFGigdALwh1rnSEaO1QjrZ7QnWYxlqXVmSZ0LNzPcE5tGKE4/
 egmnWAbx6wYRGX0WCDys8rgaNNl+Uh6EVJg5f95JZj5mCnhNFbc008LR3wCWun7tc62i
 xAvy5By5M6rwEUYKcy6a1CwzY2Ett2phfKrfgfe/E+NELvHN1ru6jRsnP3JvFM6BYIFH
 rEhBcpGIOaou2icpefra6aqyafhvXCoST5PDaB6jGR/ncn4LzlonIjjFqVzNENCK/QDY
 7kOl2aPIz6nMKuCXpY6vlUspbYVQd250gdRzXUwYdcf62L2Xs+ehH/HsbMG4lvYAggkB
 71Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690793227; x=1691398027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMFQkURIt+B7Z40RIh76WBFgtW+t214r6i/VW2pjKYA=;
 b=fPR3ysX9K0pYoZPcberNALY5k4q+5pGNy6aj5nzMyMSgw9AFrxydUuY2fYyRvAtzDK
 0hw7s9IOg4gsd1OruN3WRxIH5+/0A2qKtoeUhpUSt1MAUi/efGnhflm4Bh26L5ocFI5J
 PBWSCzno6fZAXMSkkGGVJKLVYAr4z9x+vFsXpJXw75eesFDeoBxWUen8whGtiPrMAUCN
 UTOiZDNCnoRBI2mC39UVosyclPUAx3/HjNyz0wwLl2wvO+CVBm97Y1r4gNNtsIf1Jty8
 9p+JW+ySJcdxF1T3lePtsJkDrXaR52hkBUy2bABX7BqQjroeaQXt6lHNvAmrX0RmFjIt
 4/Qw==
X-Gm-Message-State: ABy/qLYRsq1va10FW8Qxl/vPkpdsjuLHndf2P2cIPBFzGpxEy21z8iXg
 bcT5VtM69/lTPlpLTwxEZOEJzw==
X-Google-Smtp-Source: APBJJlGkUW1RnGS9ESWmYImJ9GrE7QDrALMk8lbobcLMurlu7CrDj8O8WvZLmQUWPdukfH3AvivBNA==
X-Received: by 2002:a05:6a00:174a:b0:66c:6766:7373 with SMTP id
 j10-20020a056a00174a00b0066c67667373mr10776209pfc.23.1690793227302; 
 Mon, 31 Jul 2023 01:47:07 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 u19-20020aa78493000000b00666e649ca46sm7075563pfn.101.2023.07.31.01.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:47:07 -0700 (PDT)
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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
 qemu-s390x@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 19/24] gdbstub: Hide gdb_has_xml
Date: Mon, 31 Jul 2023 17:43:46 +0900
Message-ID: <20230731084354.115015-20-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731084354.115015-1-akihiko.odaki@daynix.com>
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

gdb_has_xml is no longer referenced by the other components.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/internals.h    | 8 ++++++++
 include/exec/gdbstub.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index f2b46cce41..92f5ce8cbb 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -234,4 +234,12 @@ void gdb_breakpoint_remove_all(CPUState *cs);
 int gdb_target_memory_rw_debug(CPUState *cs, hwaddr addr,
                                uint8_t *buf, int len, bool is_write);
 
+/**
+ * gdb_has_xml:
+ * This is an ugly hack to cope with both new and old gdb.
+ * If gdb sends qXfer:features:read then assume we're talking to a newish
+ * gdb that understands target descriptions.
+ */
+extern bool gdb_has_xml;
+
 #endif /* GDBSTUB_INTERNALS_H */
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 6da4af9612..cbd1e6ead4 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -40,14 +40,6 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
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
 extern const GDBFeature gdb_features[];
 
-- 
2.41.0


