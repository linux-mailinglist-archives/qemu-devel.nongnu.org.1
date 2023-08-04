Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E57704B9
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:31:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwl9-0006OF-Qh; Fri, 04 Aug 2023 11:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwky-0006Dy-1G; Fri, 04 Aug 2023 11:30:25 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwkw-0004OG-C1; Fri, 04 Aug 2023 11:30:23 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-56ccdb2c7bbso1481075eaf.1; 
 Fri, 04 Aug 2023 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163020; x=1691767820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zkglx2BRJmppKi0eGpH9W2XIhA3WWhO1HfeX9ZW+4xY=;
 b=Ba7IU+rOiaGNk5cprrgsIbjEGX97CGC2ykkRCr6HA1F1LA0P4QZpS2kdI7Utb3pJqf
 swOYY1SDTfMLgmQ8fryMl+fL6IcCy11HC/65Yt+5GVoQ93vQ4n6c8f2qWp54JBEhBf4q
 PpPY3QcTteefPkxgenwroSgZOFb8+uWvstjp7uS47flURRb46iIPdJJDv6SIMtQNJlR1
 KTV5DWt/wILz0ewxWq2Xq6Nv5BqSnUryRlrEoVxBllkak9hdf2sLvmttuncuqm6unTp0
 0VDXnD7850x4vkvaedK4FCKW4dK7h950gTtOG2zJksixEsi+6vYAUD1MTLMee5X2IGZY
 yBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163020; x=1691767820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zkglx2BRJmppKi0eGpH9W2XIhA3WWhO1HfeX9ZW+4xY=;
 b=O8hbxtqmjk/95nyrxD+K1zrQk0G4YuU/Rg4nejGt/oOlKmAjM64XlR0mfBiQ+MaQfl
 jxFA3AgQNDuTygC1U3xhYlMvseqFxDW4I63N2UpcUIDbEwOCcBz7YOQ0iwPjC0lLRBSM
 F0IMXS2+39YCVAVFDcgb3jxYb4kRaLv+ANykHKB6SziHBb7c55rVqC41b1/Hl45brEPC
 JuOe+QmrzFQ9JUoDmDzUkyXVV8jgxVGqc91NkRYtD9bkik5qJs2d0Wa69keiLpLIyV2V
 +zJfhrW02yu8/67xyq9gqrzkPHkKvyR2dr3iE5IAvH+kgVIDO4qM+QdqQ/DnXx/Saozf
 Iz5A==
X-Gm-Message-State: AOJu0Yyx8pkUe8ktcXlTip6tj9J9Stepe0cylKgh0J6PwogCnwqbowLu
 chBNc6l1WswGhzlTEiKhkf4eVJUJyGI=
X-Google-Smtp-Source: AGHT+IG+kTuz/JWHj/nxmZWGF9E49ezL1uoe6Kds2L3izNUac0i4FdxJ7ndpwOUBFlNU3961VfYSHQ==
X-Received: by 2002:a4a:8554:0:b0:567:27f4:8c45 with SMTP id
 l20-20020a4a8554000000b0056727f48c45mr2238439ooh.8.1691163020488; 
 Fri, 04 Aug 2023 08:30:20 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:20 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 2/7] ppc/pegasos2: Fix reg property of ROM BARs
Date: Fri,  4 Aug 2023 12:29:50 -0300
Message-ID: <20230804152955.22316-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
References: <20230804152955.22316-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2d.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The register offset of the ROM BAR is 0x30 not 0x28. This fixes the
reg property entry of the ROM region in the device tree.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <6abd73b1211f9d0776dfa5d71d6294f17eecb426.1689725688.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pegasos2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 4a2ab35f19..8ed13a42a2 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -766,7 +766,11 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
         if (!d->io_regions[i].size) {
             continue;
         }
-        cells[j] = cpu_to_be32(d->devfn << 8 | (PCI_BASE_ADDRESS_0 + i * 4));
+        cells[j] = PCI_BASE_ADDRESS_0 + i * 4;
+        if (cells[j] == 0x28) {
+            cells[j] = 0x30;
+        }
+        cells[j] = cpu_to_be32(d->devfn << 8 | cells[j]);
         if (d->io_regions[i].type & PCI_BASE_ADDRESS_SPACE_IO) {
             cells[j] |= cpu_to_be32(1 << 24);
         } else {
-- 
2.41.0


