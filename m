Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA676C648
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR67X-0007Yo-TN; Wed, 02 Aug 2023 03:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67T-0007YJ-2l
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:07 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67Q-0002nP-9k
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:06 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a734b8a27fso1774811b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690960683; x=1691565483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwhyQWrYrTRaPWXxrhNy1oYg4FzuyUAbcs+xMqgoAhw=;
 b=KfnnQwMxvTspADCyE+ZezwsOOaTl5kW1LuPm9RS5vCP9bxidqnYboiPdQJC9B+cFgc
 fn7qXZ+U0rM9cZOcLORDMXskYo8VfLvkSXOJysFCodNYaAbKFKffi/FCFdAhChpi19H0
 ArRrZpYnwCGsMJZAB7ckkQ+RbpzrBcXEBA+TjSyqfRwEpIeZne+obh+jj8yTyUX1yu4d
 LrBOra0Cx7eGnfhvnsxtuzAtjZ4mAESbwv56r6y8j4gM8ca1BjosemqhAeK5HAL3p8/c
 5/hXXq5Kl3Ij1xjN2FBr1bGdHkbFSsg80NaxEheiQnsr/KTmqROb7vyqzjvVj1vZcNzb
 wbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690960683; x=1691565483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FwhyQWrYrTRaPWXxrhNy1oYg4FzuyUAbcs+xMqgoAhw=;
 b=O9cIP2EI1q+9Q7KW3VTxda6w0T0aERk/68ci6JVixusJkUOkfMxQ+eSO+tAZZhfVfg
 9J2410A5d7zVmTY8od2SbrVJ1kkTNQlAxfxwR0hb51XWe9QP0DddNPOp87wrSxpr/aGF
 vOgPDiMU+tieGWGOXlHO7gBvgGlah5lsBofRGZfizD/IqWHFdTxUcBKo7g3LvMkcbIGa
 nZTgYYTaLb8yaTwu2dkpRC7tLPTykI9VAscYGOBsGlR9asMXABBrB/2dYp1D9iJINRZA
 Bth0ntz/Fz0COxC8HLmhemhZOzx2Ll4xwDrwgRY39Lx6R0UE90B6Xpinx1uteqtja7tm
 hUYQ==
X-Gm-Message-State: ABy/qLakyEW6jpEEFNI/Xu/41PZCacLQuZeQbvsEHS07mIDUtlSmtUHz
 pI2Xa02A6Uzlx3GyAQ7JDlyJ4g==
X-Google-Smtp-Source: APBJJlGYqi/vWXoBh9ym0WilBKzP8JSMbNXV1XyHsAA2ucYZJbpLaNYM0evT77KPZb9C/j8i6CXrCw==
X-Received: by 2002:a05:6808:1708:b0:3a4:8a41:c69c with SMTP id
 bc8-20020a056808170800b003a48a41c69cmr16081119oib.13.1690960682931; 
 Wed, 02 Aug 2023 00:18:02 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a63b20c000000b00528da88275bsm11004440pge.47.2023.08.02.00.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 00:18:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 1/6] linux-user: Unset MAP_FIXED_NOREPLACE for host
Date: Wed,  2 Aug 2023 16:17:47 +0900
Message-ID: <20230802071754.14876-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802071754.14876-1-akihiko.odaki@daynix.com>
References: <20230802071754.14876-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Passing MAP_FIXED_NOREPLACE to host will fail if the virtual
address space is reserved with mmap. Replace it with MAP_FIXED in such
a case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 linux-user/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a5dfb56545..14cd1b9feb 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -610,6 +610,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
+        if (reserved_va) {
+            flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+        }
+
         /*
          * worst case: we cannot map the file because the offset is not
          * aligned, so we read it
-- 
2.41.0


