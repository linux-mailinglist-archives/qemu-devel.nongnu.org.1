Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB19740FCA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qET3B-0002rq-Fl; Wed, 28 Jun 2023 07:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qET34-0002mL-Eu
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:09:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qET2x-00012A-CR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:09:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b7e94912daso20364015ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1687950552; x=1690542552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pxqYwFZlQDRcPvSRMEkOuNG+LRfYsTu2FiTLUQDOseY=;
 b=0OoE/b+4Ut+rto1yqBLS4JOvmzyt/9/0DMCe40VyIBW8E8/YnWZ//nXSbucDMwFhJK
 wKFXKG5P1v9R/DYTLuXzwoONwOFsQlH+zkIqpsWCDgGDGOl4CyoLgGRySRqfLfU2CH2G
 eF0LCn/JUIdlSJtGUWlRnaPzGb2hHXb/9Ss9Nmqyxd8UgqC/X9RhxitF8bNRvnS8R2fM
 x35r0pUKqB34lpE6BJojOHR2UYO5awogT8Qn9LYpksyF7pj2eU9M7Z9aft9wFPmjUcs9
 mMeeBWykZkdmx7f80pqZHLVLw/jJ3R1G8nS+lBoamXyaxUqjhw1t8XwlFE2SUZb2RY7A
 InVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687950552; x=1690542552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxqYwFZlQDRcPvSRMEkOuNG+LRfYsTu2FiTLUQDOseY=;
 b=GuiuHrwzHDnKnPwI5HFBAzi1UvRPHjlAvKzvu6jpEN7cO+a5llj+os+2W/7qMj131O
 z7K0HJ7T0X7aWgJgpaz2QlQ2r3/4DoHy7+CK743It9ZSCmUQ++fNfhHHra1kZqctwTnn
 H75fUsNkhu5NqeloDqHPaCMaDbSZ+8TptF2t0UoTZd9KF+q1J5nqy7YECGQjYM37/zHW
 1woQ8dlso4KbIqGnTLkq1djZTPoLi2CgEOS0xERmSH87zgQ6Ygdt5wXOUeZg5S3W8S92
 JGhcP3dBUkooyKeuOrNZ8UZ7mMjPJuKNH3cKHvlD5x16CKaFCXKGWptS5SoilNbnF8ZG
 B0tg==
X-Gm-Message-State: AC+VfDwu4tZmxlbf6c665M3REGNy2YCht74YkLEQC6g49xn6k7UTXc+P
 QCV33xJnAL6/fGaPIfiCYPC6+Rv/hx0jtzopYEM=
X-Google-Smtp-Source: ACHHUZ7bx82Pr0eEznRZ4VRUXFtq1AJ4wQydJbLAfLUUtZk/Qb+WZY3B6JNHcsuk3gzMFE9+scpigw==
X-Received: by 2002:a17:902:f7c1:b0:1b3:7de7:f83f with SMTP id
 h1-20020a170902f7c100b001b37de7f83fmr7665549plw.26.1687950552198; 
 Wed, 28 Jun 2023 04:09:12 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 n10-20020a170902d2ca00b001b3cac25f82sm7461198plc.139.2023.06.28.04.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 04:09:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] hw: arm: allwinner-sramc: Set class_size
Date: Wed, 28 Jun 2023 20:09:03 +0900
Message-ID: <20230628110905.38125-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

AwSRAMCClass is larger than SysBusDeviceClass so the class size must be
advertised accordingly.

Fixes: 05def917e1 ("hw: arm: allwinner-sramc: Add SRAM Controller support for R40")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/misc/allwinner-sramc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index a8b731f8f2..d76c24d081 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -159,6 +159,7 @@ static const TypeInfo allwinner_sramc_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_init = allwinner_sramc_init,
     .instance_size = sizeof(AwSRAMCState),
+    .class_size    = sizeof(AwSRAMCClass),
     .class_init    = allwinner_sramc_class_init,
 };
 
-- 
2.41.0


