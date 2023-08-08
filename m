Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADAB7737E2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTED2-0006kt-TN; Tue, 08 Aug 2023 00:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTED0-0006k6-F4; Tue, 08 Aug 2023 00:20:38 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECy-0007h2-TB; Tue, 08 Aug 2023 00:20:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-686f38692b3so5215126b3a.2; 
 Mon, 07 Aug 2023 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468434; x=1692073234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCYW5Fbo8ML/tCCBvqIHvoVVLyR1VjX2xindXtEVGn0=;
 b=pQS7Uhaol4yK6lpKGsrxh0z/cFfH91XrS5oQqUjfLxqIKb7BB9pPyvaVANxwgVG3NT
 cnGyDla8rNeajIfMMAiJosgi9oHxTkm22vSHrIJ6u3MBvxi+gsCSBrweGJ3uxnUUIHsd
 TtaTYEfNvdMuX+K4JHoEPBEVQ0YJxG4DJWGsZb9X6e4NzLis8z/1KWNgYNebbiG9hJSn
 nsqod7KBvHRu2H+xGBQoaXedbnDtiJLBzSXrHm+0T3XRqI6/y7S1ySm6UQ5AVUMfqSje
 Mn6Fy8zglcI31sFd0gnbqlXvoX1WCn/UcGieQt44X8ylnDWzRiUWz+3tpLnKI6xcfDCI
 hM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468434; x=1692073234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCYW5Fbo8ML/tCCBvqIHvoVVLyR1VjX2xindXtEVGn0=;
 b=ga94geyqM/Ir9Sqtqx5RYx9DZl/XtnswYreMTtwaSAsglKSkgbzv39DErZ2FVqJZyr
 U2m1/OP9bvMweGkeDkOFeukJuUcwG/YfJGr8QOKh8rN0qI61U769aC/7aNMaJK+SzmOP
 yZNv3rG8LxmtW3qe1XeiI2pcRrVDgr2XuqbxWtGhKoXvXQyehir2d4nRJiZmHUcRVYTk
 EW2E5B7y3p3zeQIzL/eVGfJSTpyYOQj5BICSsxT3Nzldp43uzravWpgbH9MUwICXNrR1
 sZc15Hn66UjewWOGdKVN8104mn1+m+RvQD5LBZfyO3dVQ9JdqXM0gi9CJxF5KDZkezdF
 M04w==
X-Gm-Message-State: AOJu0YwZ3VCXB8ZdUYtZx/LEHN2n/0j1zxrKhOmHqUK+8QIWeVrUCCM3
 3Hiw3/zRIpC6AuFrjt9O9cXJAZqVL0M=
X-Google-Smtp-Source: AGHT+IHMw/YKVwyF1vcufk4rQmthzA5F27qV8KqBczVBhuXHVzKbk0OQ8yqB7R/VpJ3DdHZgD6x0bg==
X-Received: by 2002:aa7:88c2:0:b0:686:2fde:4d6 with SMTP id
 k2-20020aa788c2000000b006862fde04d6mr14317971pff.6.1691468433947; 
 Mon, 07 Aug 2023 21:20:33 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 05/19] host-utils: Add muldiv64_round_up
Date: Tue,  8 Aug 2023 14:19:47 +1000
Message-Id: <20230808042001.411094-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This will be used for converting time intervals in different base units
to host units, for the purpose of scheduling timers to emulate target
timers. Timers typically must not fire before their requested expiry
time but may fire some time afterward, so rounding up is the right way
to implement these.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/qemu/host-utils.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 011618373e..e2a50a567f 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -56,6 +56,11 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
     return (__int128_t)a * b / c;
 }
 
+static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
+{
+    return ((__int128_t)a * b + c - 1) / c;
+}
+
 static inline uint64_t divu128(uint64_t *plow, uint64_t *phigh,
                                uint64_t divisor)
 {
@@ -83,7 +88,8 @@ void mulu64(uint64_t *plow, uint64_t *phigh, uint64_t a, uint64_t b);
 uint64_t divu128(uint64_t *plow, uint64_t *phigh, uint64_t divisor);
 int64_t divs128(uint64_t *plow, int64_t *phigh, int64_t divisor);
 
-static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
+static inline uint64_t __muldiv64(uint64_t a, uint32_t b, uint32_t c,
+                                  bool round_up)
 {
     union {
         uint64_t ll;
@@ -99,12 +105,25 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
 
     u.ll = a;
     rl = (uint64_t)u.l.low * (uint64_t)b;
+    if (round_up) {
+        rl += c - 1;
+    }
     rh = (uint64_t)u.l.high * (uint64_t)b;
     rh += (rl >> 32);
     res.l.high = rh / c;
     res.l.low = (((rh % c) << 32) + (rl & 0xffffffff)) / c;
     return res.ll;
 }
+
+static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
+{
+    return __muldiv64(a, b, c, false);
+}
+
+static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
+{
+    return __muldiv64(a, b, c, true);
+}
 #endif
 
 /**
-- 
2.40.1


