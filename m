Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD0E770BAA
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:03:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rM-0004tf-U5; Fri, 04 Aug 2023 18:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qo-0004jA-OL
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qm-0001u8-KD
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so18545125ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186447; x=1691791247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDzaMFTSuoNmnLh18AUGiF2g+chM/kwaFDD4OLCcPrg=;
 b=pK3wQkDQgtPhaZj82WmJ4r4+65CGKOEob0gPr/U2/ymvNB3pVdAJsoWfsZpPV3kTsr
 Na/1M8SCL3mE8Hl1hZRpD4Zt2f8YRnbWcZwPC1WyhUanPox4UzDqRs5JLbrZNC6mNIP0
 GZR5XFPT4iAqUHdqd+YCF79Zkm9jef4fvcxxCS4MCyZCJkdWMtdMeYey1d/ChoHYBNF6
 N5/raIA1fCLYIM/kFhqFn/uSosT7n8wkWqGh8Fp20w9g5iworApac+upaaYNGMFY72R+
 W85d3MBmJcI0hoc9a2FlYKNn8MuULKkoGy8Te9nyeLE+0Ry/I+I21nqUICE2dMRo6zUX
 Jqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186447; x=1691791247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDzaMFTSuoNmnLh18AUGiF2g+chM/kwaFDD4OLCcPrg=;
 b=BZxHjYl4fk2D+wuCRqQw99aVIkh++txeUDKcRg7VXHDwbherCyGLxpweFvHc+ZgBnW
 DOIgDIJ58iqz3XW8I4jSH20CBZwaoZ4RHHRz8TguoQNJW3OtBUMrDlRWyoAWdFT1Mz6Q
 tF4WzU39qVx81hqzFOpjgmr6XgDpG6+246dROEmkybkMTpylm7KvKmogxRFC5Go+LBV9
 6LMZwOJ0J4Yn6CG7fg2HKL6FM1Ze+Fxxu+LhUch42MwUyC/FVgqUJDqvjjbORoWJdU4u
 mYuUi13UvJoWrYxoPSvani7ZOGF1s4k7dIaUqn5fX1RwyMqDgKB3hmQDrT72aBdQWJDe
 Jlfg==
X-Gm-Message-State: AOJu0YyZuk/dMhR1db0XSPuVgr2eK+QC7g3Osm7pdlqZ50dDXCnALhnj
 iZdaiIbQYhv4Tdpq54sOMikWVLZfZ35KjKKhUmc=
X-Google-Smtp-Source: AGHT+IEBTsOUfwxvzwEMfBdNWS3A2nKuChwBBNqfutA5OyFKjqMV+j1xf11uFLxExvxPc/HcsIuIfA==
X-Received: by 2002:a17:902:c409:b0:1bc:56c1:a394 with SMTP id
 k9-20020a170902c40900b001bc56c1a394mr1346207plk.11.1691186447340; 
 Fri, 04 Aug 2023 15:00:47 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 16/24] linux-user: Use MAP_FIXED_NOREPLACE for initial
 image mmap
Date: Fri,  4 Aug 2023 15:00:24 -0700
Message-Id: <20230804220032.295411-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Use this as extra protection for the guest mapping over
any qemu host mappings.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2aee2298ec..0c64aad8a5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3146,8 +3146,11 @@ static void load_elf_image(const char *image_name, int image_fd,
     /*
      * Reserve address space for all of this.
      *
-     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
-     * exactly the address range that is required.
+     * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that we get
+     * exactly the address range that is required.  Without reserved_va,
+     * the guest address space is not isolated.  We have attempted to avoid
+     * conflict with the host program itself via probe_guest_base, but using
+     * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra check.
      *
      * Otherwise this is ET_DYN, and we are searching for a location
      * that can hold the memory space required.  If the image is
@@ -3159,7 +3162,7 @@ static void load_elf_image(const char *image_name, int image_fd,
      */
     load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
-                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
+                            (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
                             -1, 0);
     if (load_addr == -1) {
         goto exit_mmap;
-- 
2.34.1


