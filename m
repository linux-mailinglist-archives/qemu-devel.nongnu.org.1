Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE36705B9F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 02:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4eB-0000Oy-NT; Tue, 16 May 2023 20:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pz4e9-0000Oq-8P
 for qemu-devel@nongnu.org; Tue, 16 May 2023 20:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pz4e7-0000yI-0R
 for qemu-devel@nongnu.org; Tue, 16 May 2023 20:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684281836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SzH+xCTJ6pHvcYyFQQP+0HMvAqvCA/oZtJJIm79BM0U=;
 b=gwJdleDfqMdNG937rRMAfh3Mhma0UvyUScqC9AMI1txNWNqA7Hhy58eZcJwjKC2jR+R4KH
 Ul9e5nzWXIkj4nnML8MQGUQPH62xyYNKu7d3w3kUDt+tvXIpJzfAW+D1zXmXcefpbv2gQo
 P22VKJGvRgrbNFh+tOwX3tapyOUQeyU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-wEMKOfkkO-eZbgsKhNO-Dw-1; Tue, 16 May 2023 20:03:55 -0400
X-MC-Unique: wEMKOfkkO-eZbgsKhNO-Dw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f384644b08so383611cf.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 17:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684281834; x=1686873834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzH+xCTJ6pHvcYyFQQP+0HMvAqvCA/oZtJJIm79BM0U=;
 b=l04nndyb3QlYikiQeHQ7cKEi9pzxtI6ngeqDOARHxlaH2Nbc5JJYhSBaCQx/m2EX7w
 s8/V+AQADUf6OVj9+CBvzuchd4OwDQGg8XvaU0MghXeIudQZ0+zM9K+/kuXMVf3m0mSO
 Fwdrbwhsg4CVTrXxjHgzlWPL/jmFa/Pyj5c6vbRUuA6xqkpe282FSVE+TjrwQLOJcgPT
 JsYeIA8xJBenVToK82a44hGp/6HlwKnGlrqdcBjGuXASUyu/bXDDAYCDbUIHZG/p9aEL
 7+ycyDLKofbwk/9xSEO2RpVO9fBhaByPdF2gjEtOickH/6bSLTW/BYjL6V12v87DFPZb
 a/QQ==
X-Gm-Message-State: AC+VfDwVi645MyVJHJGnTSFo+DRfhn3SC70IoP1NfRP3yUclWqK8hL3O
 X74a/ZNSNp7c0QZ/PswRxFFdQBcXH9mINgQWrZkniev1cxHiFjEkew54bVCPylh7/iuxmo5nDbA
 kTH3Z4nnTAZPhBIk=
X-Received: by 2002:a05:622a:15d3:b0:3f5:881:6f9b with SMTP id
 d19-20020a05622a15d300b003f508816f9bmr2533944qty.4.1684281834531; 
 Tue, 16 May 2023 17:03:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZJNMj+vYJQph/HfklWHBIEUuxV+PrvJ5QaO1on/bQ3ezDI2RJsW4R6iPbJMLulYwaz2J6mQ==
X-Received: by 2002:a05:622a:15d3:b0:3f5:881:6f9b with SMTP id
 d19-20020a05622a15d300b003f508816f9bmr2533916qty.4.1684281834172; 
 Tue, 16 May 2023 17:03:54 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 j4-20020ac84c84000000b003e3860f12f7sm6639630qtv.56.2023.05.16.17.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 17:03:53 -0700 (PDT)
Date: Tue, 16 May 2023 20:03:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 3/3] migration/doc: We broke backwards compatibility
Message-ID: <ZGQZ6A+hQx0+6vBo@x1n>
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515083201.55060-4-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, May 15, 2023 at 10:32:01AM +0200, Juan Quintela wrote:
> When we detect that we have broken backwards compantibility in a
> released version, we can't do anything for that version.  But once we
> fix that bug on the next released version, we can "mitigate" that
> problem when migrating to new versions to give a way out of that
> machine until it does a hard reboot.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  docs/devel/migration.rst | 194 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
> 
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index 95e797ee60..97b6f48474 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -451,6 +451,200 @@ binary in both sides of the migration.  If we use different QEMU
>  versions process, then we need to have into account all other
>  differences and the examples become even more complicated.
>  
> +How to mitigate when we have a backward compatibility error
> +-----------------------------------------------------------
> +
> +We broke migration for old machine types continously during

continuously

> +development.  But as soon as we find that there is a problem, we fix
> +it.  The problem is what happens when we detect after we have done a
> +release that something has gone wrong.
> +
> +Let see how it worked with one example.
> +
> +After the release of qemu-8.0 we found a problem when doing migration
> +of the machine type pc-7.2.
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +
> +  This migration works
> +
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +
> +  This migration works
> +
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +
> +  This migration fails
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +
> +  This migration fails
> +
> +So clearly something fails when migration between qemu-7.2 and
> +qemu-8.0 with machine type pc-7.2.  The error messages, and git bisect
> +pointed to this commit.
> +
> +In qemu-8.0 we got this commit: ::
> +
> +    commit 9a6ef182c03eaa138bae553f0fbb5a123bef9a53
> +    Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> +    Date:   Thu Mar 2 13:37:03 2023 +0000
> +
> +        hw/pci/aer: Add missing routing for AER errors

