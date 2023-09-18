Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B97A4AA4
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:36:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEOI-0000eI-R0; Mon, 18 Sep 2023 09:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENn-0000Bb-Tp
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENl-0004gP-Tx
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695044023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUqoOfaO0gXGdW/5f1u4Tsk2Abafzpfal3JTmWroQEA=;
 b=WZPhNpwidd6/Yj9LUMXS9ZXzMZi3YP+Gbw7K8fv9slBGe+DHktDxJBop4HowBxUzLZC5sZ
 +2Dj3aPTQLGKqE/FOQJ3QrykntBUxXT2KfLTiZokAD89RAZvjJfycSBLPPcPjxrJJHDEfl
 U2Yl6OoRIbj47JYiXx73rBNgef6FNyc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-vmTDYGeVPha-qpiq_M315g-1; Mon, 18 Sep 2023 09:33:42 -0400
X-MC-Unique: vmTDYGeVPha-qpiq_M315g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D49973C025C9;
 Mon, 18 Sep 2023 13:33:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 988421005E27;
 Mon, 18 Sep 2023 13:33:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 04B411800DC1; Mon, 18 Sep 2023 15:33:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 3/8] edk2: update build config
Date: Mon, 18 Sep 2023 15:33:25 +0200
Message-ID: <20230918133338.2399701-4-kraxel@redhat.com>
In-Reply-To: <20230918133338.2399701-1-kraxel@redhat.com>
References: <20230918133338.2399701-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

risc-v switched to use split code/vars images like the other archs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2-build.config | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index 66ef9ffcb91f..ffe0d12d0cb7 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -120,5 +120,7 @@ conf = OvmfPkg/RiscVVirt/RiscVVirtQemu.dsc
 arch = RISCV64
 plat = RiscVVirtQemu
 dest = ../pc-bios
-cpy1 = FV/RISCV_VIRT.fd  edk2-riscv.fd
-pad1 = edk2-riscv.fd     32m
+cpy1 = FV/RISCV_VIRT_CODE.fd  edk2-riscv-code.fd
+cpy2 = FV/RISCV_VIRT_VARS.fd  edk2-riscv-vars.fd
+pad1 = edk2-riscv-code.fd     32m
+pad2 = edk2-riscv-vars.fd     32m
-- 
2.41.0


