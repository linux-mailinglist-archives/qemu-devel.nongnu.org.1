Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34979963C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfF-0000zI-Qz; Sat, 09 Sep 2023 00:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfC-0000yc-V3
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfA-0002vX-I8
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:42 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31f615afa52so2778734f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234019; x=1694838819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGJohYqrlAeBGqv33iEu2l+2oxUpjbZfEtEhLbQOaQw=;
 b=RAJMIHfSasOBXvJCIg1nJ+yxEAEPD6v1thNO87A3w4sNf9iJUVO5wPBg3vKg5tYm5U
 XLY0JB4YkZucX+JXK/eO4Kct2+KJ15rFFRSMd+cUNMbhQ0kP8UsvXIOwUhxi7kezI7pQ
 Dq59xYRWYRZ3nhOsfw3Av4mmOYwnyy+EMg8J9HrProvuJto8lSwLvbwWi76HDuoS10Qj
 /znnmKOaf1tu/aPigEZATluopvKFAjMXeYMMkhCbSmSTmynm+Yde+yMd8OrtaKlDWdRl
 MyobgAtoKJ6Gpu8505yt8T0cRDl7uQgsRHFttTP5rwAfrxIppq8mnTzhzIemywoROtNN
 Mm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234019; x=1694838819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGJohYqrlAeBGqv33iEu2l+2oxUpjbZfEtEhLbQOaQw=;
 b=BoyeGEb7kGCJj6KSXShE2anGuUnPsmkBcoaQWZXuoDp5FdbONM3TkGeb+JFedblePL
 PonM+dBwNiNWPj5iciFakdSk+RCVahxOnXJZur3i+yq/dsceRN6Rq2cMN7II1+DDV4JP
 4LyuCcSpKg0uUmvfI8i/cMj6VL1xdIjiLzHBGDX/q3Kbm6Z5hMnuosCDvs28XWdQ4dUa
 1ew4DcgvBRxcQRIwbgDcUWcsw/MCXkK+H2vGdF5/rDS4f9DF+qTgFCxE7aSw/Um/b3ao
 xejKnC4AM6CnjCZnGe5Gz7TbJrY7i0Nj91SgUuvYaVE0Myux0YADGJ3Zu/w7g7CJDQ11
 yOmA==
X-Gm-Message-State: AOJu0YyDvxk3LuBcpRo6TFNoVyTDgmrfUCcSfNVa2Sqs5Lflx9jFa45o
 vAjAh67Q28hNi/eZIqTFUf5e7lj+Z6o=
X-Google-Smtp-Source: AGHT+IFISqkrKad/tbjOkZQylBTIZGiTUAmS/zs5C80EfUCJQSXptY7J6v1KFTTom+1WjreSWy/qMg==
X-Received: by 2002:a5d:658e:0:b0:316:fc86:28ae with SMTP id
 q14-20020a5d658e000000b00316fc8628aemr3373360wru.15.1694234018687; 
 Fri, 08 Sep 2023 21:33:38 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 04/23] bsd-user: Introduce freebsd/os-misc.h to the source
 tree
Date: Thu,  7 Sep 2023 09:42:43 +0200
Message-ID: <20230907074302.79234-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


