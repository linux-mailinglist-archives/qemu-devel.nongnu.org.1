Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4813781C78
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaUy-0003yq-E6; Sun, 20 Aug 2023 00:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qXaUw-0003yi-H9
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:57:10 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qXaUu-0005Bz-Dp
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:57:10 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34ca1aadce9so2333015ab.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692507426; x=1693112226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J2yKTkpaT931aWU7MGIffwhJ97C7QeB+wRwkIBaugNU=;
 b=JSEDXJNLNqR/XMA0Zo18Fnv0yOlA1ccCD+RqYmTbQAmRr4Q/OXtNt632MrI0Il9fCf
 ZPoWWVbNBAnRboUmvs7eRuVZmUDDVRJyGTFWCiNHQYFEy4sKq2Qic+pDxTHRIiv5nO5M
 01JaPnl8ZJq2W7/51YHIWyoseGSrnszJJbn9FcEdMtVvl0avGKN3Fbv7IejyA3clidz5
 t2F10wUuBf194x81NbN9+Wg45oaUTtnCTgxwgzNXRv+PsfmPqVOGZip7x5dFBV73gIJO
 nKU7NNiJA7MS2zMqDe2vK3T9yyJExgjNwszH/XELJw5VOjY560J66cBjQSl5YnFgGyPW
 lmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692507426; x=1693112226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2yKTkpaT931aWU7MGIffwhJ97C7QeB+wRwkIBaugNU=;
 b=Z1oQIV45nYuJjzZwVNOHpic2hREbOT155XWi9Bj1Huucsla9uQd5Z3W1YfosoKW9H1
 +ADYvrlyIdbqmZl3QZOnLLAfbEeQpYX7k87AkWeSwFXTSGzWvEJ8evt3Nds+ctoGTAns
 ZSdkSghuHUrFGK0hVebR1X+1sPJ2sWcMlaIeRjBy4aXfNNutAuZQKN6k+1hshyc8mxdY
 2gkiZRuKVSOBzwLqoBqU6+7mCJCD79PtoK9aRF2nfUTYpJwPdfPykLdA+wmfOoWK1kiC
 53Jvya32N7YHp2k+OT7K/R1pigHL4jwZ4wYc96eLTuEbVDg7LMJZdMowWj8xp2QcOyK8
 8HhQ==
X-Gm-Message-State: AOJu0YyukGg8Rqpoh3Rq/Azig5Yia76dmbptvrIO9P/EibRyqC7Mak52
 2eKpVyQsPu3DlSFzLH1Lj4mp3qieQcfUhyJL9/E=
X-Google-Smtp-Source: AGHT+IH6U9vnzoHf/jLwEF8PFMtyMUbqo6aFLWJ403rSK5Q+ENCBAUw+XgWXGEQ11xV9JyRBTA6swQ==
X-Received: by 2002:a92:cb44:0:b0:34b:aa34:a5ca with SMTP id
 f4-20020a92cb44000000b0034baa34a5camr4263391ilq.4.1692507426350; 
 Sat, 19 Aug 2023 21:57:06 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 v9-20020a02b909000000b0043167542399sm1592566jan.99.2023.08.19.21.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 21:57:05 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH] bsd-user: Add missing break after do_bsd_preadv
Date: Sat, 19 Aug 2023 22:54:19 -0600
Message-Id: <20230820045419.89691-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::134;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x134.google.com
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

Without it, we'd call preadv, then write with weird parameters, which is
clearly not ideal...

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index de36c4b71c6..c90400abecc 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -248,6 +248,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 
     case TARGET_FREEBSD_NR_preadv: /* preadv(2) */
         ret = do_bsd_preadv(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
 
     case TARGET_FREEBSD_NR_write: /* write(2) */
         ret = do_bsd_write(arg1, arg2, arg3);
-- 
2.40.0


