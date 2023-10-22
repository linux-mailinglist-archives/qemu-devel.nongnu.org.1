Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BB7D2225
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:24:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgY-0006OX-5K; Sun, 22 Oct 2023 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgV-00065Q-Dt
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgS-0000QQ-8L
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gq5a9cgklusamAnqr6u4RtpwEQcuiHF1hB7JetLkRXQ=;
 b=exY49Mqo8X3kuozCfCdDhumLY/5SDkUyX+aOgFaEG1S+6EekaMYY5SXeDQLiqvt/agm2t0
 aPTA+FIfB0rXEf3xWtCLYPdUV9xpHRGDHPILcJjQZ7yxTyX5xiInmrhoTXQnQVIQ0IWVfZ
 NPGeTW5289RBOFh6RqbD7I0kRq9HR2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-5mZ_5GAQMh6_clwyHGV2Iw-1; Sun, 22 Oct 2023 05:23:42 -0400
X-MC-Unique: 5mZ_5GAQMh6_clwyHGV2Iw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084d08235fso14307795e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966620; x=1698571420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq5a9cgklusamAnqr6u4RtpwEQcuiHF1hB7JetLkRXQ=;
 b=tjDN+gcM+HkpzsW4k7Xw3s6wo1yV7XPI0+K8Hd9yxb2q//l50sWdOjgPayrsRPOibf
 orAm61V4v3Z8ErAfKsPVNJmI87vWRcoEwPDs2lIPk9CIOX0UM0xj6GCHh8vh77gDqv1s
 VUFasc2j4QGaBpKJC+8CzCF3p5Zx1eeqcxZrmC1z/TVSJMkjVDGxHHlreP2bIzfIvdMD
 1/CVP7RfV7mzVBfzRmFDwnWpGh8M6Bp9qfHS9RQEUAGB73cpo3DoghaoPcMnICDjgzB2
 9lVmjr/qudGXXGdlY+l03Bdxc0yNnQlW9y5hGBkB72HO/YisdbCTlpYIi6ewiIQdrmyg
 zEig==
X-Gm-Message-State: AOJu0YzRcYsSe8rO64mJy3Uks1KqWCFnmonNuAH52LdOAiCWqpWAoYJ/
 Porr+pjW+GV/c5ASeOiwXvQk6fbyEEBRIxNIuaptBRStrvJRx8show8gyqM4XXJZ+Ahh+LuqdHH
 GesUZKtsjIVto1UDxpi0PxRjIrqrOXWwSLlISAoPN8PczSjIWKWs5s8ItV5BBXpPNsF5O
X-Received: by 2002:a05:6000:152:b0:31f:8999:c409 with SMTP id
 r18-20020a056000015200b0031f8999c409mr4621955wrx.66.1697966620618; 
 Sun, 22 Oct 2023 02:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQZL0dmF1bSYTh4eFksYKlo1FBpyH9TrDLkKPp8SEf2JyAYZl2WRcsXj2GavRL9HrN/fAFIQ==
X-Received: by 2002:a05:6000:152:b0:31f:8999:c409 with SMTP id
 r18-20020a056000015200b0031f8999c409mr4621940wrx.66.1697966620294; 
 Sun, 22 Oct 2023 02:23:40 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 r4-20020adff704000000b0032d88e370basm5295065wrp.34.2023.10.22.02.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:39 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 23/62] hw/i386/pc_piix: Allow for setting properties before
 realizing PIIX3 south bridge
Message-ID: <fe9a7350c2900c9609e7a8ce1e042e3458a245e2.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Bernhard Beschow <shentey@gmail.com>

The next patches will need to take advantage of it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-3-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e36a3262b2..6d2f5509e6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -264,7 +264,8 @@ static void pc_init1(MachineState *machine,
         PIIX3State *piix3;
         PCIDevice *pci_dev;
 
-        pci_dev = pci_create_simple_multifunction(pci_bus, -1, TYPE_PIIX3_DEVICE);
+        pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
             pci_device_set_intx_routing_notifier(
-- 
MST


