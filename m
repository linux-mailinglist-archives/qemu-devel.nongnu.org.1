Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1001A2B0EC
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 19:28:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6be-0001xa-0z; Thu, 06 Feb 2025 13:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bZ-0001rN-6W
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bX-0001WA-I7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STyq72ML7rT9FicVBWSXnXvAyx/ZuheSNXOOWJ1gL0M=;
 b=jVbzQLkxDIexvhHkKoejkvkT76WBNY9V0edkEkCTrJr/+Unv5iU6TBBZXqfaqA+pLD6Ebm
 MqTxYX/GDs6O3tb5hauMm98v6VB6xzFbBJ0QnUww3qjpcEOgOKAeqAqc6kkcJypkbRt9Mi
 AbmLab6NTpeyqQrs2/oiKahdSOOd/hc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Q0z4apgWOI-Si5GVFCfbmQ-1; Thu, 06 Feb 2025 13:27:54 -0500
X-MC-Unique: Q0z4apgWOI-Si5GVFCfbmQ-1
X-Mimecast-MFC-AGG-ID: Q0z4apgWOI-Si5GVFCfbmQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso7086485e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866473; x=1739471273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STyq72ML7rT9FicVBWSXnXvAyx/ZuheSNXOOWJ1gL0M=;
 b=b+WjCHHELhYm4uq4TPlXWNG2Prt/ePz2zaKrg7qYRi3rxl8yO9Vf0LpUDqiGmsJcqr
 5lC92ic4s6HEd3Is1Uee5WC3F0cqT4GCsrL5NbTQ8En53xXeTWaqb7/odU2VLxXFAPZA
 607f6qVJiXwzor1H4oz63iOWC9w7qHikPPdzz1FY+XGXhQVodjy7Km2tujc4ja9shbbm
 fLirR+klJdyPXfZpMTeExdCGLWtcolc2BJzCHT1O3jGZROM9Sz9mXJ8nun93GbOFvLou
 Fr0YmBab2wY2THTKZPush2ewlXHsGj1Sn3Wf4MFXNtXOVKc2Xs63g3U6z5v+QEVPQfu2
 fHrw==
X-Gm-Message-State: AOJu0Yyo7qxtjc4tcuwijJAdkg7yTAygqC5ljtBmaeO4IJpe6mZa3cH0
 cnN5245sw0wbCouL5FLE0x7w6XBNyBVebD1B4OS1cmLDC2U16q3y2z5iHOhsKvNoB85YYydpvch
 y7VlvLoQ8Tkj1aaobmAcE7nIpWhpBfjihRpdNS+IWG43+1IkbQwJKfhBD8T7j5J8PRzAoEoO436
 6MFFmyDn3mi6HNwI2Bp4EdOnepCJmgKjcBDxa/lTw=
X-Gm-Gg: ASbGncv5O/HhPyToTSa2X/uKivBSNZm3Hdr5rX5bfpu70GN373vLxV9XI4ZxZNetJ10
 qzIftDze5MHGqjhcQYmElpnVejwsCFtOhMB+9ILDRZEQi1Bxz9v/UPtzrpf6hmQOCbD5X1Tn9vI
 km83OGi7Jj+izxYh1qfYQRgl+QegxgV/2anGR0h9Q2tdFBP659DZhKYP4elwat4PVSm5kC16icL
 Q5BEH6B9SIPORQBQ79vrH1w+klkDo4cY3n3EyHKeQlhrUFBI1e1diJlNQqEeTssRWFcz4SnymgL
 3PkZleY=
X-Received: by 2002:a05:600c:4748:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-439249e6676mr4050435e9.31.1738866472670; 
 Thu, 06 Feb 2025 10:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMSizYmKgIPyTmJ6wZJxCyoK28lewewEd9WDUduFDWqDH0CLO5NNmT7Lqkn+mPAyOLMB3ObA==
X-Received: by 2002:a05:600c:4748:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-439249e6676mr4050255e9.31.1738866472210; 
 Thu, 06 Feb 2025 10:27:52 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd36967sm2393506f8f.37.2025.02.06.10.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 18/22] target/riscv: convert TT Ascalon to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:27:06 +0100
