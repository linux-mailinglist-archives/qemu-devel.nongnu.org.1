Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5B7B3403
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 15:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmDxl-0005Gt-F9; Fri, 29 Sep 2023 09:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDxh-0005Fp-QY
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDxd-00063p-7m
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695995716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6P4KgJQBGdDcFdO9sb3G/xIZASen918S6QSBLo14es=;
 b=R0Lm5pDvvllWE4ug79QCAbikYVnva7tpEV8qKZSVUjLtj76vjUPjw9Y3NszI6ip92GyaRW
 3e+qAMrjnjbED+N+Df/RqairMjqmAfd8Tqq9UhEjTD8don4NxOeiY5C98B/yxgOZ3t25hW
 +wH+fw1YQZUMbNSl3qug5qjTzRlsbeg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-k2H-W8sNNYeKWGuQeZwOGQ-1; Fri, 29 Sep 2023 09:55:12 -0400
X-MC-Unique: k2H-W8sNNYeKWGuQeZwOGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7ED32810D60
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:55:11 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E97440C2064;
 Fri, 29 Sep 2023 13:55:11 +0000 (UTC)
Date: Fri, 29 Sep 2023 15:55:10 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 8/9] qapi: golang: Add CommandResult type to Go
Message-ID: <ygdyvgf4aqwr4usdxkrwbh6n2cxq6hbkun6psa45njbwhd3zck@2pn37qd5snsh>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-9-victortoso@redhat.com>
 <ZRWVsIK7lDr+WX78@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5ulmuogekf6zzijd"
Content-Disposition: inline
In-Reply-To: <ZRWVsIK7lDr+WX78@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--5ulmuogekf6zzijd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 04:03:12PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:43PM +0200, Victor Toso wrote:
> > This patch adds a struct type in Go that will handle return values
> > for QAPI's command types.
> >=20
> > The return value of a Command is, encouraged to be, QAPI's complex
> > types or an Array of those.
> >=20
> > Every Command has a underlying CommandResult. The EmptyCommandReturn
> > is for those that don't expect any data e.g: `{ "return": {} }`.
> >=20
> > All CommandReturn types implement the CommandResult interface.
> >=20
> > Example:
> > qapi:
> >     | { 'command': 'query-sev', 'returns': 'SevInfo',
> >     |   'if': 'TARGET_I386' }
> >=20
> > go:
> >     | type QuerySevCommandReturn struct {
> >     |     CommandId string     `json:"id,omitempty"`
> >     |     Result    *SevInfo   `json:"return"`
> >     |     Error     *QapiError `json:"error,omitempty"`
> >     | }
> >=20
> > usage:
> >     | // One can use QuerySevCommandReturn directly or
> >     | // command's interface GetReturnType() instead.
> >     |
> >     | input :=3D `{ "return": { "enabled": true, "api-major" : 0,` +
> >     |                        `"api-minor" : 0, "build-id" : 0,` +
> >     |                        `"policy" : 0, "state" : "running",` +
> >     |                        `"handle" : 1 } } `
> >     |
> >     | ret :=3D QuerySevCommandReturn{}
> >     | err :=3D json.Unmarshal([]byte(input), &ret)
> >     | if ret.Error !=3D nil {
> >     |     // Handle command failure {"error": { ...}}
> >     | } else if ret.Result !=3D nil {
> >     |     // ret.Result.Enable =3D=3D true
> >     | }
> >=20
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/golang.py | 72 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 70 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > index 52a9124641..48ca0deab0 100644
> > --- a/scripts/qapi/golang.py
> > +++ b/scripts/qapi/golang.py
> > @@ -40,6 +40,15 @@
> >  '''
> > =20
> >  TEMPLATE_HELPER =3D '''
> > +type QapiError struct {
>=20
> QAPIError as the name for this

Agreed. I'll fix it.

> > +    Class       string `json:"class"`
> > +    Description string `json:"desc"`
> > +}
>=20
> > +
> > +func (err *QapiError) Error() string {
> > +    return fmt.Sprintf("%s: %s", err.Class, err.Description)
> > +}
>=20
> My gut feeling is that this should be just
>=20
>     return err.Description
>=20
> on the basis that long ago we pretty much decided that the
> 'Class' field was broadly a waste of time  except for a
> couple of niche use cases. The error description is always
> self contained and sufficient to diagnose problems, without
> knowing the Class.
>=20
> Keep the Class field in the struct though, as it could be
> useful to check in certain cases

I'll trust you on this. I'll change it.

Cheers,
Victor

--5ulmuogekf6zzijd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUW1z4ACgkQl9kSPeN6
SE9frw/+PXJ/GK4sCGBnJv0kQbvx46++XCKz/GK8X/4JQ/Iy7mc9+bK1tmWAklrW
Gx7y/89xgEO5m3bKvXV66hhYyWAhLH/VUCHHfMrigPzKNOTaWnq5252ngGFKkkA9
zeov6XwpJtx1ltHziNIEak75Gwb9XGv9YQZjLozZN2ZzAw2xdcENZZkePIlVmwYe
tbw0q7Q4whiwHlGPw13eKOkUZVA5COCzfMU1bTkbOgq6xd4mwJhGN6dOE396hb0F
i5X97SHaUAlLxQny/zUNcmDq3gUwSegi2F3dzvzSnN6johdsV32DNu22zZyKwLAN
esbW0A3khu1ZhhO9RhjXQjvGhPMPC4qZXehQuBUEJxS8i0B3b1GVbIc6GtnEorE1
FS3wQrCUKvkh2aOJJecb6RJTUJ1gYJWHvwooUgNcVECydjFs+N5KF6u7LsWhNRDB
LRY44GaHJU2BuF+OxcYlZccIBoQQjEkc5eucuQKKYAyNeg8qCIC82JL9uPrLI9Dx
L14D2xnlArfZNPu/yQu8sVR/F2veETu4LFdTqDO7dIYvRGNGR7CVTzg8K30pK3Su
YqjAf3CpYQmfmvVlz9Q/VHeipaT4Llc94AzvPost2K1xeXtWzPWW2+edIh3Q5uM7
a9VFqEfo4Opto6uVr9ZvUwiF7H9jMWs3qXG1YrzLG6J21ixb+RI=
=fvRj
-----END PGP SIGNATURE-----

--5ulmuogekf6zzijd--


