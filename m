Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03613831C15
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:13:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU1Q-0002As-CN; Thu, 18 Jan 2024 10:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0L-0000KA-D3; Thu, 18 Jan 2024 10:08:32 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0J-00089X-CZ; Thu, 18 Jan 2024 10:08:29 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so674246a12.0; 
 Thu, 18 Jan 2024 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590503; x=1706195303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=932rck93+p3uE7RHibSzEQIxsVpMtqfmklZvCHAoAU0=;
 b=IVCWxOIDtDcSVvOs4A0fBzoLJlBk0+lQ4KSUGLBwFe49aDeM+idcc5SOLSWUIpAczz
 2ESmlJvhs21MfP7BlWlHzKmhoNBiG/5bErZM1UlAbtULtV3k79KAvhUr3xWZ9+qsy3NO
 QwlgRhP5IVwXQbkIRErMCRDmJtouJ5/zQf65XFG33KqtOZAvq1D6GN/7NzgUM7r7+PH8
 MKU9SgtDXI8eo4PgcfZ4k6M/Q3SZIGOlv1ohnKYiU/8mX1627uDGpLHzaVtG0fLtsMNG
 Xfm/eAsxVN6i/qpP0iDvZPf554Re/YW6vg+ojey5yEjOjBTUMT5nxjhKrXdK7E1LWaIY
 0owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590503; x=1706195303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=932rck93+p3uE7RHibSzEQIxsVpMtqfmklZvCHAoAU0=;
 b=Ye3pbEgBeMxGsRZPPMk3WhKQrIWJmeSIxiF8waAjft3TNiAtyGaTQ6hOTXFAXKnMPv
 ZKcJfaXzi/P6+TyZxN/6WqB/+wos0qAVCd5KRkQcrpix4TZsHOwAh0OY+j/cx9C/El5A
 C2ZdDfVTxCTGhT9UmzQdWjKYi0n00e/bkIHRfEq8xLqYxsMuNtj3EQTJHG8zN9wfPgxX
 3/NshoHQeUU8MkkTMcjauxz7WMqq+zQhE14rtYL9vj4r5EyZrz2xGw791Q/7zQdxy5GG
 vKWwiy+8shiYsE2/+zWYy6fNR2yKOUYRI4qTKaJ2BjXtrxwVNBYs1+dxtQgh2J5I24qb
 CAtQ==
X-Gm-Message-State: AOJu0YwV7ON/oJnhuDx9ndCbn5pAyrOAg/pbl5WAIpUG8whEuZM0RgZy
 LgsDrpz6pNUtlQ8h5BLAjfKMKds36Fx//7el+fXbf201wKB8ALOkso1WgGFA
X-Google-Smtp-Source: AGHT+IHg6TdHArdCi0xy9me+FO1Nwc6/ertvxpmg441ncDzHYEYzyWaiCZwKNyaX39/jPkgCJCPNzg==
X-Received: by 2002:a17:90a:6008:b0:28e:6dfd:ad6c with SMTP id
 y8-20020a17090a600800b0028e6dfdad6cmr3633030pji.10.1705590503702; 
 Thu, 18 Jan 2024 07:08:23 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 19/26] target/ppc: Wire up BookE ATB registers for e500 family
Date: Fri, 19 Jan 2024 01:06:37 +1000
Message-ID: <20240118150644.177371-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From the Freescale PowerPC Architecture Primer:

  Alternate time base APU. This APU, implemented on the e500v2, defines
  a 64-bit time base counter that differs from the PowerPC defined time
  base in that it is not writable and counts at a different, and
  typically much higher, frequency. The alternate time base always
  counts up, wrapping when the 64-bit count overflows.

This implementation of ATB uses the same frequency as the TB. The
existing spr_read_atbu/l functions are unused without this patch
to wire them into the SPR.

RTEMS uses this SPR on the r6500 (not yet tested).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8287494c39..b732a1b06e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -920,6 +920,18 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
 #endif
 }
 
+static void register_atb_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_ATBL, "ATBL",
+                 &spr_read_atbl, SPR_NOACCESS,
+                 &spr_read_atbl, SPR_NOACCESS,
+                 0x00000000);
+    spr_register(env, SPR_ATBU, "ATBU",
+                 &spr_read_atbu, SPR_NOACCESS,
+                 &spr_read_atbu, SPR_NOACCESS,
+                 0x00000000);
+}
+
 /* SPR specific to PowerPC 440 implementation */
 static void register_440_sprs(CPUPPCState *env)
 {
@@ -2896,6 +2908,11 @@ static void init_proc_e500(CPUPPCState *env, int version)
     register_BookE206_sprs(env, 0x000000DF, tlbncfg, mmucfg);
     register_usprgh_sprs(env);
 
+    if (version != fsl_e500v1) {
+        /* e500v1 has no support for alternate timebase */
+        register_atb_sprs(env);
+    }
+
     spr_register(env, SPR_HID0, "HID0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
-- 
2.42.0