Worst timing ever for him.. :(

The lesson is never break migration when the maintainer has any intention
to add some docs explaining backward compatibility.

> +
> +The relevant bits of the commit for our example are this ones:
> +
> +    --- a/hw/pci/pcie_aer.c
> +    +++ b/hw/pci/pcie_aer.c
> +    @@ -112,6 +112,10 @@ int pcie_aer_init(PCIDevice *dev,
> +
> +         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
> +                      PCI_ERR_UNC_SUPPORTED);
> +    +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
> +    +                 PCI_ERR_UNC_MASK_DEFAULT);
> +    +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
> +    +                 PCI_ERR_UNC_SUPPORTED);
> +
> +         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
> +                     PCI_ERR_UNC_SEVERITY_DEFAULT);
> +
> +The patch changes how we configure pci space for AER.  But qemu fails
> +when the pci space configuration is different betwwen source and
> +destination.
> +
> +The following commit show how this got fixed:
> +
> +<put info of the commit once that it arrives upstream>
> +
> +The relevant parts of the fix are as follow:
> +
> +First, we create a new property for the device to be able to configure
> +the old behaviour or the new behaviour. ::
> +
> +    diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> +    index 8a87ccc8b0..5153ad63d6 100644
> +    --- a/hw/pci/pci.c
> +    +++ b/hw/pci/pci.c
> +    @@ -79,6 +79,8 @@ static Property pci_props[] = {
> +         DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
> +                            failover_pair_id),
> +         DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
> +    +    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
> +    +                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> +         DEFINE_PROP_END_OF_LIST()
> +     };
> +
> +Notice that we enable te feature for new machine types.

the

> +
> +Now we see how the fix is done.  This is going to depend on what kind
> +of breakage happens, but in this case it is quite simple. ::
> +
> +    diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> +    index 103667c368..374d593ead 100644
> +    --- a/hw/pci/pcie_aer.c
> +    +++ b/hw/pci/pcie_aer.c
> +    @@ -112,10 +112,13 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver,
> +    uint16_t offset,
> +
> +         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
> +                      PCI_ERR_UNC_SUPPORTED);
> +    -    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
> +    -                 PCI_ERR_UNC_MASK_DEFAULT);
> +    -    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
> +    -                 PCI_ERR_UNC_SUPPORTED);
> +    +
> +    +    if (dev->cap_present & QEMU_PCIE_ERR_UNC_MASK) {
> +    +        pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
> +    +                     PCI_ERR_UNC_MASK_DEFAULT);
> +    +        pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
> +    +                     PCI_ERR_UNC_SUPPORTED);
> +    +    }
> +
> +         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
> +                      PCI_ERR_UNC_SEVERITY_DEFAULT);
> +
> +I.e. If the property bit is enabled, we configure it as we did for
> +qemu-8.0.  If the property bit is not set, we configure it as it was in 7.2.
> +
> +And now, everything that is missing is disable the feature for old

disabling

> +machine types: ::
> +
> +    diff --git a/hw/core/machine.c b/hw/core/machine.c
> +    index 47a34841a5..07f763eb2e 100644
> +    --- a/hw/core/machine.c
> +    +++ b/hw/core/machine.c
> +    @@ -48,6 +48,7 @@ GlobalProperty hw_compat_7_2[] = {
> +         { "e1000e", "migrate-timadj", "off" },
> +         { "virtio-mem", "x-early-migration", "false" },
> +         { "migration", "x-preempt-pre-7-2", "true" },
> +    +    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
> +     };
> +     const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
> +
> +And now, when qemu-8.0.1 is released with this fix, all combinations
> +are going to work as supposed.
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2 (works)
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2 (works)
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2 (works)
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2 (works)
> +
> +So the normality has been restaured and everything is ok, no?
> +
> +Not really, now our matrix is much bigger.  We started with the easy
> +cases, migration from the same version to the same version always
> +works:
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +
> +Now the interesting ones.  When the QEMU processes versions are
> +different.  For the 1st set, their fail and we can do nothing, both
> +versions are relased and we can't change anything.
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +
> +This two are the ones that work. The whole point of making the
> +change in qemu-8.0.1 release was to fix this issue:
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +
> +But now we found that qemu-8.0 neither can migrate to qemu-7.2 not
> +qemu-8.0.1.
> +
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +
> +So, if we start a pc-7.2 machine in qemu-8.0 we can't migrate it to
> +anything except to qemu-8.0.
> +
> +Can we do better?
> +
> +Yeap.  If we know that we are gonig to do this migration:

IIUC the other thing one should do is always keep their QEMU binaries
uptodate.  E.g., anyone seriously using 8.0 released QEMU should always
consider to do timely upgrade to e.g. 8.0.1 so this issue can also be
avoided (by dropping 8.0 directly).

> +
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +
> +We can launche the appropiate devices with

launch

> +
> +--device...,x-pci-e-err-unc-mask=on
> +
> +And now we can receive a migration from 8.0.  And from now on, we can
> +do that migration to new machine types if we remember to enable that
> +property for pc-7.2.  Notice that we need to remember, it is not
> +enough to know that the source of the migration is qemu-8.0.  Think of this example:

(wrap)

> +
> +$ qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 -> qemu-8.2 -M pc-7.2
> +
> +In the second migration, the source is not qemu-8.0, but we still have
> +that "problem" and have that property enabled.  Notice that we need to
> +continue having this mark/property until we have this machine
> +rebooted.  But it is not a normal reboot (that don't reload qemu) we
> +need the mapchine to poweroff/poweron on a fixed qemu.  And from now
> +on we can use the proper real machine.
> +

The 8.0.1 breaking migration to 8.0 is a very important point to mention
indeed.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


