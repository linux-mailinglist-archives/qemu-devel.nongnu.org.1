Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B755768F7F
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNsS-0002CQ-O7; Mon, 31 Jul 2023 04:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsR-0002CD-2f
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:39 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsP-000600-Gm
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bbd03cb7c1so25246995ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690790616; x=1691395416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOp4AdoD8Bkg7odyELEU2opCXFUALl4I3whyZmG1z+k=;
 b=dwR66dtxXEOvdgQUON0x5rThkA5uIRjdmLQuLz+5V7cu5lXxAQLc8DCYYIPoOA6sCK
 GVgwRbg5xQvwRi2RtbUttZJ8dDTzQkL/bcs3i3QW4l0oYr8WOR9fQKOAWe1+du28+Hat
 Co5W7Bco3E2Ys+ZedEPOtssEFOul5QiQ1vHd4EIBJEGmhunQYw5wWWH0RR7ZJsWpmvlp
 2bw+WPuH5fD9h9huC6WgCG0FjQcTnPJGaBAD99H6Pz7H9NGk3zbfQk9KnBYssDeA0vQw
 2+eSSgg6NmTkd/r6t89FvN7qi+b3VD3M+hLQ/Z1tDZGEU/Mqh1z6ybkpf+mvPrLj0200
 hrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790616; x=1691395416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOp4AdoD8Bkg7odyELEU2opCXFUALl4I3whyZmG1z+k=;
 b=KI5sbgUlo6hfPHz1F0MCLsQz0IpQ92hIMz7Li7poHC06zqbXzBv947cdPQk2E4tPN1
 /hkkh9UtesMOpsKuO81WLu6oZI8MGHefjQKwcJzLz2PbcuTiurrMElD6xPSPtrUjsc7k
 2i7UakqDMD/XQyGN+j0h+s76e6hLxbPeMCY8bc/b8P4eHFYZuD5yN4bHCoWEt6mW+X1r
 n37Vgwe9opBuyvHWdvHPrnyRypERg4NenzrsUPd99fhVhMT/PKZJJGS124nt8UkiXB7Q
 CHzan9UZo83TW2JAI++MSqMVHdMxT5M39r8t1znrCwGGQklDOTA8RtWWiFCJy5WYzi9d
 fw3w==
X-Gm-Message-State: ABy/qLav397eD/QD0ppW9C3w/bd5T/fb6NAm/Nw3D7fJKsAxvx+j/6RJ
 +oUsHr0zoTj3tbVYLi8mbm1gIRbSdDhyNVbXjKI=
X-Google-Smtp-Source: APBJJlHTRunyYGiU770e+tpFDx8VgoB8ZdLrtZtbWSlP7NR33vVpz8Y8vbZfjUrmMOyykwz2ZuAa7A==
X-Received: by 2002:a17:902:d303:b0:1b8:3dec:48de with SMTP id
 b3-20020a170902d30300b001b83dec48demr8485591plc.47.1690790616157; 
 Mon, 31 Jul 2023 01:03:36 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001b89466a5f4sm7883559plb.105.2023.07.31.01.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:03:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 3/5] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Date: Mon, 31 Jul 2023 17:03:12 +0900
Message-ID: <20230731080317.112658-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080317.112658-1-akihiko.odaki@daynix.com>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
concerning that the new mapping overwrites something else.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 linux-user/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9d2ec02f9..ac429a185a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -854,17 +854,12 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ|PROT_WRITE,
-                                  MAP_ANON|MAP_PRIVATE, 0, 0);
+                                  PROT_READ | PROT_WRITE,
+                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
+                                  0, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
@@ -883,12 +878,6 @@ abi_long do_brk(abi_ulong brk_val)
         target_brk = brk_val;
         brk_page = new_host_brk_page;
         return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
     }
 
 #if defined(TARGET_ALPHA)
-- 
2.41.0


