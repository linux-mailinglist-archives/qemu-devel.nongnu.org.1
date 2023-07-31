Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6F768F88
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:04:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNsW-0002Dm-3e; Mon, 31 Jul 2023 04:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsS-0002CR-N7
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:40 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsR-00060R-6Y
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bb775625e2so26318745ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690790618; x=1691395418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdY2jz5owuzZfQl4B7CvgdbQ9JW8e4qk8DsaUFELJ3w=;
 b=rmJSkpY75v35otj0qRIK6lNDFFt56TfGf/rl/SxXHNbc8FGpLLukws7YevwbUxUw9S
 /j5+qP8OiLpZA4GnApGhnG86shqHi2CZtdoI4A1cN6V0VDV+TLmXh544225JkjfxcRF+
 zkVpk7hfoVLX+i1wxpqn1t3OshyjbwXKM4cQL+uDrTjHUOlBf2dgwUe7qqEd0SkfCz5e
 fLL145TnPQYcxY7bTNUPGKXJ40N/hTGtVEBpvV4b8sEF3kE659Q6C0nUCA3PuQMWSQRb
 yo4a9dhYoq/JEE3jwylFe5k9U9bg7x2X3YE/BIRnuDF0lIR4jVFpfIw55MdOaM0kmOTY
 X0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790618; x=1691395418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdY2jz5owuzZfQl4B7CvgdbQ9JW8e4qk8DsaUFELJ3w=;
 b=eYkz0Qe/hagAeQSSQ6GAyONKKUhOta11OVKt+K9wdvyIoUL6TRs7kdjOUH/3Ko2Kqt
 bK3ZDSPzk7V5rS91AXhNf/H5189lsoQOAkWtlfGxyaUV/ra7XQnbwfilnr0YxkJdJSxd
 6ZxUoLw+MvFqfIWxnEMHk5/1UmZxaXZ+B8BZwo83Z1pSiH3B4AzZXthcv0mZcqj14pMK
 CoIOqurQgSpEHTIkjci0UGBzY8ZEDHu/qtmxpLZe+zP8x1yDYa03boVhIxZ8YHFWslk9
 L7W+HwpSVK4FmbIxa3pYgOSSVLtPaOCdfAi6wsVbG+rsdIHtRGJcLMMmxwX1q26eOwVW
 yPbw==
X-Gm-Message-State: ABy/qLYG1kqkfSst3Q4MOKP3qZn38ZiAvBz4bfA/hu9WWGETCNtp45wF
 IuIUeTwwvEQ3imjN1nSXAWmLorOCcXhEs3XgSmc=
X-Google-Smtp-Source: APBJJlGKjPMdlALwK3Rt9RfSqlGXPTp1GCDtvWV5XoqcVAjHUXopYJR5wsP4X3rW0pXtYcvFKbAGMg==
X-Received: by 2002:a17:902:da87:b0:1b8:6952:5381 with SMTP id
 j7-20020a170902da8700b001b869525381mr11603982plx.9.1690790617621; 
 Mon, 31 Jul 2023 01:03:37 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001b89466a5f4sm7883559plb.105.2023.07.31.01.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:03:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 4/5] linux-user: Do nothing if too small brk is specified
Date: Mon, 31 Jul 2023 17:03:13 +0900
Message-ID: <20230731080317.112658-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080317.112658-1-akihiko.odaki@daynix.com>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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


