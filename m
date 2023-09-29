Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B249E7B2B3A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:34:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm691-0004JF-VV; Fri, 29 Sep 2023 01:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm68x-0004Hy-TP
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm68w-0001hI-CU
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695965665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKufPbBVjlsOEmymByTllmVxOvwUM0QsR0S5BTJ/fYM=;
 b=I90glNqICErpEgHth7AkYFcyxYASqlyzZiDrjNqrCZCQEPe3xIg8D9tsL0s0RBZE5FhiQ7
 GUfKWYRLKJNOHzHZ7edrbxXnpPEAv1qIcTkomrSisZg6Yv99Y2BqT0y1On5PmnhRY9mk/G
 xmq8ScXR6zG18rRarghUL5A22zZkAEY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-DsPOHS95PTOVwsjXku4w4Q-1; Fri, 29 Sep 2023 01:34:22 -0400
X-MC-Unique: DsPOHS95PTOVwsjXku4w4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 654693C0C49A;
 Fri, 29 Sep 2023 05:34:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40B26C154CB;
 Fri, 29 Sep 2023 05:34:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5115821E6904; Fri, 29 Sep 2023 07:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  qemu-ppc@nongnu.org,  qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  David Gibson
 <david@gibson.dropbear.id.au>,  Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 6/8] spapr/drc: Clean up local variable shadowing in
 rtas_ibm_configure_connector()
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-7-clg@kaod.org>
 <9e061471-931c-daf8-ab8f-567ce99f5057@linux.ibm.com>
 <0f407c08-fb59-4a41-e134-4f184b5ec758@kaod.org>
 <CAEuJdmqPg2TnOBE2q3c+FaP5y9g+fwk=9SG+_u17J8d=5mgp+w@mail.gmail.com>
Date: Fri, 29 Sep 2023 07:34:20 +0200
In-Reply-To: <CAEuJdmqPg2TnOBE2q3c+FaP5y9g+fwk=9SG+_u17J8d=5mgp+w@mail.gmail.com>
 (Harsh Prateek Bora's message of "Tue, 19 Sep 2023 18:31:08 +0530")
Message-ID: <87zg15k0f7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Tue, 19 Sept, 2023, 5:33 pm C=C3=A9dric Le Goater, <clg@kaod.org> wrot=
e:
>
>> On 9/19/23 10:29, Harsh Prateek Bora wrote:
>> >
>> >
>> > On 9/18/23 20:28, C=C3=A9dric Le Goater wrote:
>> >> Remove extra 'drc_index' variable to avoid this warning :
>> >>
>> >>    ../hw/ppc/spapr_drc.c: In function =E2=80=98rtas_ibm_configure_con=
nector=E2=80=99:
>> >>    ../hw/ppc/spapr_drc.c:1240:26: warning: declaration of =E2=80=98dr=
c_index=E2=80=99
>> shadows a previous local [-Wshadow=3Dcompatible-local]
>> >>     1240 |                 uint32_t drc_index =3D spapr_drc_index(drc=
);
>> >>          |                          ^~~~~~~~~
>> >>    ../hw/ppc/spapr_drc.c:1155:14: note: shadowed declaration is here
>> >>     1155 |     uint32_t drc_index;
>> >>          |              ^~~~~~~~~
>> >>
>> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> >> ---
>> >>   hw/ppc/spapr_drc.c | 2 --
>> >>   1 file changed, 2 deletions(-)
>> >>
>> >> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> >> index b5c400a94d1c..843e318312d3 100644
>> >> --- a/hw/ppc/spapr_drc.c
>> >> +++ b/hw/ppc/spapr_drc.c
>> >> @@ -1237,8 +1237,6 @@ static void
>> rtas_ibm_configure_connector(PowerPCCPU *cpu,
>> >>           case FDT_END_NODE:
>> >>               drc->ccs_depth--;
>> >>               if (drc->ccs_depth =3D=3D 0) {
>> >> -                uint32_t drc_index =3D spapr_drc_index(drc);
>> >> -
>> > I guess you only wanted to remove re-declaration part. Assigning the
>>
>> value returned by this function doesnt seem to happen before.
>>
>> drc_index is assigned at the top of this large routine with :
>>
>>      drc_index =3D rtas_ld(wa_addr, 0);
>>      drc =3D spapr_drc_by_index(drc_index);
>>
>>
>> So, the extra local variable 'drc_index' is simply redundant because
>> there are no reason for it to change. The drc object is the same AFAICT.
>> Correct ? I should have explained that better in the commit log.
>>
>
> Okay, since both routines were implemented differently, I wasn't sure abo=
ut
> the impact of reassignment. Better commit log is always welcome.

Do you expect a respin?  If not, would you like to give your R-by?


