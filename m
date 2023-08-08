Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AC774C8B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTwx-0007gV-6r; Tue, 08 Aug 2023 17:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwu-0007fM-Q3
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:04 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwt-0005vx-3Q
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:04 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-56433b1b12dso3652336a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528942; x=1692133742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJUFfIS4Wr1y8fuwf4as7ebNw3oHaTbxYse/4v8c7ug=;
 b=c3odcsCmTbi6SjqtVD0sLtX7A5t+73vs2CspyQ4GUvPyU5DCV6Ipb7uTYNQH0jzXhN
 Q5WBls7nlioIAEk1aVJ85Y3jLYOLdcBJRomyjaU4QbQyHYCulJ34NvJfOhoEDCWLfGEv
 eS9zrkpUpCGi+SMJ2TJL5MMVbkzkcwuu22P9nvYmn86ZxaaNn9nrBoudSNmnVdax8V0K
 v95GinP1JDJQQ7ZWQFwnrK1eJXI0ulirLLjHKTijBv7aS+A9jRm3k/tu1UP7IyrGYFe4
 ixPQCI1068f5NOknzSKbTnnYzPP8wuxiY6jugSH1A+3eML4oeZBc06If8Irgu5VsVZsi
 t46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528942; x=1692133742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJUFfIS4Wr1y8fuwf4as7ebNw3oHaTbxYse/4v8c7ug=;
 b=DE89nli0ZFT4FTVhRGQhTkQYk09/R1Dcg86nKlzGOYjhrE4yewUUkv+4LGX4P1T40e
 FOCLi36oOD3B93ckstizDfQ14iQVwUfRIDLpp6krUCT716qQ1k41CxY+EumwcpsyNkcj
 2NnFBmYu/oqr5uoyQg5JkEG3bG3O2ynnUhQEfvG4tgt0g/+b3te9sQXhjLXswNIdzQqH
 +CZ7hI1ZWcqlXYfNDSHIBGiExe5cA1YJqdzO8njgrGtkA1euv/noW+MGgpwIw6es4NUu
 HfPp1n9demPkz/s89voDPmOPh+8G+h3a9AZl97YjlHJHvMEmlKAJV5nmU3teMf0kJpP9
 ofsQ==
X-Gm-Message-State: AOJu0YwR5372LLch/ATRw4Zxey2d4fF9u66Ul22Kc2onLQXNVjOzZLyw
 QsjYEP7eukAk9biSCaGtC8DpUverVhE1849hTzY=
X-Google-Smtp-Source: AGHT+IGE92B102AGwf9JdPvJnYc8G2xF/bwNYhh5GCZITudlKcCqE/Zd1NmbWklHjICG5L6wNNuNwQ==
X-Received: by 2002:a17:90a:6c05:b0:268:c5c7:f7ed with SMTP id
 x5-20020a17090a6c0500b00268c5c7f7edmr642605pjj.30.1691528941789; 
 Tue, 08 Aug 2023 14:09:01 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 04/14] linux-user: Use MAP_FIXED_NOREPLACE for initial image
 mmap
Date: Tue,  8 Aug 2023 14:08:46 -0700
Message-Id: <20230808210856.95568-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
index 36e4026f05..1b4bb2d5af 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3147,8 +3147,11 @@ static void load_elf_image(const char *image_name, int image_fd,
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
@@ -3160,7 +3163,7 @@ static void load_elf_image(const char *image_name, int image_fd,
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