Message-ID: <20250206182711.2420505-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 127 +++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b0bc5e4503f..b2b9b4f6e39 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -525,72 +525,6 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 #endif
 }
 
-/* Tenstorrent Ascalon */
-static void rv64_tt_ascalon_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
-    env->priv_ver = PRIV_VERSION_1_13_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.mmu = true;
-    cpu->cfg.vlenb = 256 >> 3;
-    cpu->cfg.elen = 64;
-    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
-    cpu->cfg.rvv_ma_all_1s = true;
-    cpu->cfg.rvv_ta_all_1s = true;
-    cpu->cfg.misa_w = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.cbom_blocksize = 64;
-    cpu->cfg.cbop_blocksize = 64;
-    cpu->cfg.cboz_blocksize = 64;
-    cpu->cfg.ext_zic64b = true;
-    cpu->cfg.ext_zicbom = true;
-    cpu->cfg.ext_zicbop = true;
-    cpu->cfg.ext_zicboz = true;
-    cpu->cfg.ext_zicntr = true;
-    cpu->cfg.ext_zicond = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zihintntl = true;
-    cpu->cfg.ext_zihintpause = true;
-    cpu->cfg.ext_zihpm = true;
-    cpu->cfg.ext_zimop = true;
-    cpu->cfg.ext_zawrs = true;
-    cpu->cfg.ext_zfa = true;
-    cpu->cfg.ext_zfbfmin = true;
-    cpu->cfg.ext_zfh = true;
-    cpu->cfg.ext_zfhmin = true;
-    cpu->cfg.ext_zcb = true;
-    cpu->cfg.ext_zcmop = true;
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbs = true;
-    cpu->cfg.ext_zkt = true;
-    cpu->cfg.ext_zvbb = true;
-    cpu->cfg.ext_zvbc = true;
-    cpu->cfg.ext_zvfbfmin = true;
-    cpu->cfg.ext_zvfbfwma = true;
-    cpu->cfg.ext_zvfh = true;
-    cpu->cfg.ext_zvfhmin = true;
-    cpu->cfg.ext_zvkng = true;
-    cpu->cfg.ext_smaia = true;
-    cpu->cfg.ext_smstateen = true;
-    cpu->cfg.ext_ssaia = true;
-    cpu->cfg.ext_sscofpmf = true;
-    cpu->cfg.ext_sstc = true;
-    cpu->cfg.ext_svade = true;
-    cpu->cfg.ext_svinval = true;
-    cpu->cfg.ext_svnapot = true;
-    cpu->cfg.ext_svpbmt = true;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
-#endif
-}
-
 static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -3095,7 +3029,66 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
+        .priv_spec = PRIV_VERSION_1_13_0,
+        .vext_spec = VEXT_VERSION_1_00_0,
+
+        /* ISA extensions */
+        .cfg.mmu = true,
+        .cfg.vlenb = 256 >> 3,
+        .cfg.elen = 64,
+        .cfg.rvv_ma_all_1s = true,
+        .cfg.rvv_ta_all_1s = true,
+        .cfg.misa_w = true,
+        .cfg.pmp = true,
+        .cfg.cbom_blocksize = 64,
+        .cfg.cbop_blocksize = 64,
+        .cfg.cboz_blocksize = 64,
+        .cfg.ext_zic64b = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicond = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zimop = true,
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zfbfmin = true,
+        .cfg.ext_zfh = true,
+        .cfg.ext_zfhmin = true,
+        .cfg.ext_zcb = true,
+        .cfg.ext_zcmop = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zkt = true,
+        .cfg.ext_zvbb = true,
+        .cfg.ext_zvbc = true,
+        .cfg.ext_zvfbfmin = true,
+        .cfg.ext_zvfbfwma = true,
+        .cfg.ext_zvfh = true,
+        .cfg.ext_zvfhmin = true,
+        .cfg.ext_zvkng = true,
+        .cfg.ext_smaia = true,
+        .cfg.ext_smstateen = true,
+        .cfg.ext_ssaia = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svade = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_svpbmt = true,
+
+        .satp_mode64 = VM_1_10_SV57,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
-- 
2.48.1


