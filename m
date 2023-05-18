Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF197084AD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:11:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfH1-0007wj-PQ; Thu, 18 May 2023 11:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzfGw-0007ur-71
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzfGt-0000Kz-VC
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684422627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QQJZV7pGn00rYuJROGnck+p7KpwVNB0FtLS0D3QbZr0=;
 b=Ash3jRhRuM9uJcfSEmiRKwdLicweUsC9PuBRmI4rIi20YG46wTBx7XlWJa+1vtWM94vVGr
 3z71rfI770TJf0t0M+mjVxQ/kF3H/ytHccZ8kGsk0TGw8JGeuE8xTFG6F4e6X3mBCPYbyB
 zbai1yhGjf6jB9HYdsFpCDXhtHJJhfg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-8T7Nr8QcPumfRqVKQvZPKw-1; Thu, 18 May 2023 11:10:25 -0400
X-MC-Unique: 8T7Nr8QcPumfRqVKQvZPKw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso1420364e87.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684422624; x=1687014624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQJZV7pGn00rYuJROGnck+p7KpwVNB0FtLS0D3QbZr0=;
 b=GziJmlZU4bAj7otHe1x16+grlSKW5CggfGN1FBk6PIq1pHdIi2EeKrablU/2BAgllq
 DdvCQeLeZyTih8auSaCkllrqah500K0IoNVPMyC25WU1aDYuNARVyUb0iz5sAs5BSMi2
 QkrxnSCNP7gA200e9o/FyoaJTT7bQSzaLCXB5OBZXHyAEgpt8B1W4/GOU2p0IEM5tpM+
 gsKG6eUgmRalKKQuw3VSldW5HIeRJrtILie2VQvPBiXMheB1uQM/D+TeTijK7n8NfE96
 WrV/bsfMKaTAW8nxOBdJraiBS2ORc6u85bqaZCtHcyXqHGQgIYxWxJC7OsyrTK2GOs6w
 XhNg==
X-Gm-Message-State: AC+VfDxaghK9rnB58k4oJcCAHC0Tk9MPhLfA00KCz92uaCE7ejvCh8E9
 KJVelqEx5dZxZ2dVbGrPgbPdh+XRRUhEuiCgA1wS/pQjlwkaNhbk1zpjQCkNIj66oqeuP1ahcpZ
 offqhqOCRUEI7sCQ=
X-Received: by 2002:ac2:4465:0:b0:4f3:aae3:aedc with SMTP id
 y5-20020ac24465000000b004f3aae3aedcmr83725lfl.9.1684422624044; 
 Thu, 18 May 2023 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52uv3QM7c4Or1piLfBKlgQu3Bf4Ejcm7ogR55fusiOFt29piCaRrV4S/GxVLKyIKqL5fPczA==
X-Received: by 2002:ac2:4465:0:b0:4f3:aae3:aedc with SMTP id
 y5-20020ac24465000000b004f3aae3aedcmr83717lfl.9.1684422623677; 
 Thu, 18 May 2023 08:10:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a19ac0c000000b004eeec1261ecsm285895lfc.31.2023.05.18.08.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:10:23 -0700 (PDT)
Date: Thu, 18 May 2023 11:10:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Fiona Ebner <f.ebner@proxmox.com>, Leonardo Bras <leobras@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
Message-ID: <20230518110755-mutt-send-email-mst@kernel.org>
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <87jzxf5ki9.fsf@secure.mitica>
 <8c3a4f60-b3ab-7c38-27c0-3f8f2caaeae4@tls.msk.ru>
 <87wn15dgbs.fsf@secure.mitica> <ZGYnpQmc+5Sut3x8@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGYnpQmc+5Sut3x8@x1n>
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

