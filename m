Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7382005A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 16:46:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJF35-0007TN-Jf; Fri, 29 Dec 2023 10:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rJF33-0007SM-Ia
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 10:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rJF31-0007kw-LA
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 10:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703864717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMC8qbc8rIJ0A8ALQ0gnzvIqQ4al1hDZkVp49mF193Q=;
 b=BdaR+9pafKH9GZdv0Ic7GKdcN5k9l7IQTZIo0Zed/lbJ9FdD1TCv3i1KDpojUjyoiyw1MP
 gQ8Y4ob8LUVCL40C9FHoWe9rsTHXSf+KMRYmjIXsj1RcZLJL6BgOAGzRhPLAaMUXRRigD4
 pyFjyfMqD1+lsG+gqY8Hw4yaCrbun4E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-PkoDXZVQNgipzkIc4NMNMA-1; Fri, 29 Dec 2023 10:45:14 -0500
X-MC-Unique: PkoDXZVQNgipzkIc4NMNMA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d54db2ab5so46620735e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 07:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703864713; x=1704469513;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tMC8qbc8rIJ0A8ALQ0gnzvIqQ4al1hDZkVp49mF193Q=;
 b=ihg8W1ZbDva78yaC09cV8Pxts8EzFtniXU29dE2eCU60bGil/NNuI8bQc80Woazewk
 RsNFUaI7jJmuo1YL5tcum/NtUARyfXkD4VM0wcbqHMSD4WfGi8VRQ0Sg09xlxgi0ET2P
 S0Nrwu55dikgO/myRm679NeY7OIgapDIt3SWKR2UM4LALAdpk2m2ulKCKbYUtJFaGK1U
 2VSMTUh4bN21EskrSE0ccFys2CG/9e75DO4ehhTWxijWsZH1080mKjHI8rr35AOg+qQF
 lmO0mo/OrxAKcAlouIrjrRbyOnpu0yZ+tZ1hK/yrgkC5/5/1nuMs2JEtBzwKNKgd5/rI
 Jqgw==
X-Gm-Message-State: AOJu0Ywqyw5lsX/h3JRQdC2dEVRTJ0fx3CISguP8lC390AMSS05VUYLc
 k707RW84Dl491gzuKvvGJEe5+gMkmZzN2tckftgA9DYIenxDTmq/0v01jErsutGfjycTBMz5XEZ
 Od1La/5Lc/5qUiRa+vzzHoB8=
X-Received: by 2002:a1c:6a0d:0:b0:40d:621b:83c8 with SMTP id
 f13-20020a1c6a0d000000b0040d621b83c8mr1521466wmc.198.1703864713267; 
 Fri, 29 Dec 2023 07:45:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUicluL1IfB/YUhvBp93RDCvHLcRsBK6txrrhaAEsuRkMBYzpZZy2zNsi7Y4qqoruEJq2l9A==
X-Received: by 2002:a1c:6a0d:0:b0:40d:621b:83c8 with SMTP id
 f13-20020a1c6a0d000000b0040d621b83c8mr1521454wmc.198.1703864712881; 
 Fri, 29 Dec 2023 07:45:12 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 a5-20020a05600c348500b0040d597abf05sm13643174wmq.42.2023.12.29.07.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 07:45:12 -0800 (PST)
Date: Fri, 29 Dec 2023 10:45:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20231229104428-mutt-send-email-mst@kernel.org>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
 <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
 <20231128105920-mutt-send-email-mst@kernel.org>
 <20231129110107.7993894d@imammedo.users.ipa.redhat.com>
 <20231130122237.3a5f79b2@imammedo.users.ipa.redhat.com>
 <20231229163514.72082dfd@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231229163514.72082dfd@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.553,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 29, 2023 at 04:35:14PM +0100, Igor Mammedov wrote:
> On Thu, 30 Nov 2023 12:22:37 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Wed, 29 Nov 2023 11:01:07 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > > On Tue, 28 Nov 2023 11:00:29 -0500
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Tue, Nov 28, 2023 at 03:53:21PM +0100, Fiona Ebner wrote:    
> > > > > Am 28.11.23 um 15:13 schrieb Daniel P. Berrangé:      
> > > > > > On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote:      
> > > > > >> we received some reports about the new default causing issues for
> > > > > >> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot fails
> > > > > >> and Microsoft Windows, where querying an UUID set via QEMU cmdline
> > > > > >> -smbios 'type=1,uuid=a4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
> > > > > >> in Powershell with
> > > > > >> get-wmiobject win32_computersystemproduct | Select-Object
> > > > > >> -expandProperty UUID
> > > > > >> doesn't return any value anymore and can trip up some guest
> > > > > >> applications. The original report is about Windows 10 and I reproduced
> > > > > >> this with Windows Server 2019 and the German (but I hope it doesn't
> > > > > >> matter this time) version of Windows Server 2022.
> > > > > >>
> > > > > >> Using machine type 8.0 or the machine option smbios-entry-point-type=32
> > > > > >> are workarounds.
> > > > > >>
> > > > > >> Since Windows is widely used, that seems a bit unfortunate. Just wanted
> > > > > >> to ask if you are aware of the issue and if there is something else that
> > > > > >> can be done other than specifying the more specific machine commandline
> > > > > >> for those OSes?      
> > > > > > 
> > > > > > I don't recall seeing this issue mentioned before. Could you file a
> > > > > > bug at https://gitlab.com/qemu-project/qemu
> > > > > >       
> > > > > 
> > > > > I made one for the Windows issue:
> > > > > https://gitlab.com/qemu-project/qemu/-/issues/2008
> > > > > 
> > > > > It's not clear to me if this is a bug in QEMU or just a bug/limitation
> > > > > of the guest OS when 64 bit entry is used by SMBIOS.
> > > > > 
> > > > > I didn't create one for vSRX, because I'm not using it myself and since
> > > > > it's based on FreeBSD and FreeBSD 13.1 can boot just fine with both 32
> > > > > and 64 bit entry, it might be an issue on their side.
> > > > > 
> > > > > Best Regards,
> > > > > Fiona      
> > > > 
> > > > I would be inclined to limit this to when we have too many VCPUs then.
> > > > Igor WDYT?    
> > > 
> > > Let me try to reproduce and see if Windows debug logs would provide some clue.  
> > 
> > Nothing notable in debug output on Windows side, but it looks like Windows
> > doesn't see SMBIOS tables at all.
> > 
> > However it affects VMs with Seabios only, UEFI based VMs work just fine.
> > My guess would be it's not QEMU issue, but Seabios one.
> > I'm still looking at it,
> > but CCing Gerd, who might have an idea what's going wrong from firmware pov. 
> > 
> 
> So running Seabios VM with Win10 as a guest under debugger
> (set access breakpoint on SMBIOS anchor string), one can see
> that Windows doesn't look for _SM3_ signature during lookup
> at all. While after some convincing and making make lookup
> code return SMBIOS 3.x entrypoint, the rest of Windows handles
> SMBIOS 3.x just fine and shows UUID /using Fiona's reproducer/.
> 
> So it's bug in Windows.
> 
> As for qemu, I'd guess we'd just have to live with it until MS
> fixes it and even after that it won't help with unsupported versions
> as they are not likely to get fix.
> 
> To that effect, we have 3 options:
>    1. make mgmt force 32bit entry point if they are starting Windows VM
>    2. unconditionally switch pc|q35 9.0+ machine types to 32bit entry point
>       and error out if configuration doesn't fit into SMBIOS 2.0 tables
>       (easiest from QEMU pov)
>    3. introduce 'auto' value for smbios entry point option, and then
>       try to stick with 32bit entry point while it is usable
>       (cpu count < 256 and tables still fit in guest's FSEG RAM).
>       When that fails switch dynamically to 64bit entry point.
> 
> Any opinions on preferable route?
> 
> I'm looking into my least favorite option 3 atm, and it's pretty messy
> with current SMBIOS code and needs quite a bit of cleanup.

I like 3 as the least disruptive ... but UEFI works do you know why?


-- 
MST


