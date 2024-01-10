Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA08292D1
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 04:38:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNPOV-0004iw-4A; Tue, 09 Jan 2024 22:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNPOU-0004ik-0Z
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 22:36:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNPOS-0001oV-3f
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 22:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704857799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6wNPZVyTsb6/Il0PjvU4wZq4/+5curYOG/Y/WmD2Kw=;
 b=LUsXiYmkn7Xk7845hFlA81T3kaPoxdFAuzVI9ReqWCzdtmlKUrSIRXiImQHZbtmc6o03T1
 UYAU74IafdQxBGFAKbaZaICO3yrk3YOnxryipnKgbfENuvlCuvh7oZuCWd2JgSfipAEyrB
 Hyq33o6gtVL9EQ7kucRYpvAPucOVJwQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-9_PSG51vMRiIYd7OHYAGJQ-1; Tue, 09 Jan 2024 22:36:26 -0500
X-MC-Unique: 9_PSG51vMRiIYd7OHYAGJQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d50d0e552dso5510695ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 19:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704857784; x=1705462584;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6wNPZVyTsb6/Il0PjvU4wZq4/+5curYOG/Y/WmD2Kw=;
 b=YPMyGvmyiNBEDHntQKjpMoif8BOp4JaB6WHVI2CH9V20VHbj33iSnCNwBxtaKJ0xK8
 4gVKBJFn9GcPbMLmDgyO7ypopBK8uEsu+RH1Qqkz7NSdNUTr+oQDiyompnT74q+zjTW2
 q/8T3QYQmYzqdF37LriJN5MJKtz8KJgcMlMoq+Uxxu6Yt7j9mi5tsxq6T6UgwcMUgM2Y
 5GdRSQiUrK4B4dKxoUQ6Hc02ywh8NTxIQpYx1gFt86F+4GjQwV+oRXvUY3fmP0nBUJaW
 XzDELvD46GV9QJL23+xCciyRde0MsRP/792iwXhE+eQubXhLCWtlXlXx3XVvLdpUueol
 kSww==
X-Gm-Message-State: AOJu0YzeedHySn782EXn2m7aTfONFZezACudAa2/x5DvXbBo7MDYNakf
 pElWRP8lYNDhwh6vglRrNsx7g5NdyxEW5Cr5IICKj6GzBNQ3re53GPUdwK7lg7ceP9xy6jPZei+
 jc+HZEC2WABfD1one8iNsn9E=
X-Received: by 2002:a17:902:8a92:b0:1d4:3abc:29e2 with SMTP id
 p18-20020a1709028a9200b001d43abc29e2mr817088plo.0.1704857784424; 
 Tue, 09 Jan 2024 19:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeEBjDGj5HRMuTTjhQ+VbYzOglxeBQ0xje2mbHmqwmzZRphuxD7++UhrQRWqa37P/d3zT3Pg==
X-Received: by 2002:a17:902:8a92:b0:1d4:3abc:29e2 with SMTP id
 p18-20020a1709028a9200b001d43abc29e2mr817078plo.0.1704857784094; 
 Tue, 09 Jan 2024 19:36:24 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t10-20020a1709028c8a00b001d1d27259cesm2510389plo.180.2024.01.09.19.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 19:36:23 -0800 (PST)
Date: Wed, 10 Jan 2024 11:36:13 +0800
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
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
Message-ID: <ZZ4Qrfis4XHWGN0j@x1n>
References: <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org>
 <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org>
 <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
 <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Fabiano,
