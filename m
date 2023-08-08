Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F587739F4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLGo-0007zn-CA; Tue, 08 Aug 2023 07:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTLGm-0007zB-7n
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:53:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTLGj-0008W9-5t
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:52:59 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so35959175ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691495575; x=1692100375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C5bVzf/kXW+6y8ZBQL8fmchmVsCziEs+FsRsNhOCy4k=;
 b=4UnOerjZiESiyfXrzuilw2u3PqXRgb1oT1fSP+rsM0qW/34v31SLv6L4nMtLDdeILZ
 KBz9pJVgxcH/zRR9Py2XmdJsL/XSDUhxkNDVzV7pZT+mNPdaj+mS4gE/LLLOgaQbmTjw
 OXbtU39LWdc8L+8XaJBEtIBTFL0WxCYO/HUC0gGWQjHd2Jso5o5GS/VxqvpyxezsSOyU
 7Rbqvfrd+2BMvjwCp61UQWvzGPVooUdlAI8d3gbZP2LoyUW/XpuSSI2iaL9KVQUDqvGe
 BXSAsK0jqED36pAat204ySyoVk6J5IHnwmX72rGwwjEo9KwEqc6ItvUPjgzX1D9m9Pco
 aWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691495575; x=1692100375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5bVzf/kXW+6y8ZBQL8fmchmVsCziEs+FsRsNhOCy4k=;
 b=Em5yO0YCsCTKZ/5u1+Hpqdkku6Lu3jts9RKLdUXyS5nk4gsgqiQoFwNiy/yZ/Fn3Zn
 1y55jOHlSx/0r0EQnJL4lcc1KOuM8yqkBBD09Mo+j+0NayWKpMKC75ZvDDNtphNinmPT
 N7lGLWbuy8foTJ4gaAnyYMezv8RtlCUKXx1MRnpZRNMZQbK7c0V/V8q22SRTZnaR6YrW
 VQf7bC13hDQLGImk0DNbw7oJI0x5MirDPkqvXbrO4I0Z9Zg+tcwre4WWs4k765vb2zfB
 4uaAFkCTn4LsWCDJGcg1lvIwjs6YK0Vpu1VAmIgqwyFG7muiIixO10Qs/p2SNlOWz6P3
 L8hA==
X-Gm-Message-State: AOJu0YxmD3lO7JakwjBGUIbOKjaBLgG/fvaRlARt4wJcHZMjYMo0PThl
 jnRXb8SmScZx70+6BgcIsXWW6g==
X-Google-Smtp-Source: AGHT+IH0Bice8Pzlv44PGFJcqbIbd55iBIP9o/PUmCvGtROXmVtBGT1LgqCieRZq0vQTMGzsG8Rr/w==
X-Received: by 2002:a17:902:c101:b0:1b5:edd:e3c7 with SMTP id
 1-20020a170902c10100b001b50edde3c7mr10356699pli.16.1691495574595; 
 Tue, 08 Aug 2023 04:52:54 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a170902dad100b001bb9aadfb04sm8831390plx.220.2023.08.08.04.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 04:52:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1] linux-user: Define real MAP_FIXED_NOREPLACE value
Date: Tue,  8 Aug 2023 20:52:38 +0900
Message-ID: <20230808115242.73025-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

do_brk() assumes target_mmap() emulates MAP_FIXED_NOREPLACE even when
the host does not support it. However, such emulation is not possible
if MAP_FIXED_NOREPLACE is defined as zero.

Define MAP_FIXED_NOREPLACE with the real value instead of zero if it is
not defined.

Fixes: e69e032d1a ("linux-user: Use MAP_FIXED_NOREPLACE for do_brk()")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/osdep.h | 8 ++++++--
 linux-user/elfload.c | 1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cc61b00ba9..1aac17ec2f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -289,8 +289,12 @@ void QEMU_ERROR("code path is reachable")
 #ifndef MAP_ANONYMOUS
 #define MAP_ANONYMOUS MAP_ANON
 #endif
-#ifndef MAP_FIXED_NOREPLACE
-#define MAP_FIXED_NOREPLACE 0
+#if defined(__linux__) && !defined(MAP_FIXED_NOREPLACE)
+#if HOST_ALPHA
+#define MAP_FIXED_NOREPLACE 0x200000
+#else
+#define MAP_FIXED_NOREPLACE 0x100000
+#endif
 #endif
 #ifndef MAP_NORESERVE
 #define MAP_NORESERVE 0
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 36e4026f05..9d9c79a653 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2807,7 +2807,6 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     /* Widen the "image" to the entire reserved address space. */
     pgb_static(image_name, 0, reserved_va, align);
 
-    /* osdep.h defines this as 0 if it's missing */
     flags |= MAP_FIXED_NOREPLACE;
 
     /* Reserve the memory on the host. */
-- 
2.41.0


