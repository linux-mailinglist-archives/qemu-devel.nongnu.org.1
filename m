Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0D91B5A0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 06:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN2sP-0000Pj-Dp; Fri, 28 Jun 2024 00:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sN2sE-0000Lg-QR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:06:10 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sN2s8-00036F-5g
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:06:09 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d562882f4cso124719b6e.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719547562; x=1720152362;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QEi5+8U8YJj7uqGzkrc9EazSHbd0EQel3t1dgAbMB7k=;
 b=IQs4RwUtCxB6NQa7xJoi4uScTCDQeRN67lZ0ZLHrYirDiCEgUTbK+5uPNS3eCExM2q
 UkMKO1JwtnAuxmPy/J06e9dnVsEVLAiM/kgwqDLvgoOzuuu5LBwlQGWWhOG8MR/vIAwO
 PZAhiyJpZ85lnxx4olTjvXW1i5ZALB3sjsMMXlwosg+fQUzxa0Vv63Rd842GnBOxpA6I
 CjD/5MxnxNNoUSFuaNb7BQ5bPVktMb6TbXu3ij1uCQEyhAMBgLriLLU2M3s7xVvChGl+
 zgk/eEhvpZ1HzK/YwZZzrExhUyWAL5lZTSD6uAqTJ7RStLp86kriEynchFRUlP+Q4grd
 WFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719547562; x=1720152362;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QEi5+8U8YJj7uqGzkrc9EazSHbd0EQel3t1dgAbMB7k=;
 b=QqbqFiyUkEQwgRub8BOHwlxPMWmwzOrrIKZZ/fglkFcNKgs7SPzP80Pz5aIxo+OHCP
 +e0/IyN5kt44k0N3Owis3SP4wgRFUuwgqOmXvTQpTCPU5T5NbtAGm9whZKm0JeARdveU
 O1cxuDHhFRtqSueok/yD2SCzMAjM0XrE+yLHVUXsctQFeE/S9eMIwDR81phHPxt6g2BY
 sj9VqksM1Km9bR6JrmZyGlfPjRtRtsVKkMD2ojWgOLT64r+EV+hjraxXTOhc2wlK//v7
 +aOJ3cRKiGm+Zgd9XFfjLrPljk/Uad1+JF1WryDzsCqKHt7TuX8KjRXLYWxACi9Ee/SL
 Abyw==
X-Gm-Message-State: AOJu0YzuBlGu2AZ/h1NyJJRlCmR48AgCjRzGI0RyMXkqyiNj38BWey0Z
 qud7BOd1nAAKl+2iw06WV8IsE68FzJ9Ku6ZvNoRfaZ1cYDBmixen6fkSp3ULgvw=
X-Google-Smtp-Source: AGHT+IGQ/E6Xdv9+Ri5o8NdQkZ51QP2DRnMOm8QBpbiIHgWo3GK6KOoS1RZFnRbifTDRUAJezJUeBQ==
X-Received: by 2002:a05:6808:1b0d:b0:3d2:1d67:13e4 with SMTP id
 5614622812f47-3d545a52de2mr19554551b6e.36.1719547562396; 
 Thu, 27 Jun 2024 21:06:02 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7080246c8edsm533428b3a.58.2024.06.27.21.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 21:06:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Jun 2024 13:05:52 +0900
Subject: [PATCH] system/physmem: Fix reference to dump-guest-core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dump-v1-1-c581d10f3646@daynix.com>
X-B4-Tracking: v=1; b=H4sIAJ82fmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MT3ZTS3AJd8yRz48QkQ4tkY8NEJaDSgqLUtMwKsDHRsbW1AM+uwLB
 WAAAA
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

dump_guest_core is exposed as dump-guest-core with QOM.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index b7847db1a2c5..effa97184f25 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1521,7 +1521,7 @@ static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
         if (ret) {
             perror("qemu_madvise");
             fprintf(stderr, "madvise doesn't support MADV_DONTDUMP, "
-                            "but dump_guest_core=off specified\n");
+                            "but dump-guest-core=off specified\n");
         }
     }
 }

---
base-commit: 046a64b9801343e2e89eef10c7a48eec8d8c0d4f
change-id: 20240614-dump-7b73ab18c31a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


