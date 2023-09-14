Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD917A0F37
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:46:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAq-0003KV-0m; Thu, 14 Sep 2023 16:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAb-00038g-Nt
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAZ-0006Is-1Z
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:37 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c7912416bso1263762f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724153; x=1695328953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK7hmPDkvNZ7gao1BckcXOde8JB8Py+cCsJYB29LOaU=;
 b=jdpRb/JVRfdxTIsVnLRVxu94zZWEvEmIo1u5rUezDArGV0AwbaJFWyBdlQFD2LpCTh
 FetHwhIk7zAnbMhdaq7n8+O2yJ6Nv43emLeYemALWhZU0wuErE23mc3jgRZQOEht5Pn6
 dvZ7ow3UiDGjlXuGBBANugQihuMWswnnlyzpRSPaLivK31UCbCnytN+BjY349sdgR1w/
 jMxwFn485S35zmZrzBGwt0/c4iFScgpfY06MIy8YEG+0H3YNGh/P+yxqCQhuoJkqJ8eM
 7vwe+EQH3+yPFX8NpuBGjGRwDDcmAKm2i9QUxCbT6yy+DAaoRNrZih63HrT5gZd/a7G/
 38xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724153; x=1695328953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KK7hmPDkvNZ7gao1BckcXOde8JB8Py+cCsJYB29LOaU=;
 b=K2vRMGaKd8SjGJkcPHt/LhjJtT1tYI5a9d7q9tuIjEC+KbSPuaW8Qomll4eZIvqmiq
 1CRta4rpAR3whKzF8rpVsnjWTnpKq5QwqM/ivugVIzvtHVWCNPGuKpIOyyE5e9WAVuED
 CA3OXRFaEWmOBlq7XFfg/5+7nl4oSlNiibXwN+zY0Ip6+K1VkLQnd3x8SsLXMA3/40h/
 f9xI7gwwzWdNL/pJg+Q7oviKgI8C/BbTKeo6CdFaVAmAVoDpYMgLDWZSQ0pi2wPHAp2D
 wnoOI1rIbyOzbuNWSgQR5ZSEmTC1Zskwbz236gaszuMCckT0QRLmrbeUfmBIaSIqKG0q
 taHQ==
X-Gm-Message-State: AOJu0YwLCSDCy2EVDaI7ZJ9BsYwiuEa00Tq8X7qR2CyPABKlCiUbVJTL
 Vn/8HpDvlcARUjYI2tdUfRo+lc5rL5g=
X-Google-Smtp-Source: AGHT+IFiQqiPI+KA6gvcCXbXm8goGXx5dQBgCDAeRN7yBcviTume8V21sbhJjtNsDojZAuAn12oDhQ==
X-Received: by 2002:adf:ee4e:0:b0:319:6001:978c with SMTP id
 w14-20020adfee4e000000b003196001978cmr5497016wro.53.1694724152611; 
 Thu, 14 Sep 2023 13:42:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 04/23] bsd-user: Introduce freebsd/os-misc.h to the source
 tree
Date: Thu, 14 Sep 2023 23:40:48 +0300
Message-ID: <20230914204107.23778-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
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


