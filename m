Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8EA7C7F05
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwK-0004gn-5c; Fri, 13 Oct 2023 03:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwH-0004XP-1C
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCw0-0004Mt-Al
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so1740848f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183410; x=1697788210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66vawv2jQ85l7nEj6T3VZBD0nxIvxIedFUMpqTCTMPs=;
 b=jsbGTeH3K9txWklVTGXwEyJO2QJAKwvcL8K208RKKVWhEJRnYnCbIi/3Qd7AttP+xB
 F2ag6WrtYoFjnOdc6r2wQf3UMhMcneleq+K/RQG6zcgY6B00qpDWDkNMDBEcytnU/5qO
 xzIxTxGjoIJIDcLVWgBHrCUsuL8bjZWxfhXVPsGl2vKrtKASd+GTbv6DeYIpw42WG+1Q
 riCPtnrVgk6/TTEFr7s7GW9lEhm+maOmpjst0VmZwtjucsXfNItDKfJCTF1rM9EwrfLb
 gsszjrDZC5LG45JwrI0usVxZiM/wrBEYfPZACZ7Csrm28bPO/FovyqNtHbefP147ofCx
 s7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183410; x=1697788210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66vawv2jQ85l7nEj6T3VZBD0nxIvxIedFUMpqTCTMPs=;
 b=mea47h/gVxm8+4tlAkxS8CkdGHSedGjTnshTDPFznA4pt1nLKONToBcy1jFvayEg6k
 JMXJCjHUXGFfF1BdmR5lm+4j8/QzVatIRhqxQu8wLLpgCW0q3I7CwdOWWoJpvl6j0KL+
 diNEzylndTQjkuo/ZD30dpT+6TAKjvBPa9rEkrVE/CduiQ93ICUHnBkApIc6sLFDn48K
 CWiPXIqUoilGRVEWwAr2wseSOdYhivbqRarxuPGwzumQ0pLIT1WpzZkH3sysZMqqYq3D
 AY2DHRsqWawPZKPv7EQg+qPiAI5vdzbiue6vLGDysdQh+eVHIeYnBLeA848HlG9oKvGM
 1mMw==
X-Gm-Message-State: AOJu0Yy+V+aUpBsaHcKZg8IYsKLxYaNTcDRw956PiQ3yYN3pfYNMKLG+
 8wKgkoiSsINMEGWg7SyuDV8ws+Y7Qoja2x4eoew=
X-Google-Smtp-Source: AGHT+IHL1ThSqx4qtaCucHo7MfWHaoGkV/qeCc1vdHVDktP1ImrBIAU17c+xPhRsYOxqdy4Ktio8pw==
X-Received: by 2002:a5d:56c8:0:b0:321:4de3:fd5c with SMTP id
 m8-20020a5d56c8000000b003214de3fd5cmr22236868wrw.51.1697183410103; 
 Fri, 13 Oct 2023 00:50:10 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:09 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 12/78] hw/usb: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:16 +0300
