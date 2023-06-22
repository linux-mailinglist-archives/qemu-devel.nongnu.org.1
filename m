Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF4739E99
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:34:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHdH-0002zA-Oz; Thu, 22 Jun 2023 06:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdG-0002z2-G3
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdD-0007Hs-Re
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687430018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9lBo45iBOx3ROsD8+uccm1MTNpEHRYqfkqJn9ffz3Y=;
 b=AlyPGrbSUfF3AK21VIphGegqlGfyj1q6JZr1nMrpPWNz3o+fMcE+mRC9xobhQztTnDHw/I
 +KvJA6cBZcbncir9O9qd7EaEhT8mXt8Z34p1kjLn3IDlCeyiIzW78NekdcKzhOAv5YZqTf
 K4Krg1s6k47K2KjZv/eYLNNA/m2ks9c=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-wfCVJT-2MmyZLOia_8WzPw-1; Thu, 22 Jun 2023 06:33:37 -0400
X-MC-Unique: wfCVJT-2MmyZLOia_8WzPw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5609a6c4145so2241403eaf.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687430016; x=1690022016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9lBo45iBOx3ROsD8+uccm1MTNpEHRYqfkqJn9ffz3Y=;
 b=FRVNYSrg/WVX5MqWDvYnmKyUoDZG3PdswK2dRkBCNwxMCrSjhawTxwoyby+aygVLJ1
 rm3kV/c8NZMjx3+HW/aDQ7AETh1tv/YG3nTwx195wZh+iN9++JNhGB9XSV3ykQgZCjfD
 abSwchlV0KimxUeyMhgrwiNV8CMq3G2XhXJgTKhKPuo85l6xalpDgujH2ksDxBtsBTEP
 F+adUJeFw8ljjYv53RZxv7f/RqTxxKRZnh2EdzWVUNBPYkDJ7Xyt1jD121S5l37Njqwl
 UOHCxSjkvle/JjJNx9UXE/UpwC2iEqciFSuESF877eQld5EODI9GY3/Wis8DMkGUtzrs
 zinQ==
X-Gm-Message-State: AC+VfDz5q0x/bIiAJam3P2VzjQE80TmF7ToxwywcJHZEIxnJ07tWNO6L
 /mTCY7HTQHIpfNjV1SZzsL+Lezxr4pIQrkdj75didQw66XVo45pSvlYOQ2MRZnoNz1Ne/8udctT
 Up4fyqoUzwWWlcULFHb+wYiXcB2ghGWGuIOqLi/ymn/8wS33nJvzm5IUAA6lLjZ1aOVgmLS6T2L
 4=
X-Received: by 2002:a05:6808:618:b0:39a:a521:383e with SMTP id
 y24-20020a056808061800b0039aa521383emr15420393oih.51.1687430016596; 
 Thu, 22 Jun 2023 03:33:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SYQyWF0iq4I99UsM1x1ShSnw9RV7x8aAduZ7OIo7HvoriR7V1lI0LRZH5ziVeeix3niE9tw==
X-Received: by 2002:a05:6808:618:b0:39a:a521:383e with SMTP id
 y24-20020a056808061800b0039aa521383emr15420379oih.51.1687430016353; 
 Thu, 22 Jun 2023 03:33:36 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.213])
 by smtp.googlemail.com with ESMTPSA id
 29-20020a17090a035d00b0025eb3b237b4sm11004872pjf.44.2023.06.22.03.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 03:33:35 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 2/5] tests/acpi/bios-tables-test: use the correct slot on
 the pcie-root-port
Date: Thu, 22 Jun 2023 16:02:52 +0530
Message-Id: <20230622103255.267289-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230622103255.267289-1-anisinha@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
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


