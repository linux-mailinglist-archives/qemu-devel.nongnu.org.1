Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E560D768F7E
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNsS-0002CN-EZ; Mon, 31 Jul 2023 04:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsP-0002Bl-HM
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:37 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsO-0005zo-2v
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bb775625e2so26318445ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690790615; x=1691395415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKykz5Wsssds9S/3O933s/0TQLXH+UtBErA42CM1Ugg=;
 b=LZLtttVSqoVNhyBPcQXUCEnBVf73dtxl5hN7Mt9h5uDVaHBU/U4TBI2kVeM3lE/OU2
 MTOi1arr5qp4LmITL4LMWrVe2ABTMsRP1swFqxmSuEgqXpYiZ4HbFYDpoMVB7lKvzKEv
 tHWQLgV3WRiNFI+WAaogEWPajHInRbOqGn7w+vaba9l21BbC1vYN/TL6NvvENi0H8c7H
 NzAliuorJjP9h4XH9/fwzxfi1mnBykseLxBYJs5eh9PCvjOiGVwgtcVixe3mOactUGWF
 b8UFjWUbVW98Fyhk2jIohgrCh7EGH+OFVAIYzHbPvW4ZTnVTIdeQBzBAzjTtTBSyUU+7
 8LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790615; x=1691395415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKykz5Wsssds9S/3O933s/0TQLXH+UtBErA42CM1Ugg=;
 b=Y8qE8McRxBJwZMtMPZnx7t8vbSYZE4Jcdc+WFnE95j9ShBqJXKLP2kO8i+3oK9kjca
 OtHYgfCScGbSX7gLIIfO+WpHlM4UAc3jEl/Koof4K88wNSUzp9heAuDFnTQ4mQXFU5H/
 nD+Rn6Z29JXRjNeawMTphbfQ1w61AJAJQkSsYmG0+f93gj3sLoQV2dwbZkGr1QePK5aO
 U+GTw6RGAspF5pzFQsZHmAbinTxMIsxBXpArK4+onwjJmmMObmIvus2KWBiFvt3CuUEr
 afmhagsfudivJMvL5MrGGIsz//xsSEEw8JVN9mQuz28o6V+gIHBjOdXiqeZLWcLI3uYh
 AaQQ==
X-Gm-Message-State: ABy/qLbTciU6nhoxuSaR/Z6zhtZdE7o7lRZzBspCzI6NuniQo4KuhW6u
 gfjQxaz1kq8yt9dcTJyLaGH5igqldB24DRVJBuk=
X-Google-Smtp-Source: APBJJlG8i2K5iWLzc/YhtY6E+KaPKI3/geE28oCmkUaHaWqdOFx2tklpj0jC9BVuNnqFnTbx0HyrKg==
X-Received: by 2002:a17:903:30d2:b0:1b6:6b03:10e7 with SMTP id
 s18-20020a17090330d200b001b66b0310e7mr8083818plc.5.1690790614730; 
 Mon, 31 Jul 2023 01:03:34 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001b89466a5f4sm7883559plb.105.2023.07.31.01.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:03:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 2/5] linux-user: Do not call get_errno() in do_brk()
Date: Mon, 31 Jul 2023 17:03:11 +0900
Message-ID: <20230731080317.112658-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080317.112658-1-akihiko.odaki@daynix.com>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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


