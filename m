Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE7779430
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUqH-0001Bq-GG; Fri, 11 Aug 2023 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUq9-0001At-6r
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUq6-0002v9-D1
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691770693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5HrhQDqCZESUAZxnB5WFAVSGLIbuLgc4e3wnZg4iy4=;
 b=DCI/NWJttqlhf3JYe8qo18q7Z6mNskOUA//4JLU5mLi+WZf34+4SG0zFBoTK5dgcaONKTz
 fAZBfSpquuEm9jMQeW2Hmx/xVEtNg8Qy1gqjJLE8PMa4SfjA+Wv7qopVhdATruDgW/gzhP
 yHsBe1xjVffnhowvtF5Y2zByQMVBfuQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-OlQOlHU2NUyhrgxaHqgVoA-1; Fri, 11 Aug 2023 12:18:12 -0400
X-MC-Unique: OlQOlHU2NUyhrgxaHqgVoA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso145937366b.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770690; x=1692375490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5HrhQDqCZESUAZxnB5WFAVSGLIbuLgc4e3wnZg4iy4=;
 b=gHi2cqluzm2tMo+0gqf0vuERlfQfPGhCButdSBjaUAKES/rwekcThufLaE4QpYTPCo
 nWZvkyrNBUwmd0Hj3jbHGL0XQ110qmrCi9+f2ewwL2nmgkk7iIwalNDjKJRO/ECHQER0
 aIkG+YUnLVLlCQRr9RHXZsKjy3pcj2tg6KtcY65mE9ca5gu3Wz1tynftMFKjq0C4fxRt
 u7v4uWUYQgpICPV53AJnmBlaFO/17cQH1/Wx681xJmgQySApowXGDZHkV4ohyVmWH0S3
 1/HCEKg3l/yK5bSWzD4qUWa6ThTS14BPLvYLrr6vNV8eA27H9GnABfgjaFznNK0Cc6e1
 GRCg==
X-Gm-Message-State: AOJu0Yy05jgxLKRUWkP7ZS/gugih71p9mZvoMP1Sg0n/0jHeUzbBy5+t
 Vtyn2tJvewcZVtVjuIBQAQ6TipQhco8O0MmIHFn58ida5vFpowo7FYOEzA8lpKarMWbsjAkDFPF
 5i0Z7AjWFyU/aRdVC/O8cnM5a/vNqLJ2gUnhSDj+vMdZfHLLPq4eAPSVOpOE5mZwo9/DX
X-Received: by 2002:a17:906:3107:b0:99c:d069:d1e with SMTP id
 7-20020a170906310700b0099cd0690d1emr2069015ejx.46.1691770690656; 
 Fri, 11 Aug 2023 09:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH96wfK0M6IoUwM1yCbtGqBZ05PZe/nlybv8oUvJrd4dnu9ALxl+q7RRA686obZ5CQrzx9JMw==
X-Received: by 2002:a17:906:3107:b0:99c:d069:d1e with SMTP id
 7-20020a170906310700b0099cd0690d1emr2068995ejx.46.1691770690301; 
 Fri, 11 Aug 2023 09:18:10 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 qh28-20020a170906ecbc00b0099ce188be7fsm2452870ejb.3.2023.08.11.09.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:18:09 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:18:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Guoyi Tu <tugy@chinatelecom.cn>,
 yuanminghao <yuanmh12@chinatelecom.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 2/2] pci: Fix the update of interrupt disable bit in
 PCI_COMMAND register
Message-ID: <0f936247e8ed0ab5fb7e75827dd8c8f73d5ef4b5.1691770630.git.mst@redhat.com>
References: <cover.1691770630.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691770630.git.mst@redhat.com>
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

From: Guoyi Tu <tugy@chinatelecom.cn>

The PCI_COMMAND register is located at offset 4 within
the PCI configuration space and occupies 2 bytes. The
interrupt disable bit is at the 10th bit, which corresponds
to the byte at offset 5 in the PCI configuration space.

In our testing environment, the guest driver may directly
updates the byte at offset 5 in the PCI configuration space.
The backtrace looks like as following:
    at hw/pci/pci.c:1442
    at hw/virtio/virtio-pci.c:605
    val=5, len=1) at hw/pci/pci_host.c:81

In this situation, the range_covers_byte function called
by the pci_default_write_config function will return false,
resulting in the inability to handle the interrupt disable
update event.

To fix this issue, we can use the ranges_overlap function
instead of range_covers_byte to determine whether the interrupt
bit has been updated.

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>
Message-Id: <ce2d0437-8faa-4d61-b536-4668f645a959@chinatelecom.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: b6981cb57be5 ("pci: interrupt disable bit support")
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b8d22e2e74..881d774fb6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1613,7 +1613,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         range_covers_byte(addr, l, PCI_COMMAND))
         pci_update_mappings(d);
 
-    if (range_covers_byte(addr, l, PCI_COMMAND)) {
+    if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-- 
MST


