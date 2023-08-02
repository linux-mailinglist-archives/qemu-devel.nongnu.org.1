Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A00A76C64C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR67y-0007bk-JK; Wed, 02 Aug 2023 03:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67b-0007aA-Nb
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:20 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67a-0002oh-7u
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:15 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-56661fe27cbso4395284eaf.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690960692; x=1691565492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXFcqmHho+ugFR7XQfPhKsdc5kffqTAo6APhg2JvIkQ=;
 b=xTH2eYJfTZyhPX7K+Q4ZqSNnZd3+3Dp9UXy6tpuh4TzzQJUCnAadV20dajBoGcZfnc
 sZEyNWsoyzNM12ROgYmunVrpN/u5TZ5ECssm11xE9gTWoCoxEHqBkohWh/7Cs0H+6AMA
 ZC6crjOMotqnWiaCSe6JQabGW04gg9i5ArRrC9YeS6/lCvSOe5ku4P8tDGJ3PFKd4tMH
 5xPFVwnUiIJwj8+f4/bCyfWPv6oruJEHAosz7HYe3UjyREHWL4N+sjjRBKtQP5v3ynaY
 oKCHoNhTtJV4oCznfvhXrn9vl4egYl1cEc+76KzSqLjlaHAF5obvQ/PYUYqg9buwh6Gt
 C4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690960692; x=1691565492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXFcqmHho+ugFR7XQfPhKsdc5kffqTAo6APhg2JvIkQ=;
 b=cg/vmLWqvROjhOGw8CthSiBC9la3fV+amrPUMruiR6iHkrn7BpPrf7NYvzZ2abdRpj
 w+9pGeCGORdOub2PCbOLzkvZL1qYXFSo+y5Y3xTcBnytkD9EqnKyFYaN2bvnaywvxfuO
 n8Z6NJm3yu437WKnvlyte2PLffV9LlWlixu3D3I+Q0pYzIx4hyWMgagebNrAS+Dv9tyW
 r2Cwo8WpQxm31TjrpLjlDvr1CG/lLdWwLHbV7Zchp9ibjOGUBwIgm4GRLYrSg49MMiU/
 BRKMjKXHAWaidPP5/1gZeHRe39/Qcymwhlhy92op9vFughWZ0xl70a1IJ1P8NfN8XxBf
 ooeQ==
X-Gm-Message-State: ABy/qLZAC/FwMv9vn6dUh0TdJVbozErMKKsRL7OX+KnNhNXxNKPsCMdV
 d8/mCdHcsgOo/bQztbFH3u5zMA==
X-Google-Smtp-Source: APBJJlFnCFvjqvI2pzFlGFvlvxFRqNdhbTZV1rpaz2sVZ0MxqW2jH2OPvEVWidItBMfJe3GT898H6Q==
X-Received: by 2002:a05:6358:4429:b0:139:c7cb:77d4 with SMTP id
 z41-20020a056358442900b00139c7cb77d4mr6462436rwc.24.1690960692581; 
 Wed, 02 Aug 2023 00:18:12 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a63b20c000000b00528da88275bsm11004440pge.47.2023.08.02.00.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 00:18:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 5/6] linux-user: Do nothing if too small brk is specified
Date: Wed,  2 Aug 2023 16:17:51 +0900
Message-ID: <20230802071754.14876-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802071754.14876-1-akihiko.odaki@daynix.com>
References: <20230802071754.14876-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc33.google.com
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

Linux 6.4.7 does nothing when a value smaller than the initial brk is
specified.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ac429a185a..ebdc8c144c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -820,14 +820,14 @@ abi_long do_brk(abi_ulong brk_val)
 
     /* brk pointers are always untagged */
 
-    /* return old brk value if brk_val unchanged or zero */
-    if (!brk_val || brk_val == target_brk) {
+    /* return old brk value if brk_val unchanged */
+    if (brk_val == target_brk) {
         return target_brk;
     }
 
     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
-        brk_val = initial_target_brk;
+        return target_brk;
     }
 
     new_brk = TARGET_PAGE_ALIGN(brk_val);
-- 
2.41.0


