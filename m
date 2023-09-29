Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1347B2B43
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:39:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6DY-0006iQ-2c; Fri, 29 Sep 2023 01:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6DW-0006iF-6K
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6DU-0002Rb-M7
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695965948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOBUQx8bzaeE9e1wDidEi84x8IDXsIR2+lHmLZ6CVXk=;
 b=AcWZpBEv/KPO8vq9dxxN+FTr8huMlUX0SPSS0BzKSE0JuW4X9teSkm4zdlBZSEXJfWwBM0
 vwp+K1ao96mIddZf16uoYyftwbGF4vDEioqms80YnTgrVSH/EUXAfgSdhTtGbApMxeZOJ8
 npEsCKOIVusczNQS06nWtgZgRNNe6Vw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-p2AGxy7bPf2bmAR0LKdUpw-1; Fri, 29 Sep 2023 01:39:02 -0400
X-MC-Unique: p2AGxy7bPf2bmAR0LKdUpw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97411185A79B;
 Fri, 29 Sep 2023 05:39:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7324840C6EBF;
 Fri, 29 Sep 2023 05:39:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 709C421E6904; Fri, 29 Sep 2023 07:39:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  qemu-ppc@nongnu.org,  qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  David Gibson
 <david@gibson.dropbear.id.au>,  Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 8/8] spapr/drc: Clean up local variable shadowing in
 prop_get_fdt()
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-9-clg@kaod.org>
 <660b5c89-d219-1e20-9fa5-1b7c390a2f1b@linux.ibm.com>
 <e5480b29-a1d0-8d6f-54b7-a8957f568ed9@kaod.org>
 <CAEuJdmqTUOS13mfxVKnMyoeE6vtLAkReohHn31+cz85ZV0s5pA@mail.gmail.com>
Date: Fri, 29 Sep 2023 07:39:00 +0200
In-Reply-To: <CAEuJdmqTUOS13mfxVKnMyoeE6vtLAkReohHn31+cz85ZV0s5pA@mail.gmail.com>
 (Harsh Prateek Bora's message of "Tue, 19 Sep 2023 18:25:43 +0530")
Message-ID: <87v8btk07f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Harsh Prateek Bora <harsh.prateek.bora@gmail.com> writes:

> On Tue, 19 Sept, 2023, 5:39 pm C=C3=A9dric Le Goater, <clg@kaod.org> wrot=
e:
>
>> On 9/19/23 10:48, Harsh Prateek Bora wrote:
>> >
>> >
>> > On 9/18/23 20:28, C=C3=A9dric Le Goater wrote:
>> >> Rename 'name' variable to avoid this warning :
>> >>
>> >>    ../hw/ppc/spapr_drc.c: In function =E2=80=98prop_get_fdt=E2=80=99:
>> >>    ../hw/ppc/spapr_drc.c:344:21: warning: declaration of =E2=80=98nam=
e=E2=80=99 shadows
>> a parameter [-Wshadow=3Dcompatible-local]
>> >>      344 |         const char *name =3D NULL;
>> >>          |                     ^~~~
>> >>    ../hw/ppc/spapr_drc.c:325:63: note: shadowed declaration is here
>> >>      325 | static void prop_get_fdt(Object *obj, Visitor *v, const ch=
ar
>> *name,
>> >>          |
>> ~~~~~~~~~~~~^~~~
>> >>
>> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> >> ---
>> >>   hw/ppc/spapr_drc.c | 10 +++++-----
>> >>   1 file changed, 5 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> >> index 843e318312d3..2b99d3b4b1a6 100644
>> >> --- a/hw/ppc/spapr_drc.c
>> >> +++ b/hw/ppc/spapr_drc.c
>> >> @@ -341,7 +341,7 @@ static void prop_get_fdt(Object *obj, Visitor *v,
>> const char *name,
>> >>       fdt_depth =3D 0;
>> >>       do {
>> >> -        const char *name =3D NULL;
>> >> +        const char *dt_name =3D NULL;
>> >
>> > I guess you wanted to use the input arg "name" here without
>> re-declaration.
>>
>> I don't understand. I don't want to use the input arg "name" here.
>> It seems useless in this case.
>>
>
> Yeh, I realize now. This patch can actually remove the unused arg "name" =
as
> well?

C=C3=A9dric?

Lose ends like this one make me reluctant to queue a series, even when
they look minor to me.

>> C.
>>
>> > I do not see "name" being used elsewhere in this routine.
>> >
>> > regards,
>> > Harsh
>> >>           const struct fdt_property *prop =3D NULL;
>> >>           int prop_len =3D 0, name_len =3D 0;
>> >>           uint32_t tag;
>> >> @@ -351,8 +351,8 @@ static void prop_get_fdt(Object *obj, Visitor *v,
>> const char *name,
>> >>           switch (tag) {
>> >>           case FDT_BEGIN_NODE:
>> >>               fdt_depth++;
>> >> -            name =3D fdt_get_name(fdt, fdt_offset, &name_len);
>> >> -            if (!visit_start_struct(v, name, NULL, 0, errp)) {
>> >> +            dt_name =3D fdt_get_name(fdt, fdt_offset, &name_len);
>> >> +            if (!visit_start_struct(v, dt_name, NULL, 0, errp)) {
>> >>                   return;
>> >>               }
>> >>               break;
>> >> @@ -369,8 +369,8 @@ static void prop_get_fdt(Object *obj, Visitor *v,
>> const char *name,
>> >>           case FDT_PROP: {
>> >>               int i;
>> >>               prop =3D fdt_get_property_by_offset(fdt, fdt_offset,
>> &prop_len);
>> >> -            name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
>> >> -            if (!visit_start_list(v, name, NULL, 0, errp)) {
>> >> +            dt_name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
>> >> +            if (!visit_start_list(v, dt_name, NULL, 0, errp)) {
>> >>                   return;
>> >>               }
>> >>               for (i =3D 0; i < prop_len; i++) {


