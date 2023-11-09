Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66817E7260
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:33:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Akg-00032t-Au; Thu, 09 Nov 2023 14:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1AkD-0002i3-9I
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1Ak6-0005tJ-20
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699558265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=li/n+UmxrwGqNT4NZgB19Cf4+zFp7ViBow0FgNe5Af4=;
 b=Qzgjf+jK/uAq6Vx5xtyoSwy6EDjuKQNq4yoi0oiJ995pKcaK9T5oBbDaDW3DxGXpqPKQ9B
 nH7em1mvTVyFULPZfL7gFHXGN//RCb80hGZBehOx5FwHzCwUeyf5WTL/rPCcGlAeCCVODB
 rHuckd+g8gqFb/uQLcazcABPHPQ+gdM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-ZTlagTBDNmaiz5ZK1n23Hg-1; Thu, 09 Nov 2023 14:31:02 -0500
X-MC-Unique: ZTlagTBDNmaiz5ZK1n23Hg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BB2B185A783
 for <qemu-devel@nongnu.org>; Thu,  9 Nov 2023 19:31:02 +0000 (UTC)
Received: from localhost (unknown [10.45.226.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33C86492BFA;
 Thu,  9 Nov 2023 19:31:02 +0000 (UTC)
Date: Thu, 9 Nov 2023 20:31:01 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 10/11] qapi: golang: Add CommandResult type to Go
Message-ID: <dfwqu6vgvmhezaorvm6vhj2kwuibpke4fvcocttrnyi2rypjat@jpwugcjwewbs>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-11-victortoso@redhat.com>
 <CABJz62PJVbhJkqCzsSHfHSbeZ8PX74OGjbhf6uKZy7JBxnoa5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vl4za3hqt6dsui32"
Content-Disposition: inline
In-Reply-To: <CABJz62PJVbhJkqCzsSHfHSbeZ8PX74OGjbhf6uKZy7JBxnoa5Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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


--vl4za3hqt6dsui32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 09, 2023 at 10:24:20AM -0800, Andrea Bolognani wrote:
> On Mon, Oct 16, 2023 at 05:27:03PM +0200, Victor Toso wrote:
> > This patch adds a struct type in Go that will handle return values
> > for QAPI's command types.
> >
> > The return value of a Command is, encouraged to be, QAPI's complex
> > types or an Array of those.
> >
> > Every Command has a underlying CommandResult. The EmptyCommandReturn
> > is for those that don't expect any data e.g: `{ "return": {} }`.
> >
> > All CommandReturn types implement the CommandResult interface.
>=20
> I guess EmptyCommandReturn is something that you have scrapped
> in between revisions, because I see no reference to it in the
> current incarnation of the code. Same thing with CommandResult,
> unless that's just a typo for CommandReturn?

No typo. I did overlooked this commit log. We had
EmptyCommandReturn type in the past, we agreed to have a specific
type for each command even if they are empty (with basic/common
fields only)

>=20
> > Example:
> > qapi:
> >     | { 'command': 'query-sev', 'returns': 'SevInfo',
> >     |   'if': 'TARGET_I386' }
> >
> > go:
> >     | type QuerySevCommandReturn struct {
> >     |     MessageId string     `json:"id,omitempty"`
> >     |     Result    *SevInfo   `json:"return"`
> >     |     Error     *QapiError `json:"error,omitempty"`
> >     | }
> >
> > usage:
> >     | // One can use QuerySevCommandReturn directly or
> >     | // command's interface GetReturnType() instead.
>=20
> I'm not convinced this function is particularly useful. I know
> that I've suggested something similar for events, but the usage
> scenarios are different.

I think that I wanted to expose knowledge we had in the parser,
not necessarily useful or needed indeed. At the very least, I
agree that at this layer, we just want Command and ComandReturn
types to be generated and properly (un)mashalled.

One downside is for testing.

If we have a list of commands, I can just iterate over them
Unmarshal to a command interface variable, fetch the return type
and do some comparisons to see if all is what we expected. See:

https://gitlab.com/victortoso/qapi-go/-/blob/main/test/examples_test.go#L61

Not saying we should keep it for tests, but it is useful :)

