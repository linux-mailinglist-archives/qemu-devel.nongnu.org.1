Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B89177369A5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYq1-0003Cv-83; Tue, 20 Jun 2023 06:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBYps-0003CY-7r
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBYpq-0005Ss-B3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687257820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0T6+3y4CApZfYEfM2nonydkBM1a3ObbCCbxLFWRNnqs=;
 b=VJ/p6Tt8Pg28GkQHKMX35+saD39gjXnT0S+1Mc+jA4E/dYmIQhWoLaSG2Q40/v8r8VYglE
 vLoDfy4M35oHIdRqq4aiIlSzZ7zxJISEE1XLKesOha4mTKs9Iali9suuofKMblyvCUBI59
 Gs5b3L5N9AFLOYE2ZXk/hHvPlbhee24=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-1BE6S0LoPgaxwYniR68jog-1; Tue, 20 Jun 2023 06:43:39 -0400
X-MC-Unique: 1BE6S0LoPgaxwYniR68jog-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso17924965e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257816; x=1689849816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0T6+3y4CApZfYEfM2nonydkBM1a3ObbCCbxLFWRNnqs=;
 b=DKVQYMQ5DePbAr60xZEQZY8JjNHyO1evSvfPiy0uZuYX7mAfSG2F5S3q8kTfwBONAV
 gRd+wYn9cGpPysa1ez93ZR8BVJP3R4Bguw2hPeQoQ66H/bzS9/8UwctgXZsArV93W3pu
 P7oI0TP2/AjTMBEomxRY6dP5AdJSN7XwRAPSjKCygIzyEWsJWi2gwrc2d9HTRHID5EKw
 o6OQdNBUA6/f7yi4aEDMa0kHU3FT08efjlAJL2pP3/Kunj6paaLAUCy3L9nlbFZ/5WZe
 0eRGi6nHhj6UoqWkKdXvHjPlIvZfYFl9RlsvbQmMy6AIdZwOQpFF+cwq5+A2KkcMyvHi
 /R8A==
X-Gm-Message-State: AC+VfDzkidef4ksscnouJnAoGidz1A67am/sLPfEytObBd6MJPXfDx7u
 gnN2QlAtU93JG1Lv+Zteak1GIVEPBRhANKCJuV6jfDGIB4lVwqKzCPmjBNPcd8/jAYPZLqHrDrG
 AWQRJm929G2fDhP4=
X-Received: by 2002:a1c:f310:0:b0:3f8:f382:8e1f with SMTP id
 q16-20020a1cf310000000b003f8f3828e1fmr7893270wmq.24.1687257816548; 
 Tue, 20 Jun 2023 03:43:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gdJdFbfMF5q3rLyqwG0I9jtYK28BM8XHKdxxeGCNICrBzQS0HJLhrV5vtmp6sDLwybBATEQ==
X-Received: by 2002:a1c:f310:0:b0:3f8:f382:8e1f with SMTP id
 q16-20020a1cf310000000b003f8f3828e1fmr7893260wmq.24.1687257816254; 
 Tue, 20 Jun 2023 03:43:36 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 p21-20020a7bcc95000000b003f739a8bcc8sm2021066wma.19.2023.06.20.03.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 03:43:35 -0700 (PDT)
Date: Tue, 20 Jun 2023 06:43:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
Message-ID: <20230620062307-mutt-send-email-mst@kernel.org>
References: <20230620071805.4400-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620071805.4400-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 20, 2023 at 12:48:05PM +0530, Ani Sinha wrote:
> When a device has an upstream PCIE port, we can only use slot 0.

Actually, it's when device is plugged into a PCIE port.
So maybe:

	PCI Express ports only have one slot, so
	PCI Express devices can only be plugged into
	slot 0 on a PCIE port

> Non-zero slots
> are invalid. This change ensures that we throw an error if the user
> tries to hotplug a device with an upstream PCIE port to a non-zero slot.

it also adds a comment explaining why function 0 must not exist
when function != 0 is added. or maybe split that part out.

> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> changelog:
> v2: addressed issue with multifunction pcie root ports. Should allow
> hotplug on functions other than function 0.
> v3: improved commit message.
> v4: improve commit message and code comments further. Some more
> improvements might come in v5. No claims made here that this is
> the final one :-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..30ce6a78cb 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -64,6 +64,7 @@ bool pci_available = true;
>  static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>  
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -1182,6 +1183,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      } else if (dev->hotplugged &&
>                 !pci_is_vf(pci_dev) &&
>                 pci_get_function_0(pci_dev)) {
> +        /*
> +         * populating function 0 triggers a bus scan from the guest that
> +         * exposes other non-zero functions. Hence we need to ensure that
> +         * function 0 wasn't added yet.
> +         */

Pls capitalize populating. Also, comments like this should come
before the logic they document, not after. By the way it doesn't
have to be a bus scan - I'd just say "a scan" - with ACPI
guest knows what was added and can just probe the device functions.

>          error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
>                     " new func %s cannot be exposed to guest.",
>                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> @@ -1189,6 +1195,18 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     name);
>  
>         return NULL;
> +    } else if (dev->hotplugged &&

why hotplugged? Doesn't the same rule apply to all devices?

> +               !pci_is_vf(pci_dev) &&

Hmm. I think you copied it from here:
    } else if (dev->hotplugged &&
               !pci_is_vf(pci_dev) &&
               pci_get_function_0(pci_dev)) {

it makes sense there because VFs are added later
after PF exists.

But here it makes no sense that I can see.


> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> +        /*
> +         * If the device has an upstream PCIE port, like a pcie root port,

no, a root port can not be an upstream port.


> +         * we only support functions on slot 0.
> +         */
> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> +                   " only functions on slot 0 is supported for devices"
> +                   " with an upstream PCIE port.",


something like:

        error_setg(errp, "PCI: slot %d is not valid for %s:"
                   " PCI Express devices can only be plugged into slot 0")

and then you don't really need a comment.


> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>      }
>  
>      pci_dev->devfn = devfn;
> -- 
> 2.39.1


