Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0A709AB3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TI-0005Wz-OJ; Fri, 19 May 2023 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01T4-00050D-LG
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sy-0003kN-On
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yL382e7AnC4ayRKjUR+8KuEK+Fg9P80Jv7fuv4Rssck=;
 b=QB5q5E/lz30SkBWjiJocsttjzPYNnHcY9jnRz85q/ei1AAKV3GFQSVgXAwwhkofmQBaGAO
 wjhD4t1MhaMfd1YXBXvTqnJJgFdAG7ApAlcpSCPSR/vquYLsGbNJohJS1NFHgdBG1PHb+b
 5D33GL+o+0iQ56grlcozafPQzxun/yA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-a7qvYsYrPxuupZGrrobwOg-1; Fri, 19 May 2023 10:52:23 -0400
X-MC-Unique: a7qvYsYrPxuupZGrrobwOg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af237b22aaso4960241fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507939; x=1687099939;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yL382e7AnC4ayRKjUR+8KuEK+Fg9P80Jv7fuv4Rssck=;
 b=lFjYVpslG9eTmVnFQ4NQAwROO+fia7BZvwQCUyFBCodu2krjhPue7i0z94Ob/XINqO
 NNNSf+FbG0D+olFU/VFV8l74tKVwVsSjWJqcGEv1m2RmfR1UQ0co6YovwCnAiLC/7rdT
 L1t+YIpeOH20Sqrd7JY4wt0qn+LPVToHC8RqKz1vmau8tw34XaGNLK4RmkTkg35Fvp9r
 LEtwsQQ2saNJ0xF+BmtnM/ndyyWe+gOpf1dZPCmNjj5GvqKqSB/z7LPOTUmDOKyw1LlP
 6OhffLdyFww+5PKY3AZYJGqSwYZbs97UZhm6/b2S6ftnUrSsX3RcfqMUpIjC0PbXUsQf
 X6lQ==
X-Gm-Message-State: AC+VfDy/q3pePwdlhVjzKbBpLiH2HFn/fORt7COEpYl3kV7fKuGRIzGL
 ZDsVSLt1TPbwyBxjnUZXjoqe6EtzXJ62Rp6sd3xwhfA74tykUEAoj8ypVzsdbfjAnSY50tH2sNH
 aAwHddS27FuSKopxQsyo5SVhJ+qfrmVXUhk7lUs0EfSG4PPP53FV3YbbQWaOAvs2XmkB6
X-Received: by 2002:a2e:b04d:0:b0:29f:58c6:986e with SMTP id
 d13-20020a2eb04d000000b0029f58c6986emr811366ljl.52.1684507939384; 
 Fri, 19 May 2023 07:52:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BBoUNxQ0Plh7QFLNuPkZ7JbhXGtm+85gYLAL6owOdGN6erxB+kkKni03pVPqXuSTOuJkDRw==
X-Received: by 2002:a2e:b04d:0:b0:29f:58c6:986e with SMTP id
 d13-20020a2eb04d000000b0029f58c6986emr811352ljl.52.1684507939135; 
 Fri, 19 May 2023 07:52:19 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 a5-20020a05651c010500b002a8b08882dbsm854659ljb.55.2023.05.19.07.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:18 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 30/40] hw/i386/pc_q35: Reuse machine parameter
Message-ID: <1ab7167b09446996a8c967c6fe2eb4dcb9f53c87.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230213162004.2797-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f02919d92c..a76c2d4501 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -218,7 +218,7 @@ static void pc_q35_init(MachineState *machine)
     pc_memory_init(pcms, get_system_memory(), rom_memory, &ram_memory,
                    pci_hole64_size);
 
-    object_property_add_child(qdev_get_machine(), "q35", OBJECT(q35_host));
+    object_property_add_child(OBJECT(machine), "q35", OBJECT(q35_host));
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_RAM_MEM,
                              OBJECT(ram_memory), NULL);
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_PCI_MEM,
-- 
MST


