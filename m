Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF677A0ECB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZV-0002sR-Ai; Thu, 14 Sep 2023 16:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZT-0002s8-BN
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZR-0001Tg-Mg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40472f9db24so10294055e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721851; x=1695326651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK7hmPDkvNZ7gao1BckcXOde8JB8Py+cCsJYB29LOaU=;
 b=C4KQjPocFMmZm9DoBh4KmkCCQ+gmf/8fDwCalKitvH+y8UzSdIqX9w+kdYjlQ+fAIg
 +VeOOnbdHSy/F0u6rSEzETce+VtCivHWVtrzWj3X4f1TnEzxuPNDc1DLmiZ55eiaWriQ
 4y/ow8NS59uqsUKm25d7HTA2oy7nG00NvsquthJ0YAqphWWoIBNTAOcgF+JM98WRQd69
 bkqIq+yssy5ZdLygY8dSePC9cVAph2pBiYAlJjvRfYGTa2zUc6JH/wab6pgOy3QJNIMM
 dMM9CzgF4l5Ukwsh6S+GZlOQlCiGku+1L+bcMtI5LHknWB1GaGOZ5F2JDh0L22xu0jli
 hRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721851; x=1695326651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KK7hmPDkvNZ7gao1BckcXOde8JB8Py+cCsJYB29LOaU=;
 b=oTuYe0tr58eWr2t6wyeKAwqsWqFF4kRwGG9HZWVZ8SeLMcTKw6GTjHi/6dC4gUyUYK
 Cx30krHbd6niHqgCUPJxOGQcx+8hq077D2gfgyAOZDrd9pKXZEFvAGXdU9bT5WDqZrrw
 82VBleAofgonSO8B1CqQGcSOU66KmzXwhqA15vP3TsCMBXG9bW08kNXPwIQcbI4Xt3kT
 1m7tF0AypH6quU0Ak7VwpH6dwK9Ze7svk13k1DTdOEK4N7ut3/+sNMrPNZ9EwAo2P8jG
 wCbQq0rWdtj/lI0Vbq1Fm0pSkfFaHNgFBICtjzyg7DlRRy3DtN1rc5miyqLgoVsl7NVc
 hcoQ==
X-Gm-Message-State: AOJu0YxpSN2bx4FLOsTg4wGvui/rLado2lO6m481T0efJG7v52Lg9Mp1
 BOP0UYVyDXWB8WD64mHj7QwM4YZfHc8=
X-Google-Smtp-Source: AGHT+IHqqjEy2qf6M5oOImImeKggecrjv83BKTpVEAWylCuesjqAD6iGOrWT26agZ52E4R/yZizzlA==
X-Received: by 2002:a7b:c045:0:b0:402:e68f:8896 with SMTP id
 u5-20020a7bc045000000b00402e68f8896mr5742116wmc.0.1694721850771; 
 Thu, 14 Sep 2023 13:04:10 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:10 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 04/23] bsd-user: Introduce freebsd/os-misc.h to the source
 tree
Date: Thu, 14 Sep 2023 23:02:23 +0300
Message-ID: <20230914200242.20148-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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


