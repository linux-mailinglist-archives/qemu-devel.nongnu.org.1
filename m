Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5378115D
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX32b-0000CK-5x; Fri, 18 Aug 2023 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX323-0008NN-E8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX321-00087t-WD
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so8162975ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378785; x=1692983585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sLGhrncusZ++ow/925hmU4zhHqvG6lKeFI4gVIL5/yk=;
 b=Uu32AVqGVSodcZ4gTPPNa+hoE936Q2BEYSSS1WOrB/yyKLTN5a0Bsp8sBCHj8h6Xze
 PWpfhGA75s9NlaOr3elP8PfD03chJYT20z/yA1tEYUpXO6G0nlkD4rkcr5w5PdBA/bmh
 ZXUcuqd1l+9g69imzYQrwd80Q4WmHSW8IlcK5Hj/kLwnRfQEJsi2YyLf8Q4dgtsxzBWz
 NpmdgSmzeK3uvqARdBMraA8Ds7LtXbHlRoLln90yt3qKgjza+MTYZFGUT3YzJ8WzTXcf
 Mowu57GqTpbA/ofF8RfrT2OLRmWJH9AhOToZJ4oaQd4TZ0HnUa9wk8USVSxsI/QgbW0U
 oxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378785; x=1692983585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLGhrncusZ++ow/925hmU4zhHqvG6lKeFI4gVIL5/yk=;
 b=BuZ7Stpf0awMb9LxHiIpeByl6lUt7b3A3xZrPuxPm6aucRbLL59JpvrZCdJPGvc4qO
 LmCUJ1RLlvj3xCEz1CmU3GJ9cxiXp3pl/o3IbOU6nNO02hr570hGf5j0bF/mkxajucHi
 yJFHtgEea9mChivJu8WYtfMYwWXtJDs+V2X9mnqEDi33vxf5VF5PFYqbhjQOfpahsdje
 XWnV6pzIF0K2wpTCXuI3tMaN4lv7YJDziZ1UPhu3YVRwGEn4iVj0PRjSWbfEDNuswZJN
 7S4b6Tsib2loils/OPh5Nrxt6B6UYXT68mULBoKu9bNg2huP9unD2Ln2WKB/fFVmhLMj
 5P2Q==
X-Gm-Message-State: AOJu0YwR3QKR/RftCn2gYnzY/LQq8t9dazCTnvEQdw3ASc65wHvz0nEE
 I5r06LJrbyyy6cLjJYd35cbVhjX98/I6wME0nRk=
X-Google-Smtp-Source: AGHT+IHKPSyI7PSkxE6WOnkF5GC5GT6rEy/1eRJ9rtQFQA4tu4Unf4xemn91lZVWWegJizvCxBZrGQ==
X-Received: by 2002:a17:902:cecf:b0:1b8:8702:1e7c with SMTP id
 d15-20020a170902cecf00b001b887021e7cmr8096048plg.33.1692378784723; 
 Fri, 18 Aug 2023 10:13:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.13.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/33] linux-user: Bound mmap_min_addr by host page size
Date: Fri, 18 Aug 2023 10:12:25 -0700
Message-Id: <20230818171227.141728-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Bizzarely, it is possible to set /proc/sys/vm/mmap_min_addr
to a value below the host page size.  Fix that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 2334d7cc67..1925c275ed 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -904,7 +904,7 @@ int main(int argc, char **argv, char **envp)
         if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
             unsigned long tmp;
             if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
-                mmap_min_addr = tmp;
+                mmap_min_addr = MAX(tmp, host_page_size);
                 qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
                               mmap_min_addr);
             }
-- 
2.34.1


