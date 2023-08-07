Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C02F772B2B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EV-00079R-JT; Mon, 07 Aug 2023 12:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EH-00072s-92
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EF-0002gU-Nk
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc73a2b0easo5470265ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426230; x=1692031030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJUFfIS4Wr1y8fuwf4as7ebNw3oHaTbxYse/4v8c7ug=;
 b=E/VEtqppstgRkSvtLGxvUOl/Gdqzl9f/roRZtLAClsJKncpE1H3Id8ICCtNnqdc7fC
 5JD8DE7aiPvhCmpnocjUtn6dTwtayqFkAVACOPxOcrGVgkGoTnwvap94sVCb1zO80Cfs
 ExLHIitUKXmpL+IfN6dG8Zsnx6T8aQNmu+e6rhcFLVGqHWb+eJqaqxipab9wWuvcF/PC
 lEPWtbF0MMJJS/N5uIMfP8JdWeVkUqPgQ2ffWF//3WPwgka48a3sR/aSfscUv6CQRmHN
 6PjeIdHbq8Ltca/RfwnSY4ohB8ZrPsZGwWIXISvOBk3xgVtSkDZBQx5zaAbBbvZJwq0X
 RxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426230; x=1692031030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJUFfIS4Wr1y8fuwf4as7ebNw3oHaTbxYse/4v8c7ug=;
 b=P5O6iaGuim8QADuPfC60+nqT2KomfkK8ojplzZz7GvJPOWe5lbXPvbeEb9TeEzkH8w
 vtDNlTSSQisSeLCV/W6i/XSGorqw9X/tgUTDp3oWAjSBss7RldQU7yQWj7fyEKy4s9r5
 d925uENk4XZbvLCn7sKC1Xg2A/pAm1BHGhGneaRfDMZK81B3sQa9oSWRWkOL2uvUv91P
 3En7NnP1v6NYlpfEQ6iLp+WnafzwiOhrO1xOcHkumj9ykO/UjDpqI9Bp/BpYd0NVDuZ0
 g3EJJB5d0ORqlks9h1J3B3Ifa08DP/z3BBuZ4pP+oFHOuQ7XQFh1jSu0T5DQPcyLhoE0
 dQvA==
X-Gm-Message-State: AOJu0Ywtviy7GdIQTpzzxUII8VLkYH6hKlb6F8ikQIhyIV4MkJ8FIrg8
 V2lelJZwfE9e5VYh6O7m+yTUq+GWg+VTFCRon8Y=
X-Google-Smtp-Source: AGHT+IEMw/7iF7jUCvDa72dNVMtpeRQ2F0cwogCT8cFTUqMoDhBvgg5CDKSNLu+swCemPANwl3R6RQ==
X-Received: by 2002:a17:902:82c5:b0:1b8:6cae:4400 with SMTP id
 u5-20020a17090282c500b001b86cae4400mr7659675plz.37.1691426230493; 
 Mon, 07 Aug 2023 09:37:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v10 04/14] linux-user: Use MAP_FIXED_NOREPLACE for
 initial image mmap
Date: Mon,  7 Aug 2023 09:36:55 -0700
Message-Id: <20230807163705.9848-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


