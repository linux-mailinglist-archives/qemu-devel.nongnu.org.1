Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D738A8010F6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977R-00034O-BJ; Fri, 01 Dec 2023 12:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977A-0002ur-5T
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9778-0007lG-2J
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrKNKLCrqbViEto/bsg54GhvLMk/mxP8+8YpGPYFhyY=;
 b=ZxRz7kihGbaYJUiOEbtBaZEhM0FxA0a8dtvmmEX3kfMNe5YYBRKGn/JKRYqNLUrenN+XJ6
 MyH74OTzY83w4xWY5KweEXOPdB2fsfOi5Ii++6VJU+f5dq7ywLamgfuuRRGTZywoUdkZgk
 oBAcOJRugGLRRUNNyU4qNyCckgnRIYg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-eMRTn7UVO-q2sBfkkw9L0Q-1; Fri, 01 Dec 2023 12:15:38 -0500
X-MC-Unique: eMRTn7UVO-q2sBfkkw9L0Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40b443d698eso15703185e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450937; x=1702055737;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DrKNKLCrqbViEto/bsg54GhvLMk/mxP8+8YpGPYFhyY=;
 b=oKcf6rUSrU4klSYgu1IZavKJs2d8y34p8K5pezLAdmCt4r7xG30dgl4WzAr4lAfasc
 Gd+n30F1UDV0txBbzr254uiBcbg3MBMtbDkIoGU3V9d4n5R5Sc4HJao5AId74o9Ocv5Z
 ZyJTGFBfjL9sdvFZU2Hl0IcwxvH39qgpoSqhufp9SFr2XjwG7nPk7nQlWto007/FLT1n
 O1UbslHNKz3vnZcS91lHAUWyN73m6SWk+dW3ZFIsxIKjId5WPI5dBLFgE6/WAfM1BmYF
 c/i/vmfblO5OkrHD8aVvAFRTHaDMD8RXYFedXPvh2gFkxfRSDBHESInWvZ2T3tMY7qXq
 O22g==
X-Gm-Message-State: AOJu0YzaPWQSD5i4Uzbz0T58kqdJonMPhZotkY5JjvoOCB6gN6X88R47
 aewT218ngpMvh5Q9w/YuwQIfY7F52BKYoCmjuVS3x3HEUUnveLKyRGLcN9LDTcARsrPQu9MYXwA
 htQiwHG1OASsQPJuPnj7a1UM6Km4FUSVx/pznCh+gQZE0+iQXcQrgDQxAl/CsZoc5ppUF
X-Received: by 2002:a5d:4102:0:b0:332:eeba:ee8b with SMTP id
 l2-20020a5d4102000000b00332eebaee8bmr1154468wrp.24.1701450936833; 
 Fri, 01 Dec 2023 09:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuLQK/lZyIfPVQQ89c/nS4yr/HesY1BrVGK5Btfe71aL+ZgONMSgQRxnVLZBLxhJca9HBSZg==
X-Received: by 2002:a5d:4102:0:b0:332:eeba:ee8b with SMTP id
 l2-20020a5d4102000000b00332eebaee8bmr1154452wrp.24.1701450936437; 
 Fri, 01 Dec 2023 09:15:36 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 h7-20020adf9cc7000000b0032d8eecf901sm4750493wre.3.2023.12.01.09.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:35 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 10/15] hw/acpi/erst: Do not ignore Error* in realize handler
Message-ID: <451276c0e247fc8b708105e3b0fdcaf6ed7c13ec.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

erst_realizefn() passes @errp to functions without checking for
failure.  If it runs into another failure, it trips error_setv()'s
assertion.

Use the ERRP_GUARD() macro and check *errp, as suggested in commit
ae7c80a7bd ("error: New macro ERRP_GUARD()").

Cc: qemu-stable@nongnu.org
Fixes: f7e26ffa59 ("ACPI ERST: support for ACPI ERST feature")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231120130017.81286-1-philmd@linaro.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/erst.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 35007d8017..ba751dc60e 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -947,6 +947,7 @@ static const VMStateDescription erst_vmstate  = {
 
 static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
 {
+    ERRP_GUARD();
     ERSTDeviceState *s = ACPIERST(pci_dev);
 
     trace_acpi_erst_realizefn_in();
@@ -964,9 +965,15 @@ static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
 
     /* HostMemoryBackend size will be multiple of PAGE_SIZE */
     s->storage_size = object_property_get_int(OBJECT(s->hostmem), "size", errp);
+    if (*errp) {
+        return;
+    }
 
     /* Initialize backend storage and record_count */
     check_erst_backend_storage(s, errp);
+    if (*errp) {
+        return;
+    }
 
     /* BAR 0: Programming registers */
     memory_region_init_io(&s->iomem_mr, OBJECT(pci_dev), &erst_reg_ops, s,
@@ -977,6 +984,9 @@ static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
     memory_region_init_ram(&s->exchange_mr, OBJECT(pci_dev),
                             "erst.exchange",
                             le32_to_cpu(s->header->record_size), errp);
+    if (*errp) {
+        return;
+    }
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY,
                         &s->exchange_mr);
 
-- 
MST


