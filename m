Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D4832921
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:44:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBv-0007Zf-QG; Fri, 19 Jan 2024 06:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBt-0007TF-Mj
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:41 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBr-00038G-2G
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so6699365e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664257; x=1706269057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdcgrGS7kL0CXr2CCXnG/ae/hIrP2R+qiFCnst8/G2g=;
 b=Lv0xOUsR8jSnPsTMMFjE5j1Jtl60ljrC2zftr1b+GX1sTsjNi+mxM4ajbRvvdTq6en
 YknxEbKnB7kD6Hghij0oPqZvSHxsvpg3+fcGdLcdSNc5acb9Fd5HQpCaQbj1igcxBllu
 YEhf3YD28a11MFlDvMNjIn7zianxhp9HxBt4B1AOuCXmdPGfZST9TYIITI7PNnsIT5Qw
 ROzv02W7BljapvtbShWakoG9yACgDU5WghtaM6QcBzC/DfWZvL3upM0q/wUKzkE8dIQt
 m0FmpFld07A1UXaPAkjHzXfBNVBCrcKNTKv2Eaw7OqbesxOxIWu8fgJl2UXQZt/PWLD9
 GAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664257; x=1706269057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdcgrGS7kL0CXr2CCXnG/ae/hIrP2R+qiFCnst8/G2g=;
 b=p2bCJPun5T5U1ZBzV4xoNcIq8o9fJT6hy3epnnBNNdS5fLplL0c72nxEopDrxC6gZ9
 Ats6Fk6mTfc9Ru46Gy58sSa13BRlU+OIlgJrBf6JoYAcJtQt4y171I0Xxud11WNo40oF
 Hyj1qSJy5P3PCck0np0n3FJdShkoP17P5aENwk61hRwcGYLQAQZGjKEdQLWdWI7sLqHB
 yHHEBHDjBnNZvL7CSxFcYPsbEajigLt1QCTp93TKuhQw2P3fL4JSpuPhDeLHy7zgmirH
 MdB9l3J/JrW8r4zBh+GskSc3jxD4qNiq64I/8xHCKfQwjVnaPHMdgcLWRpNvss+RQpFq
 l6wg==
X-Gm-Message-State: AOJu0YzIFJCUN9VIMq511DqM5KhXEFkUkdO6TRCGQ64QFHgKc/wDriho
 gxbl0Rx6ba2S15yafRU3MSgDhrdVv0mCRcKHW2YZZJQT3y6HaMdfJM8bdyoUJs5agEMEA2n75HL
 t1FYKzA==
X-Google-Smtp-Source: AGHT+IENvoMQug95mCHXVpi+b44bKuO934CBuAz7EsoeistjipxTzDoyjJW5sWeZD96g7cmRskYsRA==
X-Received: by 2002:a05:600c:4656:b0:40e:87fe:79d8 with SMTP id
 n22-20020a05600c465600b0040e87fe79d8mr1523223wmo.59.1705664257252; 
 Fri, 19 Jan 2024 03:37:37 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 i6-20020adffc06000000b003375009accesm6301614wrr.50.2024.01.19.03.37.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:37:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng@tinylab.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/36] hw/elf_ops: Ignore loadable segments with zero size
Date: Fri, 19 Jan 2024 12:35:02 +0100
Message-ID: <20240119113507.31951-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bin Meng <bmeng@tinylab.org>

Some ELF files really do have segments of zero size, e.g.:

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  RISCV_ATTRIBUT 0x00000000000025b8 0x0000000000000000 0x0000000000000000
                 0x000000000000003e 0x0000000000000000  R      0x1
  LOAD           0x0000000000001000 0x0000000080200000 0x0000000080200000
                 0x00000000000001d1 0x00000000000001d1  R E    0x1000
  LOAD           0x00000000000011d1 0x00000000802001d1 0x00000000802001d1
                 0x0000000000000e37 0x0000000000000e37  RW     0x1000
  LOAD           0x0000000000000120 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0x1000

The current logic does not check for this condition, resulting in
the incorrect assignment of 'lowaddr' as zero.

There is already a piece of codes inside the segment traversal loop
that checks for zero-sized loadable segments for not creating empty
ROM blobs. Let's move this check to the beginning of the loop to
cover both scenarios.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240116155049.390301-1-bmeng@tinylab.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/elf_ops.h | 71 +++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 9c35d1b9da..3e966ddd5a 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -427,6 +427,16 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             file_size = ph->p_filesz; /* Size of the allocated data */
             data_offset = ph->p_offset; /* Offset where the data is located */
 
+            /*
+             * Some ELF files really do have segments of zero size;
+             * just ignore them rather than trying to set the wrong addr,
+             * or create empty ROM blobs, because the zero-length blob can
+             * falsely trigger the overlapping-ROM-blobs check.
+             */
+            if (mem_size == 0) {
+                continue;
+            }
+
             if (file_size > 0) {
                 if (g_mapped_file_get_length(mapped_file) <
                     file_size + data_offset) {
@@ -530,45 +540,38 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
                 *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
 
-            /* Some ELF files really do have segments of zero size;
-             * just ignore them rather than trying to create empty
-             * ROM blobs, because the zero-length blob can falsely
-             * trigger the overlapping-ROM-blobs check.
-             */
-            if (mem_size != 0) {
-                if (load_rom) {
-                    g_autofree char *label =
-                        g_strdup_printf("%s ELF program header segment %d",
-                                        name, i);
+            if (load_rom) {
+                g_autofree char *label =
+                    g_strdup_printf("%s ELF program header segment %d",
+                                    name, i);
 
-                    /*
-                     * rom_add_elf_program() takes its own reference to
-                     * 'mapped_file'.
-                     */
-                    rom_add_elf_program(label, mapped_file, data, file_size,
-                                        mem_size, addr, as);
-                } else {
-                    MemTxResult res;
+                /*
+                 * rom_add_elf_program() takes its own reference to
+                 * 'mapped_file'.
+                 */
+                rom_add_elf_program(label, mapped_file, data, file_size,
+                                    mem_size, addr, as);
+            } else {
+                MemTxResult res;
 
-                    res = address_space_write(as ? as : &address_space_memory,
-                                              addr, MEMTXATTRS_UNSPECIFIED,
-                                              data, file_size);
+                res = address_space_write(as ? as : &address_space_memory,
+                                          addr, MEMTXATTRS_UNSPECIFIED,
+                                          data, file_size);
+                if (res != MEMTX_OK) {
+                    goto fail;
+                }
+                /*
+                 * We need to zero'ify the space that is not copied
+                 * from file
+                 */
+                if (file_size < mem_size) {
+                    res = address_space_set(as ? as : &address_space_memory,
+                                            addr + file_size, 0,
+                                            mem_size - file_size,
+                                            MEMTXATTRS_UNSPECIFIED);
                     if (res != MEMTX_OK) {
                         goto fail;
                     }
-                    /*
-                     * We need to zero'ify the space that is not copied
-                     * from file
-                     */
-                    if (file_size < mem_size) {
-                        res = address_space_set(as ? as : &address_space_memory,
-                                                addr + file_size, 0,
-                                                mem_size - file_size,
-                                                MEMTXATTRS_UNSPECIFIED);
-                        if (res != MEMTX_OK) {
-                            goto fail;
-                        }
-                    }
                 }
             }
 
-- 
2.41.0


