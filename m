Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB778E6BE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 08:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbQx-0007PF-7f; Thu, 31 Aug 2023 02:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qbbQu-0007Oz-EU
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qbbQq-0004Hn-II
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693464331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/y5DzxMLTw1D8HRtgegoAmhlZUlasmvCG+PdKWBwVA=;
 b=VKGFLvcmFkBJZHXwX6+lSRqGBs2FTEKRUKsjW4zdQEuSEebUJM3Gj0txlbY8Q8WlhjSrkx
 4ZACc49zPGGiGvEPAipvqLLz+qoyZ+kDtUalFEcInq0CYe/8Aa7OKaxWZsn14HdiP5j4HW
 cUl4GO4Vp2PmaMEfd+4w23yOuBW5FXo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-QM-2_-LSOquIyOM4YUTAbA-1; Thu, 31 Aug 2023 02:45:29 -0400
X-MC-Unique: QM-2_-LSOquIyOM4YUTAbA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso340680a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 23:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693464328; x=1694069128;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O/y5DzxMLTw1D8HRtgegoAmhlZUlasmvCG+PdKWBwVA=;
 b=LZOjTuhfqQR99Y7SjYswUcufrzlmnmpW5xFYIHcktG8QS0pCZA+c3GajjYew/c/xJP
 lSuXGJumHdYy/CkPzgE17NpaPOChgs4irE0VeSqj7L4n2JgecP4O4StxW4gtKDlM/h4C
 83+JIccDkR/xd70Adnkj48Odoi6bKMSnHQ4G3wKN4F0RBqhfgsMMrMHaxKmzgiaKL5oN
 2SdFfPvMzVPjIzgCCuqhFzVQul2s0ghFleuPx6taT/ZWpj+vmSVLyk9j926qZlu8g3kO
 EdaWd2cgei2jhtawBieKFRiYkXg7KTMUSVK4RknXvtSVLHV+bGzSeR/vgOJqrtXfoIXV
 19dw==
X-Gm-Message-State: AOJu0Yx1UNc0tlc0HR4KRWCTVHnTwYNsIRJ94QP5HJ/W6NHJoeCIWXta
 clkFZ606nO4o864LTCu7IATdM7v63SoRvdzj9wJPGBGicEeJCWrw+LVxKxnpuUkSe3tTh0asxiA
 Sb0CF4Na+WI4amM0=
X-Received: by 2002:a05:6402:3442:b0:523:c19d:a521 with SMTP id
 l2-20020a056402344200b00523c19da521mr2936303edc.40.1693464328580; 
 Wed, 30 Aug 2023 23:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmk5w0DRODFUFQ+G7BgF8xBdCo/TKoDfuRcn6UwTERZ4uXb+dh9Ec+gdKNlK00IttzsCz6oQ==
X-Received: by 2002:a05:6402:3442:b0:523:c19d:a521 with SMTP id
 l2-20020a056402344200b00523c19da521mr2936288edc.40.1693464328225; 
 Wed, 30 Aug 2023 23:45:28 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 bo9-20020a0564020b2900b0052889d090bfsm420011edb.79.2023.08.30.23.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 23:45:27 -0700 (PDT)
Date: Thu, 31 Aug 2023 02:45:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH] pci: SLT must be RO
Message-ID: <20230831024011-mutt-send-email-mst@kernel.org>
References: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
 <084d2e90-86d4-eabc-3270-d3ef680c9631@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <084d2e90-86d4-eabc-3270-d3ef680c9631@linaro.org>
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

On Thu, Aug 31, 2023 at 08:22:34AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> On 30/8/23 23:48, Michael S. Tsirkin wrote:
> > current code sets PCI_SEC_LATENCY_TIMER to WO, but for
> > pcie to pcie bridges it must be RO 0 according to
> > pci express spec which says:
> >      This register does not apply to PCI Express. It must be read-only
> >      and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges, refer to the
> >      [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
> > 
> > also, fix typo in comment where it's make writeable - this typo
> > is likely what prevented us noticing we violate this requirement
> > in the 1st place.
> > 
> > Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Marcin, could you pls test this patch with virt-8.1 and latest?
> > Thanks a lot!
> > 
> > 
> >   include/hw/pci/pci_bridge.h |  3 +++
> >   hw/core/machine.c           |  5 ++++-
> >   hw/pci/pci.c                |  2 +-
> >   hw/pci/pci_bridge.c         | 14 ++++++++++++++
> >   4 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> > index ea54a81a15..5cd452115a 100644
> > --- a/include/hw/pci/pci_bridge.h
> > +++ b/include/hw/pci/pci_bridge.h
> > @@ -77,6 +77,9 @@ struct PCIBridge {
> >       pci_map_irq_fn map_irq;
> >       const char *bus_name;
> > +
> > +    /* SLT is RO for PCIE to PCIE bridges, but old QEMU versions had it RW */
> > +    bool pcie_writeable_slt_bug;
> >   };
> 
> Patch LGTM, so:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> > -GlobalProperty hw_compat_8_1[] = {};
> > +GlobalProperty hw_compat_8_1[] = {
> > +    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> 
> However I don't understand why we can't clear the config register and
> must use a compat flag, since per the spec it is hardwired to 0.

Because historically we didn't. If we make it RO and migrate from
VM where guest wrote into this register, migration will fail
as we check that RO fields are unchanged.
Another trick would be to pretend it's hardware driven
and set cmask. Compat machinery is more straight-forward though.

> Do we need the "x-" compat prefix? This is not an experimental property.

It's an internal one, we don't want users to tweak it.

> > +};
> >   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> 
> 
> > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> > index e7b9345615..6a4e38856d 100644
> > --- a/hw/pci/pci_bridge.c
> > +++ b/hw/pci/pci_bridge.c
> > @@ -38,6 +38,7 @@
> >   #include "qapi/error.h"
> >   #include "hw/acpi/acpi_aml_interface.h"
> >   #include "hw/acpi/pci.h"
> > +#include "hw/qdev-properties.h"
> >   /* PCI bridge subsystem vendor ID helper functions */
> >   #define PCI_SSVID_SIZEOF        8
> > @@ -385,6 +386,11 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
> >       pci_bridge_region_init(br);
> >       QLIST_INIT(&sec_bus->child);
> >       QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
> > +
> > +    /* For express secondary buses, secondary latency timer is RO 0 */
> > +    if (pci_bus_is_express(sec_bus) && !br->pcie_writeable_slt_bug) {
> > +        dev->wmask[PCI_SEC_LATENCY_TIMER] = 0;
> > +    }
> >   }
> 
> 


