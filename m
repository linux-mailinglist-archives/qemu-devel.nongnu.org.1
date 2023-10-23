Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C47D3193
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qusoJ-0006JW-4z; Mon, 23 Oct 2023 07:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qusoB-0006JB-6i
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1quso8-0007vY-TI
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698059356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Khk4DuZiRt8SK4I+Gl6pGas0MeNdo3pxc8sYNsoRZoM=;
 b=LuZYvUz83TTMQrK269za5Ju/XWxWUE5dsKyvhgZTTrOeRK8geByCsrHlYjWFZdOU7FmFjN
 /LKTdWgV8D79yezpO7WN26o6Pq/nbr1fknk6b8DBKeCwbF8MXxaSgGjEv1ReADHuJsLG9K
 eMuu++v8O0SuqTjsy8gywcd0ZUPwt10=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-4Tswi1WnOkapa0AEcfG9-A-1; Mon, 23 Oct 2023 07:09:09 -0400
X-MC-Unique: 4Tswi1WnOkapa0AEcfG9-A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c503af866dso31635281fa.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698059348; x=1698664148;
 h=mime-version:date:reply-to:user-agent:references:message-id
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Khk4DuZiRt8SK4I+Gl6pGas0MeNdo3pxc8sYNsoRZoM=;
 b=pX696nEld72MuJqdblMelQSIu4uR8wSFqCWcb9YiFG4THzKwLbnoiYm+y2/8dWRmr+
 /FXcHCE9RVi8x0sBSrnAA/lAUd5hSxa/cntVu0gZsSoxsFppId7QKMjHqCEKpoS/bPEk
 lUUxEM49pJ+VMfpkzhMLDJrUkv7Zt378gETCEthtSQg3wVWOPiGi3W7XXAdcKL8m0MWA
 r26AJ6o0JuLdH2IU5aqUJ4RXwCfvYpMmkLxn6kTDRAavEInE4BaXwjdWYjR4ea9Nq/OB
 CPFSfZ7qNrWr7ZH8ot5KD3TuRZHOdNMxE1mKEbPodAKvzqHud+OpYuXjYFiX0qNCC/u7
 xA3g==
X-Gm-Message-State: AOJu0Yx9EmugJGMRaW0gHrJ/FZw7jnxUsHtI/PdOQ2zGbha1T7XFrnaO
 xnxAt6mS2uk5IkBMpXc8wEGuZTiZWg1GP9CV0l05a+c6X12FFddRfU3vdIuSOOp/oO6NMqwKcux
 HtvXZNInfQ3z8K04=
X-Received: by 2002:a2e:80ca:0:b0:2c5:1542:57e9 with SMTP id
 r10-20020a2e80ca000000b002c5154257e9mr6050357ljg.41.1698059348063; 
 Mon, 23 Oct 2023 04:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEljllzXg38IwNX4a9sDuUHsNViIB6plPhbRr1BM0SIY/JuTpeAeJoBWk1K/d1ntgn1GVo+DQ==
X-Received: by 2002:a2e:80ca:0:b0:2c5:1542:57e9 with SMTP id
 r10-20020a2e80ca000000b002c5154257e9mr6050343ljg.41.1698059347679; 
 Mon, 23 Oct 2023 04:09:07 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b003fefb94ccc9sm9205168wms.11.2023.10.23.04.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:09:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Jiri
 Denemark <jdenemar@redhat.com>,  Avihai Horon <avihaih@nvidia.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 3/3] migration/doc: We broke backwards compatibility
In-Reply-To: <42862ba2-4c46-f8a7-66fb-1d56104d64af@proxmox.com> (Fiona Ebner's
 message of "Wed, 17 May 2023 09:09:43 +0200")
