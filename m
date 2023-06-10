Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B572ABBA
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhB-0004Po-05; Sat, 10 Jun 2023 09:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh7-0004Nf-0e; Sat, 10 Jun 2023 09:31:53 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh5-0007Zc-5m; Sat, 10 Jun 2023 09:31:52 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b2c3ec38f0so1117298a34.1; 
 Sat, 10 Jun 2023 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403909; x=1688995909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05MVwC+qKRZY2wPKCClkEX8ATHFeJQo5bXxiDjV+tc0=;
 b=OcQ68xXiY9bfH2QIxcTLHncwSQ6ol6qYheNSUsLG2zkgfpCpOnTSh7zWektcokWMTD
 rIjM2s9Li6pTsPsgDTv2/d47n7fNxcNvNr+DwwFeaKcpkkrB403LKNyLsb5dm3VAAwyn
 2mgjQvcuFWm0GKAk7wbnkKhL8rHFg6piphHbnKQBxMDASa+fflBMs6RsxZ81UhbJfCXL
 kkPLj6AYdxmuVaYSVLi4BNvgClyfnrau5AK0IudscwkjR+bFmb4/2dxJb/nlZ1kDZkJ9
 3UeEkT9T+VIfx7GQitM5SCWYCP36g+zLTL+E+sXtbC14Zr3eSia14XR2d4UBIRGavIas
 SIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403909; x=1688995909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05MVwC+qKRZY2wPKCClkEX8ATHFeJQo5bXxiDjV+tc0=;
 b=MyMeccOIoTD8jKo0ZstCcjOzefal6amoK3PZgvgKHUleFdVd5K839w6Ee4TJm0zdRn
 JQiJ33kkPYVyKzP+OAb1UfT4pIdTQzN7MtuTXxb5g6opnuGeviwxiHaWtr50dIXOMJQ8
 s7dZ8VNC5oh2Bc8PeJZxYfh0vSzzcHWD4fwdAz5VWZYDBihUpCF2omlCVmt/2FUc6mOV
 7LBMOsrX++k5Ntzi5MWtv9djRaU4UCAiRVinFKdcV7ShbKucm67BU34Zu6GMoLCvkcMs
 OmZrbw1j7h4YRWl8I9wYHMq3lrgzYEqzH2qq5fpCBOnnLUwzbAWtWkFA5DQa048PtQBi
 dD3g==
X-Gm-Message-State: AC+VfDzVeKsZp0uyfjcv3vyAParB7Hk5aI8G+ri1dno/PBNY//TT82pc
 nvPgkLiqQRflYTW/RnbjgbTbhfpJoyc=
X-Google-Smtp-Source: ACHHUZ5hEqohMQrEv0DteTlO4jm4q2OXsXNTdXtyFsvjKeWA7f407UaK7zRnW56QIMUr81zwbg1AoQ==
X-Received: by 2002:a05:6808:1382:b0:396:4bbc:9a36 with SMTP id
 c2-20020a056808138200b003964bbc9a36mr1164153oiw.19.1686403908931; 
 Sat, 10 Jun 2023 06:31:48 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:48 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 03/29] pnv/xive2: Allow writes to the Physical Thread Enable
 registers
Date: Sat, 10 Jun 2023 10:31:06 -0300
Message-Id: <20230610133132.290703-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Fix what was probably a silly mistake and allow to write the Physical
Thread enable registers 0 and 1. Skiboot prefers to use the ENx_SET
variant so it went unnoticed, but there's no reason to discard a write
to the full register, it is Read-Write.

Fixes: da71b7e3ed45 ("ppc/pnv: Add a XIVE2 controller to the POWER10 chip")
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230601121331.487207-4-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index a75ff270ac..132f82a035 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1294,6 +1294,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
      */
     case TCTXT_EN0: /* Physical Thread Enable */
     case TCTXT_EN1: /* Physical Thread Enable (fused core) */
+        xive->tctxt_regs[reg] = val;
         break;
 
     case TCTXT_EN0_SET:
-- 
2.40.1