> 
> On 9/1/24 21:21, Fabiano Rosas wrote:
> > Cédric Le Goater <clg@kaod.org> writes:
> > 
> > > On 1/9/24 18:40, Fabiano Rosas wrote:
> > > > Cédric Le Goater <clg@kaod.org> writes:
> > > > 
> > > > > On 1/3/24 20:53, Fabiano Rosas wrote:
> > > > > > Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> > > > > > 
> > > > > > > +Peter/Fabiano
> > > > > > > 
> > > > > > > On 2/1/24 17:41, Cédric Le Goater wrote:
> > > > > > > > On 1/2/24 17:15, Philippe Mathieu-Daudé wrote:
> > > > > > > > > Hi Cédric,
> > > > > > > > > 
> > > > > > > > > On 2/1/24 15:55, Cédric Le Goater wrote:
> > > > > > > > > > On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
> > > > > > > > > > > Hi,
> > > > > > > > > > > 
> > > > > > > > > > > When a MPCore cluster is used, the Cortex-A cores belong the the
> > > > > > > > > > > cluster container, not to the board/soc layer. This series move
> > > > > > > > > > > the creation of vCPUs to the MPCore private container.
> > > > > > > > > > > 
> > > > > > > > > > > Doing so we consolidate the QOM model, moving common code in a
> > > > > > > > > > > central place (abstract MPCore parent).
> > > > > > > > > > 
> > > > > > > > > > Changing the QOM hierarchy has an impact on the state of the machine
> > > > > > > > > > and some fixups are then required to maintain migration compatibility.
> > > > > > > > > > This can become a real headache for KVM machines like virt for which
> > > > > > > > > > migration compatibility is a feature, less for emulated ones.
> > > > > > > > > 
> > > > > > > > > All changes are either moving properties (which are not migrated)
> > > > > > > > > or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
> > > > > > > > > is still migrated elsewhere). So I don't see any obvious migration
> > > > > > > > > problem, but I might be missing something, so I Cc'ed Juan :>
> > > > > > 
> > > > > > FWIW, I didn't spot anything problematic either.
> > > > > > 
> > > > > > I've ran this through my migration compatibility series [1] and it
> > > > > > doesn't regress aarch64 migration from/to 8.2. The tests use '-M
> > > > > > virt -cpu max', so the cortex-a7 and cortex-a15 are not covered. I don't
> > > > > > think we even support migration of anything non-KVM on arm.
> > > > > 
> > > > > it happens we do.
> > > > > 
> > > > 
> > > > Oh, sorry, I didn't mean TCG here. Probably meant to say something like
> > > > non-KVM-capable cpus, as in 32-bit. Nevermind.
> > > 
> > > Theoretically, we should be able to migrate to a TCG guest. Well, this
> > > worked in the past for PPC. When I was doing more KVM related changes,
> > > this was very useful for dev. Also, some machines are partially emulated.
> > > Anyhow I agree this is not a strong requirement and we often break it.
> > > Let's focus on KVM only.
> > > 
> > > > > > 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
> > > > > 
> > > > > yes it depends on the QOM hierarchy and virt seems immune to the changes.
> > > > > Good.
> > > > > 
> > > > > However, changing the QOM topology clearly breaks migration compat,
> > > > 
> > > > Well, "clearly" is relative =) You've mentioned pseries and aspeed
> > > > already, do you have a pointer to one of those cases were we broke
> > > > migration
> > > 
> > > Regarding pseries, migration compat broke because of 5bc8d26de20c
> > > ("spapr: allocate the ICPState object from under sPAPRCPUCore") which
> > > is similar to the changes proposed by this series, it impacts the QOM
> > > hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
> > > ("spapr: fix migration of ICPState objects from/to older QEMU") which
> > > is quite an headache and this turned out to raise another problem some
> > > months ago ... :/ That's why I sent [1] to prepare removal of old
> > > machines and workarounds becoming a burden.
> > 
> > This feels like something that could be handled by the vmstate code
> > somehow. The state is there, just under a different path.
> 
> What, the QOM path is used in migration? ...

Hopefully not..

> 
> See recent discussions on "QOM path stability":
> https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
> https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
> https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/

If I read it right, the commit 46f7afa37096 example is pretty special that
the QOM path more or less decided more than the hierachy itself but changes
the existances of objects.

> 
> > No one wants
> > to be policing QOM hierarchy changes in every single series that shows
> > up on the list.
> > 
> > Anyway, thanks for the pointers. I'll study that code a bit more, maybe
> > I can come up with some way to handle these cases.
> > 
> > Hopefully between the analyze-migration test and the compat tests we'll
> > catch the next bug of this kind before it gets merged.

Things like that might be able to be detected via vmstate-static-checker.py.
But I'm not 100% sure, also its coverage is limited.

For example, I don't think it can detect changes to objects that will only
be created dynamically, e.g., I think sometimes we create objects after
some guest behaviors (consider guest enables the device, then QEMU
emulation creates some objects on demand of device setup?), and since the
static checker shouldn't ever start the VM and run any code, they won't
trigger.

-- 
Peter Xu


