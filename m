Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B364074E1FF
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvo-0001H9-0x; Mon, 10 Jul 2023 19:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvl-00012i-VC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvk-0004XZ-ET
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CIQfU3WFFO/+csV0ypsEiMeMOH7tqtHxkacd12WBjno=;
 b=R8+FxZXVyKEdz7h0Qv9IjTdPsOMAnShV2nDuBgyGjDZR4Lk2EPkxSYmGuX/bc+N93l5Ws7
 AV9EKjCOCdVzo5X7Cw7PI4WQA4VipqsIlmO3UEzoCQnW6Mhvp6Fsi02TP9+JTo09tPjTLa
 YViNt+jGoUDQVdm75yJ2ep+YZGyKwLc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-321VpTNYMuKrgvXW2aB9aQ-1; Mon, 10 Jul 2023 19:04:30 -0400
X-MC-Unique: 321VpTNYMuKrgvXW2aB9aQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa979d0c32so31021325e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030269; x=1691622269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIQfU3WFFO/+csV0ypsEiMeMOH7tqtHxkacd12WBjno=;
 b=d+oWABRsAMDW3WPlyn63nLzaNyZkojHp6N+PiSGwwVhP1aeIFUvrM6UTPaOSA/aNIR
 uB4c+IBVjoRdkm2f/DmMxEqueOCViJ88t/phuKwcpbX8XiBkLKBN9U5CzrCJku91sszt
 QKIKzEHF0knIq+qR8oy8TlzfVKGGNILnYlrxRhfxGO1RxW7Ze2d5zHZzhJqqxhFP/9B/
 8Ln7cbLJemWY/E4JRjNwPkZ+ambzitUKSLXXREJGLddLSqW4Wuj3cQ8AwfbkVjGZSGTF
 w9txzep/ZVacFl6XvONUQrt3LiE9U4JrMsYAjI9lJUPB6l2OxOh1WvVJfDsYodZdDfKT
 Iz+w==
X-Gm-Message-State: ABy/qLZvuLIlzYRVi/oGELYFCo7kxWU0JtxIhzfqX4tQw2zbakNX7OY7
 Cfc+4I1EL/NgHxIQoWo++1XwZFee9JzAEDooxd7WVbqHD6RsN+Tp65zcYRzZEdoCNyU6lrtnUzt
 tg2Jx4FyuyqDEMVQbr8M5LemKFSpbLRcqZDXv7xW3MFmCF7IzccSkgF/g7i+vTkyRXBvf
X-Received: by 2002:a1c:6a09:0:b0:3fc:586:ccb4 with SMTP id
 f9-20020a1c6a09000000b003fc0586ccb4mr7471185wmc.36.1689030269152; 
 Mon, 10 Jul 2023 16:04:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEtd8psith3Q/JFLB7Gmf04jVUIDcMl+Na99LBUqCvrAwxSeCsbtqLakfrUvvSkhcoPQa2csg==
X-Received: by 2002:a1c:6a09:0:b0:3fc:586:ccb4 with SMTP id
 f9-20020a1c6a09000000b003fc0586ccb4mr7471171wmc.36.1689030268862; 
 Mon, 10 Jul 2023 16:04:28 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c458d00b003fa9a00d74csm20008487wmo.3.2023.07.10.16.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:28 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 42/66] tests/acpi/bios-tables-test: use the correct slot on
 the pcie-root-port
Message-ID: <7b0ba7b1c8b362a83bfb30170dae6035a71192c2.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ani Sinha <anisinha@redhat.com>

PCIE ports only have one slot, slot 0. Hence, non-zero slots are not available
for PCIE devices on PCIE root ports. Fix test_acpi_q35_tcg_no_acpi_hotplug()
so that the test does not use them.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230705115925.5339-3-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ed1c69cf01..47ba20b957 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1020,9 +1020,9 @@ static void test_acpi_q35_tcg_no_acpi_hotplug(void)
         " -device pci-testdev,bus=nohprp,acpi-index=501"
         " -device pcie-root-port,id=nohprpint,port=0x0,chassis=3,hotplug=off,"
                                  "multifunction=on,addr=8.0"
-        " -device pci-testdev,bus=nohprpint,acpi-index=601,addr=8.1"
+        " -device pci-testdev,bus=nohprpint,acpi-index=601,addr=0.1"
         " -device pcie-root-port,id=hprp2,port=0x0,chassis=4,bus=nohprpint,"
-                                 "addr=9.0"
+                                 "addr=0.2"
         " -device pci-testdev,bus=hprp2,acpi-index=602"
         , &data);
     free_test_data(&data);
-- 
MST


