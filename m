Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD49E7705
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 18:23:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJc1Y-0004IP-Tl; Fri, 06 Dec 2024 12:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc1O-00047S-DK; Fri, 06 Dec 2024 12:21:42 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc1L-0000xY-Lw; Fri, 06 Dec 2024 12:21:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CACFE5C6668;
 Fri,  6 Dec 2024 17:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A0CC4AF0E;
 Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733505688;
 bh=gH9yBConPFlFAtM5yFnFIpjEGK22gESF+5Hl3wqFIsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KMbMu3HUDRY4XARuHPlMa3Y35tEDU7FqK84deiaamMnlDr9eY4bU9Pp+QxVG1cxts
 91QoUvh3qgrHPiLUpxTBcY995K2vIm83brX7fkbzni+e2Eg7l3cJtdmW4b4171I7Im
 S8wPr0FB1YMHko+pZBRQyCfXg4ohQFOzTTWuha2OXQtV5YlmDJM+mQqQWF004acFgp
 6cMJZMuyKFXnD7RJS5XOSorifnbCKWC3GkehwUmLLWgBDbqTZPjXgX9FvPgrpokGFZ
 HsaXXl9+pYxaLT64nRiC26LWEoTMYNaPaP21RKmVFvt83RKxHyKgN/C+/ElmPNuhdH
 iiCS8Gp0g+8RA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc18-00000005RLG-0ui3; Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 27/31] DEBUG
Date: Fri,  6 Dec 2024 18:12:49 +0100
Message-ID: <6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5 autolearn=ham autolearn_force=no
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index abca351b18de..1fe4c536611a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -534,9 +534,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     ags = &acpi_ged_state->ghes_state;
 
     if (!ags->hest_lookup) {
+        fprintf(stderr,"Using old GHES lookup\n");
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
     } else {
+        fprintf(stderr,"Using new HEST lookup\n");
         get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
                                 &cper_addr, &read_ack_register_addr, errp);
     }
-- 
2.47.1