> For events, you're going to have some loop listening for them
> and you can't know in advance what event you're going to
> receive at any given time.
>=20
> In contrast, a return value will be received as a direct consequence
> of running a command, and since the caller knows what command it
> called it's fair to assume that it also knows its return type.
>=20
> > +        if ret_type:
> > +            marshal_empty =3D ""
> > +            ret_type_name =3D qapi_schema_type_to_go_type(ret_type.nam=
e)
> > +            isptr =3D "*" if ret_type_name[0] not in "*[" else ""
> > +            retargs.append(
> > +                {
> > +                    "name": "Result",
> > +                    "type": f"{isptr}{ret_type_name}",
> > +                    "tag": """`json:"return"`""",
> > +                }
> > +            )
>=20
> This produces
>=20
>   type QueryAudiodevsCommandReturn struct {
>     MessageId string     `json:"id,omitempty"`
>     Error     *QAPIError `json:"error,omitempty"`
>     Result    []Audiodev `json:"return"`
>   }
>=20
> when the return type is an array. Is that the correct behavior? I
> haven't thought too hard about it, but it seems odd so I though I'd
> bring it up.

Hm, the schema for it is

  ##
  # @query-audiodevs:
  #
  # Returns information about audiodev configuration
  #
  # Returns: array of @Audiodev
  #
  # Since: 8.0
  ##
  { 'command': 'query-audiodevs',
    'returns': ['Audiodev'] }
=20
So, I think it is correct. Would you expect it to be an object
wrapping the array or I'm missing what you find odd.

 # -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
 # <- { "return": [
 #         {
 #             "promiscuous": true,
 #             "name": "vnet0",
 #             "main-mac": "52:54:00:12:34:56",
 #             "unicast": "normal",
 #             "vlan": "normal",
 #             "vlan-table": [
 #                 4,
 #                 0
 #             ],
 #             "unicast-table": [
 #             ],
 #             "multicast": "normal",
 #             "multicast-overflow": false,
 #             "unicast-overflow": false,
 #             "multicast-table": [
 #                 "01:00:5e:00:00:01",
 #                 "33:33:00:00:00:01",
 #                 "33:33:ff:12:34:56"
 #             ],
 #             "broadcast-allowed": false
 #         }
 #       ]
 #    }
 ##
 { 'command': 'query-rx-filter',
   'data': { '*name': 'str' },
   'returns': ['RxFilterInfo'] }

Cheers,
Victor

--vl4za3hqt6dsui32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVNM3UACgkQl9kSPeN6
SE8E9g//brRUHglY1DWrar2aghUrQgu6aYRBAupbn+JpAuiaisKu5jvSYlC0CAJz
7rJpwBKW2WTBEbEo8KbxPgcWNI+ytXK4nKY2M0hGI1rIOYgfpqoND6RCl77jERdI
/tUFGCQYeqsYDucD//QwNlux4KHSbqpv9zKI4SsBObMg71XOKBT6e5tA8HG8SOYP
CevYWLK22C6uXzUH4w3xZ80rwcZVJFaILq3Wx2avgfn4ArPFmhfCXFFoKJko/kP7
W2FIx1d+Sw5U/LUil4Tuahl/DcfzV6mXe95G9iQf3GrRmJoHV4FkHY6ZIZmHMA+S
g3Iyjs59GoU5/T0WR3ZHhJJnONRVq7uyS80uoNGjdZOgev3DMEZeFsAl2KXJ10De
3dJeu94qEEnsgNH+ufJbKj7NcRZ9E05zIpVwMSq/MlOsMo9/PzM2D3tTrFAUOiyv
LRJs1/wnIe9SQll3cM5Q9Ek+FRfOk+WNCp7+CyWS8HrPYXXTN1ge8UddeaQN/3Mk
dSyiGNBi/7pm0KMr30qBehk/AoygOyXfuFKvohL8CfL/LJNkXbBBNwXPbg7Uv2uM
7gLyhSPdDBV4cJyKKWVJjMNS4wqokPH6EOhcsSaFmtHZYP35mUdGPdC99pUjNR7G
nAL04/r8G1L/5RaLvEP+50+UCSwATUzFskN4cFNk2MjFHQkJpgo=
=IoGp
-----END PGP SIGNATURE-----

--vl4za3hqt6dsui32--


