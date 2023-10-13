Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C94177C7D58
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 07:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrBCb-0004vf-4M; Fri, 13 Oct 2023 01:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qrBCZ-0004vN-6Z; Fri, 13 Oct 2023 01:59:11 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qrBCX-0007zb-OY; Fri, 13 Oct 2023 01:59:10 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c49f781855so1119247a34.3; 
 Thu, 12 Oct 2023 22:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697176748; x=1697781548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rbnNW4aTZ3zGnVnGVrKDK59ktqJ9qZ/3V996CX6ob0=;
 b=VfsDj2Gd6CC5E9tlwQ8eC7vSFDRSjN1Bn+7MluWosAAUwbDzwFyNbuHExNYck/vgM+
 99jwTV5xlD4WyKQlSE5wXWmPPgrYAbmiduUz3CBFvCH/x7BnjBEYwv3RllD/6rfLmv+O
 po8lW9KCXFD9wN3fLsx9dI7hWTgmbg9bqFps2I+IwNWYVCTKFe0t8R2uRK9xF4Ged0s6
 4DXOENTmF5nZIgj/OR8MjyuvWqwybTs4/uyWDb0F9/dAnI3HZNyKRrbYBHqUBJQsTHXW
 edB3nCNbHH+oT2HKGFv6DWhDjs0n9MfwN6dgC0MPjnWC7mgJSW+ZuLlbC7s/RLR2PAAA
 Hzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697176748; x=1697781548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rbnNW4aTZ3zGnVnGVrKDK59ktqJ9qZ/3V996CX6ob0=;
 b=Wq0g5jR0qPhO3HN6XlyXrUvffy9LvC9IlCFuAeiuOT9tIdlp3wvrSkvRkSuuZl+/00
 eRJccp+eHR9kwfRDct77ABC2W4Oe33nSYufb2St2UFvVp2YJJ8gvLZxi2nx+n5jalp2Q
 jlwoB/ZJuTcAn3go3jueedNGtt3858s1I91b1TZerLrgcXjdKVhdqi4TaNbwCrW6v2gZ
 gXiooC3FjrlWzCMAtrPkthMbxUvIBour3pmqDYw0QxcJS7kS1nd6uPWOzzqbnmC8XzyM
 9xLJ149mD9Pu3+zShyKwcqf2yW/LQ99PdJXBeuyMchbx8fjCEwZPJ3slIfgNG3mSKrDZ
 /zIA==
X-Gm-Message-State: AOJu0YxcWF3/BA1ftg9EJYYUW6zc/pnhie06hYg2j9kh2Hw2z6FKXu1h
 BGaymG29x8uQIGWsF42+K6I=
X-Google-Smtp-Source: AGHT+IH2B0likiTY/PryLEa4LnQi4NoJJ37wrLGXbTXtXAPaS5ZFF2mgDvIMejnpEcgIr+EkPlvpNQ==
X-Received: by 2002:a05:6871:220f:b0:1e9:9833:daad with SMTP id
 sc15-20020a056871220f00b001e99833daadmr6238960oab.4.1697176748156; 
 Thu, 12 Oct 2023 22:59:08 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 6-20020a630806000000b0056c2f1a2f6bsm394071pgi.41.2023.10.12.22.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 22:59:07 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: stefanha@redhat.com,
	qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 bmeng.cn@gmail.com, Bin Meng <bmeng@tinylab.org>
Subject: [PULL v2 2/2] hw/ufs: Fix incorrect register fields
Date: Fri, 13 Oct 2023 14:58:42 +0900
Message-Id: <ebca80bbdb5c1650e4b753a3d13b43634e7dfe05.1697173210.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697173209.git.jeuk20.kim@samsung.com>
References: <cover.1697173209.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

This patch fixes invalid ufs register fields.
This fixes an issue reported by Bin Meng that
caused ufs to fail over riscv.

Fixes: bc4e68d362ec ("hw/ufs: Initial commit for emulated Universal-Flash-Storage")
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reported-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
Tested-by: Bin Meng <bmeng@tinylab.org>
---
 include/block/ufs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index fd884eb8ce..7631a5af10 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -111,14 +111,14 @@ REG32(UECT, offsetof(UfsReg, uect))
 REG32(UECDME, offsetof(UfsReg, uecdme))
 REG32(UTRIACR, offsetof(UfsReg, utriacr))
 REG32(UTRLBA, offsetof(UfsReg, utrlba))
-    FIELD(UTRLBA, UTRLBA, 9, 22)
+    FIELD(UTRLBA, UTRLBA, 10, 22)
 REG32(UTRLBAU, offsetof(UfsReg, utrlbau))
 REG32(UTRLDBR, offsetof(UfsReg, utrldbr))
 REG32(UTRLCLR, offsetof(UfsReg, utrlclr))
 REG32(UTRLRSR, offsetof(UfsReg, utrlrsr))
 REG32(UTRLCNR, offsetof(UfsReg, utrlcnr))
 REG32(UTMRLBA, offsetof(UfsReg, utmrlba))
-    FIELD(UTMRLBA, UTMRLBA, 9, 22)
+    FIELD(UTMRLBA, UTMRLBA, 10, 22)
 REG32(UTMRLBAU, offsetof(UfsReg, utmrlbau))
 REG32(UTMRLDBR, offsetof(UfsReg, utmrldbr))
 REG32(UTMRLCLR, offsetof(UfsReg, utmrlclr))
-- 
2.34.1


