Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A314A76772D
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPTaF-00034B-Vm; Fri, 28 Jul 2023 15:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTaA-00032j-HO; Fri, 28 Jul 2023 15:57:03 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTa9-0004ms-58; Fri, 28 Jul 2023 15:57:02 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1bba254a7d4so1924735fac.2; 
 Fri, 28 Jul 2023 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690574219; x=1691179019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vS+TVeZ0EksmCAFo0RsvrYC95AcrMT9z2jCTN7Sy8gY=;
 b=hH7CADAMFqMOKcK3seUDBQ3aP3xX7bQAAS2QyZN9x1X8UxRcpIJhqzAL/3f/2/NpZO
 gSBO1nyUK6AP+qj8bG8ZTyCd/ebXsMmaCkFA5cynHzzfgp5GKE0FhYmn6kgck15xOKfj
 yViYMkLFDWNxBv+tNAXehWuC3CrjYG9u8Bg4tvkmGJusyH70CN86Lr54qCuX+VpkQyA/
 1ZaScWBpIAPkQDv/AlsI5OUzJh0/l0QOOdQO2HebzremTF2+7Y/gSTdbYcgcVLaUX9fK
 mK313OVdf5AQ9f+tDNpMwQmuVeUsqNQ5spESdsUZdE+1dtbU8D15MmzaxZOIGAXn2TCB
 VpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690574219; x=1691179019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vS+TVeZ0EksmCAFo0RsvrYC95AcrMT9z2jCTN7Sy8gY=;
 b=hR+C/RV7/CttNshx7WgXRGunxgdF290WV/c3c/6HynSBfnfRXXWa153BjlYKEC7tLc
 ei6lInwjmDGA/VqOavJ0IalfsNmzMryBFHFDL2MFplRSEdXbdqFnoRZRpZo2I+cZmpSE
 0DOitMSc1bPgq91tquQ/fmAm2gkddNvvO3VTymIEwHDHLBJv3q181MwrSCv+4CG2UKe6
 yfXM8Z9PFGydzwVwKLOFdGvyj20FDFXWjKfnyS5yA7JDzGJvRPM9k/XfaOg+LM+cUj5r
 pHf+bU2d67ZdHafKzEEHbIKgyhWu0DRb4Qm3YOfV2R4UGga/bp8HEQN4Qei0/zYbXn/w
 ARDg==
X-Gm-Message-State: ABy/qLZnVhrKj01aSb87CXiX8tGgigc/srdesuUrh5OzqWd2IOkOOs61
 H/HZ4NVw/0/sBnq/UMwEJYC6yj4giCk=
X-Google-Smtp-Source: APBJJlFMawrzK1Pn5L3cUjW8rg9O0qatUnyduF/mTB1dLfh5VeyEvzidxDhKwJ2heq2wLOo/Evw+lA==
X-Received: by 2002:a05:6870:64a4:b0:1bb:fd78:4f22 with SMTP id
 cz36-20020a05687064a400b001bbfd784f22mr3300239oab.34.1690574219090; 
 Fri, 28 Jul 2023 12:56:59 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a056870180600b001b02a3426ddsm2087050oaf.14.2023.07.28.12.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 12:56:58 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH for-8.2 1/2] hw/ppc: use g_free() in
 spapr_tce_table_post_load()
Date: Fri, 28 Jul 2023 16:56:45 -0300
Message-ID: <20230728195646.168997-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728195646.168997-1-danielhb413@gmail.com>
References: <20230728195646.168997-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x29.google.com
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

tcet->mig_table is memcpy'ed from tcet->table, which in turn is created
via spapr_tce_alloc_table().

Use g_free() instead of free() to deallocate it.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 63e34d457a..5e3973fc5f 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -248,7 +248,7 @@ static int spapr_tce_table_post_load(void *opaque, int version_id)
         memcpy(tcet->table, tcet->mig_table,
                tcet->nb_table * sizeof(tcet->table[0]));
 
-        free(tcet->mig_table);
+        g_free(tcet->mig_table);
         tcet->mig_table = NULL;
     }
 
-- 
2.41.0


