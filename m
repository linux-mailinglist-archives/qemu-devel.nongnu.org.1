Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE405771377
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaG-0003ii-9z; Sat, 05 Aug 2023 23:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaC-0003gV-CJ
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:32 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaA-0007Zf-UJ
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:32 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5645bbc82aaso2460846a12.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293049; x=1691897849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDzaMFTSuoNmnLh18AUGiF2g+chM/kwaFDD4OLCcPrg=;
 b=Ca2j5s/BFtOLCUKfMdbZy1xHU1VLWsUnkcnOuRkHvZaJt10Ar/8c/CS7zIkznYQLUt
 wcvYKUbvv0fUXa/i144iNeKbhky3wX8vwoXl7D5oAdfh0MoGK7T9QMVkVHZUYapJOzlh
 TeP5TVAFjJ+bs1pihN4NyjOCmcB3+Os2VIbAABHuqntzP05B2YylYI4/qth57FO70yAR
 9g3JQOtIdi/DTH3epXm4D3e/ptBlntamVnSdP8Z/l7gCmIVAzfC9LoIPXV9Mc8xCqUo0
 GU4vpz61YxzYBKC8L3E1dAgCfQJnqUYHRLch292/gBcuAXX+uLykPzyHSunn8hAill3d
 mkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293049; x=1691897849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDzaMFTSuoNmnLh18AUGiF2g+chM/kwaFDD4OLCcPrg=;
 b=LOjQO4iVkgSmfb4rqJHlHjMfMsa345OHhV85dj4VsSnGC4fJB9oZ2VsWjZ4CQ5EMEl
 wSE2t+hvUTxeVX/dIOkCnHnLBlO/VWkwX6QOR8lqPq4vAPP0excRrZkhsjw9GwxHQRpJ
 zh+n0PFVSdB2/2K26efcOycG3D/HYUcoGg8QvxbXp3VDbdg9BlxmZNyWGvQO4Hct6R5O
 1m+/EZOO5AYFx/2kisMjW0+P7gkr0fAbxQThYTroaBOPoDe4u86ewsv92Febhumc2R1t
 Ex/QR9A3Bu9tuTm5kXFC2hVrB+qTzdAXwM1HGi6aH0b9hLmCx8sCeP6LnBS1k4QjvbWw
 v9oQ==
X-Gm-Message-State: AOJu0YwQETV7+LUjPIvAtJFg3h7vKqUxBfnLnpZF/EpkWm6dxOgna2xY
 D3pyQZidPGm29HberEyE7DtohaF5Bc+3gFa+AAg=
X-Google-Smtp-Source: AGHT+IEDhvxkKXoK1HXBp0hZK4vlNH35HuIMqmZaRGT8RfD8ZIEpOGtQD1nhjvr0oaKPpiGybcgClQ==
X-Received: by 2002:a17:90a:12cc:b0:267:7021:4e3c with SMTP id
 b12-20020a17090a12cc00b0026770214e3cmr6084202pjg.8.1691293049589; 
 Sat, 05 Aug 2023 20:37:29 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 16/24] linux-user: Use MAP_FIXED_NOREPLACE for initial image
 mmap
Date: Sat,  5 Aug 2023 20:37:07 -0700
Message-Id: <20230806033715.244648-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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


