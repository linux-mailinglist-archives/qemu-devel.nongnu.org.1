Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC89774C76
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTx0-0007iC-Nm; Tue, 08 Aug 2023 17:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwz-0007hZ-6R
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwx-0005ws-Bp
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso6595805ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528946; x=1692133746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVgimCTGuUjAfzzKq6Eqz3lfGX5YOiTLny3wMx0dHp4=;
 b=TnDVQbCcwnxs52vKgqoQ3E9lHmxLc+ApFqOoz6XxH+pysU5kSNF2akLXTgw9d6Opxt
 l7boMNpddTX0+0BkRZ41RdTZsR8aW48Yj2Dqul9fVP2RNLGuZNyrJD4jtxiwdqy/CrSQ
 XmpQ/iRsYK/xHlv4/1//kHgSn1pA/9PT+kgXlm1f/Pb/YScQZFIKLih4hXupSfMXPiaP
 fE+g/RnPyk8wqjgHq1isFiIs/tT0ULHwsDONDucNupIZMngqSKRKDPMj5odeIZBWMqnU
 CFL54H23gH8RqPSb+l3glbGcKel4xAQ5LsDbHYqzs0xBAF7eEw6wISoCQptPWP/D5Wgh
 Nwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528946; x=1692133746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVgimCTGuUjAfzzKq6Eqz3lfGX5YOiTLny3wMx0dHp4=;
 b=cdDI+NlicomLTJL2mh2AK5KLwLVebBJLOAQvcqqzZN0Fnqq8nlARhx5JrvtQxklu8d
 EBY+sueHPKEttnYbCpzdNJX2dQlYoxAHDjweH8RgNjYXHtS/9grQrsE9pioIFN/b1bjh
 Br71Oofr0I1wxyrpPnd8D/JDBJ/EVFbIOcC/PWyOCPEJf8CYk5gCHBNBoXXYYH4dW4Sa
 //Za75vqhhCPbl/S9iD9B9OPB0TYK7WVUDmH5G+QPIZ/mM6MqtJc4IjOz9LGADIabhyc
 BE3iZH5R92SOkV8dew9RfrBydPf6ZZh+WcZVbz5uDQClkbflQqIbe0ilqaoCO9tsyQ79
 rXBA==
X-Gm-Message-State: AOJu0YwcMASGe7x1kbYm6abwSRKt2WVV82t00VbfiDJH+wFf4cpiLYGy
 okpGGSDOLoFFtQYWR/KjautolxqhcT0SMYhaY+c=
X-Google-Smtp-Source: AGHT+IGRdfAnh/W5Mszngq3kZYSppO7sH9AHKMCXYl2mLsFDS8L6rQFBTxJrY3O9nvu9FDEQ9n+XTw==
X-Received: by 2002:a17:902:d904:b0:1b8:3dec:48de with SMTP id
 c4-20020a170902d90400b001b83dec48demr758807plz.47.1691528946122; 
 Tue, 08 Aug 2023 14:09:06 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/14] linux-user: Use zero_bss for PT_LOAD with no file
 contents too
Date: Tue,  8 Aug 2023 14:08:51 -0700
Message-Id: <20230808210856.95568-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

If p_filesz == 0, then vaddr_ef == vaddr.  We can reuse the
code in zero_bss rather than incompletely duplicating it in
load_elf_image.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 881fdeb157..e72497c4b4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3208,7 +3208,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
-            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
+            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em;
             int elf_prot = 0;
 
             if (eppnt->p_flags & PF_R) {
@@ -3233,31 +3233,18 @@ static void load_elf_image(const char *image_name, int image_fd,
              * but no backing file segment.
              */
             if (eppnt->p_filesz != 0) {
-                vaddr_len = eppnt->p_filesz + vaddr_po;
-                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
-                                    MAP_PRIVATE | MAP_FIXED,
+                error = target_mmap(vaddr_ps, eppnt->p_filesz + vaddr_po,
+                                    elf_prot, MAP_PRIVATE | MAP_FIXED,
                                     image_fd, eppnt->p_offset - vaddr_po);
-
                 if (error == -1) {
                     goto exit_mmap;
                 }
+            }
 
-                /*
-                 * If the load segment requests extra zeros (e.g. bss), map it.
-                 */
-                if (eppnt->p_filesz < eppnt->p_memsz &&
-                    !zero_bss(vaddr_ef, vaddr_em, elf_prot)) {
-                    goto exit_mmap;
-                }
-            } else if (eppnt->p_memsz != 0) {
-                vaddr_len = eppnt->p_memsz + vaddr_po;
-                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
-                                    MAP_PRIVATE | MAP_FIXED | MAP_ANONYMOUS,
-                                    -1, 0);
-
-                if (error == -1) {
-                    goto exit_mmap;
-                }
+            /* If the load segment requests extra zeros (e.g. bss), map it. */
+            if (vaddr_ef < vaddr_em &&
+                !zero_bss(vaddr_ef, vaddr_em, elf_prot)) {
+                goto exit_mmap;
             }
 
             /* Find the full program boundaries.  */
-- 
2.34.1


