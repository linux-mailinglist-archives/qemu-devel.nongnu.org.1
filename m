Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87878793034
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcu8-0001HA-S0; Tue, 05 Sep 2023 16:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdcu7-0001Gg-5O
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdcu3-0000mD-2v
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693946641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJnWyERjpXcZTAMTv8MbDjaow04MVwSMqfbZSI0pog4=;
 b=BESrU++Hbqx/l/VrCVAvgZ5uEFYSKWibjIIX415IhgexTC5cCyGzdLmPNJVYDw6k66ogDv
 BF/yzqes/CYDrBANAxOOENWtRocf1h6unSvOSqKPvcsvMLkR0OGxfLFz1fEZRvUiCx8UVy
 /gRoMlzfX1T546ZMVA92vckcnbyvB2c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-KJm1HXaHNUOXk8nWe9zvyw-1; Tue, 05 Sep 2023 16:44:00 -0400
X-MC-Unique: KJm1HXaHNUOXk8nWe9zvyw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-500b5641eeaso3149544e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 13:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693946639; x=1694551439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJnWyERjpXcZTAMTv8MbDjaow04MVwSMqfbZSI0pog4=;
 b=k6HKLqyXmmn/g2+Hld7MenYCohAMIJvSVW1EQTDjJU7RBKyohec94k4uNOf5FxBJvT
 grnBd0IC2ZebHS4FRynJbt7EyN82h5aOMO8bkPV0rfX0flBMkkrgVU1f6nLW63fPNxqQ
 qOVr8O63+SmwotuqXgolRUW5WXWiUoftJ2XQRQUhhNAiMd7psxvQZYS0EU5X5AePY2bF
 tt5bArTEw2IK1VWX21RdiMgx8GaYMH6nGiK++YT28xPvpsP6oNKxKHpzsqKkRE5oY8Uj
 BHOgrDixvlygopXrP40Xmmg7W4tNqFZO5LoS7PClEHk3Xe7oyfOmzNoAgIOocdLmcic1
 fF0w==
X-Gm-Message-State: AOJu0YxYvQm2SZ7yIzeLRIEEsxjYoLnnFSoBMnnNqU+8LlBfhN9esWu9
 VhWyIN7+SKn3J+HEPQwhfyjBzPWBMwX2nZ4EP0TCikkXd+LbnA6+6puor5h/aswbotuIXsvudjj
 0zUKh4u4ah3v9vyc=
X-Received: by 2002:a19:2d4c:0:b0:500:b7ed:105a with SMTP id
 t12-20020a192d4c000000b00500b7ed105amr582903lft.29.1693946639065; 
 Tue, 05 Sep 2023 13:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnL41Xxx1YeqPUIEA4QvibMnyDvFNiyTmB6SxKksTkLbDW9Fcdqxd11huwMJWqJwuoXV/BGA==
X-Received: by 2002:a19:2d4c:0:b0:500:b7ed:105a with SMTP id
 t12-20020a192d4c000000b00500b7ed105amr582888lft.29.1693946638696; 
 Tue, 05 Sep 2023 13:43:58 -0700 (PDT)
Received: from redhat.com ([2.52.23.134]) by smtp.gmail.com with ESMTPSA id
 b4-20020aa7c6c4000000b00523653295f9sm7455175eds.94.2023.09.05.13.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:43:57 -0700 (PDT)
Date: Tue, 5 Sep 2023 16:43:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcello Sylverster Bauer <sylv@sylv.io>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ani@anisinha.ca,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: PCI Hotplug ACPI device names only 3 characters long
Message-ID: <20230905163919-mutt-send-email-mst@kernel.org>
References: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
 <20230905123447-mutt-send-email-mst@kernel.org>
 <bfd8c202-0ceb-47c2-8e9c-9547bd4bdd5f@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd8c202-0ceb-47c2-8e9c-9547bd4bdd5f@sylv.io>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 05, 2023 at 07:45:12PM +0200, Marcello Sylverster Bauer wrote:
> Hi Michael,
> 
> On 9/5/23 18:44, Michael S. Tsirkin wrote:
> > On Tue, Sep 05, 2023 at 05:05:33PM +0200, Marcello Sylverster Bauer wrote:
> > > Greetings,
> > > 
> > > I'm currently working on a project to support Intel IPU6 in QEMU via VFIO so
> > > that the guest system can access the camera. This requires extending the
> > > ACPI device definition so that the guest knows how to access the camera.
> > > 
> > > However, I cannot extend the PCI devices because their names are not 4
> > > characters long and therefore do not follow the ACPI specification.
> > > 
> > > When I use '-acpitable' to include my own SSDT for the IPU6 PCI device, it
> > > does not allow me to declare the device as an External Object because it
> > > automatically adds padding underscores.
> > > 
> > > e.g.
> > > Before:
> > > ```
> > > External(_SB.PCI0.S18.SA0, DeviceObj)
> > > ```
> > > After:
> > > ```
> > > External(_SB.PCI0.S18_.SA0_, DeviceObj)
> > > ```
> > > 
> > > Adding the underscore padding is hard coded in iASL and also in QEMU when
> > > parsing an ASL file. (see: build_append_nameseg())
> > > 
> > > So here are my questions:
> > > 1. Is there a solution to extend the ACPI PCI device using '-acpitable'
> > > without having to patch iASL or QEMU?
> > > 2. Are there any plans to change the names to comply with the ACPI spec?
> > > (e.g. use "S%.03X" format string instead)
> > > 
> > > Thanks
> > > Marcello
> > 
> > 
> > 1.  All names in ACPI are always exactly 4 characters long. _ is a legal character
> >      but names beginning with _ are reserved.
> 
> Exactly, which is why I want to address this issue here. Currently, Qemu
> generates ACPI device names with only 3 characters. (See
> build_append_pci_bus_devices() in hw/i386/acpi-build.c).
> For example, the device I want to append entries to has the path
> "_SB.PCI0.S18.SA0", but I can't because of the two auto-generated devices
> with only 3 characters in their names.

They are 4 characters otherwise OSPMs wouldn't work.
In your example the path is _SB.PCI0.S18_.SA0_ - you disassembler probably
just helpfully hides it for readability.

> > There's no rule in ACPI
> >      spec that says they need to follow S%.03X or any other specific format.
> >      I'm pretty sure we do follow the ACPI specification in this but feel free to
> >      prove me wrong.
> 
> You have misunderstood me. Currently, Qemu uses the following format to
> create PCI ACPI devices:
> 
> ```
> aml_name("S%.02X", devfn)
> ```
> 
> My question is whether we should change it to something that results in a 4
> character name like "S%.03X" or "S%.02X_".

I think you misunderstand the code. Look at build_append_nameseg and you will
see that the name is always ACPI_NAMESEG_LEN characters which equals 4.

> I have tested it and it works fine as long as any hardcoded path references
> are adjusted. But I'm not 100% sure if this could cause any regressions.
> 
> > 2.  You can probably add something to existing ACPI devices using Scope().
> 
> I'm pretty sure the external object is required when loading a separate
> SSDT, but I'll try by just using scopes.
> 
> >      I would not advise relying on this - current names are not a stable
> >      interface that we guarantee across QEMU versions.
> >      If adding this functionality is desirable, I think we'll need some new interface
> >      to set a stable ACPI name. Maybe using aliases.
> 
> Currently I'm just working on a PoW to get IPU6 working in QEMU, so
> instability is fine.
> 
> Thanks,
> Marcello
> 
> > 
> > 


