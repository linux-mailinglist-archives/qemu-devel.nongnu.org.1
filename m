Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A237D3FD3
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 21:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv0FM-00074V-F4; Mon, 23 Oct 2023 15:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qv0FK-00073a-L6
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 15:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qv0FI-0000kn-Gl
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 15:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698087946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tHlHfLnGp9x77VLcHdmF3ex8hXUhtqlWdXqoIvugkRk=;
 b=LB9xr1JHuGZaehEmMgtwK1QYEyOVO5DhQAkJbgkIcFL99XXVpS/t+rmbmj4ClMdFJ4tXla
 jiUwRdJBDdZ+IieIPK1YDiGaIPnkiT1zdR5ND2FLUiBKlVU8+mM5GmJNjbJrKrL7KXWSfe
 fvbeiDR+VKLqbQcgKOIjpEFH1NHW1kQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-6Oxe3DsRMBaX--I8R1zcyg-1; Mon, 23 Oct 2023 15:05:29 -0400
X-MC-Unique: 6Oxe3DsRMBaX--I8R1zcyg-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1e9d213d27bso581537fac.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 12:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698087929; x=1698692729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHlHfLnGp9x77VLcHdmF3ex8hXUhtqlWdXqoIvugkRk=;
 b=MjHqEPc1TgL91mdVYuwWV0Cf0iKghIKfYPzpYZmSCQVf9OKxIEq+Wxj58kjXGyG3gL
 cOmAbXXbRLGT0I/BnoIEHLFoxfPMfYcI5Uf6yFqxfVAzkmPZQEgCws5ANgjkENYMHZFJ
 zaOa3qRdoVrSSuXNtFHXi9ysEzjMKbVFuhFOPUGeaK38Z6jXsFl0/DyttBb2NgW4KJCq
 veIXuSIFjyYQGGCQxeAhJaICRoXZ/BMyMDZPLk8ETlHjd1MuUEhGoVioDtq8gOWADSWY
 68CeX4boj6R0t5Aqz8yeYDJtYCL5NKguDoS+MFbObGvk5nv4sZIx/Bfw8rCCQqXXoaLK
 oQ3w==
X-Gm-Message-State: AOJu0YxbKzGfUYJ826uefnSkCYkyfpaOE25e/5SebSpgcu095iI0l92H
 pADh4kk87JHpB8siuzzG3nLqZO5OkP1TOPXd/SEA/9G//gFBmI16429LzylZL2lH98dLmzzgG+i
 sKeeRYLNJvSi9S/w=
X-Received: by 2002:a05:6870:4d17:b0:1e9:8a7e:5893 with SMTP id
 pn23-20020a0568704d1700b001e98a7e5893mr12383691oab.5.1698087928793; 
 Mon, 23 Oct 2023 12:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERzLt9+HFFCW3h0k1K5O3UMXgHU8Y2jhaLmFBLrU8a9DgIg62VCIXYKn/RM5rNrik4tuO/Nw==
X-Received: by 2002:a05:6870:4d17:b0:1e9:8a7e:5893 with SMTP id
 pn23-20020a0568704d1700b001e98a7e5893mr12383665oab.5.1698087928416; 
 Mon, 23 Oct 2023 12:05:28 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 gd14-20020a05622a5c0e00b0041b381b9833sm2929996qtb.75.2023.10.23.12.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 12:05:28 -0700 (PDT)
Date: Mon, 23 Oct 2023 15:05:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
Message-ID: <ZTbD9kL1ggc8UsVK@x1n>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <ZTaTrEPcK2yU8MT5@x1n>
 <389959d5-6d15-4557-839b-575b43bd2ed4@oracle.com>
 <17f8d519-f86f-4857-93c4-080f0b18834b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17f8d519-f86f-4857-93c4-080f0b18834b@oracle.com>
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

