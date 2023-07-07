Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52174B03F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:48:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhI-0002Kz-49; Fri, 07 Jul 2023 07:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh6-0002Gx-CG; Fri, 07 Jul 2023 07:32:13 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh4-0006cz-Py; Fri, 07 Jul 2023 07:32:12 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b73b839025so1663567a34.1; 
 Fri, 07 Jul 2023 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729529; x=1691321529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mjKXMeUttV3Uid1LXfHbj4gfkGjkGwN3VB8fvkyEUU=;
 b=TPDpD3Y+BzAE1YjEMbFdBMB9+qwzEkZZ9BYWWZLYAwIFcT7tuTbJtcVY7kdpGeY1mX
 vkSTiCf3Ts1xqDStJYs2NGn4evOWAa+i64jD3oCHzQ9D2bQtjnCFZboTKVYzyhvwzS5j
 aeqJGlGNer8R2tFysFUjI3Oaj/jcy5N0jjvjZ8ff5FmD/hQ3h3nAKDm8sCI8lTi/WAel
 WalykXypmwcKVKsqcFNnRT5NzZGxWJcsCbMSJErUtsBtP30nVK50opfe71fwQOdL5U7E
 at6eLRgwC0DpPA7ZknO9pyN2FgcG2Q7yVYxigV6wcY53vlPiqzK0keswn7wivTFS/Tj9
 UI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729529; x=1691321529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mjKXMeUttV3Uid1LXfHbj4gfkGjkGwN3VB8fvkyEUU=;
 b=C8WVC22X13XapU9PRrusnYNxvjQM2ABrVsWbK3BSGKLUOCDAmkafL9EnaMUDHl82UY
 IkOtJbEAc3Ak9zJ0c+Yv8TpkWJ1F1MWSoo8DgaTf/ouajCu7pICfBBbmzDw0Nr5PJ/dL
 UZAASWC5cBUbyGXexeQ04eGnqHFW4pouvG8M65xThSeN16636IXJN+dL2FoTTeuz4+IC
 72ZGSZ/LDwgOcOSOVNYvFOasD0PXMLtUdREZJSxdmc+6ugWCvnzuGeiHrvu2zqtyP8Bx
 LLpo5+prDrXHEUIPMUNaIOSzfV4AnREGAeERf24o7XQPFqVAZEa+R7r4FN9oeLlYAv0T
 nsVQ==
X-Gm-Message-State: ABy/qLYXTi3rvKX8dEzpi8B1M2fpiuxScGGVBTl1fyvYUkw8B58tLScK
 XNTIzLWbNKws+p1b5syWMjOuv6Wsdu8=
X-Google-Smtp-Source: APBJJlHJBASOvLCItPl4vfP8TK7oKDancf+w8OBQvlRj0ooW88isnK+CuPojz3aDyTuDjv0KzclEeA==
X-Received: by 2002:a9d:62cf:0:b0:6b8:92ea:23cb with SMTP id
 z15-20020a9d62cf000000b006b892ea23cbmr5493938otk.14.1688729529331; 
 Fri, 07 Jul 2023 04:32:09 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:09 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Narayana Murty N <nnmlinux@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PULL 18/60] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
Date: Fri,  7 Jul 2023 08:30:26 -0300
Message-ID: <20230707113108.7145-19-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Narayana Murty N <nnmlinux@linux.ibm.com>

Currently on PPC64 qemu always dumps the guest memory in
Big Endian (BE) format even though the guest running in Little Endian
(LE) mode. So crash tool fails to load the dump as illustrated below:

Log :
$ virsh dump DOMAIN --memory-only dump.file

Domain 'DOMAIN' dumped to dump.file

$ crash vmlinux dump.file

<snip>
crash 8.0.2-1.el9

WARNING: endian mismatch:
          crash utility: little-endian
          dump.file: big-endian

WARNING: machine type mismatch:
          crash utility: PPC64
          dump.file: (unknown)

crash: dump.file: not a supported file format
<snip>

This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
always set for powerNV even though the guest is not running in hv mode.
The hv mode should be taken from msr_mask MSR_HVB bit
(cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
MSR_HVB value to ppc_interrupts_little_endian() in order to determine
the guest endianness.

The crash tool also expects guest kernel endianness should match the
endianness of the dump.

The patch was tested on POWER9 box booted with Linux as host in
following cases:

Host-Endianess Qemu-Target-Machine                Qemu-Generated-Guest
                                                  Memory-Dump-Format
BE             powernv(OPAL/PowerNV)                   LE
BE             powernv(OPAL/PowerNV)                   BE
LE             powernv(OPAL/PowerNV)                   LE
LE             powernv(OPAL/PowerNV)                   BE
LE             pseries(OPAL/PowerNV/pSeries) KVMHV     LE
LE             pseries TCG                             LE

Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory
dumps")
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/arch_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index f58e6359d5..a8315659d9 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
 
-    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
+    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
         info->d_endian = ELFDATA2LSB;
     } else {
         info->d_endian = ELFDATA2MSB;
-- 
2.41.0


