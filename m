Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E707CC736
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:15:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsllq-0004xf-Tj; Tue, 17 Oct 2023 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qslll-0004x8-I1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsllh-00043W-LU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697555639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9Tmb5CD4oU5V/uVjtPKkYTxRJcgvM0ILMsEXA1w5EE=;
 b=B2TLSV4DOiKponbeVpQWTJHv+7e2oGXzPrAOQJ/mqXhIt2jKFWaEOmKf6CvJNtkhDIV6N+
 REo9eL/Lr+Y30+uEnX/2K8txK5ZbLKVX4H0Z6oquNIO4DvPDFTZs1vjCr2XAm8wEAoAFWV
 Pupa/J1FHjDRVZDqQ/uNayQdxMHROZs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-vFu-uVpbPmqoS2oRcp6nLg-1; Tue, 17 Oct 2023 11:13:57 -0400
X-MC-Unique: vFu-uVpbPmqoS2oRcp6nLg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-419719b700aso12931011cf.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697555637; x=1698160437;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m9Tmb5CD4oU5V/uVjtPKkYTxRJcgvM0ILMsEXA1w5EE=;
 b=XCcnLihnPohvVS4cRddw7F3e9pee8Jf632Z1HHAX3EgdxZvSvMU0GP9YqKWvFkkmoA
 rc4rKpGl7s03q1iYJDIpGG0YpiuZdv1nLLDBkNEkYektZESKFKOInb4F7tJS1UpYXh7u
 ZG5LG6L4h5KQxKwIm6Yp9qUvsNAbz2LGNkaENhDdqP2sP8+FmDQAdBWUyRFmxdxVMCfI
 /gvAN8RgkIVep8yu0e9b0ZQGFWdjyZL6EjZg+AVmiqDOJCki5X8+rrqIHqZMFrsCHBPw
 fe1jDJsXQWhAM6x+QG0ProdroQPVZVG+66CI4F+Mbvjh1ld+BrNxEmTd+yQetqb2u/Bw
 WVUg==
X-Gm-Message-State: AOJu0YzhmqWchaPymIvyU+i+SWDUD36Y7xJK2u/hFDDM94ltuX6Ccb9X
 QGZhk+exI6e1o+gplhtQtmdyr46iFNuMEie/vWQfcoetB18RcxgW6FIJuMzbhlyG3hlIEcYo/ie
 AcS337Iy1ly17ynQ=
X-Received: by 2002:ac8:5706:0:b0:416:ea40:6e84 with SMTP id
 6-20020ac85706000000b00416ea406e84mr2935618qtw.2.1697555637195; 
 Tue, 17 Oct 2023 08:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnIN5/uV5BVciagmOqigMUJOcFe9VB2nhW2bI42ZM/osphf1fWCZ+c1nIfi/jbGN1+MLl6Ow==
X-Received: by 2002:ac8:5706:0:b0:416:ea40:6e84 with SMTP id
 6-20020ac85706000000b00416ea406e84mr2935588qtw.2.1697555636704; 
 Tue, 17 Oct 2023 08:13:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d8-20020ac847c8000000b0041818df8a0dsm689850qtr.36.2023.10.17.08.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:13:56 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:13:53 -0400
From: Peter Xu <peterx@redhat.com>
To: William Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com
Subject: Re: [PATCH v4 2/2] migration: prevent migration when a poisoned page
 is unknown from the VM
Message-ID: <ZS6ksf8o7dJ8mzUe@x1n>
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
 <20231013150839.867164-3-william.roche@oracle.com>
 <ZS1pSeL3hj4/73lk@x1n>
 <c0af41b7-56dd-4395-8c79-d630ece3b589@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0af41b7-56dd-4395-8c79-d630ece3b589@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 17, 2023 at 02:38:48AM +0200, William Roche wrote:
> On 10/16/23 18:48, Peter Xu wrote:
> > On Fri, Oct 13, 2023 at 03:08:39PM +0000, “William Roche wrote:
> > > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > > index 5e95c496bb..e8db6380c1 100644
> > > --- a/target/arm/kvm64.c
> > > +++ b/target/arm/kvm64.c
> > > @@ -1158,7 +1158,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> > >           ram_addr = qemu_ram_addr_from_host(addr);
> > >           if (ram_addr != RAM_ADDR_INVALID &&
> > >               kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> > > -            kvm_hwpoison_page_add(ram_addr);
> > >               /*
> > >                * If this is a BUS_MCEERR_AR, we know we have been called
> > >                * synchronously from the vCPU thread, so we can easily
> > > @@ -1169,7 +1168,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> > >                * called synchronously from the vCPU thread, or a bit
> > >                * later from the main thread, so doing the injection of
> > >                * the error would be more complicated.
> > > +             * In this case, BUS_MCEERR_AO errors are unknown from the
> > > +             * guest, and we will prevent migration as long as this
> > > +             * poisoned page hasn't generated a BUS_MCEERR_AR error
> > > +             * that the guest takes into account.
> > >                */
> > > +            kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));
> > 
> > I'm curious why ARM doesn't forward this event to guest even if it's AO.
> > X86 does it, and makes more sense to me.
> 
> I agree that forwarding this error is the best option to implement.
> But an important note about this aspect  is that only Intel architecture
> handles the AO error forwarding correctly; currently an AMD VM crashes
> when an AO error relay is attempted.
> 
> That's why we've submitted the following kvm patch:
> https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/
> Among other AMD enhancements to better deal with MCE relay.

