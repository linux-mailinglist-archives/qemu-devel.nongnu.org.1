Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784897CE253
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:09:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vw-0007pk-2u; Wed, 18 Oct 2023 11:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ug-0004KX-8f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ue-00077c-5J
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gq5a9cgklusamAnqr6u4RtpwEQcuiHF1hB7JetLkRXQ=;
 b=Ku+iGh7yFukVWYrOyS0kJ6BpHjYggFbcEEWCI4WR/IUlWd5pKYkUDfkzedol78oeuD8H/O
 Ctl4auLxhzwB97XlG/7/KHnrPWzY56hIrhwI0p8lx0Va+Dq0PvbZjkwINaq34h/timx2m4
 Jawm48dY5gpSwtfIZsKhNOg+0VO5JVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-5p_aU2uYPd25nygGLH7BZg-1; Wed, 18 Oct 2023 11:56:46 -0400
X-MC-Unique: 5p_aU2uYPd25nygGLH7BZg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4077e9112b4so25265795e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644604; x=1698249404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq5a9cgklusamAnqr6u4RtpwEQcuiHF1hB7JetLkRXQ=;
 b=hAatImKDBW8alAcXOH/E1kyBNAZt51VK5dEN8boeMzDe5B6EmVzrZZ4AcviQ4TY/74
 Lb/bAjRs/tV2mS5bMgiT2tcDKyDWmRLyxcBKFptJFZ7HfLht5nMWd8DWFrOoAR166wz/
 YOeXgljXHIsjtaI9e5t+hNu8o6tCopsoEafSDf5GUZo2xW+bYEFrJHqTfesjrR0ChDWd
 ThDJX4Pa6DVBBuX6y4Sy9IF14b4Mcy7gLSkTvHQMc9PtmOhRsXjitFq30Yw6TDUgy0jI
 ToipzwVpxN55YGYMv6EpqVFuiMU56Ms3ba8fUDJjU8oW+tvDD5OK/VL0vJSQLDFQHPPb
 ah+g==
X-Gm-Message-State: AOJu0Yy1sOVef+QRpMKK8tb6s/6SmhvWeCRz6EBLyvsQJxeuX4nNEKKW
 m5QInzvDcHdjkjOudGfc5f5Ju5ODPa8gW4JUI/W/TsX1PaHYLGsvbWWo1iC+NI4ck/YzB5RAWv6
 Td5YHWgzAJyI923b7r7295faW29jfRWworwvGGz6LrlWTe0iKWFAPl6lLX3tXN1ewBby8WDU=
X-Received: by 2002:a05:600c:468e:b0:405:3d04:5f52 with SMTP id
 p14-20020a05600c468e00b004053d045f52mr4279735wmo.24.1697644604607; 
 Wed, 18 Oct 2023 08:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEznV9EVqIusTp62/1f18QBj8l2IikeCzaV1LA+nTS/NXjgogVee9IRBftVMpfsqBGb8WZzPA==
X-Received: by 2002:a05:600c:468e:b0:405:3d04:5f52 with SMTP id
 p14-20020a05600c468e00b004053d045f52mr4279718wmo.24.1697644604140; 
 Wed, 18 Oct 2023 08:56:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a7bca4d000000b00402ff8d6086sm1990012wml.18.2023.10.18.08.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:43 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 44/83] hw/i386/pc_piix: Allow for setting properties before
 realizing PIIX3 south bridge
Message-ID: <cd232c0a6ce02a5c9de103c2426a13005b9329a2.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


