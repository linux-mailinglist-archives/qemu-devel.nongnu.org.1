Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55747776607
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:04:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmbB-0006kn-EH; Wed, 09 Aug 2023 13:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qTmbA-0006kS-20
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qTmb8-0005CD-AM
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691600627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7NZUTLj+t+e3P9V2CL11tQI84MbNS5URPIhzJSb3HQ=;
 b=S8L741672DcNBEc6F1D36vLXWpj0rE6T17/XfmdxoNwpRVns4DuYo4nFdLRPnTxs/GUe7k
 xSrW+n/7Jgw6ZBThL4iVMAi4EL0Y9X+m1l6+J9afysogdyt4h2xXds3A6GQYgrcD1tDTyM
 9Kco3PFEvsXIaTDe6SNO8xn04r93dyo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-gUmlJRmvO3OimSmHmmuB0w-1; Wed, 09 Aug 2023 13:03:46 -0400
X-MC-Unique: gUmlJRmvO3OimSmHmmuB0w-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-77e3208a8cbso579266239f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691600624; x=1692205424;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7NZUTLj+t+e3P9V2CL11tQI84MbNS5URPIhzJSb3HQ=;
 b=VNON9bAMql9vh0doAzUaZcPb59nk3sEWHhH0U3Fmw63lNK6u8lhpMlHhgKIkjvTxZR
 sH7CD90VQunV/LgEDtBKLk6xFgHyDyXHVMY/sGgH4FCUlh43V/rlhNLN5haV4J5HkHxh
 24YmibauUYGdBET1MPgwbJLaK/5/ry+meaF7DMWrBTVVISwtkTCr+4POFsM0fg6gBhti
 lAyykNDUlRMVEANTrsrTnQ0hTM8qNxGa2apZ0TOGnaDEId1A+I3XCdPxC4t/hBUaH7jP
 yuDjbPEaLo3NpCsOLuQ7AHAbJad+44hdd6nG+n7D3IGjMCMZszM9rZ0Bqj427P2SZlLK
 61oA==
X-Gm-Message-State: AOJu0YzvQG7NMqjgZRmNFACYwVwZ4gswi61llTU4h4J6GxE3cGJJ8VC7
 +zfdNv4gPK/xcXcQXahEjzKl8Ad0Oaxccg7FQqOWJSb4YfmgNYEyKO95YsVhrfRz+4R9PQaVDJP
 gV9AEuHP6IO7GKJw=
X-Received: by 2002:a05:6e02:1a0f:b0:348:fc48:6d00 with SMTP id
 s15-20020a056e021a0f00b00348fc486d00mr4637710ild.12.1691600624734; 
 Wed, 09 Aug 2023 10:03:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnnt5Ktg+3Wb3W2O+j0r7nFpyBjhuzuvDRp2C1X6+Pv2QnM32YVYeSRG5b/nJ8LqvAJ+ibyw==
X-Received: by 2002:a05:6e02:1a0f:b0:348:fc48:6d00 with SMTP id
 s15-20020a056e021a0f00b00348fc486d00mr4637690ild.12.1691600624471; 
 Wed, 09 Aug 2023 10:03:44 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 b14-20020a92dcce000000b003426356a35asm4240636ilr.0.2023.08.09.10.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:03:43 -0700 (PDT)
Date: Wed, 9 Aug 2023 11:03:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/pci: hide ROM BAR on SFC9220 10/40G Ethernet
 Controller PF
Message-ID: <20230809110342.3646e393.alex.williamson@redhat.com>
In-Reply-To: <5cd1b468-5b94-6459-73b9-f428e6dce342@redhat.com>
References: <20230808145916.81657-1-lersek@redhat.com>
 <20230808094041.41ebe3b6.alex.williamson@redhat.com>
 <5cd1b468-5b94-6459-73b9-f428e6dce342@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 9 Aug 2023 14:07:07 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 8/8/23 17:40, Alex Williamson wrote:
> > On Tue,  8 Aug 2023 16:59:16 +0200
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >   
> >> The Solarflare Communications SFC9220 NIC's physical function (PF) appears
> >> to expose an expansion ROM with the following characteristics:
> >>
> >> (1) Single-image ROM, with only a legacy BIOS image (no UEFI driver).
> >> Alex's rom-parser utility dumps it like this:
> >>  
> >>> Valid ROM signature found @0h, PCIR offset 20h
> >>>         PCIR: type 0 (x86 PC-AT), vendor: 1924, device: 0a03, class: 000002
> >>>         PCIR: revision 3, vendor revision: 1
> >>>         Last image    
> >>
> >> (2) The BIOS image crashes when booted on i440fx.
> >>
> >> (3) The BIOS image prints the following messages on q35:
> >>  
> >>> Solarflare Boot Manager (v5.2.2.1006)
> >>> Solarflare Communications 2008-2019
> >>> gPXE (http://etherboot.org) - [...] PCI[...] PnP PMM[...]    
> >>
> >> So it appears like a modified derivative of old gPXE.
> >>
> >> Alex surmised in advance that the BIOS image could be accessing
> >> host-physical addresses rather than guest-phys ones, leading to the crash
> >> on i440fx.  
> > 
> > ROMs sometimes take shortcuts around the standard interfaces to the
> > device and can therefore hit gaps in the virtualization, which is why
> > that's suspect to me.  However if it works on q35 but not 440fx it
> > might be more that we're not matching a PCI topology expectation of the
> > ROM.  Was it only tested on 440fx attached to the root bus or does it
> > also fail if the PF is attached downstream of a PCI-to-PCI bridge?  
> 
> Turns out the oprom wants the NIC to have PCI device number 0,
> regardless of the bus number, and regardless of the bus's location in
> the PCI topology.
> 
> Please drop this patch; I've documented the workaround in the BZ for now
> (which I've also opened up to the public).
> 
> We should probably find a more visible place for the documentation, though.
> 
> Thanks for pointing me in the right direction!

Thanks for pursuing this, it's an interesting discovery and just the
sort of shortcut I'd expect to find in a ROM.  Documentation seems like
a reasonable solution to me, especially given that the ROM works in the
current recommended default configuration.

We could probably come up with a device quirk to flag an incompatible
configuration, but it's tricky to get the right balance since ROMs can
be updated and we're not identifying the ROM itself, we're only
essentially flagging that a bad ROM has been observed on a given device.

Given the lack of prevalence of this device for assignment versus the
VF use case, it's probably not worth the effort to do more.  Thanks,

Alex


