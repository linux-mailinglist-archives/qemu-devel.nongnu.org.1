Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7DA821632
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU2x-0003Ea-Kz; Mon, 01 Jan 2024 20:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2v-0003E5-UB
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:21 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2u-0006yU-Dp
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:21 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-35feb61c91fso30808955ab.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160698; x=1704765498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l62Z9VXoyvTMtkttPIPmMaK8R/9tk3/QfUP+wlVNz/k=;
 b=y4Amshy1Hp9nkLEcpNUUAsO/SoCyVfNmgYVZhmpwtW0lxL1xesQwmKsR5ZMf0lOgMz
 hWKVHDFBuT/R28bpz9WGHRtOdwDMn6XDNbBS15C+iM9SUUpY9gvtlt8s33ro2jsJO/I/
 EN+tl1wIfFEv7IYun6REkwyLiLWE3XHfy2DPAVuOdwOZ3BuLUmXBToAF+ge1RgEjUAg0
 gHlIcyc8txcKXHClJbPqxwQCNZzi+KWuiVww085DTeJ3Ao71ma/OzXMB5/9hBSJKHR+m
 zr1b03jjd2wKemSnTyDxb1ZvdKS6L+N1B8kZoktF0k17ANmINzW/O9tnd0q12oSqNe8H
 8uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160698; x=1704765498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l62Z9VXoyvTMtkttPIPmMaK8R/9tk3/QfUP+wlVNz/k=;
 b=DVIjhloKMzMWCkGRZgWr3z0oEdVZYhOGYCa77uXeoIVUTx2791/DdUg9RDijclPLoD
 ruYL4JGrjftiRiZuRgKmQ+hYKCfdeZZfWZ0yLbLyRL3GlTb0xWk2vh2tE0WqjLISM6rn
 EILzqPDkgYVcXsXkdJD/nLWgrLCye2g1SX1B3i7V41AnoBCWJw4KmW9bosQVkKqssq9F
 9/lIaVpv2LuG8WD3iA6ZF2BbcfaIkuP0q7S6AfWHRpISkOwAHSzivUPnz7gPRSCl8jGu
 Q/CcclMucMBls8exWXMgaZAypn+TrRLN4QCEd0LW/CWRztrIrkn+OOb8tPYJvxSTnmwQ
 0iZg==
X-Gm-Message-State: AOJu0YzemjoDqrJuzJ9+RwE5kj9GeQFp2b8nKz/ac78wTry3SCXvRcQT
 7MSycHJd7unJCom2FDr1zbTjeo+kRikFKWOFTJqUGFbpaJg=
X-Google-Smtp-Source: AGHT+IEMWqBKFdfumainh/u5vhap5ruY89ncyugK3RcufyB6OuRxZFoeCRrqKAdqlA/97KDDbaGKwg==
X-Received: by 2002:a05:6e02:1c4e:b0:35f:d727:1dba with SMTP id
 d14-20020a056e021c4e00b0035fd7271dbamr14346991ilg.63.1704160698152; 
 Mon, 01 Jan 2024 17:58:18 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/33] linux-user: Adjust SVr4 NULL page mapping
Date: Tue,  2 Jan 2024 12:57:37 +1100
Message-Id: <20240102015808.132373-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x136.google.com
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

Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.

We really should be attending to this earlier during
probe_guest_base, as well as better detection and
emulation of various Linux personalities.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cf9e74468b..f3c1e0fb64 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3911,8 +3911,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
                and some applications "depend" upon this behavior.  Since
                we do not have the power to recompile these, we emulate
                the SVr4 behavior.  Sigh.  */
-            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
-                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
+                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
+                        -1, 0);
         }
 #ifdef TARGET_MIPS
         info->interp_fp_abi = interp_info.fp_abi;
-- 
2.34.1


