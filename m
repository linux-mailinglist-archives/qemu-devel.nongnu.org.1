Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C17DEA4D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcW-0007qK-1m; Wed, 01 Nov 2023 21:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbK-0006fK-0R
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:26 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbG-0002A3-CA
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:25 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-565334377d0so288822a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888859; x=1699493659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=A0ZLAK+UHvh6L8H/lWaTooEHX/xqRWgBgwcnRiKpwkpMbzmh/Gj05m9+TkGPgFSG2A
 JZB8rmLT0qVlHm69tekYMGXMLchFxZpufxm+fShXAoNBUwNPQrOtheg8sFfRqclYAbAG
 JenZuSsu2PJqAJLjwPnQ/mBqDofBSulzlJl3jDpQLa0rB7vsDoIApaf0cWv/gFUN+87/
 O3YHMKnywei+1mcf7XMGhC61KtxdHZsKB27smTeTYJVEFnMelFnDxEQT+skG2Qw9sJxb
 8mk0HSWGXkPsC0QxNQppwChkSe+2gLpH8ZInh/56Aq6GYmJhFkkCh+YdPvTAFjqbAbis
 Jv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888859; x=1699493659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=kgXBsddYSCFMuHfdi1in8zK4/NFO0cr6X/y1+KOW860XOkR3ZuyqJoL73oKKmdtiwQ
 38s1LvpHUjeI7EKZiMOYOGDR3gEW8x6B/Ta8jtbgXBmCjGrs7WifjO6xIppCVwxTeS69
 Fm4XkUho86f2WLwX4XRa6PmMnjHk54QDtulCSD5nSwFucwLSYRBTR/hfQ2bVERPmLZIl
 Q7cFRjF00+gIA04MOArusPwjt/2/HhuB75rDcVfQw3uZlo+KU/QICyIZcnZ7zyoQItlg
 /PzQbnjzoVcoVvKlV8cK9wEQPyDtMB6uJb33Jgf0SOR6mbTlBCaS+POqau2/mCeVX+0f
 +Y1Q==
X-Gm-Message-State: AOJu0YwXKpms3S8KnbaSk79hsDTUvuIW+XXhybJFl3JwCUDGJdcQpAP1
 K0WVA17HCwH0IxL0UVmB6rVtADvi5mvqvCs+d2M=
X-Google-Smtp-Source: AGHT+IG1ywMI7inNidsaViA9dIP0XONtNQ+oul6040G7HtLgYSAOjvkaFDtGE8iDL8dja9Eq5I0V6g==
X-Received: by 2002:a05:6a21:7782:b0:181:731:89b7 with SMTP id
 bd2-20020a056a21778200b00181073189b7mr7317173pzc.41.1698888859652; 
 Wed, 01 Nov 2023 18:34:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 73/88] include/hw/elf: Remove truncating signed casts
Date: Wed,  1 Nov 2023 18:30:01 -0700
Message-Id: <20231102013016.369010-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There's nothing about elf that specifically requires signed vs unsigned.
This is very much a target-specific preference.

In the meantime, casting low and high from uint64_t back to Elf_SWord
to uint64_t discards high bits that might have been set by translate_fn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/elf_ops.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index dffb0e73d2..0a5c258fe6 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -385,10 +385,11 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
     }
 
     if (pflags) {
-        *pflags = (elf_word)ehdr.e_flags;
+        *pflags = ehdr.e_flags;
+    }
+    if (pentry) {
+        *pentry = ehdr.e_entry;
     }
-    if (pentry)
-        *pentry = (uint64_t)(elf_sword)ehdr.e_entry;
 
     glue(load_symbols, SZ)(&ehdr, fd, must_swab, clear_lsb, sym_cb);
 
@@ -610,10 +611,12 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
         }
     }
 
-    if (lowaddr)
-        *lowaddr = (uint64_t)(elf_sword)low;
-    if (highaddr)
-        *highaddr = (uint64_t)(elf_sword)high;
+    if (lowaddr) {
+        *lowaddr = low;
+    }
+    if (highaddr) {
+        *highaddr = high;
+    }
     ret = total_size;
  fail:
     if (mapped_file) {
-- 
2.34.1


