Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83173926E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 00:22:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC6C2-00010k-KR; Wed, 21 Jun 2023 18:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC6C0-00010I-JM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 18:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC6By-00039R-Oe
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 18:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687386045;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cp406WOhdzlUrS4EHZ8ld6Qlh5gICID7k7O3xS/cOSU=;
 b=SRw3oGFw2J+ajZo3JSnol41C0KEnYEVQ0WlTQwzHCeyFVisowVmtAa2fqMnSPvc1nC7Vt2
 bILXQ/Cg+XbQRES+TzflvqnSNJGH5QA+bFKfmjT+HRWF8qgB4iBCXVstCj/HBs50mVWxBy
 YOoUZTRfTwV3oOhu+GmdEk3R8z0h+X4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-YoQ31VhuPPyxrMxj2T287g-1; Wed, 21 Jun 2023 18:20:43 -0400
X-MC-Unique: YoQ31VhuPPyxrMxj2T287g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31283f4d22fso843858f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 15:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687386042; x=1689978042;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cp406WOhdzlUrS4EHZ8ld6Qlh5gICID7k7O3xS/cOSU=;
 b=Ecwki2GN9qnSLSzuUS2o6GOLsvcZagoWTD2XI5cxag5/rqqWFc/Fj1XWCq0l6M0a3W
 pKpoWp6M4Bn7olxrv4MDOHC2mQh+fftFRW2q2SMXxy6Lvb57GPn+OFwyWffuhFsFmb0b
 n405sYqyuhtByjdDNX+v3ib1qX6qGaBS/soTQAXUJ+vvVRRjxm7OA0wajKxZLqvYYEHU
 T8D6sVrFdTB095ZcKpI46yDTmY1WpnQCoM3q+YgMGfvKC5+x3lod+bqQ6VrcPvkJkIQ6
 V3O3ZmWjATd1Rde7nW6mPy6iVAhmHEouYcO2VwOnZUk7YdLYYhC5UJ6SneuQo8c02XSW
 VqPg==
X-Gm-Message-State: AC+VfDyO3eyjb+7n22Csmj1veOFGqSw12LxZkHdtC2sxYR3ta2a689No
 o+uOfl6gR4QCRZeyeGhFVurgorhTFuNBcL+9rq7+nIqdwjYjDO/wlGaUSrwo82/zTZVeUZRW+sC
 0p7pNQqC2qt/ILaE=
X-Received: by 2002:adf:f847:0:b0:309:3af4:8c8c with SMTP id
 d7-20020adff847000000b003093af48c8cmr9918948wrq.54.1687386042611; 
 Wed, 21 Jun 2023 15:20:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bgg4lfZOFAbabg85bkcsH0ncgh7uAQD3gNq8xIXQCs8wBJ2iXyhmvHWlVPqXp3w2G3hVTsA==
X-Received: by 2002:adf:f847:0:b0:309:3af4:8c8c with SMTP id
 d7-20020adff847000000b003093af48c8cmr9918933wrq.54.1687386042204; 
 Wed, 21 Jun 2023 15:20:42 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f14-20020adfe90e000000b003111a9a8dbfsm5441984wrm.44.2023.06.21.15.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 15:20:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  qemu-block@nongnu.org,  Fam Zheng
 <fam@euphon.net>
Subject: Re: [PATCH v2 04/20] qemu-file: We only call
 qemu_file_transferred_* on the sending side
In-Reply-To: <ZInCUphJMtmWLkKq@x1n> (Peter Xu's message of "Wed, 14 Jun 2023
 09:36:18 -0400")
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-5-quintela@redhat.com> <ZH4m8nUAEfZglPLD@x1n>
 <87y1kne4g2.fsf@secure.mitica> <ZInCUphJMtmWLkKq@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 00:20:40 +0200
Message-ID: <87h6r08nk7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Jun 13, 2023 at 06:02:05PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Tue, May 30, 2023 at 08:39:25PM +0200, Juan Quintela wrote:
>> >> Remove the increase in qemu_file_fill_buffer() and add asserts to
>> >> qemu_file_transferred* functions.
>> >>=20
>> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >
>> > The read side accounting does look a bit weird and never caught my not=
ice..
>> >
>> > Maybe worth also touching the document of QEMUFile::total_transferred =
to
>> > clarify what it accounts?
>> >
>> > Reviewed-by: Peter Xu <peterx@redhat.com>
>> >
>> > Though when I'm looking at the counters (didn't follow every single re=
cent
>> > patch on this..), I found that now reading transferred value is actual=
ly
>> > more expensive - qemu_file_transferred() needs flushing, even if for t=
he
>> > fast version, qemu_file_transferred_fast() loops over all possible iov=
s,
>> > which can be as large as MAX_IOV_SIZE=3D=3D64.
>> >
>> > To be explicit, I _think_ for each guest page we now need to flush...
>> >
>> >   ram_save_iterate
>> >     migration_rate_exceeded
>> >       migration_transferred_bytes
>> >         qemu_file_transferred
>> >
>> > I hope I'm wrong..
>>=20
>> See patch 7:
>>=20
>> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
>> index 79eea8d865..1696185694 100644
>> --- a/migration/migration-stats.c
>> +++ b/migration/migration-stats.c
>> @@ -62,7 +62,7 @@ uint64_t migration_transferred_bytes(QEMUFile *f)
>>  {
>>      uint64_t multifd =3D stat64_get(&mig_stats.multifd_bytes);
>>      uint64_t rdma =3D stat64_get(&mig_stats.rdma_bytes);
>> -    uint64_t qemu_file =3D qemu_file_transferred(f);
>> +    uint64_t qemu_file =3D stat64_get(&mig_stats.qemu_file_transferred);
>>=20=20
>>      trace_migration_transferred_bytes(qemu_file, multifd, rdma);
>>      return qemu_file + multifd + rdma;
>
> If this is a known regression, should we make a first patchset fix it and
> make it higher priority to merge?

This is the simpler way that I have found to arrive from A to B.
The reason why I didn't want to enter the atomic vars (and everybody
before) was because it had so many changing bits.

