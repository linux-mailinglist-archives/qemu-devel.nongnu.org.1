Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D933B79727D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdM-0003B6-T2; Thu, 07 Sep 2023 09:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcp-0002mF-PJ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcm-0007Fp-Cb
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yioP/nXneuDSCiJJHSA9x2f5GhZOCJ1auXXR4f8hYLQ=;
 b=iH/Rvv/vych0AUgX+p00qTe9KDIvT7GsoRaxvYZ3pceQjQWuiHgo4Co1BM+idGH0sH3jGh
 1BPLoHRQ3p9ZfYfhzgHW1AaXTuiM5FrUtQXtTNS0kr6ZnTDIuoRU3o47hXmnmTmNa1/7IH
 s+25503/tv2yUgyK7lj9jJbIwAYZ+Pw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-8fzqgCMrNRuDN0ZptZ4iRw-1; Thu, 07 Sep 2023 09:00:39 -0400
X-MC-Unique: 8fzqgCMrNRuDN0ZptZ4iRw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so6557765e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091633; x=1694696433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yioP/nXneuDSCiJJHSA9x2f5GhZOCJ1auXXR4f8hYLQ=;
 b=C7WmnOg+6DL/YAJr1ONPLLQg5vv+oh5k5xWu7aNJgO7bzMZIh9qOWCc57S4tNkKY41
 acgvbwTCKmJej3v7mVYMUWP09EIvr8gdwm0jMDrjBZSkKFJQSttWy1hlXpVNyivnjsWi
 GXjqspR5hwdOVwwVoSyssSvoDiVMb+fDTb6DoAscClsPuyMFUe7NGOgqeUt9gztEU35n
 Ifk+ZDh/Jfk+Ix6uCXr1pllKIUQUJlb9x9dp95lTIWytVmAkrSpe9k+zetGwo3hBxpHy
 Xmt1y2hlEWhAfR7Gr+UJGrCy0xUPOeG++Moz9/fvV/u1jY4SYXPfP41lQZT7Zk0f2Brw
 Lv8g==
X-Gm-Message-State: AOJu0YxNN4+WprK/w/DwzgoHLQLsZnJ7Zi6XEA9bhSN8f0/HDvSnbmNy
 ZKq30le+io09dgF+Wl13O+Bdpu9e2qo4/lJ4Zj2MAaP7ARonn0ve79TRZU9SuNnLDCRIikAAdH8
 JcrGAnPw0dPCoW91wl5xvetbek8g5DuFtSBSX4+JcpY/QKRP3s6CUc4sWatJsjYGl6u6wFW8ocJ
 k=
X-Received: by 2002:a05:600c:2308:b0:401:d803:6243 with SMTP id
 8-20020a05600c230800b00401d8036243mr4759848wmo.32.1694091633454; 
 Thu, 07 Sep 2023 06:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl/Z8wWWHXS2yIejoFGXn95eJWfaY6Dtg953tIGUZGRTxLxDdolIRrOKRIuKp+QCtKqUYmtw==
X-Received: by 2002:a05:600c:2308:b0:401:d803:6243 with SMTP id
 8-20020a05600c230800b00401d8036243mr4759820wmo.32.1694091633083; 
 Thu, 07 Sep 2023 06:00:33 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a05600c225500b003fed78b03b4sm2459592wmm.20.2023.09.07.06.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 12/51] softmmu/vl.c: inline include/qemu/qemu-options.h into
 vl.c
Date: Thu,  7 Sep 2023 14:59:21 +0200
Message-ID: <20230907130004.500601-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

qemu-options.h just includes qemu-options.def with some #defines.
We already do this in vl.c in other place. Since no other file
includes qemu-options.h anymore, just inline it in vl.c.

This effectively reverts second half of commit 59a5264b99434.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230901101302.3618955-8-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/qemu-options.h | 41 -------------------------------------
 softmmu/vl.c                | 11 +++++++++-
 2 files changed, 10 insertions(+), 42 deletions(-)
 delete mode 100644 include/qemu/qemu-options.h

diff --git a/include/qemu/qemu-options.h b/include/qemu/qemu-options.h
deleted file mode 100644
index 4a62c83c453..00000000000
--- a/include/qemu/qemu-options.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * qemu-options.h
- *
- * Defines needed for command line argument processing.
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef QEMU_OPTIONS_H
-#define QEMU_OPTIONS_H
-
-enum {
-
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
-    opt_enum,
-#define DEFHEADING(text)
-#define ARCHHEADING(text, arch_mask)
-
-#include "qemu-options.def"
-};
-
-#endif
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0a74810ca32..78b6570f19c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -91,7 +91,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "qemu/qemu-options.h"
 #include "qemu/main-loop.h"
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
@@ -894,6 +893,16 @@ static void help(int exitcode)
     exit(exitcode);
 }
 
+enum {
+
+#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
+    opt_enum,
+#define DEFHEADING(text)
+#define ARCHHEADING(text, arch_mask)
+
+#include "qemu-options.def"
+};
+
 #define HAS_ARG 0x0001
 
 typedef struct QEMUOption {
-- 
2.41.0


