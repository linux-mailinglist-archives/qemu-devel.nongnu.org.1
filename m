Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17B799A9F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3mt-0005kF-6N; Sat, 09 Sep 2023 15:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mr-0005gz-5K
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mo-0003Ce-Mm
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso34426255e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288309; x=1694893109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGJohYqrlAeBGqv33iEu2l+2oxUpjbZfEtEhLbQOaQw=;
 b=d3ZGBraZ26QDToG9+b9On5Fot1RrcxLgQsqJD4G2lfYRK9d4FWQQ5JoDDGVU76mcOu
 U8rppbTq7SHSSlzCnSR1hCQePxMgxHXUiFEUiibBoLdztxrt3KGaGDCoqaF7IbrArcUh
 Vs0x29EoCNjg8De+HklhawaPr87UfltOl+cnUQQEd7mA7GL3PrA5wzXOK8jap2LxbM1I
 nyDEOLJlLe6kuW9Iol7DDJxYCsb47gqllbDxikjyumNGuHZ09ejOPwWNZ3CuHZMuHIeK
 T5ZSijNfdk4cfNPSf/IaVVp2ec0/1hIOaEORgOcYdfVNL9yCIOLeaLohLljsxaSpOknJ
 i/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288309; x=1694893109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGJohYqrlAeBGqv33iEu2l+2oxUpjbZfEtEhLbQOaQw=;
 b=rtxih5bNdlccoe6fJLRcBQlecVheIT6cjuP2lO8fcp9Cv5d8NWUMNuc+28O/K2nd+d
 EWgLlULQna+Y7P76wgHcd3cT4yc7PC3zF9Tw5BAKAL5MuXsWqkUMfz7qT6AmuoyDde1c
 +rTLh0UsaqbwLgNKrPeT/Kb8fItideoMigUxigGakZkYkPuCLWZtSwJVZvB/JRlgOmcm
 I7BwYddEHGzJKKI4w6sfslVJCZuw7dhjUTES6TrtcyhgXyhve6x/LWNCFZ2ybA/BIkT8
 R5x7E1a923sA+ELFNO4sydpQdisc2wkyCVLBHYACJaGA+0FCXWlxCLQMEP6M+nfuXlXp
 JA2Q==
X-Gm-Message-State: AOJu0YxUwtr2CQu22CDpfoQeH1t0KJ93+u02Ydv4qfCTtJHZv6etptN4
 B6etG/mXgl6Cm2LYWk0QfZ5SmBBF+cU=
X-Google-Smtp-Source: AGHT+IHCKiRX6dnJwdr3XKuUWl230X1Y7zS886jYsMUpuS7okoW7NHMyTHSnqW6GhJnA221eOgZkVQ==
X-Received: by 2002:a7b:c386:0:b0:402:ea96:c09a with SMTP id
 s6-20020a7bc386000000b00402ea96c09amr5052969wmj.16.1694288308975; 
 Sat, 09 Sep 2023 12:38:28 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:28 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 04/23] bsd-user: Introduce freebsd/os-misc.h to the source
 tree
Date: Sat,  9 Sep 2023 22:36:45 +0300
Message-ID: <20230909193704.1827-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

To preserve the copyright notice and help with the 'Author' info for
subsequent changes to the file.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 bsd-user/freebsd/os-misc.h

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
new file mode 100644
index 0000000000..8436ccb2f7
--- /dev/null
+++ b/bsd-user/freebsd/os-misc.h
@@ -0,0 +1,28 @@
+/*
+ *  miscellaneous FreeBSD system call shims
+ *
+ *  Copyright (c) 2013-14 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef OS_MISC_H
+#define OS_MISC_H
+
+#include <sys/cpuset.h>
+#include <sys/random.h>
+#include <sched.h>
+
+
+#endif /* OS_MISC_H */
-- 
2.42.0