Message-Id: <0b899c2fdbfedc8fa3ebe91e4fb9a8e9ddc124be.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/usb/dev-mtp.c   | 2 +-
 hw/usb/dev-wacom.c | 2 +-
 hw/usb/hcd-ehci.c  | 4 +++-
 hw/usb/hcd-xhci.c  | 4 ++--
 hw/usb/redirect.c  | 4 ++--
 hw/usb/tusb6010.c  | 2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1cac1cd435..5cbaabd2b2 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1602,76 +1602,76 @@ static int usb_mtp_update_object(MTPObject *parent, char *name)
 static void usb_mtp_write_data(MTPState *s, uint32_t handle)
 {
     MTPData *d = s->data_out;
     MTPObject *parent =
         usb_mtp_object_lookup(s, s->dataset.parent_handle);
     char *path = NULL;
     uint64_t rc;
     mode_t mask = 0755;
     int ret = 0;
 
     assert(d != NULL);
 
     switch (d->write_status) {
     case WRITE_START:
         if (!parent || !s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                 0, 0, 0, 0);
             return;
         }
 
         if (s->dataset.filename) {
             path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
             if (s->dataset.format == FMT_ASSOCIATION) {
                 ret = g_mkdir(path, mask);
                 if (!ret) {
                     usb_mtp_queue_result(s, RES_OK, d->trans, 3,
                                          QEMU_STORAGE_ID,
                                          s->dataset.parent_handle,
                                          handle);
                     goto close;
                 }
                 goto done;
             }
 
             d->fd = open(path, O_CREAT | O_WRONLY |
                          O_CLOEXEC | O_NOFOLLOW, mask & 0666);
             if (d->fd == -1) {
                 ret = 1;
                 goto done;
             }
 
             /* Return success if initiator sent 0 sized data */
             if (!s->dataset.size) {
                 goto done;
             }
             if (d->length != MTP_WRITE_BUF_SZ && !d->pending) {
                 d->write_status = WRITE_END;
             }
         }
-        /* fall through */
+        fallthrough;
     case WRITE_CONTINUE:
     case WRITE_END:
         rc = write_retry(d->fd, d->data, d->data_offset,
                          d->offset - d->data_offset);
         if (rc != d->data_offset) {
             ret = 1;
             goto done;
         }
         if (d->write_status != WRITE_END) {
             g_free(path);
             return;
         } else {
             /*
              * Return an incomplete transfer if file size doesn't match
              * for < 4G file or if lstat fails which will result in an incorrect
              * file size
              */
             if ((s->dataset.size != 0xFFFFFFFF &&
                  d->offset != s->dataset.size) ||
                 usb_mtp_update_object(parent, s->dataset.filename)) {
                 usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
                                      0, 0, 0, 0);
                 goto close;
             }
         }
     }
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 7177c17f03..bd2a1bae50 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -371,27 +371,27 @@ static void usb_wacom_handle_control(USBDevice *dev, USBPacket *p,
 static void usb_wacom_handle_data(USBDevice *dev, USBPacket *p)
 {
     USBWacomState *s = (USBWacomState *) dev;
     g_autofree uint8_t *buf = g_malloc(p->iov.size);
     int len = 0;
 
     switch (p->pid) {
     case USB_TOKEN_IN:
         if (p->ep->nr == 1) {
             if (!(s->changed || s->idle)) {
                 p->status = USB_RET_NAK;
                 return;
             }
             s->changed = 0;
             if (s->mode == WACOM_MODE_HID)
                 len = usb_mouse_poll(s, buf, p->iov.size);
             else if (s->mode == WACOM_MODE_WACOM)
                 len = usb_wacom_poll(s, buf, p->iov.size);
             usb_packet_copy(p, buf, len);
             break;
         }
-        /* Fall through.  */
+        fallthrough;
     case USB_TOKEN_OUT:
     default:
         p->status = USB_RET_STALL;
     }
 }
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 19b4534c20..e29cc21957 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1402,116 +1402,116 @@ static int ehci_execute(EHCIPacket *p, const char *action)
 static int ehci_process_itd(EHCIState *ehci,
                             EHCIitd *itd,
                             uint32_t addr)
 {
     USBDevice *dev;
     USBEndpoint *ep;
     uint32_t i, len, pid, dir, devaddr, endp;
     uint32_t pg, off, ptr1, ptr2, max, mult;
 
     ehci->periodic_sched_active = PERIODIC_ACTIVE;
 
     dir =(itd->bufptr[1] & ITD_BUFPTR_DIRECTION);
     devaddr = get_field(itd->bufptr[0], ITD_BUFPTR_DEVADDR);
     endp = get_field(itd->bufptr[0], ITD_BUFPTR_EP);
     max = get_field(itd->bufptr[1], ITD_BUFPTR_MAXPKT);
     mult = get_field(itd->bufptr[2], ITD_BUFPTR_MULT);
 
     for(i = 0; i < 8; i++) {
         if (itd->transact[i] & ITD_XACT_ACTIVE) {
             pg   = get_field(itd->transact[i], ITD_XACT_PGSEL);
             off  = itd->transact[i] & ITD_XACT_OFFSET_MASK;
             len  = get_field(itd->transact[i], ITD_XACT_LENGTH);
 
             if (len > max * mult) {
                 len = max * mult;
             }
             if (len > BUFF_SIZE || pg > 6) {
                 return -1;
             }
 
             ptr1 = (itd->bufptr[pg] & ITD_BUFPTR_MASK);
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);
             if (off + len > 4096) {
                 /* transfer crosses page border */
                 if (pg == 6) {
                     qemu_sglist_destroy(&ehci->isgl);
                     return -1;  /* avoid page pg + 1 */
                 }
                 ptr2 = (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);
                 uint32_t len2 = off + len - 4096;
                 uint32_t len1 = len - len2;
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);
                 qemu_sglist_add(&ehci->isgl, ptr2, len2);
             } else {
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len);
             }
 
             dev = ehci_find_device(ehci, devaddr);
             if (dev == NULL) {
                 ehci_trace_guest_bug(ehci, "no device found");
                 ehci->ipacket.status = USB_RET_NODEV;
                 ehci->ipacket.actual_length = 0;
             } else {
                 pid = dir ? USB_TOKEN_IN : USB_TOKEN_OUT;
                 ep = usb_ep_get(dev, pid, endp);
                 if (ep && ep->type == USB_ENDPOINT_XFER_ISOC) {
                     usb_packet_setup(&ehci->ipacket, pid, ep, 0, addr, false,
                                      (itd->transact[i] & ITD_XACT_IOC) != 0);
                     if (usb_packet_map(&ehci->ipacket, &ehci->isgl)) {
                         qemu_sglist_destroy(&ehci->isgl);
                         return -1;
                     }
                     usb_handle_packet(dev, &ehci->ipacket);
                     usb_packet_unmap(&ehci->ipacket, &ehci->isgl);
                 } else {
                     DPRINTF("ISOCH: attempt to address non-iso endpoint\n");
                     ehci->ipacket.status = USB_RET_NAK;
                     ehci->ipacket.actual_length = 0;
                 }
             }
             qemu_sglist_destroy(&ehci->isgl);
 
             switch (ehci->ipacket.status) {
             case USB_RET_SUCCESS:
                 break;
             default:
                 fprintf(stderr, "Unexpected iso usb result: %d\n",
                         ehci->ipacket.status);
-                /* Fall through */
+                fallthrough;
             case USB_RET_IOERROR:
             case USB_RET_NODEV:
                 /* 3.3.2: XACTERR is only allowed on IN transactions */
                 if (dir) {
                     itd->transact[i] |= ITD_XACT_XACTERR;
                     ehci_raise_irq(ehci, USBSTS_ERRINT);
                 }
                 break;
             case USB_RET_BABBLE:
                 itd->transact[i] |= ITD_XACT_BABBLE;
                 ehci_raise_irq(ehci, USBSTS_ERRINT);
                 break;
             case USB_RET_NAK:
                 /* no data for us, so do a zero-length transfer */
                 ehci->ipacket.actual_length = 0;
                 break;
             }
             if (!dir) {
                 set_field(&itd->transact[i], len - ehci->ipacket.actual_length,
                           ITD_XACT_LENGTH); /* OUT */
             } else {
                 set_field(&itd->transact[i], ehci->ipacket.actual_length,
                           ITD_XACT_LENGTH); /* IN */
             }
             if (itd->transact[i] & ITD_XACT_IOC) {
                 ehci_raise_irq(ehci, USBSTS_INT);
             }
             itd->transact[i] &= ~ITD_XACT_ACTIVE;
         }
     }
     return 0;
 }
 
 
 /*  This state is the entry point for asynchronous schedule
  *  processing.  Entry here constitutes a EHCI start event state (4.8.5)
  */
