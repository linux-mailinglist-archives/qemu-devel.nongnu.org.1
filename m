Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC8A7D0192
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXiC-00028x-6L; Thu, 19 Oct 2023 14:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfh-00073m-RH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfg-0000rZ-Bb
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gq5a9cgklusamAnqr6u4RtpwEQcuiHF1hB7JetLkRXQ=;
 b=BlezHp6Y37WvareFJM/SqOhPuv5BtT3olZahY3Owz6czdVsftz5fZv8247RO+Lc+iMeG7/
 yWX3tx/b+eQwIcjLeCOca+T4A4feqmaWWV+HUO08c9IKsYUt8TuvhOl2M41YjHRkRMa3Fh
 Ypp4LNM6HdhbvYzAugZqYa7+xy81Gvc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-JIGMBl0sO4KeSAgKsVLQiQ-1; Thu, 19 Oct 2023 14:22:58 -0400
X-MC-Unique: JIGMBl0sO4KeSAgKsVLQiQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d879cac50so5653f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739777; x=1698344577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq5a9cgklusamAnqr6u4RtpwEQcuiHF1hB7JetLkRXQ=;
 b=DFFjW0cl1Y1YSKOMICAE7AYhFCNoBG4umD/GhDVkArRfOBiaz5i1ZBOqubLR0OToii
 l4R5mzUnQlDP4bJmjYxIZVXoh6qVQmbzIc2lE+zOfhyxTJZTw58U45XddkFDshKHdLaa
 xz3jWD6sQ6XAUZR8igejvBQ4V8iM7aVyrom8J1hYypXFDsmOHtydhlULmHuPKTvZZEfK
 lSGzUFEj+D2TOEqG5FvKsK47QOiYI1/ZXm8qe0/mp8YCNNAtCubIutX9K76Ni+RDBWE1
 TF8ThIYcO3zZM+b8SeY+HLcgrdLvI5QTWRyVWJ2GiVcLpglZXFc6d9Lx4ZRcAs16q36c
 d4Dw==
X-Gm-Message-State: AOJu0YzKhdXevbXIGZDa+Oi8JXEog30EE3ywa/o7WIfvNcsp+Ivn9eDz
 gC0U/YAkkfOBUd3QeBF40drhzBylX+mytGdhKSiXD+KnV43muVs4TcrxsDkmgOBssMGvy5wpDM9
 6baUX8FY+lQfDBHhyC7Rdg8dnMcoVpYS4cJHFBikbmoAqkQ8/Mp4/Rb1WxUTGJ7C0BGDi
X-Received: by 2002:adf:db05:0:b0:32d:a495:435b with SMTP id
 s5-20020adfdb05000000b0032da495435bmr2299561wri.61.1697739776975; 
 Thu, 19 Oct 2023 11:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzc4ch72vhTZUYVo9rsfkUOO0O/KmF4LYAlgr5SX36EU27HhQlJ9AXx+szhFtTNwMw+49E+Q==
X-Received: by 2002:adf:db05:0:b0:32d:a495:435b with SMTP id
 s5-20020adfdb05000000b0032da495435bmr2299544wri.61.1697739776635; 
 Thu, 19 Oct 2023 11:22:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 i7-20020adffc07000000b0032d8354fb43sm5049921wrr.76.2023.10.19.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:56 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 39/78] hw/i386/pc_piix: Allow for setting properties before
 realizing PIIX3 south bridge
Message-ID: <07779d2a500af6a47d8638da6f404f9f70b917e2.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