And here we are, moving to single counters instead of several of them
took something like 200 patches.

> It seems this is even not mentioned in the cover letter.. while IMHO this
> is the most important bit to have in it..

My fault.

I cc'd Fiona on v1, and she confirmed that this fixed her problem.

This is the commit that introduces the slowdown.

commit 813cd61669e45ee6d5db09a83d03df8f0c6eb5d2
Author: Juan Quintela <quintela@redhat.com>
Date:   Mon May 15 21:57:01 2023 +0200

    migration: Use migration_transferred_bytes() to calculate rate_limit
=20=20=20=20
    Signed-off-by: Juan Quintela <quintela@redhat.com>
    Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
    Message-Id: <20230515195709.63843-9-quintela@redhat.com>

Important bits:

-    uint64_t rate_limit_used =3D stat64_get(&mig_stats.rate_limit_used);
+    uint64_t rate_limit_start =3D stat64_get(&mig_stats.rate_limit_start);
+    uint64_t rate_limit_current =3D migration_transferred_bytes(f);
+    uint64_t rate_limit_used =3D rate_limit_current - rate_limit_start;
     uint64_t rate_limit_max =3D stat64_get(&mig_stats.rate_limit_max);

We moved from reading an atomic to call qemu_file_transferred(), that
does the iovec dance.

This commit (on this series):

ommit 524072cb5f5ce5605f1171f86ba0879405e4b9b3
Author: Juan Quintela <quintela@redhat.com>
Date:   Mon May 8 12:16:47 2023 +0200

    migration: Use the number of transferred bytes directly
=20=20=20=20
    We only use migration_transferred_bytes() to calculate the rate_limit,
    for that we don't need to flush whatever is on the qemu_file buffer.
    Remember that the buffer is really small (normal case is 32K if we use
    iov's can be 64 * TARGET_PAGE_SIZE), so this is not relevant to
    calculations.
=20=20=20=20
    Signed-off-by: Juan Quintela <quintela@redhat.com>

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 79eea8d865..1696185694 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -62,7 +62,7 @@ uint64_t migration_transferred_bytes(QEMUFile *f)
 {
     uint64_t multifd =3D stat64_get(&mig_stats.multifd_bytes);
     uint64_t rdma =3D stat64_get(&mig_stats.rdma_bytes);
-    uint64_t qemu_file =3D qemu_file_transferred(f);
+    uint64_t qemu_file =3D stat64_get(&mig_stats.qemu_file_transferred);
=20
     trace_migration_transferred_bytes(qemu_file, multifd, rdma);
     return qemu_file + multifd + rdma;

Undoes the damage.

And yes, before you ask, I got this wrong lots of times, have to rebase
and changing order of patches several times O:-)

>>=20
>> > Does it mean that perhaps we simply need "sent and put into send buffe=
r"
>> > more than "what really got transferred"?  So I start to wonder what's =
the
>> > origianl purpose of this change, and which one is better..
>>=20
>> That is basically what patch 5 and 6 do O:-)
>>=20
>> Problem is arriving to something that is bisectable (for correctness)
>> and is easy to review.
>>=20
>> And yes, my choices can be different from the ones tat you do.
>>=20
>> The other reason for the small patches is that:
>> a - sometimes I found a different test where things broke, and have to
>>     bisect
>> b - small patches are much easier to rebase (that I am doing a lot)
>
> That's okay.  Thanks,

Later, Juan.


