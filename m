Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527978F70F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtoz-0006Tg-If; Thu, 31 Aug 2023 22:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtox-0006Sn-NA
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:39 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtov-0001O2-2u
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a3e271491so1099143b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535016; x=1694139816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1Ia6H4r6/UDLfCIgaKhnJIkJDHurCCHa2efkMKJruA=;
 b=u3Ojsx1ZXD6IVEVCqXqvTn0O/PZHORG75p6wWJm961yqH3STGeebqV8V6B7AI0NP3C
 IHTP67pUF8PrtFpFQGbmw9HmEtvVvGYh2JjMxPsPYIJD+fBVppv7NpSEKa/4hrnJvmH7
 2JB0BzFHfOXjipUNs2QTC9E1OSAG7nTAJvlvemBhpvzhdu1jfq0/ILu+qIQkvryVl54x
 Phfdkh4D0mYDt7eUdma6hqMQaHZ6O0FgJs7HxaKrBD0Qiqgc3+3XZHlch7RDmzUI2yUH
 u8iuKa4yMKxkqXN8Qv4+JpjePaSo5KqPqusoinP0L7nQRgAaEVZesrUfg728StOLnbe4
 pWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535016; x=1694139816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1Ia6H4r6/UDLfCIgaKhnJIkJDHurCCHa2efkMKJruA=;
 b=QywVY0XYqn4ys6aDZIlVo1veQNxtZICXmv8QVnx7gdsiFTvQmA6QqQsPO5GRafSsjP
 /Gdl/8/xipqyeVtbWmg5RrTKJ01U4AoAdu37ruA0xV48P8DhCipN5tZFnDqLZBJtW0ea
 MtIix7Ajf0aFuyF3CuqjWtjgoXTIY8mIlAaWOSSI3+k6wyS1SuTGfh1UDV+3kY8NwtU+
 31wzsmP/ts/uMoG1aTZVCuvjKa1vTsdcSq5FB7KxqgWQvSO2Arh/Ef22QFj5PEfUX8GS
 OWCFGS+fK8ZghUCUGfBKQ7Cmbpgp2yRGd4VfLVMxq0Ezguuz8Py+x7D3GBNJ/HOMFpEw
 GI+w==
X-Gm-Message-State: AOJu0YwLjoIwUCc67NPrAfT2l7KKDh2eGfPW+hwWRjcxaGfpFHM0UzdU
 R/sVeWOteOPLgdAaksUWUMOGOjSjjWtTRWQZeGE=
X-Google-Smtp-Source: AGHT+IHEALxxBg6d86WOmSKU1byXjrg4JPQqlT9FMnuoRk3lgRk7KjWBr+fjPJE08JZd3pMSH9z5cA==
X-Received: by 2002:a05:6a00:3985:b0:68a:3b25:50d2 with SMTP id
 fi5-20020a056a00398500b0068a3b2550d2mr1529427pfb.14.1693535015739; 
 Thu, 31 Aug 2023 19:23:35 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 04/33] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Date: Thu, 31 Aug 2023 19:23:02 -0700
Message-Id: <20230901022331.115247-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 7851003147..885566c798 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2498,13 +2498,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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


