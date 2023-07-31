Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E057768C79
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:00:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMsO-0007VG-1y; Mon, 31 Jul 2023 02:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsN-0007Us-2J
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsL-0001KM-JA
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:30 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bb119be881so35439625ad.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 23:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690786768; x=1691391568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77Gl1gR/CtV/Pj1pMJJnyApzrSwhQ8z1Fjifq2QlnZw=;
 b=FxGCQ10Cz6y3wx5KwnEgTHTRROxg0d0sOHhPQTie1C13lvSdcbL3/JBxAQNq7juOwU
 jSnkXiCYUWHOFlLgZVhgZmKpG885oFkEFza7zI8ur7nxVSw/HxgI0rbeDwhdZb07jdoZ
 /OYDJPAGyOIpi85lzjNqboYOAYaiS0/ZR94s5WdQqN32Ue5d2jHxvSuJlG16OaGplPfZ
 2Fn0kOF3Kkjp/J75iPWj1QAybjrUJn1hkqHGD0fajP1kDiiZ8HCO3at0ETnMYiditOEe
 8RV2jbwfW9ReXQrz7efSJhgSF9dUkUcEhmxve83MO4zJFPmi70UY84rCZKiUaqPlp93L
 Ri/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690786768; x=1691391568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77Gl1gR/CtV/Pj1pMJJnyApzrSwhQ8z1Fjifq2QlnZw=;
 b=lIrYoFrmPK4lycCjBfs9Oq2evsE4a7tL55DpmoxBd9H0zXS+MZf8xhoDJWRkLilx/p
 18m69XTaqVE4ZkOkWgXIsWOGnW2+dZni+VvES3RzE09lum8SRbBSv2a2DL+33tvc8s5o
 NHu3yWR+iytDO1XnSCBRCrPlzy5wb6jtsQ4aG2qAbVGXgRJoZ/FoeQgbt9wN/TE6xCKd
 Bx/Ehc59Savs6PyMGlEwq7GGdJNu/QyU984sKv5trc+kV5eugV1EaqMfPVK/xbjDSXBZ
 yz9C5yfEcNZh046qnwlyV29lTjj5gZDh48CX3L1S4GUsfcM8g4xf0fXemcTQKZUYde//
 Dfig==
X-Gm-Message-State: ABy/qLYR1DWFxNGqnCrvluePGrnkBIhOJhYQVO0RfKeThHE3PeVt4LAv
 3NjasU1wToSz9ZEXO6lSCJUSCA==
X-Google-Smtp-Source: APBJJlGuHvXm0wU1LBdoC8IQQAHXHR8XcSIIBnPyan7ZOUUSWAPvzgOPVv/RGU+vU8/bZeQjs2Trbw==
X-Received: by 2002:a17:903:32c4:b0:1bb:1e69:28c0 with SMTP id
 i4-20020a17090332c400b001bb1e6928c0mr10622243plr.30.1690786768234; 
 Sun, 30 Jul 2023 23:59:28 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 l16-20020a170903121000b001b8af7f632asm7684988plh.176.2023.07.30.23.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jul 2023 23:59:27 -0700 (PDT)
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
Subject: [PATCH 2/3] tests/migration: Add -fno-stack-protector
Date: Mon, 31 Jul 2023 15:58:55 +0900
Message-ID: <20230731065904.5869-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731065904.5869-1-akihiko.odaki@daynix.com>
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 tests/migration/s390x/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/migration/s390x/Makefile b/tests/migration/s390x/Makefile
index 6393c3e5b9..6671de2efc 100644
--- a/tests/migration/s390x/Makefile
+++ b/tests/migration/s390x/Makefile
@@ -6,8 +6,8 @@ all: a-b-bios.h
 fwdir=../../../pc-bios/s390-ccw
 
 CFLAGS+=-ffreestanding -fno-delete-null-pointer-checks -fPIE -Os \
-	-msoft-float -march=z900 -fno-asynchronous-unwind-tables -Wl,-pie \
-	-Wl,--build-id=none -nostdlib
+	-msoft-float -march=z900 -fno-asynchronous-unwind-tables \
+	-fno-stack-protector -Wl,-pie -Wl,--build-id=none -nostdlib
 
 a-b-bios.h: s390x.elf
 	echo "$$__note" > header.tmp
-- 
2.41.0


