Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26AE7E2926
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:53:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01tl-0005RG-Rl; Mon, 06 Nov 2023 10:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r01tj-0005PD-LO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r01th-0007ro-KJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699285936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tWyDbQWcWO5F3XsI9SDFIo4HSYSKh3uMBDpGLTA/Ec=;
 b=Xv9VvCVP5Bd8aTLYF5I80mYeUmtdrQTjciiJLqU1pn7qXBjqHDrESVdvjdo/VaCbAf5Dz2
 768DR/CnIuncbbLXRrquX3zFsd1bg/GE7bD92CTkJavZkkIJmLslS4GeQWQr86V/hYWxsv
 AVfK23ooZtq9zC4y6xxY1WRgulpvsdY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-PtIYI8MxMGea-M5OQ5-G8Q-1; Mon, 06 Nov 2023 10:52:14 -0500
X-MC-Unique: PtIYI8MxMGea-M5OQ5-G8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6635085C1A1
 for <qemu-devel@nongnu.org>; Mon,  6 Nov 2023 15:52:14 +0000 (UTC)
Received: from localhost (unknown [10.45.226.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1883502B;
 Mon,  6 Nov 2023 15:52:13 +0000 (UTC)
Date: Mon, 6 Nov 2023 16:52:12 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 04/11] qapi: golang: Generate qapi's alternate types
 in Go
Message-ID: <hlu7dit5w6oxjz6ib423ak3ptzppdvuvltymzinxb3v2o2mwwa@xyfns7sv77gj>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-5-victortoso@redhat.com>
 <CABJz62O9YKuRHqW2_WUijzY5PfqmjxDjbU=7-O4cp0OO+JQi3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="erm6rjp6rtsc43dy"
Content-Disposition: inline
In-Reply-To: <CABJz62O9YKuRHqW2_WUijzY5PfqmjxDjbU=7-O4cp0OO+JQi3g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--erm6rjp6rtsc43dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 06, 2023 at 07:28:04AM -0800, Andrea Bolognani wrote:
> On Mon, Oct 16, 2023 at 05:26:57PM +0200, Victor Toso wrote:
> > This patch handles QAPI alternate types and generates data structures
> > in Go that handles it.
> >
> > Alternate types are similar to Union but without a discriminator that
> > can be used to identify the underlying value on the wire. It is needed
> > to infer it. In Go, most of the types [*] are mapped as optional
> > fields and Marshal and Unmarshal methods will be handling the data
> > checks.
> >
> > Example:
> >
> > qapi:
> >   | { 'alternate': 'BlockdevRef',
> >   |   'data': { 'definition': 'BlockdevOptions',
> >   |             'reference': 'str' } }
> >
> > go:
> >   | type BlockdevRef struct {
> >   |         Definition *BlockdevOptions
> >   |         Reference  *string
> >   | }
> >
> > usage:
> >   | input :=3D `{"driver":"qcow2","data-file":"/some/place/my-image"}`
> >   | k :=3D BlockdevRef{}
> >   | err :=3D json.Unmarshal([]byte(input), &k)
> >   | if err !=3D nil {
> >   |     panic(err)
> >   | }
> >   | // *k.Definition.Qcow2.DataFile.Reference =3D=3D "/some/place/my-im=
age"
> >
> > [*] The exception for optional fields as default is to Types that can
> > accept JSON Null as a value. For this case, we translate NULL to a
> > member type called IsNull, which is boolean in Go.  This will be
> > explained better in the documentation patch of this series but the
> > main rationale is around Marshaling to and from JSON and Go data
> > structures.
>=20
> These usage examples are great; in fact, I think they're too good to
> be relegated to the commit messages. I would like to see them in the
> actual documentation.
>=20
> At the same time, the current documentation seems to focus a lot on
> internals rather than usage. I think we really need two documents
> here:
>=20
>   * one for users of the library, with lots of usage examples
>     (ideally at least one for JSON->Go and one for Go->JSON for each
>     class of QAPI object) and little-to-no peeking behind the
>     curtains;
>=20
>   * one for QEMU developers / QAPI maintainers, which goes into
>     detail regarding the internals and explains the various design
>     choices and trade-offs.
>=20
> Some parts of the latter should probably be code comments instead. A
> reasonable balance will have to be found.
>=20
> > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > +TEMPLATE_HELPER =3D """
> > +// Creates a decoder that errors on unknown Fields
> > +// Returns nil if successfully decoded @from payload to @into type
> > +// Returns error if failed to decode @from payload to @into type
> > +func StrictDecode(into interface{}, from []byte) error {
> > +\tdec :=3D json.NewDecoder(strings.NewReader(string(from)))
> > +\tdec.DisallowUnknownFields()
> > +
> > +\tif err :=3D dec.Decode(into); err !=3D nil {
> > +\t\treturn err
> > +\t}
> > +\treturn nil
> > +}
> > +"""
>=20
> I think the use of \t here makes things a lot less readable. Can't
> you just do
>=20
>   TEMPLATE_HELPER =3D """
>   func StrictDecode() {
>       dec :=3D ...
>       if err :=3D ... {
>          return err
>       }
>       return nil
>   }
>   """
>=20
> I would actually recommend the use of textwrap.dedent() to make
> things less awkward:
>=20
>   TEMPLATE_HELPER =3D textwrap.dedent("""
>       func StrictDecode() {
>           dec :=3D ...
>           if err :=3D ... {
>              return err
>           }
>           return nil
>       }
>   """
>=20
> This is particularly useful for blocks of Go code that are not
> declared at the top level...
>=20
> > +        unmarshal_check_fields =3D f"""
> > +\t// Check for json-null first
> > +\tif string(data) =3D=3D "null" {{
> > +\t\treturn errors.New(`null not supported for {name}`)
> > +\t}}"""
>=20
> ... such as this one, which could be turned into:
>=20
>   unmarshal_check_fields =3D textwrap.dedent(f"""
>       // Check for json-null first
>       if string(data) =3D=3D "null" {{
>           return errors.New(`null not supported for {name}`)
>       }}
>   """)
>=20
> Much more manageable, don't you think? :)

Didn't know this one, I agree 100% that is nicer. I'll take a
look for the next iteration if the output would still be similar
as I want to gofmt change be zero (see bellow).
=20
>=20
> On a partially related note: while I haven't yet looked closely at
> how much effort you've dedicated to producing pretty output, from a
> quick look at generate_struct_type() it seems that the answer is "not
> zero". I think it would be fine to simplify things there and produce
> ugly output, under the assumption that gofmt will be called on the
> generated code immediately afterwards. The C generator doesn't have
> this luxury, but we should take advantage of it.

Yes, I wholeheartedly agree. The idea of the generator producing
a well formatted Go code came from previous review. I didn't want
to introduce gofmt and friends to QEMU build system, perhaps it
wasn't a big deal but I find it foreign to QEMU for a generated
code that QEMU itself would not use.

See: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01188.html

Cheers,
Victor

--erm6rjp6rtsc43dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVJC6wACgkQl9kSPeN6
SE+egQ//f7gwzhoJCtgyljZ/f7rJotTvVZJ7qws9xyfousYd4d7MUoXvEd4gY454
Mt7tVqZXIvzo9nhHrvqdPAxBIItdtLMjK1fG8qkSIHejGtPGW9vhDwMPpACDXLxT
prP1RD7MPuC5S5oyIuDAqnbxqeGuIRnNPFBas6/EKbVUIxyhnHJBXnmo+LtXPdU2
XoycFeOvELxhFBbXzqUlnn6HiWP/pAryl794Hc2/jB7Wr1VBTJxSGphCUv0d9ONG
VSsxHvYqNWUSJS8dUnQiUt57i4dmmjZ6F1tGCwid8MgWcoRpNb9ql3chGUcz6JpC
22lpCdVRjXChgNUCPZxjc9HPg39sBenL//OMRbKgs9KFfTc+agENINjFjsRbdcZp
mQ0gynAZuurkMUhT1u6Ejp6ARGY1xx83nRSYncxvCPYu7WgQZB3tkSHfLDpPyEME
ThMGi05xvdoLnJ0KWLQ2/NTiSvr3JC8N9qlSqG87ATnqCQHwl4CFp4gLsn2y4WUR
ZAce8MJa6TXKYJ9k8PijznZMILvE0zQzLzM/VAGNrc/xoxnukbTKb7rZIgOY7D95
IjPOBk474LpRU7gQiU9T4nRKPr2EOYA0jx6aIDYIpocF75uON/HjAJfCF4tlHyJs
BSHS/9pX/d7BWSySj/Ifd8JsPTaMg5GcFwp2kuLJ+/1hTZvljDk=
=NtqF
-----END PGP SIGNATURE-----

--erm6rjp6rtsc43dy--


