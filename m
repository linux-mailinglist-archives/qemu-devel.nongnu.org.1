Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAF7818A0
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZw-0008DB-G7; Sat, 19 Aug 2023 05:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZU-0007ut-1D
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZR-0004H0-Ay
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3198d2745feso1477214f8f.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438515; x=1693043315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCSfwfk5J8aV9f6C+8dP8rhVQliK6Ou3TFJHqD6MEtM=;
 b=ewGnM/vPEBE6AFXNnT09XxqlMfyHCC7LhF7nbqJL6s4fbFO3Yf1JkePnBtmlDiwB1+
 tXVvJ/ndie5my1ivIJwTnorfPgPitAlbEx+C+JDCvNs5T3vHdfKHfvxcXTkKX4LRASmf
 kQ5ZfEaosCM1eyyKx2BPka9u27uIEkW2du9Uy5Ff/DmU7BUo6nG91+d1oaahbvWUtWyR
 EmaTnTweCTLOENNM04ca1KmTqtrnpiZ14Ha1k81WU9y7tfdWXRrrHr/4e0g6j79+PEQ7
 QbZbkkHP8Ml54exm937GqNNa2jI8z3MnOfO9nEdZnMkn46Y+bAGgegYVauSHwEayCNM/
 0+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438515; x=1693043315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCSfwfk5J8aV9f6C+8dP8rhVQliK6Ou3TFJHqD6MEtM=;
 b=O9GA4aLb2O6JTd7iV5zdnSHEjFtC5nVat8c0YxEDiqXsaijkBk3lYIxSbAUmr1eKyH
 0r8HCwqwRrOBd59ny4B7Vg1iF8sl9Jkx0kJOelQrwWpQldvvupso98RuYzQQH8lHdSgG
 p98wQxt6F/5pOEltMr2PJVM/pFSAFjjyP83QszM8/2/KcLpMjJfU5Pq369K5GXiT0Qjx
 bQSMN/FbvuZLNOQKLNfqxqyvqpt8ls7IkgGy6KKYR9baEjQ71ntsSf/+pbIzq5Zl2bmp
 q4yLyvK+3KFnCUc3D4Ap9Jvyuz6HrX87mRp+0fqYwHcFfNZBLclhanpgO9JQcZmwA8Jt
 MrPQ==
X-Gm-Message-State: AOJu0YyEFaIUiEheCof2a192Vv4ClqDicEup4qWFDISYTpUi/VErINR0
 PoW2AyI9XwsGyzPBQ7QY7VwAgovXdqY=
X-Google-Smtp-Source: AGHT+IHIATPMcZRxARaz4kzhFpdzFBkIJoMJH9v2d6wHRQQHMAtkZGQy4K1my7gQgSATNWPfuP0EtA==
X-Received: by 2002:a5d:4908:0:b0:314:11fe:c72e with SMTP id
 x8-20020a5d4908000000b0031411fec72emr1136032wrq.46.1692438515468; 
 Sat, 19 Aug 2023 02:48:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 04/22] Introduce freebsd/os-misc.h to the source tree
Date: Sat, 19 Aug 2023 11:47:48 +0200
Message-Id: <20230819094806.14965-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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
2.40.0


