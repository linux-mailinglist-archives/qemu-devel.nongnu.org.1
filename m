Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 922027C80C0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:51:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDq9-0007et-1w; Fri, 13 Oct 2023 04:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpb-0007RA-BX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpZ-0000oG-43
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso1680524f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186855; x=1697791655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rEO8xhabBa8+qN/AA3htMa/EbaT4NYRpi2EeykzU0A=;
 b=EfdjYYMvuzLlpMXWZFWJI/6WwEiWto8G6EIE+ofVI8NX2G+HVl7nP3I6HdVAr6GlFc
 5MdMfD2cblJdCSnJvl1/3dNxkfDt5kZcXagWAJTiZVGcpkXUnukcPEfcD8SEYK/BTzBA
 Cvsx4Kx6aJOpkQ82ho+3DKGB/HGDwsnI/18I1SpcoV5dZ5DpX+aXc9UxHLqaEnLYxRd9
 krNBlfS8KCZwl8wCFpdYQPrRp8O6VgYkIBKu6Y9F22jI22b6AlLtfwuzVQXaLH++MDNa
 o/kjDaxnsTC+QN33IrBDC2IZPB27jo2vghO9GPYdWeDHiAwRNnTtudeEZowXiYXAbWVS
 ji0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186855; x=1697791655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rEO8xhabBa8+qN/AA3htMa/EbaT4NYRpi2EeykzU0A=;
 b=hV0uFWKuHH3SG+zam+rqQvF1sfvxVFvbGdpqS7JXoZh60LNFty7mc4gdXfOtv9zUi4
 ZESjkQaSB3DR6Ykm5e3WC2qhwi84AeGVwIU1dVOYcavfcb+ab+6E1TJV8O0m/KH846Co
 OELPDB0Kro1VhXw+4Jvbcb3Qwwo00k/RL8/H911L1YhVBLBhqKeWDVDaFcDnSLNfWV5Q
 Zd0TGqlQpawrC1DyKVJVpgUYjro7XQ3ezvK4AnAMssLOj9yaPAnMXmWNrRbnS2tSyRBQ
 WX/+cY+xY8GfhUB/lWPGrVBO0XHDwFybK75FRwSQAbwPAxU1NQtjSxmw7o0+Xx/ldFKx
 yE8A==
X-Gm-Message-State: AOJu0YwfQBj1UHEhbCJh/Uct/CaA6zHOoyvFGZjWwVTijx3Nr48T8IKW
 32I7ftFM236vxxsk3d8i28HZEWA1yrC0xMliC0M=
X-Google-Smtp-Source: AGHT+IEDQSwhe6yfPltI9w8sc2zzs4ry6ouEcRIkZONEZjZspWMLaLXrbanB4lUSoPjJ0nN0YUoxYQ==
X-Received: by 2002:a5d:6483:0:b0:32d:8830:edb with SMTP id
 o3-20020a5d6483000000b0032d88300edbmr6935441wri.38.1697186855101; 
 Fri, 13 Oct 2023 01:47:35 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:34 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH v3 12/78] hw/usb: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:40 +0300
Message-Id: <8a8bc7d7ac048e5caaa31b5020f63056c9490325.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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
@@ -1648,7 +1648,7 @@ static void usb_mtp_write_data(MTPState *s, uint32_t handle)
                 d->write_status = WRITE_END;
             }
         }
-        /* fall through */
+        fallthrough;
     case WRITE_CONTINUE:
     case WRITE_END:
         rc = write_retry(d->fd, d->data, d->data_offset,
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 7177c17f03..bd2a1bae50 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -389,7 +389,7 @@ static void usb_wacom_handle_data(USBDevice *dev, USBPacket *p)
             usb_packet_copy(p, buf, len);
             break;
         }
-        /* Fall through.  */
+        fallthrough;
     case USB_TOKEN_OUT:
     default:
         p->status = USB_RET_STALL;
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 19b4534c20..e29cc21957 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1477,7 +1477,7 @@ static int ehci_process_itd(EHCIState *ehci,
             default:
                 fprintf(stderr, "Unexpected iso usb result: %d\n",
                         ehci->ipacket.status);
-                /* Fall through */
+                fallthrough;
             case USB_RET_IOERROR:
             case USB_RET_NODEV:
                 /* 3.3.2: XACTERR is only allowed on IN transactions */
@@ -2140,6 +2140,7 @@ static void ehci_advance_async_state(EHCIState *ehci)
         }
         ehci_set_state(ehci, async, EST_ACTIVE);
         // No break, fall through to ACTIVE
+        fallthrough;
 
     case EST_ACTIVE:
         if (!ehci_async_enabled(ehci)) {
@@ -2197,6 +2198,7 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
         if (!(ehci->frindex & 7) && ehci_periodic_enabled(ehci)) {
             ehci_set_state(ehci, async, EST_ACTIVE);
             // No break, fall through to ACTIVE
+            fallthrough;
         } else
             break;
 
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4b60114207..3e9b9c62bd 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1457,7 +1457,7 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
                 DPRINTF("xhci: data direction mismatch for TR_DATA\n");
                 goto err;
             }
-            /* fallthrough */
+            fallthrough;
         case TR_NORMAL:
         case TR_ISOCH:
             addr = xhci_mask64(trb->parameter);
@@ -2678,7 +2678,7 @@ static void xhci_port_reset(XHCIPort *port, bool warm_reset)
         if (warm_reset) {
             port->portsc |= PORTSC_WRC;
         }
-        /* fall through */
+        fallthrough;
     case USB_SPEED_LOW:
     case USB_SPEED_FULL:
     case USB_SPEED_HIGH:
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index c9893df867..2531d583ad 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1814,7 +1814,7 @@ static void usbredir_ep_info(void *priv,
         case usb_redir_type_iso:
             usbredir_mark_speed_incompatible(dev, USB_SPEED_FULL);
             usbredir_mark_speed_incompatible(dev, USB_SPEED_HIGH);
-            /* Fall through */
+            fallthrough;
         case usb_redir_type_interrupt:
             if (!usbredirparser_peer_has_cap(dev->parser,
                                      usb_redir_cap_ep_info_max_packet_size) ||
@@ -1831,7 +1831,7 @@ static void usbredir_ep_info(void *priv,
                 usbredir_reject_device(dev);
                 return;
             }
-            /* Fall through */
+            fallthrough;
         case usb_redir_type_control:
         case usb_redir_type_bulk:
             DPRINTF("ep: %02X type: %d interface: %d\n", I2EP(i),
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 1dd4071e68..88c736fad2 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -741,7 +741,7 @@ static void tusb_musb_core_intr(void *opaque, int source, int level)
     case musb_irq_tx:
     case musb_irq_rx:
         s->usbip_intr = musb_core_intr_get(s->musb);
-        /* Fall through.  */
+        fallthrough;
     default:
         if (level)
             s->intr |= 1 << source;
-- 
2.39.2