@@ -2132,54 +2132,55 @@ static void ehci_advance_state(EHCIState *ehci, int async)
 static void ehci_advance_async_state(EHCIState *ehci)
 {
     const int async = 1;
 
     switch(ehci_get_state(ehci, async)) {
     case EST_INACTIVE:
         if (!ehci_async_enabled(ehci)) {
             break;
         }
         ehci_set_state(ehci, async, EST_ACTIVE);
         // No break, fall through to ACTIVE
+        fallthrough;
 
     case EST_ACTIVE:
         if (!ehci_async_enabled(ehci)) {
             ehci_queues_rip_all(ehci, async);
             ehci_set_state(ehci, async, EST_INACTIVE);
             break;
         }
 
         /* make sure guest has acknowledged the doorbell interrupt */
         /* TO-DO: is this really needed? */
         if (ehci->usbsts & USBSTS_IAA) {
             DPRINTF("IAA status bit still set.\n");
             break;
         }
 
         /* check that address register has been set */
         if (ehci->asynclistaddr == 0) {
             break;
         }
 
         ehci_set_state(ehci, async, EST_WAITLISTHEAD);
         ehci_advance_state(ehci, async);
 
         /* If the doorbell is set, the guest wants to make a change to the
          * schedule. The host controller needs to release cached data.
          * (section 4.8.2)
          */
         if (ehci->usbcmd & USBCMD_IAAD) {
             /* Remove all unseen qhs from the async qhs queue */
             ehci_queues_rip_unseen(ehci, async);
             trace_usb_ehci_doorbell_ack();
             ehci->usbcmd &= ~USBCMD_IAAD;
             ehci_raise_irq(ehci, USBSTS_IAA);
         }
         break;
 
     default:
         /* this should only be due to a developer mistake */
         fprintf(stderr, "ehci: Bad asynchronous state %d. "
                 "Resetting to active\n", ehci->astate);
         g_assert_not_reached();
     }
 }
@@ -2187,49 +2188,50 @@ static void ehci_advance_async_state(EHCIState *ehci)
 static void ehci_advance_periodic_state(EHCIState *ehci)
 {
     uint32_t entry;
     uint32_t list;
     const int async = 0;
 
     // 4.6
 
     switch(ehci_get_state(ehci, async)) {
     case EST_INACTIVE:
         if (!(ehci->frindex & 7) && ehci_periodic_enabled(ehci)) {
             ehci_set_state(ehci, async, EST_ACTIVE);
             // No break, fall through to ACTIVE
+            fallthrough;
         } else
             break;
 
     case EST_ACTIVE:
         if (!(ehci->frindex & 7) && !ehci_periodic_enabled(ehci)) {
             ehci_queues_rip_all(ehci, async);
             ehci_set_state(ehci, async, EST_INACTIVE);
             break;
         }
 
         list = ehci->periodiclistbase & 0xfffff000;
         /* check that register has been set */
         if (list == 0) {
             break;
         }
         list |= ((ehci->frindex & 0x1ff8) >> 1);
 
         if (get_dwords(ehci, list, &entry, 1) < 0) {
             break;
         }
 
         DPRINTF("PERIODIC state adv fr=%d.  [%08X] -> %08X\n",
                 ehci->frindex / 8, list, entry);
         ehci_set_fetch_addr(ehci, async,entry);
         ehci_set_state(ehci, async, EST_FETCHENTRY);
         ehci_advance_state(ehci, async);
         ehci_queues_rip_unused(ehci, async);
         break;
 
     default:
         /* this should only be due to a developer mistake */
         fprintf(stderr, "ehci: Bad periodic state %d. "
                 "Resetting to active\n", ehci->pstate);
         g_assert_not_reached();
     }
 }
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4b60114207..3e9b9c62bd 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1438,41 +1438,41 @@ static TRBCCode xhci_set_ep_dequeue(XHCIState *xhci, unsigned int slotid,
 static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
 {
     XHCIState *xhci = xfer->epctx->xhci;
     int i;
 
     xfer->int_req = false;
     qemu_sglist_init(&xfer->sgl, DEVICE(xhci), xfer->trb_count, xhci->as);
     for (i = 0; i < xfer->trb_count; i++) {
         XHCITRB *trb = &xfer->trbs[i];
         dma_addr_t addr;
         unsigned int chunk = 0;
 
         if (trb->control & TRB_TR_IOC) {
             xfer->int_req = true;
         }
 
         switch (TRB_TYPE(*trb)) {
         case TR_DATA:
             if ((!(trb->control & TRB_TR_DIR)) != (!in_xfer)) {
                 DPRINTF("xhci: data direction mismatch for TR_DATA\n");
                 goto err;
             }
-            /* fallthrough */
+            fallthrough;
         case TR_NORMAL:
         case TR_ISOCH:
             addr = xhci_mask64(trb->parameter);
             chunk = trb->status & 0x1ffff;
             if (trb->control & TRB_TR_IDT) {
                 if (chunk > 8 || in_xfer) {
                     DPRINTF("xhci: invalid immediate data TRB\n");
                     goto err;
                 }
                 qemu_sglist_add(&xfer->sgl, trb->addr, chunk);
             } else {
                 qemu_sglist_add(&xfer->sgl, addr, chunk);
             }
             break;
         }
     }
 
     return 0;
@@ -2666,28 +2666,28 @@ static void xhci_port_update(XHCIPort *port, int is_detach)
 static void xhci_port_reset(XHCIPort *port, bool warm_reset)
 {
     trace_usb_xhci_port_reset(port->portnr, warm_reset);
 
     if (!xhci_port_have_device(port)) {
         return;
     }
 
     usb_device_reset(port->uport->dev);
 
     switch (port->uport->dev->speed) {
     case USB_SPEED_SUPER:
         if (warm_reset) {
             port->portsc |= PORTSC_WRC;
         }
-        /* fall through */
+        fallthrough;
     case USB_SPEED_LOW:
     case USB_SPEED_FULL:
     case USB_SPEED_HIGH:
         set_field(&port->portsc, PLS_U0, PORTSC_PLS);
         trace_usb_xhci_port_link(port->portnr, PLS_U0);
         port->portsc |= PORTSC_PED;
         break;
     }
 
     port->portsc &= ~PORTSC_PR;
     xhci_port_notify(port, PORTSC_PRC);
 }
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index c9893df867..2531d583ad 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1790,67 +1790,67 @@ static void usbredir_setup_usb_eps(USBRedirDevice *dev)
 static void usbredir_ep_info(void *priv,
     struct usb_redir_ep_info_header *ep_info)
 {
     USBRedirDevice *dev = priv;
     int i;
 
     assert(dev != NULL);
     for (i = 0; i < MAX_ENDPOINTS; i++) {
         dev->endpoint[i].type = ep_info->type[i];
         dev->endpoint[i].interval = ep_info->interval[i];
         dev->endpoint[i].interface = ep_info->interface[i];
         if (usbredirparser_peer_has_cap(dev->parser,
                                      usb_redir_cap_ep_info_max_packet_size)) {
             dev->endpoint[i].max_packet_size = ep_info->max_packet_size[i];
         }
 #if USBREDIR_VERSION >= 0x000700
         if (usbredirparser_peer_has_cap(dev->parser,
                                         usb_redir_cap_bulk_streams)) {
             dev->endpoint[i].max_streams = ep_info->max_streams[i];
         }
 #endif
         switch (dev->endpoint[i].type) {
         case usb_redir_type_invalid:
             break;
         case usb_redir_type_iso:
             usbredir_mark_speed_incompatible(dev, USB_SPEED_FULL);
             usbredir_mark_speed_incompatible(dev, USB_SPEED_HIGH);
-            /* Fall through */
+            fallthrough;
         case usb_redir_type_interrupt:
             if (!usbredirparser_peer_has_cap(dev->parser,
                                      usb_redir_cap_ep_info_max_packet_size) ||
                     ep_info->max_packet_size[i] > 64) {
                 usbredir_mark_speed_incompatible(dev, USB_SPEED_FULL);
             }
             if (!usbredirparser_peer_has_cap(dev->parser,
                                      usb_redir_cap_ep_info_max_packet_size) ||
                     ep_info->max_packet_size[i] > 1024) {
                 usbredir_mark_speed_incompatible(dev, USB_SPEED_HIGH);
             }
             if (dev->endpoint[i].interval == 0) {
                 ERROR("Received 0 interval for isoc or irq endpoint\n");
                 usbredir_reject_device(dev);
                 return;
             }
-            /* Fall through */
+            fallthrough;
         case usb_redir_type_control:
         case usb_redir_type_bulk:
             DPRINTF("ep: %02X type: %d interface: %d\n", I2EP(i),
                     dev->endpoint[i].type, dev->endpoint[i].interface);
             break;
         default:
             ERROR("Received invalid endpoint type\n");
             usbredir_reject_device(dev);
             return;
         }
     }
     /* The new ep info may have caused a speed incompatibility, recheck */
     if (dev->dev.attached &&
             !(dev->dev.port->speedmask & dev->dev.speedmask)) {
         ERROR("Device no longer matches speed after endpoint info change, "
               "disconnecting!\n");
         usbredir_reject_device(dev);
         return;
     }
     usbredir_setup_usb_eps(dev);
     usbredir_check_bulk_receiving(dev);
 }
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 1dd4071e68..88c736fad2 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -706,48 +706,48 @@ static void tusb_power_tick(void *opaque)
 static void tusb_musb_core_intr(void *opaque, int source, int level)
 {
     TUSBState *s = (TUSBState *) opaque;
     uint16_t otg_status = s->otg_status;
 
     switch (source) {
     case musb_set_vbus:
         if (level)
             otg_status |= TUSB_DEV_OTG_STAT_VBUS_VALID;
         else
             otg_status &= ~TUSB_DEV_OTG_STAT_VBUS_VALID;
 
         /* XXX: only if TUSB_PHY_OTG_CTRL_OTG_VBUS_DET_EN set?  */
         /* XXX: only if TUSB_PRCM_MNGMT_OTG_VBUS_DET_EN set?  */
         if (s->otg_status != otg_status) {
             s->otg_status = otg_status;
             s->intr |= TUSB_INT_SRC_VBUS_SENSE_CHNG;
             tusb_intr_update(s);
         }
         break;
 
     case musb_set_session:
         /* XXX: only if TUSB_PHY_OTG_CTRL_OTG_SESS_END_EN set?  */
         /* XXX: only if TUSB_PRCM_MNGMT_OTG_SESS_END_EN set?  */
         if (level) {
             s->otg_status |= TUSB_DEV_OTG_STAT_SESS_VALID;
             s->otg_status &= ~TUSB_DEV_OTG_STAT_SESS_END;
         } else {
             s->otg_status &= ~TUSB_DEV_OTG_STAT_SESS_VALID;
             s->otg_status |= TUSB_DEV_OTG_STAT_SESS_END;
         }
 
         /* XXX: some IRQ or anything?  */
         break;
 
     case musb_irq_tx:
     case musb_irq_rx:
         s->usbip_intr = musb_core_intr_get(s->musb);
-        /* Fall through.  */
+        fallthrough;
     default:
         if (level)
             s->intr |= 1 << source;
         else
             s->intr &= ~(1 << source);
         tusb_intr_update(s);
         break;
     }
 }
-- 
2.39.2


