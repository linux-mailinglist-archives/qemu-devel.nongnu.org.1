Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9348293B3
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 07:28:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNS36-0001lG-TR; Wed, 10 Jan 2024 01:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNS34-0001ko-8C
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNS31-0001Gv-6c
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704868001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSBkUcgNCSBjY6U3vHPbVrlY0wCbao82Fb5YTqfAByI=;
 b=FEF0SE2tNdy+Vi8KTt2E1IIcbrjFVuoq7LDIXb3P8YiPhtBLPRxycItGDHj6RUkT7ohCva
 rsEUIMSDlM19yBM4R7BqdO5+l+xRw7Ny38mC0dmVk7hf5Spj/F2iZL7PJpuxO99RXJjGLs
 8jtu+ddsE/Q5w8LLx3sQbWimeLv5w7g=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-x1sRti1oPjuoih-FLwRb2g-1; Wed, 10 Jan 2024 01:26:40 -0500
X-MC-Unique: x1sRti1oPjuoih-FLwRb2g-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d44608e379so5975925ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 22:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704867997; x=1705472797;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSBkUcgNCSBjY6U3vHPbVrlY0wCbao82Fb5YTqfAByI=;
 b=WIi7Rie0sqImZjGFgnUeWnrzfucetaxBVFSd8NKqQwaw96lg23X2zupnOt0AAQXuDI
 BiFM8mGO4dyuceh/yAuA5FJeSUkRasZpvesdnVAZvonnchthZocSgpFxyauuYEtdAETn
 auyb2BFwGzS1GXxNMcP/Gbje9/4IQBG+UfEM1qlFzPpAKnrV3i64j8JO4H2Ww8tM/Ut1
 CP/jNP9jAKbA6OXJUfbh1khQHuKLvGGJ9AZkQPGKjcVDOw2lyQhORjA8T7q/KW6QPnfH
 FqQcUVspSdkozO9QhVhUuEf2C5n7wjttV3dWBWi0ULUyZQ69YPEg1Dzht+2GePmIo51r
 ov/w==
X-Gm-Message-State: AOJu0YxlEEBfh+42i2Hq+sbJtmr5zlRob0ek2jGFcIRroZ/FFFAaGEH0
 t/tZdfTF19C/rO6Nu8pKz9+XfpLrhCgQldXuetSu0viO6DzH6ZT4uCu9qFF6Xgx3scjhGI4zpxG
 rldV27/79uiNYpB6dHL4/owk=
X-Received: by 2002:a17:902:8a92:b0:1d4:3abc:29e2 with SMTP id
 p18-20020a1709028a9200b001d43abc29e2mr1086808plo.0.1704867997125; 
 Tue, 09 Jan 2024 22:26:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1JbYLlIJV0JeYJwfkXsnjp3N2ZouT1Ac0whGb5KOKxCJSdya4fVlzXiQYw5xucJyFfdnJmw==
X-Received: by 2002:a17:902:8a92:b0:1d4:3abc:29e2 with SMTP id
 p18-20020a1709028a9200b001d43abc29e2mr1086783plo.0.1704867996745; 
 Tue, 09 Jan 2024 22:26:36 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w7-20020a1709029a8700b001d56f8f0e10sm551756plp.26.2024.01.09.22.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 22:26:36 -0800 (PST)
Date: Wed, 10 Jan 2024 14:26:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Message-ID: <ZZ44iQRPrdDpfov7@x1n>
References: <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org>
 <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org>
 <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
 <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org>
 <ZZ4Qrfis4XHWGN0j@x1n> <87cyu9hgit.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyu9hgit.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

On Wed, Jan 10, 2024 at 07:03:06AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daudé wrote:
> >> Hi Fabiano,
> >> 
> >> On 9/1/24 21:21, Fabiano Rosas wrote:
> >> > Cédric Le Goater <clg@kaod.org> writes:
> >> > 
> >> > > On 1/9/24 18:40, Fabiano Rosas wrote:
> >> > > > Cédric Le Goater <clg@kaod.org> writes:
> >> > > > 
> >> > > > > On 1/3/24 20:53, Fabiano Rosas wrote:
> >> > > > > > Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> >> > > > > > 
> >> > > > > > > +Peter/Fabiano
> >> > > > > > > 
> >> > > > > > > On 2/1/24 17:41, Cédric Le Goater wrote:
> >> > > > > > > > On 1/2/24 17:15, Philippe Mathieu-Daudé wrote:
> >> > > > > > > > > Hi Cédric,
> >> > > > > > > > > 
> >> > > > > > > > > On 2/1/24 15:55, Cédric Le Goater wrote:
> >> > > > > > > > > > On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
> >> > > > > > > > > > > Hi,
> >> > > > > > > > > > > 
> >> > > > > > > > > > > When a MPCore cluster is used, the Cortex-A cores belong the the
> >> > > > > > > > > > > cluster container, not to the board/soc layer. This series move
> >> > > > > > > > > > > the creation of vCPUs to the MPCore private container.
> >> > > > > > > > > > > 
> >> > > > > > > > > > > Doing so we consolidate the QOM model, moving common code in a
> >> > > > > > > > > > > central place (abstract MPCore parent).
> >> > > > > > > > > > 
> >> > > > > > > > > > Changing the QOM hierarchy has an impact on the state of the machine
> >> > > > > > > > > > and some fixups are then required to maintain migration compatibility.
> >> > > > > > > > > > This can become a real headache for KVM machines like virt for which
> >> > > > > > > > > > migration compatibility is a feature, less for emulated ones.
> >> > > > > > > > > 
> >> > > > > > > > > All changes are either moving properties (which are not migrated)
> >> > > > > > > > > or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
> >> > > > > > > > > is still migrated elsewhere). So I don't see any obvious migration
> >> > > > > > > > > problem, but I might be missing something, so I Cc'ed Juan :>
> >> > > > > > 
> >> > > > > > FWIW, I didn't spot anything problematic either.
> >> > > > > > 
> >> > > > > > I've ran this through my migration compatibility series [1] and it
> >> > > > > > doesn't regress aarch64 migration from/to 8.2. The tests use '-M
> >> > > > > > virt -cpu max', so the cortex-a7 and cortex-a15 are not covered. I don't
> >> > > > > > think we even support migration of anything non-KVM on arm.
> >> > > > > 
> >> > > > > it happens we do.
> >> > > > > 
> >> > > > 
> >> > > > Oh, sorry, I didn't mean TCG here. Probably meant to say something like
> >> > > > non-KVM-capable cpus, as in 32-bit. Nevermind.
> >> > > 
> >> > > Theoretically, we should be able to migrate to a TCG guest. Well, this
> >> > > worked in the past for PPC. When I was doing more KVM related changes,
> >> > > this was very useful for dev. Also, some machines are partially emulated.
> >> > > Anyhow I agree this is not a strong requirement and we often break it.
> >> > > Let's focus on KVM only.
> >> > > 
> >> > > > > > 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
> >> > > > > 
> >> > > > > yes it depends on the QOM hierarchy and virt seems immune to the changes.
> >> > > > > Good.
> >> > > > > 
> >> > > > > However, changing the QOM topology clearly breaks migration compat,
> >> > > > 
> >> > > > Well, "clearly" is relative =) You've mentioned pseries and aspeed
> >> > > > already, do you have a pointer to one of those cases were we broke
> >> > > > migration
> >> > > 
> >> > > Regarding pseries, migration compat broke because of 5bc8d26de20c
> >> > > ("spapr: allocate the ICPState object from under sPAPRCPUCore") which
> >> > > is similar to the changes proposed by this series, it impacts the QOM
> >> > > hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
> >> > > ("spapr: fix migration of ICPState objects from/to older QEMU") which
> >> > > is quite an headache and this turned out to raise another problem some
> >> > > months ago ... :/ That's why I sent [1] to prepare removal of old
> >> > > machines and workarounds becoming a burden.
> >> > 
> >> > This feels like something that could be handled by the vmstate code
> >> > somehow. The state is there, just under a different path.
> >> 
> >> What, the QOM path is used in migration? ...
> >
> > Hopefully not..
> >
> >> 
> >> See recent discussions on "QOM path stability":
> >> https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
> >> https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
> >> https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/
> >
> > If I read it right, the commit 46f7afa37096 example is pretty special that
> > the QOM path more or less decided more than the hierachy itself but changes
> > the existances of objects.
> 
> Let's see whether I got this...
> 
> We removed some useless objects, moved the useful ones to another home.
> The move changed their QOM path.
> 
> The problem was the removal of useless objects, because this also
> removed their vmstate.
> 
> The fix was adding the vmstate back as a dummy.
> 
> The QOM patch changes are *not* part of the problem.
> 
> Correct?

[I'd leave this to Cedric]

> 
> >> > No one wants
> >> > to be policing QOM hierarchy changes in every single series that shows
> >> > up on the list.
> >> > 
> >> > Anyway, thanks for the pointers. I'll study that code a bit more, maybe
> >> > I can come up with some way to handle these cases.
> >> > 
> >> > Hopefully between the analyze-migration test and the compat tests we'll
> >> > catch the next bug of this kind before it gets merged.
> >
> > Things like that might be able to be detected via vmstate-static-checker.py.
> > But I'm not 100% sure, also its coverage is limited.
> >
> > For example, I don't think it can detect changes to objects that will only
> > be created dynamically, e.g., I think sometimes we create objects after
> > some guest behaviors (consider guest enables the device, then QEMU
> > emulation creates some objects on demand of device setup?),
> 
> Feels nuts to me.
> 
> In real hardware, software enabling a device that is disabled by default
> doesn't create the device.  The device is always there, it just happens
> to be inactive unless enabled.  We should model the device just like
> that.

It doesn't need to be the device itself to be dynamically created, but some
other sub-objects that do not require to exist until the device is enabled,
or some specific function of that device is enabled.  It is logically doable.

Is the example Cedric provided looks like some case like this?  I am not
sure, that's also why I'm not sure the static checker would work here.  But
logically it seems possible, e.g. with migration VMSD needed() facilities.
Consider a device has a sub-function that requires a sub-object.  It may
not need to migrate that object if that sub-feature is not even enabled.
If that object is very large, it might be wise to do so if possible to not
send chunks of junk during the VM downtime.

But then after a 2nd thought I do agree it's probably not sensible, because
even if the src may know whether the sub-object will be needed, there's
probably no good way for the dest QEMU to know.  It can only know in
something like a post_load() hook, but logically that can happen only after
a full load of that device state, so might already be too late.

Thanks,

-- 
Peter Xu


