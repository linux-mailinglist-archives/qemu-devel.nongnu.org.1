Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7797AE922
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 11:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4LB-0005Ui-AE; Tue, 26 Sep 2023 05:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql4L5-0005UM-RL
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql4L3-0005Ip-S9
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695720400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSwmFEyzHSMgfd1VpCukG6NM+vaSMD2qnmKGT7YswwQ=;
 b=fsQpl/De/Dgy8GDpIIr41SYl8h6h2LmR8bQzsVWsf9XaoDBbPl51cX4lf10xx0sKeusc5Q
 +vqycpHkx1+SssmANi3r09qFdo+CkmTU60xrOfHT+bEy6JI9X0YzJtbWELP5+CwpiuG+PZ
 Tu3zGUE+HfsJ3uGBgxiVTy6qLhJVH8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-ciRIIEtoNiGbR-iiILp8fg-1; Tue, 26 Sep 2023 05:26:39 -0400
X-MC-Unique: ciRIIEtoNiGbR-iiILp8fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC7E3185A797;
 Tue, 26 Sep 2023 09:26:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA41C10EE6C9;
 Tue, 26 Sep 2023 09:26:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D834C21E6900; Tue, 26 Sep 2023 11:26:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
 <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com>
Date: Tue, 26 Sep 2023 11:26:37 +0200
In-Reply-To: <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com> (Zhijian Li's
 message of "Tue, 26 Sep 2023 05:55:10 +0000")
Message-ID: <87ttrhgu9e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 26/09/2023 13:50, Li Zhijian wrote:
>>=20
>>=20
>> On 18/09/2023 22:41, Markus Armbruster wrote:
>>> Functions that use an Error **errp parameter to return errors should
>>> not also report them to the user, because reporting is the caller's
>>> job.=C2=A0 When the caller does, the error is reported twice.=C2=A0 Whe=
n it
>>> doesn't (because it recovered from the error), there is no error to
>>> report, i.e. the report is bogus.
>>>
>>> qemu_rdma_write_flush() violates this principle: it calls
>>> error_report() via qemu_rdma_write_one().=C2=A0 I elected not to
>>> investigate how callers handle the error, i.e. precise impact is not
>>> known.
>>>
>>> Clean this up by converting qemu_rdma_write_one() to Error.
>>>
>>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>>> ---
>>> =C2=A0 migration/rdma.c | 25 +++++++++++--------------
>>> =C2=A0 1 file changed, 11 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index c3c33fe242..9b8cbadfcd 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -2019,9 +2019,8 @@ static int qemu_rdma_exchange_recv(RDMAContext *r=
dma, RDMAControlHeader *head,
>>> =C2=A0=C2=A0 */
>>> =C2=A0 static int qemu_rdma_write_one(QEMUFile *f, RDMAContext *rdma,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int current_index, uint64_=
t current_addr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, Error **errp)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ibv_sge sge;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ibv_send_wr send_wr =3D { 0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ibv_send_wr *bad_wr;
>>=20
>> [...]
>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -2219,7 +2216,7 @@ retry:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto retry;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (ret > 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("rdma migration: pos=
t rdma write failed");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "rdma migr=
ation: post rdma write failed");
>>=20
>> It reminds that do you miss to use error_setg_errno() instead.
>>=20
>
> Answer it myself:
> ibv_post_send(3) says:
>
> RETURN VALUE
>         ibv_post_send() returns 0 on success, or the value of errno on fa=
ilure (which indicates the failure reason).

I read this as "assign error code to errno and return it."  But...

> the global error is not defined here.

... your assertion made me check the source code, and it looks like it
does *not* assign to errno, at least not reliably.  Which means perror()
prints garbage.

I'll delete the perror() in a separate patch.

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }


