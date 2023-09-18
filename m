Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB77A4A97
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEJg-00044D-Tl; Mon, 18 Sep 2023 09:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiEJd-00040M-9V; Mon, 18 Sep 2023 09:29:29 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiEJb-0003WV-Pi; Mon, 18 Sep 2023 09:29:29 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1d6baffcac2so1266040fac.2; 
 Mon, 18 Sep 2023 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695043766; x=1695648566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiOV6DybnBNyNppeeAy4r1gwQImKNgHVzbxT9X3UxGM=;
 b=dKOA/jAG8IxNIPZyVNsDf5gn8XA95CXAC+oOJ4pqchyn5Wrc1JvLnMX4/hC+Y6PhNU
 gmt7uuRpKrVAsddkIww+Hth136LwzFcvIdsNSjU/A7zRQ3RAZBY4VW/h/6yf8tYVciYJ
 NucGu+2W3K4K1aIa27/Ah4pEwBAM3GREhRziZtdQo0xCn/o99aPsZSenQv/IUvelnG/O
 If4AYzHMhE48Cca6UOEr8ZvwxKJ55526u5k2BAe1DAJINyxVQU2y8s38/uSkv4n9iUTl
 XULkFvJQ6f5F0vALHyu8AJmpgpF7DJwL0NX0K6O9cBz3iFASfWwD4y9c5H64TrizurZe
 3h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695043766; x=1695648566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiOV6DybnBNyNppeeAy4r1gwQImKNgHVzbxT9X3UxGM=;
 b=cLa6C0jDxzpHV9mjaV5zvels0Ft8KHl/Zix1g4x1FkBU155GUmBhFtJtTsKTs/iD7W
 IKqa9rcJr/DYacoIA0WRiXYr5kqW+n1N4sqR35m/DlUsJRblOm6/xRcNR55JJy/uoiKl
 QmNQ1hbU6bTgBJG1lOjfN49BWR2qrFNA7ACM5HrJWCk92PKlq0X1luHdUXZSNxlMNSwQ
 pDwv93U9wuUR3vWfm7FWkic1BFmhR5GnTgzMZ0h/31sLFpwZh1OwqMwAsnnqREFAPfrE
 nBiIjeSK0X/8RTjbgYBZmrpm96mNf+EaJ1rNv+z8TBOZe4a1UO5tt9MK1cVmX1NX/UFv
 /Wrg==
X-Gm-Message-State: AOJu0YyjRT0r7ygxBrFohe6L3Hr/FlZVNnUn7g072dcvvw7Jsz7qlIac
 SOjkU15ntdqWG21Z2dRwRtIMWZPrnfE=
X-Google-Smtp-Source: AGHT+IGF5IT3UkMNsCORLzQqXzwGdf2egtrkJ/ZfVOvPyQ+xKC3SmnX+ATfd8XnlHBJUetuP4mIk7g==
X-Received: by 2002:a05:6870:d2a0:b0:1bb:509a:824f with SMTP id
 d32-20020a056870d2a000b001bb509a824fmr10887924oae.55.1695043766036; 
 Mon, 18 Sep 2023 06:29:26 -0700 (PDT)
Received: from grind.. ([152.234.127.211]) by smtp.gmail.com with ESMTPSA id
 y1-20020a056870a34100b001c8f250820esm4927161oak.48.2023.09.18.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 06:29:25 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 2/3] ppc/xive: Fix uint32_t overflow
Date: Mon, 18 Sep 2023 10:29:11 -0300
Message-ID: <20230918132912.291204-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918132912.291204-1-danielhb413@gmail.com>
References: <20230918132912.291204-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Cédric Le Goater <clg@kaod.org>

As reported by Coverity, "idx << xive->pc_shift" is evaluated using
32-bit arithmetic, and then used in a context expecting a "uint64_t".
Add a uint64_t cast.

Fixes: Coverity CID 1519049
Fixes: b68147b7a5bf ("ppc/xive: Add support for the PC MMIOs")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230914154650.222111-1-clg@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 9b10e90519..bda3478b1f 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -210,7 +210,7 @@ static uint64_t pnv_xive_vst_addr_remote(PnvXive *xive, uint32_t type,
         return 0;
     }
 
-    remote_addr |= idx << xive->pc_shift;
+    remote_addr |= ((uint64_t)idx) << xive->pc_shift;
 
     vst_addr = address_space_ldq_be(&address_space_memory, remote_addr,
                                     MEMTXATTRS_UNSPECIFIED, &result);
-- 
2.41.0


