Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B378116E
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31c-0008Bm-T9; Fri, 18 Aug 2023 13:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31a-0008BE-NY
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31Y-00080C-JA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc83a96067so8710565ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378755; x=1692983555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=091aIS/ULzwKFsYVlk4LamXD09yyDrpVMY8mRCUEE8k=;
 b=jSGjG3dpIAAp31YOpMrsAvmz+/qLTFUC/P/4rqkDhgPl2Mst97hfZ/dhhlEcRWFD67
 6+GyO04gisPq+dBLMYkC25I1mesgCtLJwoGUOrncTvQdopky9s1/yGY9QQ0R0Mn0G38H
 WhhzPFCNkWEvgAM8dogCl4pjmr0/UCUVvX74K1Tfs1ElvhO9yW2cr8zBgQfaHmgYTrLc
 1K1nWmzoUzyIBuPChhFdW0TGMCCOpMmdEmAoJ2Veg7TUVXziFrTXiS/X5bca/VSb0ZeV
 p9ORbDVju6Xq3RH1bv/OSvnVYc26aTpzQ0/S1vpaAOALR5IpduWZU8TiT/LCrDxKDf6X
 QwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378755; x=1692983555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=091aIS/ULzwKFsYVlk4LamXD09yyDrpVMY8mRCUEE8k=;
 b=Vktcp7+uRDjPEed5qyDepXO7QAmJAAK/PUj21KMc4WgU4u5kjOrImXuApUpavxnU+I
 BpfuhYLvSDpYQMfgZoKu1wT9+RoK7PLRzyeIWHAUTRWkr6mvcV9U/UbPalU4Ajxukx38
 V4tP6BXyWGqa3vUgbXgs0LgLNoRTt0ke9tdojRhhJsZjnoeriBDmKVpM+3TdjTpqXCUc
 ZrPd26rxss7bZnt0QZw17CdIB9urxWia6rXyzBgG0MK0oO5jp7trnd28dFaxlNWK1Aos
 GLtT87E7gOGljuKcKZ0fvYmGoZhXS/Q7vXg6+oHI3dfR2G5uDaPRevZCxrvz9tXh71yq
 nLVA==
X-Gm-Message-State: AOJu0YwzITMUUh8Oa4ry7wDs63dQTSnJfyef6IMcem47rGxt0/4i2lpm
 TF6ux55n0urdMppV6nrFvjbyYdWcn8giryrjcjc=
X-Google-Smtp-Source: AGHT+IFL+jDYOMXbclKNP9HRM7OR3Ll2AFswn2H9n+y+jfFHvKfK/jtfZEoG+x3btlWCLNKH2HLuvg==
X-Received: by 2002:a17:903:1248:b0:1bb:d59d:8c57 with SMTP id
 u8-20020a170903124800b001bbd59d8c57mr3192306plh.18.1692378755155; 
 Fri, 18 Aug 2023 10:12:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/33] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Date: Fri, 18 Aug 2023 10:11:58 -0700
Message-Id: <20230818171227.141728-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

AT_PAGESZ is supposed to advertise the guest page size.
The random adjustment made here using qemu_host_page_size
does not match anything else within linux-user.

The idea here is good, but should be done more systemically
via adjustment to TARGET_PAGE_SIZE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3648d7048d..b6af8f88aa 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2517,13 +2517,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
-    if ((info->alignment & ~qemu_host_page_mask) != 0) {
-        /* Target doesn't support host page size alignment */
-        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
-    } else {
-        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(MAX(TARGET_PAGE_SIZE,
-                                               qemu_host_page_size)));
-    }
+    NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
     NEW_AUX_ENT(AT_BASE, (abi_ulong)(interp_info ? interp_info->load_addr : 0));
     NEW_AUX_ENT(AT_FLAGS, (abi_ulong)0);
     NEW_AUX_ENT(AT_ENTRY, info->entry);
-- 
2.34.1