Message-ID: <87pm1dz5lw.fsf@secure.mitica>
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-4-quintela@redhat.com>
 <42862ba2-4c46-f8a7-66fb-1d56104d64af@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 23 Oct 2023 13:09:06 +0200
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fiona Ebner <f.ebner@proxmox.com> wrote:
> Am 15.05.23 um 10:32 schrieb Juan Quintela:
>> When we detect that we have broken backwards compantibility in a
>
> compatibility

done

> (...)
>
>> +
>> +In qemu-8.0 we got this commit: ::
>> +
>> +    commit 9a6ef182c03eaa138bae553f0fbb5a123bef9a53
>> +    Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> +    Date:   Thu Mar 2 13:37:03 2023 +0000
>> +
>> +        hw/pci/aer: Add missing routing for AER errors
>> +
>> +The relevant bits of the commit for our example are this ones:
>> +
>> +    --- a/hw/pci/pcie_aer.c
>> +    +++ b/hw/pci/pcie_aer.c
>> +    @@ -112,6 +112,10 @@ int pcie_aer_init(PCIDevice *dev,
>> +
>> +         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
>> +                      PCI_ERR_UNC_SUPPORTED);
>> +    +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
>> +    +                 PCI_ERR_UNC_MASK_DEFAULT);
>> +    +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
>> +    +                 PCI_ERR_UNC_SUPPORTED);
>> +
>> +         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
>> +                     PCI_ERR_UNC_SEVERITY_DEFAULT);
>> +
>
> These changes are not part of commit
> 9a6ef182c0 ("hw/pci/aer: Add missing routing for AER errors")
> but rather the one before it, namely
> 010746ae1d ("hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register")

grr, will fix that.


>> +The patch changes how we configure pci space for AER.  But qemu fails
>
> Should QEMU and PCI be capitalized in the text parts?

I think that I changed all 

>> +when the pci space configuration is different betwwen source and
>
> between

done.

>> +destination.
>> +
>> +The following commit show how this got fixed:
>
> shows

done

> (...)
>
>> +
>> +So the normality has been restaured and everything is ok, no?
>
> restored

done

>> +
>> +Not really, now our matrix is much bigger.  We started with the easy
>> +cases, migration from the same version to the same version always
>> +works:
>> +
>> +- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
>> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
>> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
>> +
>> +Now the interesting ones.  When the QEMU processes versions are
>> +different.  For the 1st set, their fail and we can do nothing, both
>> +versions are relased and we can't change anything.
>
> released

done

>> +
>> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
>> +- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
>> +
>> +This two are the ones that work. The whole point of making the
>> +change in qemu-8.0.1 release was to fix this issue:
>> +
>> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
>> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
>> +
>> +But now we found that qemu-8.0 neither can migrate to qemu-7.2 not
>> +qemu-8.0.1.
>> +
>> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
>> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
>> +
>> +So, if we start a pc-7.2 machine in qemu-8.0 we can't migrate it to
>> +anything except to qemu-8.0.
>> +
>> +Can we do better?
>> +
>> +Yeap.  If we know that we are gonig to do this migration:
>
> going

done

>> +
>> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
>> +
>> +We can launche the appropiate devices with
>
> "launch" was already pointed out by Peter, but there's also "appropriate"
done

>> +
>> +--device...,x-pci-e-err-unc-mask=on
>> +
>> +And now we can receive a migration from 8.0.  And from now on, we can
>> +do that migration to new machine types if we remember to enable that
>> +property for pc-7.2.  Notice that we need to remember, it is not
>> +enough to know that the source of the migration is qemu-8.0.  Think of this example:
>> +
>> +$ qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 -> qemu-8.2 -M pc-7.2
>> +
>> +In the second migration, the source is not qemu-8.0, but we still have
>> +that "problem" and have that property enabled.  Notice that we need to
>> +continue having this mark/property until we have this machine
>> +rebooted.  But it is not a normal reboot (that don't reload qemu) we
>> +need the mapchine to poweroff/poweron on a fixed qemu.  And from now
>
> machine

done

Thanks a lot.


