Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09501768C7F
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:00:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMsL-0007S1-KW; Mon, 31 Jul 2023 02:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsI-0007RO-Uv
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsG-0001Je-GR
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bbc7b2133fso25475935ad.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690786763; x=1691391563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CO7fy32xenrVhWZYD9ETTxnPRxcdVezcG1Q1gQ0RmBw=;
 b=EfLF4fppayLzjItnuta8ctFqIoTgEF5mEpipkaNCKlIL/dJu9PaOgyWekixIJ6Zi4d
 Qjgoa772Y46aBa/lF2fmvLXjc7XmuHoNfOTKZoM6YFaeX5NZSl2ARf01FFauLhtQWa8E
 WRAyX2lAtF2x4npVbVup0L7HOBTdah9c3llVRdiPX4nWilbwKld9/30fu61cKK8eg0WT
 lq/W5+XAJ6clSzZbh93UErX0p9HFW9Ejm/uwFuDoSB5eswSgJ00cBIroB+/rLVCi0G5N
 xVUYJptcA4wBljSndj7/WnAfr+MWXmuaQ4F0n9lzma79rgUAzFYWjwII1+q4KY3jReuN
 hevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690786763; x=1691391563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CO7fy32xenrVhWZYD9ETTxnPRxcdVezcG1Q1gQ0RmBw=;
 b=Iz9DL6UyMWFuZ1DlVCPvqkuXk/R6940Z1uahmiTEGCcBIZWteWxdJxuyTfOYFFqiof
 QJY1bZ/UEIl0XZGKI5Z1YdmWMlwAckg5rhHSE5OomD4TfhGCJEEv9+BcU0FDKBjGfUai
 hwF13iRW5dqp5wC8Uqga391Ce6zYzOMnNsgIvuB9ObMxn0WePVnb5uk8R/XZ15ESegdM
 L1gy5o7yeFPZYBuEnfFTM1J3d9w+UQuSJuLEGFxEtwgA00YQlrLo1ElMjw1FKH4bdGav
 ujPHX6hx0BruaqNxbVFxlSARl8QSKGNivNIlntBXuEjA8Tlp5GEdajV2QiqRt6SMP+HP
 T46Q==
X-Gm-Message-State: ABy/qLYjOeAOgThxgcFZf4ZzyZrkBQz/KA8H4OkvoTTe8q13WAETTjlt
 gHh20vN6Jb3W4GZXWDtI+uZ9og==
X-Google-Smtp-Source: APBJJlFAh+kLRCpyCJgYiETki0U6CRXFBIcTiB/Qkv53nIKSAruNdwANCAagMYM8RRxytU0pU0IklA==
X-Received: by 2002:a17:902:82c3:b0:1bb:b86e:8d60 with SMTP id
 u3-20020a17090282c300b001bbb86e8d60mr8821519plz.46.1690786763130; 
 Sun, 30 Jul 2023 23:59:23 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 l16-20020a170903121000b001b8af7f632asm7684988plh.176.2023.07.30.23.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jul 2023 23:59:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 1/3] pc-bios/optionrom: Add -fno-stack-protector
Date: Mon, 31 Jul 2023 15:58:54 +0900
Message-ID: <20230731065904.5869-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731065904.5869-1-akihiko.odaki@daynix.com>
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

A build of GCC 13.2 will have stack protector enabled by default if it
was configured with --enable-default-ssp option. For such a compiler,
it is necessary to explicitly disable stack protector when linking
without standard libraries.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 pc-bios/optionrom/Makefile | 2 +-
 pc-bios/s390-ccw/Makefile  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index b1fff0ba6c..f220d81f2c 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -19,7 +19,7 @@ quiet-command = $(call quiet-@,$2 $@)$1
 override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 override CFLAGS += -march=i486 -Wall $(EXTRA_CFLAGS) -m16
-override CFLAGS += -ffreestanding -I$(TOPSRC_DIR)/include
+override CFLAGS += -ffreestanding -fno-stack-protector -I$(TOPSRC_DIR)/include
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index acfcd1e71a..446d448913 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -38,7 +38,7 @@ OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
 EXTRA_CFLAGS += -Wall
 EXTRA_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -fno-common -fPIE
 EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
-EXTRA_CFLAGS += -msoft-float
+EXTRA_CFLAGS += -fno-stack-protector -msoft-float
 EXTRA_CFLAGS += -std=gnu99
 LDFLAGS += -Wl,-pie -nostdlib
 
-- 
2.41.0


