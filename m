Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261976C646
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR67m-0007aE-Mt; Wed, 02 Aug 2023 03:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67W-0007Yq-Sf
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:10 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67V-0002oB-6U
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:10 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bca7d82d54so2180491a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690960688; x=1691565488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lE8/yJChDEcdbTP5nW5GoFaGsy88Nd8G8Gi+fYS3eUs=;
 b=V/rYY/BUEya6d7KBLM/cKCvCh8iD6jaHYfROyxZDYcEM/gAgjQ0wq0TK+8r3XbPYg9
 CVeSsNIjeHwef/2YdkFxPOomb81pY5fYK9zQV81yL0bm8NbvTMxxpgpf6Hp+wJ7L6dGK
 49grsJvU2x/AHAtDrPMqtQ4wYgKlLwRPoY/wQrPZqIzRIM86nKZpFZ8E5K94pw/JP0Y0
 L0qH6as7GZHTpdrrrINI+XxOGQRFCaI2gducNVi3immUHfK3cc/VMjwUp5LfmudXW+ta
 w9XgDENxRP86aceJuH7X43wmcbpPZuFWnoMaKsCOwtSSKaNO9qx+lGHjaUFwVNpUrtFe
 InVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690960688; x=1691565488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lE8/yJChDEcdbTP5nW5GoFaGsy88Nd8G8Gi+fYS3eUs=;
 b=D8j8+8QBuZY38XMNGevrwJzZVyUh2bSq182ce2ETOxHXma418k1UB8WLZcdFRtpXJt
 FFxHWn5p1XL22YeIUkTb9LGvXAPAl+pF1aDs5Kw45QRXAAuQTBVhv7IzO89+wX86w0I7
 zq4ZrXMYlaJaFhnslwdHz2H513zvIhyZXlO6WwNlDdZlFtaGvBBMFZxA/Zm5E92vyJtI
 DrzA7id9D+ErgQTHtjaWTCAxF1EnoYUKtJuGyehoWTtK0Jevcz+HsoDe9MtyQ1v5O/r+
 HyAPzjYEo4sz4FDjJWkGzKGZ3i/aFMw9lQziayZv15vVPwZ0JLOpvJvDyTH7KeIqNv4T
 qnGQ==
X-Gm-Message-State: ABy/qLZMf9R68pLiFE4AnpUAlgx9Kq1Ja2CTBA8EZwjzQWcjafZlMrAe
 qPL2iwHC3YBA/BC9GOj2z3fJLA==
X-Google-Smtp-Source: APBJJlEiTKLDWYm+BsTaKnoVz/XY32BHoy6lD5DjrZqGKt/kSG/fieD0hyyclA/OLLogLXMfdU+o6Q==
X-Received: by 2002:a05:6358:6f8a:b0:135:85ec:a080 with SMTP id
 s10-20020a0563586f8a00b0013585eca080mr4924403rwn.32.1690960687823; 
 Wed, 02 Aug 2023 00:18:07 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a63b20c000000b00528da88275bsm11004440pge.47.2023.08.02.00.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 00:18:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 3/6] linux-user: Do not call get_errno() in do_brk()
Date: Wed,  2 Aug 2023 16:17:49 +0900
Message-ID: <20230802071754.14876-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802071754.14876-1-akihiko.odaki@daynix.com>
References: <20230802071754.14876-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x333.google.com
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

Later the returned value is compared with -1, and negated errno is not
expected.

Fixes: 00faf08c95 ("linux-user: Don't use MAP_FIXED in do_brk()")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..b9d2ec02f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -862,9 +862,9 @@ abi_long do_brk(abi_ulong brk_val)
      */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
-        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
+        mapped_addr = target_mmap(brk_page, new_alloc_size,
+                                  PROT_READ|PROT_WRITE,
+                                  MAP_ANON|MAP_PRIVATE, 0, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
-- 
2.41.0


