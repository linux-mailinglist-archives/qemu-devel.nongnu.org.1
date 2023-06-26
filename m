Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF5773E45C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoqM-0007UF-72; Mon, 26 Jun 2023 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoqF-0007T8-B9
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoqD-0002mW-NO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687796005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=Md7nMMjNi/GR9dVtBnzTNk2z7nuOOOBZfyw7z+fxSyLXrJLL2xJK8VPXie94GI/33Sh3Fq
 KsB5++Y/x414kMgKnotBTSGUOftWHWAgWmHBncZdYv85wRnb8L2zL4x6zXACb5wtgNiHMI
 oNu3yHY7Lxnh7iINEKcti6Muh2aZk6M=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-2S65WXZ8MzCkWdcC5ZUibA-1; Mon, 26 Jun 2023 12:13:23 -0400
X-MC-Unique: 2S65WXZ8MzCkWdcC5ZUibA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3a1e58db5caso718870b6e.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687796002; x=1690388002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=fF9sXQNuZU5TN8iM/8XFJ+UFOaWoOWfejY3mNJcVAnj4/Q08WcgZ0kepFC150d07iR
 p8G3yCXpiZU28um9rVx8p5tHixl8w3NguG3aIP1H3N84pYweltLJz3sUdiP46dQlrYKu
 K7y6JaEAZ3TaC2nImLYtxOBu98m0lYMOGQG25awt9k82uvnDrudd+Mp206qpZNgEgoi5
 31cThOlS48nFk9XvHhhmq5CnjvbK0tmkBZdx+Avs3c74CMn/qE5ZnOwnLioaifBT8uKA
 XrBV7gDfRTGzrCTgvzAcmGGvlBRySlMQUaqVhCu/LM/8lNda6tBd8FdO2pzz/qYY5ro2
 bPFA==
X-Gm-Message-State: AC+VfDxFYMeCdOcIw7DiC6ba6EuJK10CsM93i7A6i/AcDnHABFRrfDgq
 ExbtnElLi67KYJSAx5GL6abl7p67AfVa3XMMzfXML7i0s+otcuW5G7+zxmUuHrIrzXVWBtC0+jm
 JV5gwKvAYtu7796jJDcnRWdpiJADgJt4DDMmlCuWWs+TKRizar5rVl/L8iVbNWeFlBJl3KPqjSF
 8=
X-Received: by 2002:a05:6808:2128:b0:3a1:b4f1:26a with SMTP id
 r40-20020a056808212800b003a1b4f1026amr11449519oiw.52.1687796002505; 
 Mon, 26 Jun 2023 09:13:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40UbsuWKlhcvdUbIV+Np1dFfuQyKOYMruh0F2zHUcGMsTKk6aBmprQf/ck3E+x8ZWdhIbf4Q==
X-Received: by 2002:a05:6808:2128:b0:3a1:b4f1:26a with SMTP id
 r40-20020a056808212800b003a1b4f1026amr11449492oiw.52.1687796002244; 
 Mon, 26 Jun 2023 09:13:22 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 q5-20020a631f45000000b0051b7d83ff22sm4318745pgm.80.2023.06.26.09.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:13:21 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [RESEND PATCH v5 2/5] tests/acpi/bios-tables-test: use the correct
 slot on the pcie-root-port
Date: Mon, 26 Jun 2023 21:42:41 +0530
Message-Id: <20230626161244.4145-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626161244.4145-1-anisinha@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

PCIE ports only have one slot, slot 0. Hence, non-zero slots are not available
for PCIE devices on PCIE root ports. Fix test_acpi_q35_tcg_no_acpi_hotplug()
so that the test does not use them.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
2.39.1


