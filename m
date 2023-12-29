Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A30881FF54
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 13:08:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJBec-00081J-Bk; Fri, 29 Dec 2023 07:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeT-0007o0-0r
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:45 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeP-00053b-H8
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:43 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C15653F756
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703851658;
 bh=SEH1cXhIuqvfvUI/EzQ5KABDAy9IZVCjqX/d3LE2DB0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZrCak12s5+Pix70ijRLpGOsyW/XiVgjJwmhzdZlLxlA1E5uryY3+tLqBEqECMfCB1
 1uJE1kh5M4eGbqekBfrMjNx4LPvNPr/B9leF/gpdocULLqZcYl4gatg2B7p3Fg5nxA
 ZwIj5g6MZYA7Q1ZPls+VqWwGYyL7CjEnxMoFasotlfX/vXTmO+a/whOVWf+5B8gk4W
 j3dVn5XyENU3qbfjC5bo9e1EjpabeOKlqE1eo+Bz4otXwUe1dXSm1iv+Gz2tH/nDKQ
 b7JYayOeUy1c7DJ9AxDVIJvb+06pOR2iapLXTbp/3D2feuJtlMSTb6idtuA00ntK6d
 z5ERc2roWOk9w==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5552b98855bso1433404a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 04:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703851652; x=1704456452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SEH1cXhIuqvfvUI/EzQ5KABDAy9IZVCjqX/d3LE2DB0=;
 b=D5HKJh0aJuKuiL7DFQVjQCJyDqbPzlKqP3sdG5OzmUgWHrf2lXPfqo6QdOQwqrE42d
 ZU1l/DK/OtDRjvK7i7KrFSePNKSWY+DHwOh5qEDrGRbkXKhs20Hn58m35vgSxe4tEyfM
 kIPOEkXPG3nHhtMB4aQkFdUVLDXXoiwzz1NHxlIAmdg3orL0PnaX5Of1jlNu2W51zqmr
 ZII31dDBOMmMaz58mwnS0F9L4yyvpK1Dguqk6WYFEsRuzlC+6lwo9GgN7/yokFzyyfnk
 03vrT6qWAysMN2pfKkR5K4EUTiXitS4lS/ws10GyWYsd68ov1frQRDkKpLhjoZNk8iIR
 MnTQ==
X-Gm-Message-State: AOJu0YxnkaYztRAVntHCu7rSXO69iVBpTAgSuRWMMhJNjH/gRul+y97b
 Xpm00ERWlOw9cBy2O+sndxbAGHjcfmuKNDH1Z7K45Ud2PiUe1GdbL7ArE0tSP1/FllCUsDZwAqG
 g5B9HRVtbycka7OYZqrU5yPDUnangrVb71sa5B3E=
X-Received: by 2002:a50:999c:0:b0:553:721b:81c7 with SMTP id
 m28-20020a50999c000000b00553721b81c7mr7308060edb.45.1703851651977; 
 Fri, 29 Dec 2023 04:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7psCERK1hHsBpfgqNTDEU7miceNbfo+sGfOEnKqiV+mJ0nvSPaGOGrEnVC4zJGpEpvBP+gA==
X-Received: by 2002:a50:999c:0:b0:553:721b:81c7 with SMTP id
 m28-20020a50999c000000b00553721b81c7mr7308047edb.45.1703851651734; 
 Fri, 29 Dec 2023 04:07:31 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 j20-20020aa7c0d4000000b005527de2aecfsm10943344edp.42.2023.12.29.04.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 04:07:31 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] qemu-options: enable -smbios option on RISC-V
Date: Fri, 29 Dec 2023 13:07:24 +0100
Message-ID: <20231229120724.41383-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
References: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.553,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

With SMBIOS support added for RISC-V we also should enable the command line
option.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7bdb414345..5ed82df11f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2705,7 +2705,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 17 fields\n"
     "-smbios type=41[,designation=str][,kind=str][,instance=%d][,pcidev=str]\n"
     "                specify SMBIOS type 41 fields\n",
-    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH)
+    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH | QEMU_ARCH_RISCV)
 SRST
 ``-smbios file=binary``
     Load SMBIOS entry from binary file.
-- 
2.43.0


