Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96031AF6256
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 21:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hT-000852-S7; Wed, 02 Jul 2025 15:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2h5-00079b-Te
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2h3-0003X3-S2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso7748605f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482825; x=1752087625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llrZ7gc2yCtOz59p3Nw/rqzAevesIHtbma42LIMfbw8=;
 b=N/+1bslpIyhk6+LGwFuay43GGehPtdaW7uP7Rit322kmBGG6GFqx1cJHgrUzQY8si+
 m5qSPzv5i8Lh/niyMdUyKnBtpvWff7+Zgyzp24AJnlCWlydgWilrjkda9/MkehhHb/w8
 prfFkI6J7U33k4MsdRyk7cyB4awVwJ7suTvTO5CTLXXyEOry5j1wv5yExtB0afuVryzM
 Vll4naK6dtut65WBhhM9LuXyeZmOdDnIvwktJyeo774K/W3TdXHF7jZpb3conBat9aBm
 h/ooLCuxpcbNvQJDLXsl5crRqZRZBd3jLXicNphIzV/T+RkcNAvx7aYkHhSVHeX4n+A7
 tXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482825; x=1752087625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llrZ7gc2yCtOz59p3Nw/rqzAevesIHtbma42LIMfbw8=;
 b=wv0dS8XXqzvzItvsdtNQNFze3GwJEZTGd7e5Vq92MTYymiwHkZXOmOqHacorCEKO2d
 9jDGYF1/xGbNMM/bJyK7fLOEJKtuZwqkMm5WCFjw7RoerL1VYywKrojD791Imgq/YYjk
 Rn5jUDEqU2NX0/H2ad0F2X4y7cT0nDMEE0EfLpqHhytFcUT2kHDM0IeOxqgiJJ3vxRcw
 hJWVwsu8NCBbiCmFcbYEpQd8EPQ49bi2DQHkKo1NWAGADWhsoy0WnN9eHb82NqfApk1Z
 GAcPJGliH0gFQch+cD+IGCsc8Fv2hXoJS01vkkOs5LUtmzvG/umSEntkv1X/j0MB8Z6R
 E3DA==
X-Gm-Message-State: AOJu0YxLt59J680YCGGJJaG8TUyX9jroSrul2T1SyPKoFvJvmr51V1pc
 h9ffMbqXCu8El9us4mgYXCKzp7E/xOqc1PbhKHYUFy7B11/W0sDDxZkmjbzTNsXaeaQfVy0H+Xo
 pC3ja
X-Gm-Gg: ASbGncs7e76+cnHyXnG9CyeeeSoZgLORm8fy2HC1FpjlvV5+ODmATSI3QUe0D18Wk6r
 bkraT9Zoh12fkISksoor4hg9zOdh+pbq7DPRHRwedeqdNnlArqLv6zc5kf5okhDLkjfj/QOUuEu
 TxX7bkT3AH4rx58J171/bYNAvnQ+vPHkd6xXCGhj25sOPX3lau1aY3ppppoqqARpNpjgka6O23u
 IXgFZt9b2CXV0fQQoOPIYVbNaBU1t5gt/pUTu/XQVmGhMLufCQDT//oRhujOUDMeBi3Q1MT43kO
 lAFD6RJKGAbqBXK0YldnNbwwu3QLm3E0oeAZjtDMUCIC73Jsd5I2N21/5qhXjmFjsMVkZifeV7E
 YKMiQ9S4DhU6Hhy0oQhWWGngnpBPsERAi2MzpOaooBq+OfZo=
X-Google-Smtp-Source: AGHT+IGKL24UNmCkiRhem9VsoWP/8UpU1Vk+VMZRqpAeORpUrjtABi2SGSU0CZErzDH1g8QzoPWKJQ==
X-Received: by 2002:a05:6000:2b01:b0:3a4:f513:7f03 with SMTP id
 ffacd0b85a97d-3b20077164amr3084128f8f.44.1751482825346; 
 Wed, 02 Jul 2025 12:00:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9978c83sm5762955e9.13.2025.07.02.12.00.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 60/65] system/memory: Restrict eventfd dispatch_write() to
 emulators
Date: Wed,  2 Jul 2025 20:53:22 +0200
Message-ID: <20250702185332.43650-61-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Commit 8c56c1a592b ("memory: emulate ioeventfd") added a !KVM
check because the only accelerator available back then were TCG,
QTest and KVM. Then commit 126e7f78036 ("kvm: require
KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH") suggested
'!KVM' check should be '(TCG || QTest)'. Later more accelerator
were added. Implement the suggestion as a safety measure, not
dispatching to eventfd when hardware accelerator is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index e8d9b15b28f..b072a6bef83 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -25,7 +25,7 @@
 #include "qom/object.h"
 #include "trace.h"
 #include "system/ram_addr.h"
-#include "system/kvm.h"
+#include "system/qtest.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
 #include "qemu/accel.h"
@@ -1530,12 +1530,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 
     adjust_endianness(mr, &data, op);
 
-    /*
-     * FIXME: it's not clear why under KVM the write would be processed
-     * directly, instead of going through eventfd.  This probably should
-     * test "tcg_enabled() || qtest_enabled()", or should just go away.
-     */
-    if (!kvm_enabled() &&
+    if ((tcg_enabled() || qtest_enabled()) &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
         return MEMTX_OK;
     }
-- 
2.49.0


