Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A2736EA4
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcJu-0008I0-2k; Tue, 20 Jun 2023 10:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBcJn-0008He-F5
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBcJm-0003xn-1V
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687271208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FPpYquacaALJ41zl0aQayZGpY0MOvg2TLdFRHge69Z4=;
 b=LBMbwJml5HkVhTpW978h+5n6J27TTsjPXOSimJDktkqnD6u6fTQ70iSHjkO5yK2RzVWyx0
 /I5qFh6iyCfWVR4guQkNhUDtc1HHdhRKGIAp8HJ74Xkr2h2hFsJtA7HFxZserApzphM35s
 Rj5NTls2nIf95ulfcGmMrcy0cOqCrPQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-3Oj_1tGvOGeSpmoVrCKRsw-1; Tue, 20 Jun 2023 10:26:38 -0400
X-MC-Unique: 3Oj_1tGvOGeSpmoVrCKRsw-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-342832d50f2so12454345ab.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687271160; x=1689863160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPpYquacaALJ41zl0aQayZGpY0MOvg2TLdFRHge69Z4=;
 b=MN7y4yz/XJ2N7qr3YV8N7w8rE+Z+3egpUtNaxm6r55zMAfYbzNOuQoznV7bthy0u+R
 GkF1Fu+d7+uyqOY9dZhMq7Ow8MQRsPD05wwLfyd48WuI2WerKezMJR6HCMKg6rIuS65/
 MxF1NT/c5MJXBZ3ck3u9CBviCUwgjYNLq1hUGigRlw8+/5+ujcdjWl/TlvoNZMubDQDb
 nrGgUABUctRYHhKLhtp4yxGtEwKB9gzAUlerWagvPZPptN91lMFl2/sY65zv7yRU7Ia4
 iK8/U7RZy3+a6UbSuZ6BVHcH003dyt5vSRvQAuIjD250W+tZgxRT9SVeNWertc68Ga4J
 xl1A==
X-Gm-Message-State: AC+VfDxV2wg3vJcRvEp58XAdRodHDZ1sdGXggbUZJRaaprQ2neaf5woh
 yUAdmymEu8nIu9Jj2srR5YBL8CfNP8U/QEg6sS3hfcNWYbBo0uGjGepVSggG64d4cFhaJoqdg+r
 q62FvFUZx0RIa1ow=
X-Received: by 2002:a92:dc4d:0:b0:33b:363d:27eb with SMTP id
 x13-20020a92dc4d000000b0033b363d27ebmr8091571ilq.30.1687271160146; 
 Tue, 20 Jun 2023 07:26:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+nDoeB+YHX1VEv2jesBIwye3iOY4KgzjFtCwempaa8pRaPEGSbdMqjDoDKp/R6WspVVP98w==
X-Received: by 2002:a92:dc4d:0:b0:33b:363d:27eb with SMTP id
 x13-20020a92dc4d000000b0033b363d27ebmr8091554ilq.30.1687271159822; 
 Tue, 20 Jun 2023 07:25:59 -0700 (PDT)
Received: from localhost.localdomain ([116.72.143.94])
 by smtp.googlemail.com with ESMTPSA id
 b1-20020a630c01000000b00534684201b0sm1493280pgl.27.2023.06.20.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 07:25:59 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/pci: add comment explaining the reason for checking
 function 0 in hotplug
Date: Tue, 20 Jun 2023 19:55:51 +0530
Message-Id: <20230620142551.115394-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

This change is cosmetic. A comment is added explaining why we need to check for
the availability of function 0 when we hotplug a device.

CC: mst@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..847e534f68 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1179,6 +1179,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
         return NULL;
+    /*
+     * Populating function 0 triggers a scan from the guest that
+     * exposes other non-zero functions. Hence we need to ensure that
+     * function 0 wasn't added yet.
+     */
     } else if (dev->hotplugged &&
                !pci_is_vf(pci_dev) &&
                pci_get_function_0(pci_dev)) {
-- 
2.39.1


