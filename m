Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C272AAC781D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 May 2025 07:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW5x-00030U-JF; Thu, 29 May 2025 01:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5t-0002zN-3x
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5r-0003Bc-J4
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-234f17910d8so5319125ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497578; x=1749102378;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=eZ9bDppiwoM1SXYSHxH/qfzffpg4O4OmM6zv6X54LCadYOfg48WsldW959gq2zUOAP
 vwyt9RJE+O+fhcQnFpBDqKCxRtlVd21BNUlzrLzC5US9uGDyI6yAeJR5V/hSUn4/c10S
 dlBxynmaXjkl42DdH++BwZMLomERrsS9YjEQ5aTWmpkq2IujtL9+L5Xcf8xHgNIdS3iq
 jqRvZ5ECcSWo5XzfA1ZrxAuGT1Wq8BZ8IH652PXGGmqeEbL7p0Jb3Og/F5vL5rVBkDrp
 pcGSn6mJlmRBJVFa5uD4fv4T3ibtdJaudXIMtLBxvF5lAhOgYEV4edTCJN7pyaQX89sP
 Zy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497578; x=1749102378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=ueNjd0WmkRFiI4+4TtDDdR+Mggh/s6RMdy86oraGfc/taPVr90gSTYxTaSp7WpY6J0
 3IlAvs5y1pY6RMZgzSslzKzJpfjPsFu7/C+Iwwcw6HRsV7lLiHp6snGd5xdrCqyGquq+
 B9wEParXLxIfgeW9NKf8DgFHcfN2b2fOwOTyZhinXK7YXnh3uD7HbvOAq+IUn/DZMcyc
 O5qmC/cd4U+8r+/GaPrRBXOdqyhOQk2y9lw1KDYO/7+GfQdAmyCYjm1s4nHq1fLw7RcE
 +uXzNYUb+h27uxRE8jQpuPSHGYmMEFNY9vHQU3fwfoCPx3jFhjhLNRrivhW4d/MtZNO7
 eJoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBr0B8efgzWMVYrnmnppyxG2WR9xfITxGV1pzejZZX19HhumcU75q2cgTN/Rnnu4YZIHDk5OPsSTwm@nongnu.org
X-Gm-Message-State: AOJu0Yy1Yg4xJ3GXft4fNJi6vkg8ospxZLRE2IQ66McVAlNqnExdWHx+
 R5H2s61lpfLvCey5as+VogLCf1fmMxmQCam4+v0aZ5h6hZoHLDtqac6TKf0aK/wrGta/6ZFffZx
 gGXHq
X-Gm-Gg: ASbGnctlJKN88nLZrNj1N4RT0h09rfF3eaXna606Sp0Fk4FnzW7NrVCtgRrQAb79mU9
 2eGQhr/Scst1Lx/jdVUmaRj660FnfHM1HsDL+5uCkzo0vzVF8T9QfBRqlr1He66NiGEGq6iqStz
 ZghZzUlDBijvNByWUHhbyM93WxA+AyBne2nGYturulUOyEQqLontktJu6ZsY0CFWDkXZdPjWx11
 4VwoLh5zBOU+PL1TYpAtKpi0ZOtC/7YXoQF6DYq8loYtI2kYAzx9gJ9N9arni2Ht7ZqvBvZnnj4
 F/lEZ9IpTA61/60xRc3FRJoTfz6KMjTWEtI+j1Wkto5PruLQCIv3
X-Google-Smtp-Source: AGHT+IFGFfwYtfqqoWbUrux+PrgQ6ADwgdosJvR7J44Erx/OzxG3ES6qAdWdge204GhlPL32ivvf7g==
X-Received: by 2002:a17:903:15c7:b0:235:2e0:aa9 with SMTP id
 d9443c01a7336-23502e00e47mr33557045ad.14.1748497578152; 
 Wed, 28 May 2025 22:46:18 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506bdb532sm5078045ad.81.2025.05.28.22.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:55 +0900
Subject: [PATCH v5 06/13] qemu-thread: Use futex if available for QemuLockCnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-event-v5-6-53b285203794@daynix.com>
References: <20250529-event-v5-0-53b285203794@daynix.com>
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This unlocks the futex-based implementation of QemuLockCnt to Windows.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/lockcnt.h | 2 +-
 util/lockcnt.c         | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
index f4b62a3f7011..5a2800e3f182 100644
--- a/include/qemu/lockcnt.h
+++ b/include/qemu/lockcnt.h
@@ -17,7 +17,7 @@
 typedef struct QemuLockCnt QemuLockCnt;
 
 struct QemuLockCnt {
-#ifndef CONFIG_LINUX
+#ifndef HAVE_FUTEX
     QemuMutex mutex;
 #endif
     unsigned count;
diff --git a/util/lockcnt.c b/util/lockcnt.c
index ca27d8e61a5c..92c9f8ceca88 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -12,10 +12,11 @@
 #include "qemu/atomic.h"
 #include "trace.h"
 
-#ifdef CONFIG_LINUX
-#include "qemu/futex.h"
+#ifdef HAVE_FUTEX
 
-/* On Linux, bits 0-1 are a futex-based lock, bits 2-31 are the counter.
+/*
+ * When futex is available, bits 0-1 are a futex-based lock, bits 2-31 are the
+ * counter.
  * For the mutex algorithm see Ulrich Drepper's "Futexes Are Tricky" (ok,
  * this is not the most relaxing citation I could make...).  It is similar
  * to mutex2 in the paper.

-- 
2.49.0


