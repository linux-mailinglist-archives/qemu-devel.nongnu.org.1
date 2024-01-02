Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13C821652
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU30-0003F6-HD; Mon, 01 Jan 2024 20:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2y-0003Ex-HP
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:24 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2x-0006ys-2p
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:24 -0500
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7bae735875bso422555039f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160701; x=1704765501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HPXK9kHV+jGx1v/PMtKU+RQr0a5HO3R80iapTrtjCrM=;
 b=wAZ29ia+o28Vbk/E3+aA8CMLwPSNXlbbEDb1V3okaFDhoB8N9SlcWu/kvA5TSloPsl
 goEYU2rhQGf9n1oxznHMvEREwrV8TzjCoo0hKHPSQLQCAK/R85m3F1d6wztQmKTb4NZP
 T4sB4w51fTahoSPBkCLvzKXqhbqZPDM4iNeZ0JwBGwxdMFJZ3BsKcawLepWTcQHyPlWn
 IFdcJ4XlpZSK6fxbGt3QwVezxc5w0GpvLArGC7+CLu3xQa3xBJeViVXujgarrSWUOMzd
 UMBKXSc0ptz5EYQVTGbrDeVvFtEX4zD6Z54OwNjIEawWk8m4u7CDI6bSkQIxWizJ6YWB
 yCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160701; x=1704765501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPXK9kHV+jGx1v/PMtKU+RQr0a5HO3R80iapTrtjCrM=;
 b=Y/SAWzu8iRrv1k3ysmNvlRl69XMdocijaI3r3Uml1kHHYf+HTa1qgeekbrPCA9cQd9
 XKFpxx9jd/kcCjdSHJku1rhJvu3bh7RV490XVQtKowUXnNP21yPk0hkntZ46D9KashOm
 uJ1bgkEoFW7UfGZ63rXlOmGHKqrR8djgCso9xN3qsDfW8fZsPzQ1FFYjwZLFVvB76LPE
 HBMHr2W1Hqxz893rAAKlmPG1Y6L40fGaSy1CkGg56tr79TDa6aSBImcaGVwCUu4r1kFu
 RkGVmIT+TldKXFigtHa9FFO3MddP9LKZyI2HbPQFwvyG+jHhPHCuGwLDTZxn4t4qUVrp
 kBPA==
X-Gm-Message-State: AOJu0Yxk8uAAeyi7imHe1m9SHaE39Jp0GrOtkoMhOvfry2ixWgiK0A+U
 aa5bFKaGgzbl5llYK4IiZpbMMoRE3vcyiwBVuLigWdqk5VY=
X-Google-Smtp-Source: AGHT+IGDKsIlqoL0o7XJJ7rt7gKDWlzIDWGOycliW9M0LcLG+x9SFSdfP8Q4d3byotxCoWJREhsuZA==
X-Received: by 2002:a05:6e02:1847:b0:35f:b93e:6a7 with SMTP id
 b7-20020a056e02184700b0035fb93e06a7mr28136922ilv.58.1704160701787; 
 Mon, 01 Jan 2024 17:58:21 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/33] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Date: Tue,  2 Jan 2024 12:57:39 +1100
Message-Id: <20240102015808.132373-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2f.google.com
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
index 4df565d64b..c166faabab 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2678,13 +2678,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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


