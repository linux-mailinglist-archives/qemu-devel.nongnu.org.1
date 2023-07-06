Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA974A4A4
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVDa-0008Lo-LC; Thu, 06 Jul 2023 16:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHVDY-0008LK-79
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHVDW-0004ZQ-LT
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688673877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=esjILQxvACfP+Geb3schWtcLox5IMdEaEPGt2r68vqc=;
 b=A6L4IFwMIebBCgV5qDRL5LDdnS9YZRHTMSUvnJComoL9rZg4rUV6Gz4evxjOWkRWyoir1i
 n7MUudUjS/UMLOYxnHiOL0+jVlmdvwYT6JwE3JhVOHMwvH+1VgS+PWpzEqn2BoLZ8BFVrb
 8B7ZBr/ZDLeZgbNkXf+e9RKdnv+DOYw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-0-OBvl3fNeKFjXKmblo5rg-1; Thu, 06 Jul 2023 16:01:06 -0400
X-MC-Unique: 0-OBvl3fNeKFjXKmblo5rg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31455dcc30eso254890f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 13:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688673653; x=1691265653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esjILQxvACfP+Geb3schWtcLox5IMdEaEPGt2r68vqc=;
 b=kowkN+Lp1MKFC54SxAwMP3b5U8jQKpyB/QxMMgVT/Vm6scaKt/r4nRDJkcsABzRRvv
 8f/Iv3p7Pk0gNkfUslR09hOR4g6mz3Ui8FSq20abGfdLWFZ4Y4aQIps+s+EpG0BAAQg/
 2pxSHABo9tXp/DeNX48jnVhTVp7kjEWNfugcRs6nAZ+NKEAnrtdooq5R8xvwZHLVBgOS
 xPy5IAabnBWzqFp73a8v+VlktkcFvZhpwgvwzC1cBoX0kCXLEQNzGKaegeL8UJb5Qb2T
 BNeb81xLP/fQMU4cAIUuIdn+DNLxz7D0btIM+E6LeIo1IbEP5y43hhMmg5Gb5ULAr+3y
 HCxg==
X-Gm-Message-State: ABy/qLaH+XZvz9ApLTytOnDa4h71PHTfHt4xDpRPpywoyHRtylebPEC3
 r3D6Hpmvb+q4fWWCBFmrsZCzrMDHaqk0jvMFEPw/S4nhh7JhLWfe2F+Ddyyk7hMzOl9gRzS947f
 ydDkLDyKpL2yV4rs=
X-Received: by 2002:a5d:4a52:0:b0:314:4482:9b44 with SMTP id
 v18-20020a5d4a52000000b0031444829b44mr3068277wrs.5.1688673653057; 
 Thu, 06 Jul 2023 13:00:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlmScm+VXHqLNjK0/Aq+eAogJLy86BEqxH8IMnx2CcAwPzldFTDe059XgG1+bLqaixVBbQNA==
X-Received: by 2002:a5d:4a52:0:b0:314:4482:9b44 with SMTP id
 v18-20020a5d4a52000000b0031444829b44mr3068265wrs.5.1688673652755; 
 Thu, 06 Jul 2023 13:00:52 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c230a00b003fae92e7a8dsm447842wmo.27.2023.07.06.13.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 13:00:52 -0700 (PDT)
Date: Thu, 6 Jul 2023 16:00:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Leonardo Bras Soares Passos <leobras@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Message-ID: <20230706155936-mutt-send-email-mst@kernel.org>
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n>
 <20230706144844-mutt-send-email-mst@kernel.org>
 <ZKcPr3gueuOM4LGY@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKcPr3gueuOM4LGY@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 06, 2023 at 03:02:07PM -0400, Peter Xu wrote:
> On Thu, Jul 06, 2023 at 02:50:20PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 06, 2023 at 02:14:37PM -0400, Peter Xu wrote:
> > > On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Passos wrote:
> > > > > I asked the same question, and I still keep confused: whether there's a
> > > > > first bad commit?  Starting from when it fails?
> > > > >
> > > > > For example, is this broken on 6.0 binaries too with pc-q35-6.0?
> > > > 
> > > > I tested for qemu 6.0, and it still reproduces, but have not pursued
> > > > this any further.
> > > 
> > > I see, thanks!
> > > 
> > > But then do you know why it's never hit before?  I assume it means this bug
> > > has been there for a long time.
> > 
> > It's a race - you have to migrate after the bit has been set before
> > the bit got cleared.
> > cmask is exactly for bits that qemu modifies itself.
> 
> Michael, do you mean that Leo's patch is wrong?


I mean his patch is exactly right. cmask was designed with this
kind of use case in mind.
Will queue.

> I just got understood why it got cleared - I think Leo didn't mention that
> the device was actually offlined before migration, IIUC that's why the PDS
> bit got cleared, if PDS was trying to describe that of the slot.
> 
> According to:
> 
>     /* Used to enable checks on load. Note that writable bits are
>      * never checked even if set in cmask. */
>     uint8_t *cmask;
> 
> It does sound reasonable to me to have PDS cleared when device offlined.
> Since hypervisor doesn't really know what the condition the slot presence
> bit would be when migrating, it seems we should just clear the bit in
> cmask.
> 
> So with the last reply from Leo, the patch looks all right to me.  It's
> just that as Leo mentioned, we should mention the offline process if that's
> the case, because that's definitely an important step to reproduce the issue.
> 
> Thanks,

If you want to suggest more text to the commit log, for the benefit
of backporters, that is fine by me.

> -- 
> Peter Xu