I see.

> 
> 
> >  Not familiar with arm, do you
> > know the reason?
> 
> I can't answer this question as I don't know anything about the specific
> 'complications' mentioned in the comment above. Maybe something around
> the injection through ACPI GHES and its interrupt mechanism ??
> But note also that ignoring AO errors is just a question of relying on
> the Hypervisor kernel to generate an AR error when the asynchronously
> poisoned page is touched later. Which can be acceptable -- when the
> system guaranties the AR fault on the page.
> 
> > 
> > I think this patch needs review from ARM and/or KVM side.  Do you want to
> > have the 1st patch merged, or rather wait for the whole set?
> 
> I think that integrating the first patch alone is not an option
> as we would introduce the silent data corruption possibility I
> described.

I asked because I think patch 1 itself is still an improvement, which
avoids src VM from crashing when hitting poisoned pages.  Especially IIUC
on some arch (Intel?) it's a complete fix.

But for sure we can keep them as a whole series if you want, but then it'll
be good you add some more reviewers; at least some ARM/AMD developers,
perhaps.

> It would be better to integrate the two of them as a whole
> set. But the use of the kernel feature you indicated me can change all
> of that !
> 
> > 
> > Another thing to mention: feel free to look at a recent addition of ioctl
> > from userfault, where it can inject poisoned ptes:
> > 
> > https://lore.kernel.org/r/20230707215540.2324998-1-axelrasmussen@google.com
> > 
> > I'm wondering if that'll be helpful to qemu too, where we can migrate
> > hwpoison_page_list and enforce the poisoning on dest.  Then even for AO
> > when accessed by guest it'll generated another MCE on dest.
> 
> I could be missing something, but Yes, this is exactly how I understand
> this kernel feature use case with its description in:
> https://lore.kernel.org/all/20230707215540.2324998-5-axelrasmussen@google.com/
> 
>  vvvvvv
> So the basic way to use this new feature is:
> 
> - On the new host, the guest's memory is registered with userfaultfd, in
>   either MISSING or MINOR mode (doesn't really matter for this purpose).
> - On any first access, we get a userfaultfd event. At this point we can
>   communicate with the old host to find out if the page was poisoned.
> - If so, we can respond with a UFFDIO_POISON - this places a swap marker
>   so any future accesses will SIGBUS. Because the pte is now "present",
>   future accesses won't generate more userfaultfd events, they'll just
>   SIGBUS directly.
>  ^^^^^^
> 
> Thank you for letting me know about this kernel functionality.
> 
> I need to take some time to investigate it, to see how I could use it.

One more hint, please double check though: in QEMU's use case (e.g. precopy
only, while not using postcopy) I think you may even be able to install the
poisoned pte without MISSING (or any other uffd) mode registered.

You can try creating one uffd descriptor (which will bind the desc with the
current mm context; in this case we need it to happen only on dest qemu),
then try injecting poison ptes anywhere in the guest address ranges.

> 
> The solution I'm suggesting here doesn't cover as many cases as the
> UFFDIO_POISON use could help to implement.
> But it gives us a possibility to live migrate VMs that already
> experienced memory errors, trusting the VM kernel to correctly deal with
> these past errors.
> 
> AFAIK, currently, a standard qemu VM that has experienced a memory error
> can't be live migrated at all.

I suppose here you meant AO errors only.

IIUC the major issue regarding migration is AO errors will become ARs on
src qemu when vcpu accessed, which means AOs are all fine if not forwarded
to guest.  However after migration that is not guaranteed.  Poisoned ptes
properly installed on dest basically grants QEMU the ability to "migrate a
poisoned page", meanwhile without really wasting a physical page on dest,
making sure those AO error addrs keep generating ARs even after migration.

It seems the 1st patch is still needed even in this case?

Thanks,

-- 
Peter Xu


