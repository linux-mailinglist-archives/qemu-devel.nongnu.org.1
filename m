Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A77836408
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRu2S-0000OK-RK; Mon, 22 Jan 2024 08:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2Q-0000Nm-Lr
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:30 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2N-000130-6i
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:28 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5747340F07
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705928903;
 bh=/DdGWBKENTjZaY7KXKP1GzdLyXx7O5ZTdH2bjh80K18=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rK9EGAp5/w5ew0FmZTrRoesOKWJVFF0RHgH15tnklh5OZ2OnJ5Wcr4CeOxjehwDqD
 MmT0ZLXTH+VGSRush8M/kDK2Bqv3nnb0gXtwPzM2Tdv7OFOXLQYyPukwvdCgfWXMwJ
 sEDoLxmHQT+kPwwro6JTjbgSMeqxkctx49HO11AcWLwB4gXvW6EBpvLGIo7VHZ+JJ1
 oMrNXUByQXmOeabbSlYBl6Qw61ehJq7T9Mn1bK7fOFV5lG9Vme3NXKNrG8hda9NxW+
 MTwXxxdknLMCvS/51P5g65Od9fxEtbRRo/BIWio/FEWOWFedyHd+Tz9aYc0RlS/C6h
 vyRwZri5MCSNg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e74860cb0so11098855e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928903; x=1706533703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DdGWBKENTjZaY7KXKP1GzdLyXx7O5ZTdH2bjh80K18=;
 b=Snc0iyJPR0pUneWgFxwru86X5t7+pPWsvRopWdW5hZ/aigMgit6OnpMUOtnpIUerxf
 W6EfUf6ZOikb1NQ4iC5sl8yc3fP+h8XGEnuuedS0h3qg+Z2y2Hk9PVmr8JtDT36SxpOT
 4F526HYsSgXOQ1WJjlcKxIdzR6dtWJY/EXoQ3VVD2uNZLUuZvNt1GdbJcQLpur7ZhlWl
 fsDo/O0yJaajwcztPC36L6UPP+OhHbqZaFQh687y5qtbRy5Vts6+9/82DZjq4XflKSRZ
 atmd75YLlGKCPAa1KsojuxumR1BaRCHno/AfFygR38nk93CSbkm1m5lZoQspMRZ2hm3u
 ewmA==
X-Gm-Message-State: AOJu0Yym4bkPzFHTyTVhLPgt3QcdVlaX4DBLze5h0USev/WBPLmuD7Rd
 4tWsiMtAaLWGe5c8LLvdXByUJmqBDhVp2JMYB4GZZeBoqXB+/uiCR3ec/6AxSJva1lqpvKdzj3M
 3Z4LYlSGyeBGINIdmrZeBhjNVUiq9b82LMbQxwLFwvLWk6L6MrxGEjTY2IFSbjMaWS0iz
X-Received: by 2002:a05:600c:4d0e:b0:40e:75e5:4e70 with SMTP id
 u14-20020a05600c4d0e00b0040e75e54e70mr2192372wmp.166.1705928902908; 
 Mon, 22 Jan 2024 05:08:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExRT6gsEd/qOi465xI+wdYQnAJxVXrEJMllDivULizXySEff+kPZa4juN9B9iG3qjUMHDmBA==
X-Received: by 2002:a05:600c:4d0e:b0:40e:75e5:4e70 with SMTP id
 u14-20020a05600c4d0e00b0040e75e54e70mr2192363wmp.166.1705928902659; 
 Mon, 22 Jan 2024 05:08:22 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm39214456wmn.35.2024.01.22.05.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 05:08:22 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/4] smbios: function to set default processor family
Date: Mon, 22 Jan 2024 14:07:56 +0100
Message-ID: <20240122130758.74051-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
References: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v3:
	no change
v2:
	new patch
---
 hw/smbios/smbios.c           | 7 +++++++
 include/hw/firmware/smbios.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 647bc6d603..c0c5a81e66 100644
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


