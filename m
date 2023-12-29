Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F9481FF55
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 13:09:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJBeW-0007p8-Ej; Fri, 29 Dec 2023 07:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeP-0007mR-Lz
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:41 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeL-00050h-VX
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:39 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A25473F73A
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703851650;
 bh=s14UZKIRamkFLlhaFGm4Uw4f4/c+w2rqs+mbTkZJg4Q=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HHRDcV1/9I/ygSI0v51rDoZU9nAB9GYPV4zlKFH280a2RqS3gMfcxaJ5A2BsISQwV
 tSRbW7GskXkqQ5++T5C6cTUsHhCa6+RqaIevYv+mwzLqnre8h2xpyNWGsAOmcZi0Dn
 NsnbXTKkT+Z6H5xSdvNb0D1dWH+ZiIhRUoydBUv4GP3mOVXzv8o0tEAKGHckv7U4gu
 tqf3mS8Fac0Z+8cptZ7E2WDUSmavpdwh9CTUJmfZSdYslgzY6/ltN6sitYzjUOkLX8
 aeqD+/R3GDXcAh905ojm3/m2GtpPZQP5bDnweRvfMpheAk1Gr7MmRYZu5VLHy360Or
 QYk+x1HKdoNkA==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-55369c474e1so3996747a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 04:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703851650; x=1704456450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s14UZKIRamkFLlhaFGm4Uw4f4/c+w2rqs+mbTkZJg4Q=;
 b=puC98nbj7DxwHx6z3CUOpOhj0CsVPoF/7eP29hub8BZlADCdSNq22AR9eL1Oajmwse
 pUAvi52xv2EbIor2VaoMUDuP/034xGa4sTnGqtZG00I481Dtjp1y5P2zEh/9yIWvgX1w
 klYGBLq88bGfyIoWDqYz5zw/7B6RLNphtwxLXTZ/cUhE0H8OdZniyT9waseN8sdHbKZb
 YCAsGC2Wlof0SZnVbHP734ww65DWpzocEYklLv7ALXQuB15/JLnF7uwJ9rb72cqlmFR6
 4XS9cmOvPFU5rDoYHYxYMucFE9APxCTfETYkC0rE/V69rBKnoQlbRWAI0fKuBiGOKWcd
 3yIw==
X-Gm-Message-State: AOJu0Yy3oNei0XQKsWWsargfWbIgpm7RtxEbhs54ETySh2u5JcCuFIDw
 eIppfiBI2NiQfTaisqBijmCr1+k+pbHgaNTgP7zDjhC4dVZWj3tszDh3bBJeJ6KuzpaW5ZTXinO
 mR12nZOIhwO2HtKmz5ByQrtt7933J1neCnnJReeY=
X-Received: by 2002:a05:6402:2c9:b0:555:ba0d:f5a with SMTP id
 b9-20020a05640202c900b00555ba0d0f5amr268698edx.123.1703851650080; 
 Fri, 29 Dec 2023 04:07:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnMAoH5Zdij2HsmiFhNYuijcdbfoTJ5d7H8EdOtH7zAeKtc8CGnf2gv00S4ar//jPyieQBAw==
X-Received: by 2002:a05:6402:2c9:b0:555:ba0d:f5a with SMTP id
 b9-20020a05640202c900b00555ba0d0f5amr268693edx.123.1703851649784; 
 Fri, 29 Dec 2023 04:07:29 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 j20-20020aa7c0d4000000b005527de2aecfsm10943344edp.42.2023.12.29.04.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 04:07:29 -0800 (PST)
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
Subject: [PATCH v2 2/4] smbios: function to set default processor family
Date: Fri, 29 Dec 2023 13:07:22 +0100
Message-ID: <20231229120724.41383-3-heinrich.schuchardt@canonical.com>
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

Provide a function to set the default processor family.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 hw/smbios/smbios.c           | 7 +++++++
 include/hw/firmware/smbios.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 647bc6d603..03fe736565 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -989,6 +989,13 @@ void smbios_set_cpuid(uint32_t version, uint32_t features)
         field = value;                                                    \
     }
 
+void smbios_set_default_processor_family(uint16_t processor_family)
+{
+    if (type4.processor_family <= 0x01) {
+        type4.processor_family = processor_family;
+    }
+}
+
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type)
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 7f3259a630..6e514982d4 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -295,6 +295,7 @@ void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
+void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
 void smbios_get_tables(MachineState *ms,
                        const struct smbios_phys_mem_area *mem_array,
-- 
2.43.0


