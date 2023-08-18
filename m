Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22755781153
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31a-0008B2-Jx; Fri, 18 Aug 2023 13:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31Y-0008AR-FB
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:36 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31W-0007yZ-BT
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf0b24d925so8683335ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378753; x=1692983553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b6QumjYXJdEchv07+6JwQBzFkrW+HsuAnJDB/FfxSIs=;
 b=JUmAXIJC20D2Qcun6L3kV4XxmS0dBqqFkHN8pycwa24PIqxu0kjr/UK/B3DOL32D3n
 8w+KFtcQHEPpQBSZqGMm40L37h4OMYf/42sn9ukjrRrWEV0nJH6x1s1nUZgvDDg5odBy
 4IG5vkW7vT7Twcu4ehGa3C9HO6qmOxXaylbcgqIuMumyhBJTnVFzJcL0bXJpqriA78/u
 3+H6vH+pMKYhzPddfMRXLNqfHA2dax2wryJRdxte296enbvYK0UH2nV7Nn6nfiD08fCI
 Bsd1C7WrRC0bJKy6keRMkCA1zjhHGvB13ALOTjWyP/Ab1etcNUht3HKqrxe1Meie1NXN
 Qv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378753; x=1692983553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6QumjYXJdEchv07+6JwQBzFkrW+HsuAnJDB/FfxSIs=;
 b=Fgv1ER+GRWX0uJJMeYifF6tAl+2ZTwp2wABLJH+42mvGl/bGFVHWdtHfeyzOz3ql4o
 GBnLRnDv2jkNUUZN/EKhZmv5K7gqgmKdoGxEOTkw4iXn7xOwBO0x9oSJnyEgy1t27dNT
 jan6lkTR6DPsXocWLxbrojIdxRCJahucUQAznLegbHyaZz03ln7V+8gQJPzYFPHDzXSf
 oqvjEMc+1Ta50PBfGXoBtU8zTJbG7FIqBmkGj2iGt3xlm/tOPcQPke1tU7Rc596fEF0l
 1gxaS4Q9+y0LTXxua8eVlL8G7RtQCBMAuMOVjog90K1TXgepQXNqhrOw1dSANjO45RKd
 SL9A==
X-Gm-Message-State: AOJu0Yy6Vl2oyK5/plKKAtdmK+S1PBIDE/i0mHOcUjl2KYF4z1L4JoqF
 2WCrvi10U5qUlzGyFACASJ+5hMfmIJZDPYE0YEo=
X-Google-Smtp-Source: AGHT+IHtVytLiETXVKM3fFZWp2gn84mx+yMEUlebrTT+dDldAZVhWuMti+6YXguL3LL7jkXuyP5R/g==
X-Received: by 2002:a17:902:e80d:b0:1bd:e64c:5c71 with SMTP id
 u13-20020a170902e80d00b001bde64c5c71mr3766543plg.21.1692378752776; 
 Fri, 18 Aug 2023 10:12:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/33] linux-user: Remove qemu_host_page_{size,
 mask} in probe_guest_base
Date: Fri, 18 Aug 2023 10:11:57 -0700
Message-Id: <20230818171227.141728-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

The host SHMLBA is by definition a multiple of the host page size.
Thus the remaining component of qemu_host_page_size is the
target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9865f5e825..3648d7048d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2731,7 +2731,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
 
     /* Add any HI_COMMPAGE not covered by reserved_va. */
     if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
+        ga->bounds[n][0] = HI_COMMPAGE & -qemu_real_host_page_size();
         ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
         n++;
     }
@@ -2913,7 +2913,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
                       abi_ulong guest_hiaddr)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
+    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
     if (reserved_va) {
-- 
2.34.1


