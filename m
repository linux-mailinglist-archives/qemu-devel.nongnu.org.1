Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92947A4A9D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEOJ-0000iZ-KC; Mon, 18 Sep 2023 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENp-0000Bl-UI
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENm-0004gd-H7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695044025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQITvE2jgXFdamjjuDLCXC/+bAQXnvUfjj28/l61NSU=;
 b=GM1KYr78TYn8kExQDUFeK19ksUc+jEC8NSuVLCVj26CDmjTHTsZnhd50CUoJ0grP7Ie2j1
 9htm3+qFVY5RtwS6SgV12CpPtTRy6SjkeJVbODPoayTH++IB7wCO5jx2DWQd180pGiQsqz
 42C+JpAc33yBI3er/KdgWEZvF/T1Mc0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-m5mYQ-jFNR6YvJXVFHZzCg-1; Mon, 18 Sep 2023 09:33:43 -0400
X-MC-Unique: m5mYQ-jFNR6YvJXVFHZzCg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DD2A1C05146;
 Mon, 18 Sep 2023 13:33:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29AA240C2064;
 Mon, 18 Sep 2023 13:33:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 132561800DCB; Mon, 18 Sep 2023 15:33:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 4/8] edk2: workaround edk-stable202308 bug
Date: Mon, 18 Sep 2023 15:33:26 +0200
Message-ID: <20230918133338.2399701-5-kraxel@redhat.com>
In-Reply-To: <20230918133338.2399701-1-kraxel@redhat.com>
References: <20230918133338.2399701-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Set PCD to workaround two fixes missing the release.
https://github.com/tianocore/edk2/commit/8b66f9df1bb0fd5ebb743944d41cb33178cf2fdd
https://github.com/tianocore/edk2/commit/020cc9e2e7053bb62247b0babbbe80cb855592e5

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2-build.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index ffe0d12d0cb7..bab6a9caebfa 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -26,6 +26,9 @@ DEBUG_PRINT_ERROR_LEVEL  = 0x80000000
 # grub.efi uses EfiLoaderData for code
 PcdDxeNxMemoryProtectionPolicy = 0xC000000000007FD1
 
+[pcds.workaround.202308]
+PcdFirstTimeWakeUpAPsBySipi = FALSE
+
 ####################################################################################
 # i386
 
@@ -57,6 +60,7 @@ desc = ovmf build (64-bit)
 conf = OvmfPkg/OvmfPkgX64.dsc
 arch = X64
 opts = common
+pcds = workaround.202308
 plat = OvmfX64
 dest = ../pc-bios
 cpy1 = FV/OVMF_CODE.fd edk2-x86_64-code.fd
@@ -67,6 +71,7 @@ conf = OvmfPkg/OvmfPkgIa32X64.dsc
 arch = IA32 X64
 opts = common
        ovmf.sb.smm
+pcds = workaround.202308
 plat = Ovmf3264
 dest = ../pc-bios
 cpy1 = FV/OVMF_CODE.fd edk2-x86_64-secure-code.fd
@@ -76,6 +81,7 @@ desc = ovmf build for microvm
 conf = OvmfPkg/Microvm/MicrovmX64.dsc
 arch = X64
 opts = common
+pcds = workaround.202308
 plat = MicrovmX64
 dest = ../pc-bios
 cpy1 = FV/MICROVM.fd  edk2-x86_64-microvm.fd
-- 
2.41.0


