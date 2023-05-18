Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD27082F4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdey-0002uF-7k; Thu, 18 May 2023 09:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzdew-0002tV-7C
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzdes-0005fw-KB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684416425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mWCo8/GMkM1bGMZTkv39Bow/sClHMWOmAf+AIU6h2YQ=;
 b=WwhKypKkxReD9vEDR1nYUGhJ7QxfR/9BtMTUy2hJ+r2U2oDzHSfs6GHAWm+9f8XJ53lkpG
 tqVqZAsZ3kAHghwwRX1HQnaE7R4xFFZ3s+l1sasVOdvTicrKsIQeeWtkiWQDmqQfcsCbod
 2yvpU0mxAWsgU76K6d55tPCvDsQDTto=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-mIhZZBXZNSKqX4H-WURXqQ-1; Thu, 18 May 2023 09:27:03 -0400
X-MC-Unique: mIhZZBXZNSKqX4H-WURXqQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-61a3c7657aeso1867506d6.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684416423; x=1687008423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWCo8/GMkM1bGMZTkv39Bow/sClHMWOmAf+AIU6h2YQ=;
 b=byoQWrqLxiHI0T2PHQ2buFORyPQeZv7f5WEKAm9e1gE0oAg5GRFjnKWTprVkiBarqA
 QTUMmgVEMXx57akqPqW+wkNxXgVlTSWVfsoWc6AIdM3NRdp+8pMCPXaDoS5mogh9Z2eb
 NUm/nCSX++BawfRUw46rHxIWYz2r69ISzvDa2LnPCH4VSss0+/mrLD3+Iahm57QWNUQj
 u7oRF5aZJsleIBWIr/D38A4kZa/IrzHTNk0OVzV3CEASN1H7Wr2soylSDC3N8ic+Ph7e
 DbhctC40XA1Oq4e+MNozbk0Z0v4sIyjtXsFYp9Ab2OuhSax01fVONDPCakJak31K3282
 y9nw==
X-Gm-Message-State: AC+VfDyymR/Q1JCr713GGZkUZ+pWZ2w61B3YaPsOeY0gQAqVNEyjtnwh
 rJnuysv3Ag+v8swy/f+8hha8o/OmN8z5MKzIslTrB79vkVJbErVWC8syzlkFJpnY6h1uFFgkMkP
 /cXd3ZcS+6M3HxLY=
X-Received: by 2002:a05:6214:b65:b0:61b:76dd:b643 with SMTP id
 ey5-20020a0562140b6500b0061b76ddb643mr11145830qvb.4.1684416423374; 
 Thu, 18 May 2023 06:27:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5icqImK1N2iSU9/TYmOsPp0PaUB4j87ozdDFhnc8xlt5X6aQnACBZr/QGRadZC5JHg23sHNg==
X-Received: by 2002:a05:6214:b65:b0:61b:76dd:b643 with SMTP id
 ey5-20020a0562140b6500b0061b76ddb643mr11145800qvb.4.1684416423037; 
 Thu, 18 May 2023 06:27:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 z9-20020a0ce989000000b0061b608dc4c1sm514808qvn.94.2023.05.18.06.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 06:27:02 -0700 (PDT)
Date: Thu, 18 May 2023 09:27:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Fiona Ebner <f.ebner@proxmox.com>,
 Leonardo Bras <leobras@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
Message-ID: <ZGYnpQmc+5Sut3x8@x1n>
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <87jzxf5ki9.fsf@secure.mitica>
 <8c3a4f60-b3ab-7c38-27c0-3f8f2caaeae4@tls.msk.ru>
 <87wn15dgbs.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wn15dgbs.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 18, 2023 at 01:33:43PM +0200, Juan Quintela wrote:
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> > 11.05.2023 11:40, Juan Quintela wrote:
> >> Fiona Ebner <f.ebner@proxmox.com> wrote:
> > ...
> >>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1576
> >>>
> >>> AFAICT, this breaks (forward) migration from 8.0 to 8.0 + this patch
> >>> when using machine type <= 7.2. That is because after this patch, when
> >>> using machine type <= 7.2, the wmask for the register is not set and
> >>> when 8.0 sends a nonzero value for the register, the error condition in
> >>> get_pci_config_device() will trigger again.
> >> I think that works correctly.
> >> See https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02733.html
> >> What we have (before this patch) (using abbrevs as in the doc
> >> before)
> >> Current state:
> >> (1) qemu-8.0 -M pc-8.0 -> qemu-8.0 -M pc-8.0 works
> >>      not affected by the patch
> >> (2) qemu-7.2 -M pc-7.2 -> qemu-8.0 -M pc-8.0 works
> >>      works well because 7.2 don't change that field
> >> (3) qemu-8.0 -M pc-7.2 -> qemu-7.2 -M pc-7.2 fails
> >> With the patch we fixed 3, so once it is in stable, 1 and 2 continue
> >> as
> >> usual and for (3) we will have:
> >> (3) qemu-8.0.1 -M pc-7.2 -> qemu-7.2 -M pc-7.2 works
> >> If what you mean is that:
> >> (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works
> >> Will fail, that is true, but I can think a "sane" way to fix this.
> 
> Hi
> 
> > That's a great summary indeed.
> 
> Thanks.
> 
> >>> Is it necessary to also handle that? Maybe by special casing the error
> >>> condition in get_pci_config_device() to be prepared to accept such a
> >>> stream from 8.0?
> >> Well, we can do that, but it is to the pci maintainers to decide if
> >> that
> >> is "sane".
> >
> > So, can we go from here somewhere? I'd love this fix to be in 8.0.1,
> > either with or without the (un)sane part of the (3) variant above which
> > might fail.  Or else we'll have the same situation in 8.0.1 as we now
> > have in 8.0.0 (the deadline is May-27).
> >
> > We did broke x.y.0 => x.y.1 migration before already like this, such as
> > with 7.2.0=>7.2.1. I'm not saying it's a nice thing to do, just stating
> > a fact. Yes, it is better to avoid such breakage, but.. meh..
> 
> See patch for documentation:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03288.html
> 
> Basically, the best we can do is:
> - get the patch posted.  Fixes everything except:
>   (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works
> 
> And for that, we can document somewhere that we need to launch
> qemu-8.0.1 as:
> 
> $ qemu-8.0.1 -M pc-7.2 -device blah,x-pci-err-unc-mask=on

One thing we can also do to avoid it in the future is simply having someone
do this check around each softfreeze (and we'll also need maintainers be
careful on merging anything that's risky though after softfreeze) rather
than after release (what I did for this time, which is late), try to cover
as much devices as possible. I don't know whether there's a way to always
cover all devices.

I'll volunteer myself for that as long as I'll remember.  Juan, please also
have a check or remind me if I didn't. :)

I am not sure whether I mentioned it somewhere before, but maybe it'll work
if we can also have some way we check migrating each of the vmsd from
old-qemu to new-qemu (and also new->old) covering all devices.  It doesn't
need to be a real migration, just generate the per-device stream and try
loading on the other binary.

It might be an overkill to be part of CI to check each commit, but if
there's some way to check it then at least we can run it also after
softfreeze.  I also don't know whether it'll be easy to achieve it at all,
but I'll think more about it too and update if I found something useful.

> 
> And mark someone that this machine is tainted an can only be migrated to
> qemu's >= qemu-8.0.1.  And that we should reboot it as the user
> convenience. (reboot here means poweroff qemu and poweron it back
> without x-pci-err-unc-mask=on).
> 
> Later, Juan.
> 
> 
> 
> 

-- 
Peter Xu


