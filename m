Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E51AF7A2306
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBCP-0003pU-Ls; Fri, 15 Sep 2023 11:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qhBCL-0003f8-O8
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qhBCK-0003mF-7o
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694793455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dpeTD/kOaSY69EXt0DrLHveer7V6JgBE760GZsZK7cw=;
 b=L6CZEDFAo8jv8zMvRAdxjQOcYSB414zVHLMQ/HjScbxa5PgownDYRSuhtEVfBRteYeY3IE
 k8Zbs+MAaf8jr43wrAcKMqHSkjgqVknuK+nMmVJ0pqQdC+IOefNnCbeTvfpHnSiszj7oWJ
 Dqk9p8OIGR202cmrqaAc1aVGebgxC+A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-U2DbvFr1OiSH_iOCCUM0AA-1; Fri, 15 Sep 2023 11:57:34 -0400
X-MC-Unique: U2DbvFr1OiSH_iOCCUM0AA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6561d472234so4212506d6.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793454; x=1695398254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpeTD/kOaSY69EXt0DrLHveer7V6JgBE760GZsZK7cw=;
 b=P0lj9mgtC1Wu3gKABk5yEPPesx59pLg+/2ra8lI42Uvf+iCZQtocLqJwKgX3KdppG6
 p9QDMzGhd7tbaExV5PtJ4OFY3ge2CTT5HjRjaimfa93QF3llttcnGEZ3ZyZ4IqL7z3MT
 UWw/znzA2ZfSOk3hiYQ2933r+BN5r4MdaX/NU19i9giFFkKp1x5TmhHIMWb/KDLHOCvx
 HbFrz4E866kIWY3eBrCTIcVvabviQIm9y9WmoAS0/gFpErs7/yizZ13R5LzVtZG8TfOH
 5j9MbEhoC4orioWO4GI2IjAvgtemR+T3j2lI3Wr1LbTkpYCr0pbRTfWbnTXIn8wrPisW
 eq3A==
X-Gm-Message-State: AOJu0Yx4qXwjozIoWtV2fBhGx7c271ZU5chVcDlEu8WdkgEaZZrVdzZc
 cLShvPhFfQuIm1q6eNiQ32jUQZakaCHzruRObke3JVTyxVn9cm80wSxpBXK34/zXnNjPfaFmAkX
 9q6C/iNA+22oVloA=
X-Received: by 2002:a05:6214:1249:b0:656:308b:98d2 with SMTP id
 r9-20020a056214124900b00656308b98d2mr2427999qvv.0.1694793453861; 
 Fri, 15 Sep 2023 08:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiYcLS1+ho9iDvoXlyvAcw1Ax8y41T5dfgS4gM2W1j++liUMgpcju6UcWRyRKKOrMmvEOtZQ==
X-Received: by 2002:a05:6214:1249:b0:656:308b:98d2 with SMTP id
 r9-20020a056214124900b00656308b98d2mr2427982qvv.0.1694793453494; 
 Fri, 15 Sep 2023 08:57:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v17-20020a0ca791000000b0064f378f89a7sm1376238qva.73.2023.09.15.08.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:57:33 -0700 (PDT)
Date: Fri, 15 Sep 2023 11:57:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/5] softmmu: Support concurrent bounce buffers
Message-ID: <ZQR+62uSJlt/QQOn@x1n>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-3-mnissler@rivosinc.com>
 <ZQIJeaZPnzSAMZyk@x1n>
 <CAGNS4TYKVesUYepbwsLPi_-ST=c-2+=QDf5oHKhJp_UGLbXhrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGNS4TYKVesUYepbwsLPi_-ST=c-2+=QDf5oHKhJp_UGLbXhrg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 15, 2023 at 11:32:31AM +0200, Mattias Nissler wrote:
> > > @@ -3105,7 +3105,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
> > >      as->ioeventfds = NULL;
> > >      QTAILQ_INIT(&as->listeners);
> > >      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> > > -    as->bounce.in_use = false;
> > > +    as->max_bounce_buffer_size = 4096;
> >
> > Instead of hard-code this 4k again (besides the pci property), maybe we can
> > have address_space_init_with_bouncebuffer() and always pass it in from pci
> > do_realize?  Then by default no bounce buffer supported for the AS only if
> > requested.
> 
> I haven't verified in a running configuration, but I believe bounce
> buffering is also used with non-PCI code, for example
> sysbus_ahci_realize grabs &address_space_memory. So, IMO it makes
> sense to keep at the old default for non-PCI address spaces, unless we
> create additional knobs to set the limit for these?

Oh okay, in that case do we want to have a macro defining the default for
all (as 4K), then also use the macro in the pci property for the default
value?  Maybe it's slightly better than the hard-coded.

> > > +            /* Write bounce_buffer_size before reading map_client_list. */
> > > +            smp_mb();
> >
> > I know it comes from the old code.. but I don't know why this is needed;
> > mutex lock should contain an mb() already before the list iterations later.
> > Just to raise it up, maybe Paolo would like to comment.
> 
> Hm, are you sure that qemu_mutex_lock includes a full memory barrier?

No. :)

> The atomics docs say that pthread_mutex_lock is guaranteed to have
> acquire semantics, but that doesn't guarantee that previous writes are
> visible elsewhere. We need a release of bounce_buffer_size and an
> acquire of map_client_list. The latter is implied by qemu_mutex_lock,
> so I could arguably change this to smp_wmb().

Yeah I think I made such mistake before, sorry.  I think some day I looked
into x86 impl and I believe it was mb() there but I always kept that
impression in mind that it will always be, but not really.  I think you're
right that mutex_lock semantics only guarantees an REQUIRE, and that's not
the same as mb(), at least not always.

Changing it to wmb() makes sense to me but indeed that may be more suitable
for another patch.  Maybe easier to just leave it as-is as it shouldn't be
super hot path anyway.

Thanks,

-- 
Peter Xu


