Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C2D7ADF14
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqK6-0008Be-2Y; Mon, 25 Sep 2023 14:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK1-00083I-41
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJz-0007jg-9F
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32333fb6beeso190955f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666517; x=1696271317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK7hmPDkvNZ7gao1BckcXOde8JB8Py+cCsJYB29LOaU=;
 b=PSDxwb4jT9NMsckT0ZK3pyVsX67SS3SHPsdrdMaHNFOL+MpSFeTOQMXCrBU1vPnnRD
 /YoGX2KfqADCpMuoghdalhSFmrRXyx9gnyny2iy55lxykec0BfQOtNs+T7k1TMX+XYN7
 6yg10xStmvYPDzUhhd/mfr+vO8JBQN+UdNg9Ki4KFomjUhU7MRj9lpBJdPEmlwGE60HZ
 /11/tVtoGWztEsFA7SWFNZcNdMSINrTK6uDyadxrTMVAFZtEzrRIlPNDVC5UV9ydhuRU
 +ZbqxBF7xb7aOTND4xN4q2++6TMs/hgbL9XYYSOHPvEWhgsDu1jEv/veJXHPLzr3sdSj
 cngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666517; x=1696271317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KK7hmPDkvNZ7gao1BckcXOde8JB8Py+cCsJYB29LOaU=;
 b=gnbN0FIXX4UsqQ1SLrmaqEKtZ+q5UbFiz4oS1JoFGeQmNU7mmTjBazLvOO33nV8tiq
 wRWj/kXCBkttEevywLL33OvDFZTkxYBQIXnimWR5q68TOLqH48Kj1IU6fnq9HSXsxJe8
 gAmRNtfTwGv69iphrMuRfCpZj7+9KkFZ+kgYZKI7bmlEit3JAIzFWA9flW5SZ7aupYWi
 RuPigKvml9NKW5kgnx9o2Cn7wJhNaBcmfGyF2IboNXL/W9EOiqjG2MhARhWyP6YSETQq
 IzKbWJ6myni+GvaXcvcMUivn658W60yO2rInQPMsjvQP51dh0CMkNQNOIBM7ZbjFMKJh
 /I5A==
X-Gm-Message-State: AOJu0YwdBq0LVWcB5SP4nO75HL4sF58W+DMewTXpMOPn4KHaPlKeaaO0
 9ZhDpWF6rGSlb2RdAE9Zt+tPN0R5pTw=
X-Google-Smtp-Source: AGHT+IFbDofjrmn3rFBLqtAgw5JQjVY9Ozfb9YHPgoy7t2+mCv8vUuF83aYDXXpMmGWJrLUGavqYnw==
X-Received: by 2002:a5d:6b51:0:b0:31f:f99c:600a with SMTP id
 x17-20020a5d6b51000000b0031ff99c600amr6210303wrw.46.1695666517540; 
 Mon, 25 Sep 2023 11:28:37 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 04/23] bsd-user: Introduce freebsd/os-misc.h to the source
 tree
Date: Mon, 25 Sep 2023 21:26:50 +0300
Message-ID: <20230925182709.4834-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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


