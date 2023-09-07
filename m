Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DCE7972F3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 16:06:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeFcg-0000mK-17; Thu, 07 Sep 2023 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeFcc-0000lq-SH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeFca-0006qj-Ab
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694095474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pc25bkwJkTEy/h8D1Y0mOP8YfbDlJKONiPH7nWlaG3k=;
 b=beo9GGBVeUkPQiQvz9YArjDa1aAjgpunKSvZswdeqiFT4+ibpUzovDilAzwT8cC3ye+m5b
 4CP+c2yl/stso4OZPHbnM49jaQNQ1WRqnDbW74a4xyfHbSiMRsosmPepV0KxYPf5zNN0ao
 fESRmEfJfWtgG1wKAPkMPw89cHYF1wA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-dzvvVKVcMy2R2qVSpLanwQ-1; Thu, 07 Sep 2023 10:04:30 -0400
X-MC-Unique: dzvvVKVcMy2R2qVSpLanwQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B96F59565CB;
 Thu,  7 Sep 2023 14:04:29 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E64C404119;
 Thu,  7 Sep 2023 14:04:29 +0000 (UTC)
Date: Thu, 7 Sep 2023 10:04:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 pbonzini@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 1/3] hmp: avoid the nested event loop in handle_hmp_command()
Message-ID: <20230907140428.GB1363873@fedora>
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <20230906190141.1286893-2-stefanha@redhat.com>
 <ZPkiH4WvSs1k43RQ@gallifrey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ks0KT2+o94NcYHHG"
Content-Disposition: inline
In-Reply-To: <ZPkiH4WvSs1k43RQ@gallifrey>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--Ks0KT2+o94NcYHHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 01:06:39AM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > Coroutine HMP commands currently run to completion in a nested event
> > loop with the Big QEMU Lock (BQL) held. The call_rcu thread also uses
> > the BQL and cannot process work while the coroutine monitor command is
> > running. A deadlock occurs when monitor commands attempt to wait for
> > call_rcu work to finish.
>=20
> I hate to think if there's anywhere else that ends up doing that
> other than the monitors.

Luckily drain_call_rcu() has few callers: just
xen_block_device_destroy() and qmp_device_add(). We only need to worry
about their call stacks.

I haven't looked at the Xen code.

>=20
> But, not knowing the semantics of the rcu code, it looks kind of OK to
> me from the monitor.
>=20
> (Do you ever get anything like qemu quitting from one of the other
> monitors while this coroutine hasn't been run?)

Not sure what you mean?

Stefan

>=20
> Dave
>=20
> > This patch refactors the HMP monitor to use the existing event loop
> > instead of creating a nested event loop. This will allow the next
> > patches to rely on draining call_rcu work.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  monitor/hmp.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > index 69c1b7e98a..6cff2810aa 100644
> > --- a/monitor/hmp.c
> > +++ b/monitor/hmp.c
> > @@ -1111,15 +1111,17 @@ typedef struct HandleHmpCommandCo {
> >      Monitor *mon;
> >      const HMPCommand *cmd;
> >      QDict *qdict;
> > -    bool done;
> >  } HandleHmpCommandCo;
> > =20
> > -static void handle_hmp_command_co(void *opaque)
> > +static void coroutine_fn handle_hmp_command_co(void *opaque)
> >  {
> >      HandleHmpCommandCo *data =3D opaque;
> > +
> >      handle_hmp_command_exec(data->mon, data->cmd, data->qdict);
> >      monitor_set_cur(qemu_coroutine_self(), NULL);
> > -    data->done =3D true;
> > +    qobject_unref(data->qdict);
> > +    monitor_resume(data->mon);
> > +    g_free(data);
> >  }
> > =20
> >  void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
> > @@ -1157,20 +1159,20 @@ void handle_hmp_command(MonitorHMP *mon, const =
char *cmdline)
> >          Monitor *old_mon =3D monitor_set_cur(qemu_coroutine_self(), &m=
on->common);
> >          handle_hmp_command_exec(&mon->common, cmd, qdict);
> >          monitor_set_cur(qemu_coroutine_self(), old_mon);
> > +        qobject_unref(qdict);
> >      } else {
> > -        HandleHmpCommandCo data =3D {
> > -            .mon =3D &mon->common,
> > -            .cmd =3D cmd,
> > -            .qdict =3D qdict,
> > -            .done =3D false,
> > -        };
> > -        Coroutine *co =3D qemu_coroutine_create(handle_hmp_command_co,=
 &data);
> > +        HandleHmpCommandCo *data; /* freed by handle_hmp_command_co() =
*/
> > +
> > +        data =3D g_new(HandleHmpCommandCo, 1);
> > +        data->mon =3D &mon->common;
> > +        data->cmd =3D cmd;
> > +        data->qdict =3D qdict; /* freed by handle_hmp_command_co() */
> > +
> > +        Coroutine *co =3D qemu_coroutine_create(handle_hmp_command_co,=
 data);
> > +        monitor_suspend(&mon->common); /* resumed by handle_hmp_comman=
d_co() */
> >          monitor_set_cur(co, &mon->common);
> >          aio_co_enter(qemu_get_aio_context(), co);
> > -        AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
> >      }
> > -
> > -    qobject_unref(qdict);
> >  }
> > =20
> >  static void cmd_completion(MonitorHMP *mon, const char *name, const ch=
ar *list)
> > --=20
> > 2.41.0
> >=20
> >=20
> --=20
>  -----Open up your eyes, open up your mind, open up your code -------  =
=20
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \=20
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
>=20

--Ks0KT2+o94NcYHHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT52GwACgkQnKSrs4Gr
c8iE2AgArmy2eBoH/j5X7oz5MxXO3nCaEJu7w9AvWyUv0YvSCQBGbMN1BC76NF79
3+7T5HEvrcf8EaEkukqtELONvpAKLNqpeUQDNBFS9/sO2EOD64xEokV6Vm8x9Q5m
4bsG0xQYCObyvDMTAllBXAWpY7T30qUzSaN7ONlz6uN8uAjFDApI0lWNWRepE+8b
EqF/ws+5q2Gk0o1PCswQD9jdlQCf9EqFz+Rfj2Nj/dfkhB+HzaWBurJzEBCYHRME
W4ZGGnbnJxkzWa2rzRI6R3lgBknweSTAy1a3HDt/x+m05gyN5Fez/3/6Ra2TV5jm
2NqFHtpjAkFNf7eUE63J367j3ZelYw==
=1ytD
-----END PGP SIGNATURE-----

--Ks0KT2+o94NcYHHG--


