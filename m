Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178B836405
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRu2T-0000Oj-01; Mon, 22 Jan 2024 08:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2Q-0000Nj-LH
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:30 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2O-000134-FY
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:30 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0847140C72
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705928903;
 bh=bkdhpseem98U1T18GinlyhMKqzaSig5oZwtVLCYIx7A=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=hIBg8mxN6Q4JYeLj1mSaXThcYmVZ3Gy0iuEN/ZBHuq6dLQgWNzxw4mRItWaiq87bG
 WBxRzokmxueT+gmSnoL8YJGwq+kewySRjP7VOC98ktKYfG+bPIJljTkG5BRW2qmvlr
 cIMu+phl81y54qJUwLQ11tr3yegyI/OErzYb+shlhltXA2b81DNbV598ekCg15mfJx
 2LcvdCo7Y4B9svzJig8JCfgT6CsoYzDgDg4qBcG6knudeqcX9+fleSe9h4Ruyap7vo
 M5ZBxDvCLrk5QAcE1q/3/+Voer9t5FErwMXMrS7eCEi/9L2LiUaPLN0pgEelWokugz
 vC55CbLCB621Q==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e863cb806so30865905e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928902; x=1706533702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkdhpseem98U1T18GinlyhMKqzaSig5oZwtVLCYIx7A=;
 b=UtsVsw7rCrRmF1vd4vJ3l26GapmIWqAJNWI3TIgTtCcB4KDDBm0lXRDsv7P0yidZc5
 Nnj0TV8dcru9YbgpwN9wW7tr42e9s+8uaF97v+eMpUNOqOhf23T3WTX4R7j8EbSS7QRq
 FKC8JkMOPiWCHCN7vAAqxrrJHW+vRYqKT7WYAkARUrhDQPfo90+Uz44qANwbS0wXEtDF
 0d50Z89D7EZLCgEWj38u7zRLn8K0ramOhtIgjeGpD4gHaalihLD10EIsJ/xlq4pwz3zI
 6ng1o3gLQBwyz/he3GKkELO+zA/KoWQtMF5pyTsU+NCMXBaRb1qCXzTDyLQuMGQkgfk9
 heKw==
X-Gm-Message-State: AOJu0Yy0Ilhkv2qOijMU7VxeCcrdToqglRMul3Qw/WQ/Y1dms6ohB2T8
 VSDfSay5dxt5JJiTDCntA8ztDsalIqhy/z5myalVZVZl/wzJO9y2CeXZnuBG4amQ06iUCRucRr1
 fcubYG8yFXb5knwWqx2vUEGKwpWBLNPwZhA7P+djoEHSSG/vI0P74HlyTTo8lpnbNpWXo
X-Received: by 2002:a05:600c:1310:b0:40e:509b:4bcd with SMTP id
 j16-20020a05600c131000b0040e509b4bcdmr1150021wmf.375.1705928902165; 
 Mon, 22 Jan 2024 05:08:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF4Lz4w5Q13ye8H2GDlhNKmd1wbVHb+LigwBhM4NKRNdDAuU59yatBmjHni2ZMaA2hYxQBQg==
X-Received: by 2002:a05:600c:1310:b0:40e:509b:4bcd with SMTP id
 j16-20020a05600c131000b0040e509b4bcdmr1150013wmf.375.1705928901790; 
 Mon, 22 Jan 2024 05:08:21 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm39214456wmn.35.2024.01.22.05.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 05:08:21 -0800 (PST)
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
Subject: [PATCH v3 1/4] smbios: add processor-family option
Date: Mon, 22 Jan 2024 14:07:55 +0100
Message-ID: <20240122130758.74051-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
References: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
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

For RISC-V the SMBIOS standard requires specific values of the processor
family value depending on the bitness of the CPU.

Add a processor-family option for SMBIOS table 4.

The value of processor-family may exceed 255 and therefore must be provided
in the Processor Family 2 field. Set the Processor Family field to 0xFE
which signals that the Processor Family 2 is used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v3:
	no change
v2:
	new patch
---
 hw/smbios/smbios.c | 13 +++++++++++--
 qemu-options.hx    |  4 ++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 2a90601ac5..647bc6d603 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -102,6 +102,7 @@ static struct {
 #define DEFAULT_CPU_SPEED 2000
 
 static struct {
+    uint16_t processor_family;
     const char *sock_pfx, *manufacturer, *version, *serial, *asset, *part;
     uint64_t max_speed;
     uint64_t current_speed;
@@ -110,6 +111,7 @@ static struct {
     .max_speed = DEFAULT_CPU_SPEED,
     .current_speed = DEFAULT_CPU_SPEED,
     .processor_id = 0,
+    .processor_family = 0x01, /* Other */
 };
 
 struct type8_instance {
@@ -337,6 +339,10 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
         .name = "part",
         .type = QEMU_OPT_STRING,
         .help = "part number",
+    }, {
+        .name = "processor-family",
+        .type = QEMU_OPT_NUMBER,
+        .help = "processor family",
     }, {
         .name = "processor-id",
         .type = QEMU_OPT_NUMBER,
@@ -726,7 +732,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     snprintf(sock_str, sizeof(sock_str), "%s%2x", type4.sock_pfx, instance);
     SMBIOS_TABLE_SET_STR(4, socket_designation_str, sock_str);
     t->processor_type = 0x03; /* CPU */
-    t->processor_family = 0x01; /* Other */
+    t->processor_family = 0xfe; /* use Processor Family 2 field */
     SMBIOS_TABLE_SET_STR(4, processor_manufacturer_str, type4.manufacturer);
     if (type4.processor_id == 0) {
         t->processor_id[0] = cpu_to_le32(smbios_cpuid_version);
@@ -758,7 +764,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
 
     t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
-    t->processor_family2 = cpu_to_le16(0x01); /* Other */
+    t->processor_family2 = cpu_to_le16(type4.processor_family);
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
         t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
@@ -1402,6 +1408,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
                 return;
             }
             save_opt(&type4.sock_pfx, opts, "sock_pfx");
+            type4.processor_family = qemu_opt_get_number(opts,
+                                                         "processor-family",
+                                                         0x01 /* Other */);
             save_opt(&type4.manufacturer, opts, "manufacturer");
             save_opt(&type4.version, opts, "version");
             save_opt(&type4.serial, opts, "serial");
diff --git a/qemu-options.hx b/qemu-options.hx
index ced8284863..d90bdffc7a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2686,7 +2686,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
-    "              [,processor-id=%d]\n"
+    "              [,processor-family=%d,processor-id=%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
     "                specify SMBIOS type 8 fields\n"
@@ -2714,7 +2714,7 @@ SRST
 ``-smbios type=3[,manufacturer=str][,version=str][,serial=str][,asset=str][,sku=str]``
     Specify SMBIOS type 3 fields
 
-``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str][,processor-id=%d]``
+``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str][,processor-family=%d][,processor-id=%d]``
     Specify SMBIOS type 4 fields
 
 ``-smbios type=11[,value=str][,path=filename]``
-- 
2.43.0


