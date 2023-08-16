Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB58277E873
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL2f-0002Lj-RW; Wed, 16 Aug 2023 14:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2d-0002L2-3W
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2a-0003gr-PW
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso57609005ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209683; x=1692814483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=902iWhbQP4VzMfSuKMj7bvmHlg0vdFaz5xqxGaNOCL4=;
 b=IIfTeJgjkyJXi8sDe/KAAuiQmw9g7A9YVPabjQkksqfts6OmyZ+ubPderDa2iQioU6
 JPDyBU1QBbUgmK5uYq12rC9T/q84wL6mUNTNBnTEje/ENyQH9OBoVQoOn6yBPUcH2oRp
 tN6X1shHFCcXdKqY/alMZCAzbDzKqQokgoWhc9r9tI0quStHoas2SEhQaN4LKOj/Z3MU
 3/ZJpVqz7+9BtIeccfEHeVIBHZrFUJPW/7hD9Y4ZeQ2QPNuuJM7/9zC6XbBkqHY0NaMU
 NEyx7oepV6ibfiNqzBhAF+fJa6eRru2vL5OKVT2CZjyuh8lcdDGh+EoiAIgKAcdkKRL1
 yDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209683; x=1692814483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=902iWhbQP4VzMfSuKMj7bvmHlg0vdFaz5xqxGaNOCL4=;
 b=hFUjvBX1sCXQixbMMJFD5Bcjv3mutj1B5Rp7KWycu8GpUzjxtpUKtIiJj7LO2gXCok
 jBS1Ad+iCqzTFGgq8MWIm5mghxZNgYe/q/IhXmDqiHZNofJAUNywJKcJ3Ubn13o1kAKV
 o5zNXYTk/DaskyH8GQXsqXyHW9sbGdwUKtm+Y0phQUE2mDJYeWVbTVvIsOzvhRKserO7
 cLYHPsqwXQS5uJRoZNAiNFvzqqEV0dqEXa6mnT+S1FKN8ARvSw2GiWHqFjHvcF3mqaos
 10E/Xa464em5dNOEU8t/51rA6BPPKIRLgZ/IhIp9bZBoveZYD7ETPDTb/tM3ZUYa0m4C
 f8oA==
X-Gm-Message-State: AOJu0Ywfjwefer7Ry9fKS9i3+IxgGj5A1Tpi1frciqJy+lveCF5DB+6X
 yUTwWvrMfkc25Zevp4fReCOtQ+WoBiMkrSP4Nac=
X-Google-Smtp-Source: AGHT+IGSwitjIn+WQDO8e/2fFfuHSnpIZwWP0YW3etsRKTLAoH3h+X/9B97jnuY3Z+1jY+7SMeX6Rw==
X-Received: by 2002:a17:902:db0e:b0:1b9:de75:d5bb with SMTP id
 m14-20020a170902db0e00b001b9de75d5bbmr3343345plx.7.1692209683425; 
 Wed, 16 Aug 2023 11:14:43 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001b9dab0397bsm13423563plo.29.2023.08.16.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:14:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	deller@gmx.de
Subject: [PATCH 4/6] linux-user: Show heap address in /proc/pid/maps
Date: Wed, 16 Aug 2023 11:14:35 -0700
Message-Id: <20230816181437.572997-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 658c276e39..5c0fb20e19 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8125,6 +8125,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
 
     if (test_stack(start, end, info->stack_limit)) {
         path = "[stack]";
+    } else if (start == info->brk) {
+        path = "[heap]";
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
-- 
2.34.1


