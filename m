Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C67D0757
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 06:25:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qth40-0005YT-Iz; Fri, 20 Oct 2023 00:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qth3w-0005YF-2A
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 00:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qth3u-0000yz-EZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 00:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697775876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqpqqQHd2YL7QQpnpIFWxO6GYkKvGDCt83ykkZcRJ3M=;
 b=Re67gMGEFlqlN32TG6sfwgR9GACcH6LZ/01bE2Gt+pT/de94rvajQ8gsXcOU5DycTibfF2
 dRU3Qxy53URnB6QVa0pxuRqiLForQ5JOvrBqhg/eTHscnJioxrACnSp6/MqKcYIKD7tUST
 VFLCj1NWcqYM32+/90VGVGWdlgZECjs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-O63OmtdJMnuxzp483vFkhg-1; Fri, 20 Oct 2023 00:24:35 -0400
X-MC-Unique: O63OmtdJMnuxzp483vFkhg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d03b02d16so24738276d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 21:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697775874; x=1698380674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqpqqQHd2YL7QQpnpIFWxO6GYkKvGDCt83ykkZcRJ3M=;
 b=UJxLwDi43vCvNsF9j4tYauduBi11I8Oicf8RlTuxqurXyRl9QMyYWTnOUYKzMDWfYc
 J+vAB1LV/zPzcoGHC4UuUNQbaVd4DidCl/Efuh1Ooa0+Ref3ZtsS3TzmvYZMQk6ACVrO
 e5WPdjbTdPeg2WdYGeOg34FzYJjbBxgQ1EwuG3fS8/EcsBJ0FFtckcObXS1QAzMUea/F
 s5tQJO2TE7DQ1A3yGoaxorunZLZyL46ddtsuTGcFwSxxPZWgYEoBhb5gWAaJOCnbAhny
 S4ATyg0ZE1gL5c6Y8+Q0t396vaGIVtSN4hmjeOyoOVRPL2WWA4YITor9D1H3Jn5Tupp4
 lTnw==
X-Gm-Message-State: AOJu0YzFPrm1+pnXF/eCnD5iJ7iSKUSgeiGhmef71a2Fis4h4W+b/5ju
 CqlHAqZopGUhq9D259r+CxgEOnzXDPBjmN4c2P0SDhaKpXJ9WFyJNRlg3J0YLcXOjuh1/jtcb3b
 rxRgklfshp9RpCFVOoCw2epfdd9frv1o=
X-Received: by 2002:a05:6214:3bc8:b0:66d:2d80:800 with SMTP id
 ng8-20020a0562143bc800b0066d2d800800mr6354714qvb.7.1697775874631; 
 Thu, 19 Oct 2023 21:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2RJ/QsiPB+TkhlGX0b1uN92L8tBZBO3r3DJwmNN2melfP6fO4+v5/9aLP1eJo4deyEKuV7tDtEGG3BcG5DGg=
X-Received: by 2002:a05:6214:3bc8:b0:66d:2d80:800 with SMTP id
 ng8-20020a0562143bc800b0066d2d800800mr6354705qvb.7.1697775874386; Thu, 19 Oct
 2023 21:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-3-clg@kaod.org>
In-Reply-To: <20230829090529.184438-3-clg@kaod.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 12:24:22 +0800
Message-ID: <CACGkMEu6nznVGTyk8gjrZ3jE=bEAd2bDDi9PPwjDKNFkXnVhSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Tue, Aug 29, 2023 at 5:06=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> From: C=C3=A9dric Le Goater <clg@redhat.com>
>
> The Intel 82576EB GbE Controller say that the Physical and Virtual
> Functions support Function Level Reset. Add the capability to each
> device model.
>

Do we need to do migration compatibility for this?

Thanks

> Cc:  Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/net/igb.c   | 3 +++
>  hw/net/igbvf.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index e70a66ee038e..b8c170ad9b1a 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t=
 addr,
>
>      trace_igb_write_config(addr, val, len);
>      pci_default_write_config(dev, addr, val, len);
> +    pcie_cap_flr_write_config(dev, addr, val, len);
>
>      if (range_covers_byte(addr, len, PCI_COMMAND) &&
>          (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> @@ -433,6 +434,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error=
 **errp)
>      }
>
>      /* PCIe extended capabilities (in order) */
> +    pcie_cap_flr_init(pci_dev);
> +
>      if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>          hw_error("Failed to initialize AER capability");
>      }
> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> index 07343fa14a89..55e321e4ec20 100644
> --- a/hw/net/igbvf.c
> +++ b/hw/net/igbvf.c
> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev, uint32=
_t addr, uint32_t val,
>  {
>      trace_igbvf_write_config(addr, val, len);
>      pci_default_write_config(dev, addr, val, len);
> +    pcie_cap_flr_write_config(dev, addr, val, len);
>  }
>
>  static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size=
)
> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error *=
*errp)
>          hw_error("Failed to initialize PCIe capability");
>      }
>
> +    pcie_cap_flr_init(dev);
> +
>      if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>          hw_error("Failed to initialize AER capability");
>      }
> --
> 2.41.0
>
>


