Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC97E7206
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:13:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ATO-00035B-At; Thu, 09 Nov 2023 14:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1ATK-00034l-IH
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:13:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1ATG-00029K-MT
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699557221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0U9VpE3cT60untvV4n73k6nZodXWYhMqo9T83VsAVq0=;
 b=OGmd3AdpZwWnn1eNHpFcVhcGQkCP+Cy/LcyDu3VSq7F9I/T82bgPj+u7GFmuFo0U7wtreM
 Ooyej4HOP6QuhT8E4d4kesYpetR4iHT2jx/fPxdPw9MEcQY8VgbAM5mLiEkf4FHpXkUJxk
 EKOnOc09vG0RckGtTwVd7fr3GyXvF/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-11O7PslrPpeoxlpVrL_NJg-1; Thu, 09 Nov 2023 14:13:40 -0500
X-MC-Unique: 11O7PslrPpeoxlpVrL_NJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBF66185A787
 for <qemu-devel@nongnu.org>; Thu,  9 Nov 2023 19:13:39 +0000 (UTC)
Received: from localhost (unknown [10.45.226.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDAE2026D68;
 Thu,  9 Nov 2023 19:13:39 +0000 (UTC)
Date: Thu, 9 Nov 2023 20:13:38 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 08/11] qapi: golang: Generate qapi's event types in Go
Message-ID: <72qoq2br3qqf5fn3e2lwbwy4eqeffckpyweqdk7oxpmn6ad43t@fabzivfwkesw>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-9-victortoso@redhat.com>
 <CABJz62PJHOY8CLNe-xOrDqRupWMxVCz08WvaxY7tfg8e2WwOpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mjojocti3dri3igg"
Content-Disposition: inline
In-Reply-To: <CABJz62PJHOY8CLNe-xOrDqRupWMxVCz08WvaxY7tfg8e2WwOpg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_LITECOIN_ID=0.5, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--mjojocti3dri3igg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 09, 2023 at 09:59:50AM -0800, Andrea Bolognani wrote:
> On Mon, Oct 16, 2023 at 05:27:01PM +0200, Victor Toso wrote:
> > This patch handles QAPI event types and generates data structures in
> > Go that handles it.
> >
> > We also define a Event interface and two helper functions MarshalEvent
> > and UnmarshalEvent.
> >
> > Example:
> > qapi:
> >  | { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
> >  |   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }
> >
> > go:
> >  | type MemoryDeviceSizeChangeEvent struct {
> >  |         MessageTimestamp Timestamp `json:"-"`
> >  |         Id               *string   `json:"id,omitempty"`
> >  |         Size             uint64    `json:"size"`
> >  |         QomPath          string    `json:"qom-path"`
> >  | }
> >
> > usage:
> >  | input :=3D `{"event":"MEMORY_DEVICE_SIZE_CHANGE",` +
> >  | `"timestamp":{"seconds":1588168529,"microseconds":201316},` +
> >  | `"data":{"id":"vm0","size":1073741824,"qom-path":"/machine/unattache=
d/device[2]"}}`
> >  | e, err :=3D UnmarshalEvent([]byte(input)
> >  | if err !=3D nil {
> >  |     panic(err)
> >  | }
> >  | if e.GetName() =3D=3D `MEMORY_DEVICE_SIZE_CHANGE` {
> >  |     m :=3D e.(*MemoryDeviceSizeChangeEvent)
> >  |     // m.QomPath =3D=3D "/machine/unattached/device[2]"
> >  | }
>=20
> I don't think we should encourage people to perform string
> comparisons, as it completely sidesteps Go's type system and is
> thus error-prone. Safer version:
>=20
>   switch m :=3D e.(type) {
>   case *MemoryDeviceSizeChangeEvent:
>     // m.QomPath =3D=3D "/machine/unattached/device[2]"
>   }

I agree.

> Now, I'm not sure I would go as far as suggesting that the
> GetName() function should be completely removed, but maybe we
> can try leaving it out from the initial version and see if
> people start screaming?

It might be useful for debugging too. I would rather log
e.GetName() than the string version of the type but if that's the
only reason we needed, I agree on removing for now.
=20
> API-wise, I'm not a fan of the fact that we're forcing users to call
> (Un)MarshalEvent instead of the standard (Un)MarshalJSON. If we add
> something like
>=20
>   func GetEventType(data []byte) (Event, error) {
>     type event struct {
>       Name string `json:"event"`
>     }
>=20
>     tmp :=3D event{}
>     if err :=3D json.Unmarshal(data, &tmp); err !=3D nil {
>       return nil, err
>     }
>=20
>     switch tmp.Name {
>     case "MEMORY_DEVICE_SIZE_CHANGE":
>             return &MemoryDeviceSizeChangeEvent{}, nil
>     ...
>     }
>=20
>     return nil, fmt.Errorf("unrecognized event '%s'", tmp.Name)
>   }
>=20
> it becomes feasible to stick with standard functions. We can of
> course keep the (Un)MarshalEvent functions around for convenience,
> but I don't think they should be the only available API.

I agree. I'll change it. Perhaps we shouldn't use
(Un)MarshalEvent at this layer at all. Probably the same for
(Un)MarshalCommand.

Cheers,
Victor

--mjojocti3dri3igg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVNL2IACgkQl9kSPeN6
SE8syRAAvXlm++OmwnrlvHTGVvH1xnsfiLn6vsqEv3TH3vRcOinGX7PlecPZEdWC
/ppggte5k3snB5nfssHuUwS6KdLuyWLxaseMhOmYpDKTL/Hr+LGjzUTJC4sAad8E
8t0fiwM/OcYnIg25aTa9VfbN4DjF8WazMM0lWAvYegfbP5MeGIW2q6O8kiGyu2eW
xIGZAflC3vj17xihfxYSIkUp/L7FTTDJAff6hKnXSG7pz41JsdtMnsGVmCBGA9KW
ZPlSTIpzU9n8/Ac6u7kHTWtsq0quEnU5ejYoVeGme0U4vgU+4ywsQ+NF4xylkuZU
TV6plg8j7odi/4+UlyZyGmXA/XYp/zHcTG0GBjHOmfqUlT8ZxrCOZvbVhLJvr0+a
UoWF15p0SFQ6bPbeG3Cb3K0XKhoYi1CSGulbw3KmUYehxWYdhqUImS51Or7H3Bfm
tESZKlX1lLxQSAOuAQMswJqrrF1AgLmhOqrLlQQGdD9IurpQhjtFMngRq54DKPLw
HRc2lKBo/WRKnmGvxeUf9bAiG856QmYGuCr/U10lg+yiuHcBlfJEeWLo2pGSYHBb
7T6GK8whTdij8G5DUlzrZv7DJY0+M8Pa6W89FsEskrlr5H8+abvlGc1VG8w14dX7
xWtPkRb8k57qGwvleJIbtkuyuzFC+SLtX/N23pVAI3EMxtjuD/s=
=yyM0
-----END PGP SIGNATURE-----

--mjojocti3dri3igg--