On Mon, Oct 23, 2023 at 02:51:50PM -0400, Steven Sistare wrote:
> On 10/23/2023 2:29 PM, Steven Sistare wrote:
> > On 10/23/2023 11:39 AM, Peter Xu wrote:
> >> On Thu, Oct 19, 2023 at 01:47:46PM -0700, Steve Sistare wrote:
> >>> Add the cpr-reboot migration mode.  Usage:
> >>>
> >>> $ qemu-system-$arch -monitor stdio ...
> >>> QEMU 8.1.50 monitor - type 'help' for more information
> >>> (qemu) migrate_set_capability x-ignore-shared on
> >>> (qemu) migrate_set_parameter mode cpr-reboot
> >>> (qemu) migrate -d file:vm.state
> >>> (qemu) info status
> >>> VM status: paused (postmigrate)
> >>> (qemu) quit
> >>>
> >>> $ qemu-system-$arch -monitor stdio -incoming defer ...
> >>> QEMU 8.1.50 monitor - type 'help' for more information
> >>> (qemu) migrate_set_capability x-ignore-shared on
> >>> (qemu) migrate_set_parameter mode cpr-reboot
> >>> (qemu) migrate_incoming file:vm.state
> >>> (qemu) info status
> >>> VM status: running
> >>>
> >>> In this mode, the migrate command saves state to a file, allowing one
> >>> to quit qemu, reboot to an updated kernel, and restart an updated version
> >>> of qemu.  The caller must specify a migration URI that writes to and reads
> >>> from a file.  Unlike normal mode, the use of certain local storage options
> >>> does not block the migration, but the caller must not modify guest block
> >>> devices between the quit and restart.  The guest RAM memory-backend must
> >>> be shared, and the @x-ignore-shared migration capability must be set,
> >>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
> >>> reboot, such as by backing it with a dax device, but this is not enforced.
> >>> The restarted qemu arguments must match those used to initially start qemu,
> >>> plus the -incoming option.
> >>>
> >>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>> ---
> >>>  qapi/migration.json | 16 +++++++++++++++-
> >>>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/qapi/migration.json b/qapi/migration.json
> >>> index 184fb78..2d862fa 100644
> >>> --- a/qapi/migration.json
> >>> +++ b/qapi/migration.json
> >>> @@ -620,9 +620,23 @@
> >>>  #
> >>>  # @normal: the original form of migration. (since 8.2)
> >>>  #
> >>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
> >>> +#              quit qemu, reboot to an updated kernel, and restart an updated
> >>> +#              version of qemu.  The caller must specify a migration URI
> >>> +#              that writes to and reads from a file.  Unlike normal mode,
> >>> +#              the use of certain local storage options does not block the
> >>> +#              migration, but the caller must not modify guest block devices
> >>> +#              between the quit and restart.  The guest RAM memory-backend
> >>> +#              must be shared, and the @x-ignore-shared migration capability
> >>> +#              must be set, to avoid saving it to the file.  Guest RAM must
> >>> +#              be non-volatile across reboot, such as by backing it with
> >>> +#              a dax device, but this is not enforced.  The restarted qemu
> >>> +#              arguments must match those used to initially start qemu, plus
> >>> +#              the -incoming option. (since 8.2)
> >>
> >> What happens if someone migrates with non-shared memory, or without
> >> ignore-shared?  Is it only because it'll be slow saving and loading?
> >>
> >> If that's required, we should fail the mode set if (1) non-shared memory is
> >> used, or (2) x-ignore-shared is not enabled.  But I had a feeling it's the
> >> other way round.
> > 
> > Juan also asked me to clarify this.  I plan to resubmit this:
> > 
> > #                                        ...  Private guest RAM is saved in
> > #              the file.  To avoid this cost, the guest RAM memory-backend
> > #              must be shared, and the @x-ignore-shared migration capability
> > #              must be set.  ...

Okay.  We can also avoid mentioning "private guest RAM is saved to ..."
because that's what migration already does.  IMO we can simplify all that
to:

  It is suggested to use share memory with x-ignore-shared when using this
  mode.

> > 
> >>
> >> Reading the whole series, if it's so far all about "local storage", why
> >> "cpr-reboot"?  Why not "local" or "local storage" as the name?
> > 
> > The use case is about rebooting and updating the host, so reboot is in 
> > the name.  Local storage just happens to be allowed for it.
> > 
> >> I had a feeling that this patchset mixed a lot of higher level use case
> >> into the mode definition.  IMHO we should provide clear definition of each
> >> mode on what it does.  It's so far not so clear to me, even if I kind of
> >> know what you plan to do.
> > 
> > I believe I already have, in the cover letter, commit message, and qapi 
> > definition, at the start of each:
> > 
> > # @cpr-reboot: The migrate command saves state to a file, allowing one to
> > #              quit qemu, reboot to an updated kernel, and restart an updated
> > #              version of qemu.

I think this is why I'm confused: above sentence is describing a very
generic migration to file scenario to me.  IOW, I think I can get the same
result described even with normal migration to file, or am I wrong?

IMHO the description here needs to explain the difference and when an user
should use this mode.  I think the real answer resides in your whole set,
I'll try to read that.

In all cases, can we name it something like "live-upgrade" v.s. "normal"?

> > 
> > The cover letter hints at the cpr-exec use case, and the long V9 patch series
> > describes it, and I will make sure the use case comes first when I submit cpr-exec,
> > which is:
>     * restart an updated version of qemu     (I buried the lead - steve)
> >   * much shorter guest downtime than cpr reboot
> >   * support vfio without requiring guest suspension
> >   * keep certain character devices alive
> > 
> >> I tried again google what CPR is for and found this:
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08541.html
> >>
> >> I also prefer spell it out, at least make it clear on what that means..  I
> >> didn't even see "Checkpoint/restart" words mentioned anywhere in this
> >> patchset.
> > 
> > Will do.
> > 
> >> Besides: do you have a tree somewhere for the whole set of latest CPR work?
> > 
> > I have the V9 patch series:
> >   https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com
> > and I can re-send my proposal for breaking it down into patch sets that I presented in the
> > qemu community meeting, if you did not save it.

No need to resend.  A link is exactly what I need; git tree even better.
I'll comment when I get something when reading that.

Thanks,

-- 
Peter Xu


