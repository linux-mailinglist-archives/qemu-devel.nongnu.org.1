Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14F8713819
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 08:42:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3A4t-0000iq-1e; Sun, 28 May 2023 02:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q3A3z-0000ZS-0M
 for qemu-devel@nongnu.org; Sun, 28 May 2023 02:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q3A3w-00060d-Nx
 for qemu-devel@nongnu.org; Sun, 28 May 2023 02:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685255970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+tG1qwQpcI2qU7BK/9e5UD31Go/FNri7bsCkLjz7Jdw=;
 b=V342NtKtuhkurpqEnIaEXBlwaUlLdcibzGPARtN3vUznLhdPymFAUH5ji2yInXUxpmy8KZ
 xsMMRp1sAQc5p2dSVdNRoGaKGSeTHYJq+SbrAnc14eXSEZb4Fu7VhiJnhkUW4YZas4anz6
 6Lbg+H7alLxqTBJ/JLJJ3G1xNByYHVs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-DJpZiUZ0NJO1sac9-Nh4Jw-1; Sun, 28 May 2023 02:39:28 -0400
X-MC-Unique: DJpZiUZ0NJO1sac9-Nh4Jw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so795299f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 23:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685255967; x=1687847967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tG1qwQpcI2qU7BK/9e5UD31Go/FNri7bsCkLjz7Jdw=;
 b=fZCuldXfcz+JeHc0UKfNQTI/Hz/7CYRIMgtWo5lfsiiuseeSzHIgPaAYUDRVlUrIW1
 t5KDM9GEO2++U7a6LOXezv2t1BhrmdjTBUmEjwALXelNS1vh1iGkBviP++1GlGisDKlQ
 uSddoco89jTIjRfFFIFWKSpenq3P8ZAR0cd3wyVGsKDJd275DtVelSz5P0L9/1d40FGm
 SmlQrq6VmqxUWYvObiNUrmCFuCIVnL/9C2kQb5NFUmyTlHvk9QOCpBWR5Y+yqRiczXGH
 HEwD6/fSelxToCZHV5k7fUjjSt3LNZa19WrFcGEpvGKfaIFDHSQ0M6sY3YfBoNWlByGK
 f0jw==
X-Gm-Message-State: AC+VfDxTl3G+yAfePCKX5vhTexefy6LL3bcSzmwFGN9gbu79Wj2Dcw4r
 4z9a+QOeq2exB9TokAMvRTTqXoVp1VLNRib77TkvUqIMnjRyOWff0BV2XxVvkhEjxyhkDJl2eE5
 on71bgHQXxwfkAUU=
X-Received: by 2002:a5d:630c:0:b0:30a:d7a7:3db4 with SMTP id
 i12-20020a5d630c000000b0030ad7a73db4mr4828630wru.12.1685255967726; 
 Sat, 27 May 2023 23:39:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lMuOJK51islEW91wsfbIW0vQowljjtRRZ1uexryAUNgBvnyJGebZOPm6KqVbl8HCJDEieNg==
X-Received: by 2002:a5d:630c:0:b0:30a:d7a7:3db4 with SMTP id
 i12-20020a5d630c000000b0030ad7a73db4mr4828618wru.12.1685255967382; 
 Sat, 27 May 2023 23:39:27 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 h2-20020adff4c2000000b0030631f199f9sm10008708wrp.34.2023.05.27.23.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 23:39:26 -0700 (PDT)
Date: Sun, 28 May 2023 02:39:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Leonardo Bras <leobras@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
Message-ID: <20230528023313-mutt-send-email-mst@kernel.org>
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <20230511064306-mutt-send-email-mst@kernel.org>
 <8735435c0c.fsf@secure.mitica>
 <ZGuJXf9B0xEeDGe6@orkuz.int.mamuti.net>
 <87ilcf4jdh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilcf4jdh.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, May 26, 2023 at 09:55:22AM +0200, Juan Quintela wrote:
> Jiri Denemark <jdenemar@redhat.com> wrote:
> > On Thu, May 11, 2023 at 13:43:47 +0200, Juan Quintela wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> [Added libvirt people to the party, see the end of the message ]
> >
> > Sorry, I'm not that much into parties :-)
> >
> >> That would fix the:
> >> 
> >> qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2
> >> 
> >> It is worth it?  Dunno.  That is my question.
> >> 
> >> And knowing from what qemu it has migrated from would not help.  We
> >> would need to add a new tweak and means:
> >> 
> >> This is a pc-7.2 machine that has been isntantiated in a qemu-8.0 and
> >> has the pciaerr bug.  But wait, we have _that_.
> >> 
> >> And it is called
> >> 
> >> +    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
> >> 
> >> from the patch.
> >> 
> >> We can teach libvirt about this glitch, and if he is migrating a pc-7.2
> >> machine in qemu-8.0 machine, And they want to migrate to a new qemu
> >> (call it qemu-8.1), it needs to be started:
> >> 
> >> qemu-8.1 -M pc-7.2 <whatever pci devices need to do>,x-pci-err-unc-mask="true"
> >> 
> >> Until the user reboots it and then that property can be reset to default
> >> value.
> >
> > Hmm and what would happen if eventually this machine gets migrated back
> > to qemu-8.0?
> 
> It works.
> migrating to qemu-7.2 is what is not going to work.
> To migrate to qemu-8.0, you just need to drop the
> "x-pci-err-unc-mask=true" bit.  And it would work.
> 
> So, to be clear, this machine can migrate to:
> 
> - qemu-8.0, you just need to drop the "x-pci-err-unc-mask=true" bit
> 
> - qemu-8.0.1 or newer, you just need to maintain the
>   "x-pci-err-unc-mask=true" bit.
> 
> Let's just assume that qemu-7.2.1 don't get the
> "x-pci-err-unc-mask=true" bit, so it will not be able to migrate there.
> 
> 
> > Or even when the machine is stopped, started again, and
> > then migrated to qemu-8.0?
> 
> If you do what I call a hard reset (i.e. poweroff + poweron so qemu
> dies), you should drop the "x-pci-err-unc-mask=true" bit.  And then you
> can migrate to qemu-7.2 and all qemu-8.0.1 and newer.
> 
> Basically what we need is a "mark" inside libvirt that means something
> like:
> 
> - this is weird machine that looks like pc-7.2
> - but has "x-pci-err-unc-mask=true"
> - so it can only migrate to qemu-8.0 and newer.
> - but if it even reboots in qemu-8.0.1 or newer, we want it back to
>   become a "normal" pc-7.2 machine (i.e. drop the
>   x-pci-err-unc-mask=true).
> 
> That would be the perfect world.  But as we are in an imperfect world,
> something like:
> 
> - this machine started in qemu-8.0 -M pc-7.2, we know this is broken and
>   it can't migrate outside of qemu-8.0 because it would fail to go to
>   either qemu-7.2 or qemu-8.0.1.
> 
> I would argue that if you do the second option doing the "right" option
> i.e. the first one is not much more complicated, but that is a question
> that you should be better to answer.
> 
> And then we have the other Michael question.  How can we export that
> information so libvirt can use it.
> 
> In this case we can comunicate libvirt:
> - In qemu-8.0 we broke pc-7.2.
> - The problem is fixed in qemu-8.0.1 using property
>   "x-pci-err-unc-mask=false".
> - You can migrate from qemu-8.0 in newer if you set that property as
>   true.
> - Guests started in qemu-8.0 -M pc-7.2 should reboot in qemu-8.0.1 or
>   newer to become "normal pc-7.2".
> - If we publish this on qemu, we can only publish it on qemu-8.0.1 and
>   newer.
> - Or we can publish it somewhere else and any libvirt can take this
>   information.
> - Or we can comunicate this to libvirt, and they incorporate it on their
>   source anywhere that you see fit.

And this is not an isolated instance. There are things like this in
almost each release.


My suggestion is a package with known bugs like this.
It would list these work arounds in some machine readable
format and would be essentially append only, making it
relatively safe even for very old RHEL distros to
pick up the latest version once in a while.

E.g. the fact we add bug workaround for 10.0 will not affect
7.2 so you do not need to fork with each release.




> The point here is that when we use a property on a machine type, it can
> be for two reasons:
> 
> - We detected at the right time that we changed the value of something,
>   and we did the right thing on hw_compat_X_Y, so libvirt needs to do
>   nothing.
> 
> - We *DID NOT* detect that we broke compatibility before release, and we
>   need to make a property to identify that problem.  This is where we
>   need to do this dance.
> 
> Notice that normally we detect lots of problems during development and
> this *should* not happen.  But when it happens, we need to be able to do
> something.
> 
> And also notice that normally we broke just some device, not a whole
> machine type.  But as you can see we have broke it this time.  We are
> trying to automate the detection of this kind of failures, but we are
> still on design stage, so we need to plan how to handle this.
> 
> Any comments?
> 
> Later, Juan.
> 
> 
> 
> 