On Thu, May 18, 2023 at 09:27:01AM -0400, Peter Xu wrote:
> On Thu, May 18, 2023 at 01:33:43PM +0200, Juan Quintela wrote:
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
> > > 11.05.2023 11:40, Juan Quintela wrote:
> > >> Fiona Ebner <f.ebner@proxmox.com> wrote:
> > > ...
> > >>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1576
> > >>>
> > >>> AFAICT, this breaks (forward) migration from 8.0 to 8.0 + this patch
> > >>> when using machine type <= 7.2. That is because after this patch, when
> > >>> using machine type <= 7.2, the wmask for the register is not set and
> > >>> when 8.0 sends a nonzero value for the register, the error condition in
> > >>> get_pci_config_device() will trigger again.
> > >> I think that works correctly.
> > >> See https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02733.html
> > >> What we have (before this patch) (using abbrevs as in the doc
> > >> before)
> > >> Current state:
> > >> (1) qemu-8.0 -M pc-8.0 -> qemu-8.0 -M pc-8.0 works
> > >>      not affected by the patch
> > >> (2) qemu-7.2 -M pc-7.2 -> qemu-8.0 -M pc-8.0 works
> > >>      works well because 7.2 don't change that field
> > >> (3) qemu-8.0 -M pc-7.2 -> qemu-7.2 -M pc-7.2 fails
> > >> With the patch we fixed 3, so once it is in stable, 1 and 2 continue
> > >> as
> > >> usual and for (3) we will have:
> > >> (3) qemu-8.0.1 -M pc-7.2 -> qemu-7.2 -M pc-7.2 works
> > >> If what you mean is that:
> > >> (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works
> > >> Will fail, that is true, but I can think a "sane" way to fix this.
> > 
> > Hi
> > 
> > > That's a great summary indeed.
> > 
> > Thanks.
> > 
> > >>> Is it necessary to also handle that? Maybe by special casing the error
> > >>> condition in get_pci_config_device() to be prepared to accept such a
> > >>> stream from 8.0?
> > >> Well, we can do that, but it is to the pci maintainers to decide if
> > >> that
> > >> is "sane".
> > >
> > > So, can we go from here somewhere? I'd love this fix to be in 8.0.1,
> > > either with or without the (un)sane part of the (3) variant above which
> > > might fail.  Or else we'll have the same situation in 8.0.1 as we now
> > > have in 8.0.0 (the deadline is May-27).
> > >
> > > We did broke x.y.0 => x.y.1 migration before already like this, such as
> > > with 7.2.0=>7.2.1. I'm not saying it's a nice thing to do, just stating
> > > a fact. Yes, it is better to avoid such breakage, but.. meh..
> > 
> > See patch for documentation:
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03288.html
> > 
> > Basically, the best we can do is:
> > - get the patch posted.  Fixes everything except:
> >   (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works
> > 
> > And for that, we can document somewhere that we need to launch
> > qemu-8.0.1 as:
> > 
> > $ qemu-8.0.1 -M pc-7.2 -device blah,x-pci-err-unc-mask=on
> 
> One thing we can also do to avoid it in the future is simply having someone
> do this check around each softfreeze (and we'll also need maintainers be
> careful on merging anything that's risky though after softfreeze) rather
> than after release (what I did for this time, which is late), try to cover
> as much devices as possible. I don't know whether there's a way to always
> cover all devices.
> 
> I'll volunteer myself for that as long as I'll remember.  Juan, please also
> have a check or remind me if I didn't. :)
> 
> I am not sure whether I mentioned it somewhere before, but maybe it'll work
> if we can also have some way we check migrating each of the vmsd from
> old-qemu to new-qemu (and also new->old) covering all devices.  It doesn't
> need to be a real migration, just generate the per-device stream and try
> loading on the other binary.
> 
> It might be an overkill to be part of CI to check each commit, but if
> there's some way to check it then at least we can run it also after
> softfreeze.  I also don't know whether it'll be easy to achieve it at all,
> but I'll think more about it too and update if I found something useful.

I'm all for more testing but if it does not actually test that the
values loaded are actually used correctly then the testing is of course
lower quality. Better than nothing I guess ...



> > 
> > And mark someone that this machine is tainted an can only be migrated to
> > qemu's >= qemu-8.0.1.  And that we should reboot it as the user
> > convenience. (reboot here means poweroff qemu and poweron it back
> > without x-pci-err-unc-mask=on).
> > 
> > Later, Juan.
> > 
> > 
> > 
> > 
> 
> -- 
> Peter Xu


