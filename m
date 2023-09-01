Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95078FE88
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 15:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc4PR-0003zA-Qz; Fri, 01 Sep 2023 09:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc4PP-0003wv-Rj
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 09:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc4PN-0001GD-ER
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 09:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693575716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9pMmrfgRwoYvBTmwElKtEPkCaTxrEUwluNScO0dHM0=;
 b=Cq48RFIINAPAOtQVVhBiIixvDMnvRdp9cVLs+llQC0MRMU1uOE2Zfs9eueJumOOQLlJl3Z
 7lNduYYExzxZ/vxIa5QIepy0thDFVfht4EyIZUTqvGJFO7QBG7TuoEUlft+KqY9JG/mNXw
 uF96gD1Gvx5zHGq7qJdhl+QkMdauaqI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-CecrKuR8OL6-dKu3wAOgpg-1; Fri, 01 Sep 2023 09:41:54 -0400
X-MC-Unique: CecrKuR8OL6-dKu3wAOgpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2075597D662;
 Fri,  1 Sep 2023 13:41:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C31571460FE5;
 Fri,  1 Sep 2023 13:41:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCA9C21E692A; Fri,  1 Sep 2023 15:41:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  Mattias Nissler <mnissler@rivosinc.com>,
 qemu-devel@nongnu.org,  john.levon@nutanix.com,  Jagannathan Raman
 <jag.raman@oracle.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 armbru@redhat.com
Subject: Re: [PATCH v2 1/4] softmmu: Support concurrent bounce buffers
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
 <20230823092905.2259418-2-mnissler@rivosinc.com>
 <ZOZDQVgboMaiZ4x6@x1n>
 <CAGNS4TY2-scz3pu16tUF1bA-FEk+pe86QsgjW8L=qjidw5TqOQ@mail.gmail.com>
 <ZOZx7vMqFRfaIwSp@x1n> <20230824133245.GA1412804@fedora>
Date: Fri, 01 Sep 2023 15:41:52 +0200
In-Reply-To: <20230824133245.GA1412804@fedora> (Stefan Hajnoczi's message of
 "Thu, 24 Aug 2023 09:32:45 -0400")
Message-ID: <87edjixb6n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, Aug 23, 2023 at 04:54:06PM -0400, Peter Xu wrote:
>> On Wed, Aug 23, 2023 at 10:08:08PM +0200, Mattias Nissler wrote:
>> > On Wed, Aug 23, 2023 at 7:35=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
>> > > On Wed, Aug 23, 2023 at 02:29:02AM -0700, Mattias Nissler wrote:
>> > > > diff --git a/softmmu/vl.c b/softmmu/vl.c
>> > > > index b0b96f67fa..dbe52f5ea1 100644
>> > > > --- a/softmmu/vl.c
>> > > > +++ b/softmmu/vl.c
>> > > > @@ -3469,6 +3469,12 @@ void qemu_init(int argc, char **argv)
>> > > >                  exit(1);
>> > > >  #endif
>> > > >                  break;
>> > > > +            case QEMU_OPTION_max_bounce_buffer_size:
>> > > > +                if (qemu_strtosz(optarg, NULL, &max_bounce_buffer=
_size) < 0) {
>> > > > +                    error_report("invalid -max-ounce-buffer-size =
value");
>> > > > +                    exit(1);
>> > > > +                }
>> > > > +                break;
>> > >
>> > > PS: I had a vague memory that we do not recommend adding more qemu c=
mdline
>> > > options, but I don't know enough on the plan to say anything real.
>> >=20
>> > I am aware of that, and I'm really not happy with the command line
>> > option myself. Consider the command line flag a straw man I put in to
>> > see whether any reviewers have better ideas :)
>> >=20
>> > More seriously, I actually did look around to see whether I can add
>> > the parameter to one of the existing option groupings somewhere, but
>> > neither do I have a suitable QOM object that I can attach the
>> > parameter to, nor did I find any global option groups that fits: this
>> > is not really memory configuration, and it's not really CPU
>> > configuration, it's more related to shared device model
>> > infrastructure... If you have a good idea for a home for this, I'm all
>> > ears.
>>=20
>> No good & simple suggestion here, sorry.  We can keep the option there
>> until someone jumps in, then the better alternative could also come alon=
g.
>>=20
>> After all I expect if we can choose a sensible enough default value, this
>> new option shouldn't be used by anyone for real.
>
> QEMU commits to stability in its external interfaces. Once the
> command-line option is added, it needs to be supported in the future or
> go through the deprecation process. I think we should agree on the
> command-line option now.
>
> Two ways to avoid the issue:
> 1. Drop the command-line option until someone needs it.

Avoiding unneeded configuration knobs is always good.

> 2. Make it an experimental option (with an "x-" prefix).

Fine if actual experiments are planned.

Also fine if it's a development or debugging aid.

> The closest to a proper solution that I found was adding it as a
> -machine property. What bothers me is that if QEMU supports
> multi-machine emulation in a single process some day, then the property
> doesn't make sense since it's global rather than specific to a machine.
>
> CCing Markus Armbruster for ideas.

I'm afraid I'm lacking context.  Glancing at the patch...

    ``-max-bounce-buffer-size size``
        Set the limit in bytes for DMA bounce buffer allocations.
=20=20=20=20
        DMA bounce buffers are used when device models request memory-mappe=
d access
        to memory regions that can't be directly mapped by the qemu process=
, so the
        memory must read or written to a temporary local buffer for the dev=
ice
        model to work with. This is the case e.g. for I/O memory regions, a=
nd when
        running in multi-process mode without shared access to memory.
=20=20=20=20
        Whether bounce buffering is necessary depends heavily on the device=
 model
        implementation. Some devices use explicit DMA read and write operat=
ions
        which do not require bounce buffers. Some devices, notably storage,=
 will
        retry a failed DMA map request after bounce buffer space becomes av=
ailable
        again. Most other devices will bail when encountering map request f=
ailures,
        which will typically appear to the guest as a hardware error.
=20=20=20=20
        Suitable bounce buffer size values depend on the workload and guest
        configuration. A few kilobytes up to a few megabytes are common siz=
es
        encountered in practice.

Sounds quite device-specific.  Why isn't this configured per device?


