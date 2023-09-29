Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2D7B3399
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 15:30:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmDZ0-0000A1-MI; Fri, 29 Sep 2023 09:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDYu-00005b-52
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDYs-0000mF-8I
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695994181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dST3XQep7TPunrRTyLFoEtwavgF01DXXGYbenEJn31Q=;
 b=dzKggvWytsEalXvqKpw7kdE/Wytesqmm3g7Rz/x4HoifF924/AqXCT9lHIc2MN+RRDkwj9
 udFedxibaNS0leTaVqV/u2jiebd2/FPQKk7YshUCJBH11PerDCLbBRHKoqcBz/EwaLCeJa
 F2fvGuoFcLH0bCga+9JE85flKa7WJnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-STuNL6VZNqCZ4v_tYLaO-w-1; Fri, 29 Sep 2023 09:29:36 -0400
X-MC-Unique: STuNL6VZNqCZ4v_tYLaO-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58D9F85A5BE
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:29:36 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E762340C6EBF;
 Fri, 29 Sep 2023 13:29:35 +0000 (UTC)
Date: Fri, 29 Sep 2023 15:29:34 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 3/9] qapi: golang: Generate qapi's struct types in Go
Message-ID: <vyefh5qpavk2kdgg6kyglvfryxbq6w2d422zr6bc5cklfaagyy@3hgytl2yl234>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-4-victortoso@redhat.com>
 <ZRWIX36p8oaV0yF0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d4m7y7cit7wjxc2k"
Content-Disposition: inline
In-Reply-To: <ZRWIX36p8oaV0yF0@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--d4m7y7cit7wjxc2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 03:06:23PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:38PM +0200, Victor Toso wrote:
> > This patch handles QAPI struct types and generates the equivalent
> > types in Go. The following patch adds extra logic when a member of the
> > struct has a Type that can take JSON Null value (e.g: StrOrNull in
> > QEMU)
> >=20
> > The highlights of this implementation are:
> >=20
> > 1. Generating an Go struct that requires a @base type, the @base type
> >    fields are copied over to the Go struct. The advantage of this
> >    approach is to not have embed structs in any of the QAPI types.
> >    Note that embedding a @base type is recursive, that is, if the
> >    @base type has a @base, all of those fields will be copied over.
> >=20
> > 2. About the Go struct's fields:
> >=20
> >    i) They can be either by Value or Reference.
> >=20
> >   ii) Every field that is marked as optional in the QAPI specification
> >       are translated to Reference fields in its Go structure. This
> >       design decision is the most straightforward way to check if a
> >       given field was set or not. Exception only for types that can
> >       take JSON Null value.
> >=20
> >  iii) Mandatory fields are always by Value with the exception of QAPI
> >       arrays, which are handled by Reference (to a block of memory) by
> >       Go.
> >=20
> >   iv) All the fields are named with Uppercase due Golang's export
> >       convention.
> >=20
> >    v) In order to avoid any kind of issues when encoding or decoding,
> >       to or from JSON, we mark all fields with its @name and, when it is
> >       optional, member, with @omitempty
> >=20
> > Example:
> >=20
> > qapi:
> >  | { 'struct': 'BlockdevCreateOptionsFile',
> >  |   'data': { 'filename': 'str',
> >  |             'size': 'size',
> >  |             '*preallocation': 'PreallocMode',
> >  |             '*nocow': 'bool',
> >  |             '*extent-size-hint': 'size'} }
> >=20
> > go:
> > | type BlockdevCreateOptionsFile struct {
> > |     Filename       string        `json:"filename"`
> > |     Size           uint64        `json:"size"`
> > |     Preallocation  *PreallocMode `json:"preallocation,omitempty"`
> > |     Nocow          *bool         `json:"nocow,omitempty"`
> > |     ExtentSizeHint *uint64       `json:"extent-size-hint,omitempty"`
> > | }
>=20
> Note, 'omitempty' shouldn't be used on pointer fields, only
> scalar fields. The pointer fields are always omitted when nil.

'omitempty' should be used with pointer fields unless you want to
Marshal JSON Null, which is not the expected output.

'omitempty' is used when QAPI member is said to be optional. This
is true for all optional members with the exception of two
Alternates: StrOrNull and BlockdevRefOrNull, as we _do_ want to
express JSON Null with them.

```Go
    package main

    import (
        "encoding/json"
        "fmt"
    )

    type Test1 struct {
        Foo *bool `json:"foo"`
        Bar *bool `json:"bar,omitempty"`
        Esc bool  `json:"esc"`
        Lar bool  `json:"lar,omitempty"`
    }

    type Test2 struct {
        Foo *uint64 `json:"foo"`
        Bar *uint64 `json:"bar,omitempty"`
        Esc uint64  `json:"esc"`
        Lar uint64  `json:"lar,omitempty"`
    }

    func printIt(s any) {
        if b, err :=3D json.Marshal(s); err !=3D nil {
            panic(err)
        } else {
            fmt.Println(string(b))
        }
    }

    func main() {
        printIt(Test1{})
        printIt(Test2{})
    }
```

```console
    toso@tapioca /tmp> go run main.go
    {"foo":null,"esc":false}
    {"foo":null,"esc":0}
```

Cheers,
Victor

--d4m7y7cit7wjxc2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUW0T4ACgkQl9kSPeN6
SE/rnhAAiMzbm4hIhHrU3pQZXOT9Z1SG8b6PcpL4utiKYNPtpabDtZTRKCZMWqP1
v7VRkEyCQ9vY3Gv/Hpx8XO8m1LJywq8LKI723DpmzpTMky0reS8l2rZWk5f2CD7g
oyRLsT/oyWzA82daf/ZB51KzV+bulkjie7ucBs4/GWwIkqoGfH2Vyz/B5KS1qO8/
K2hjszco/dP+Dj3TxUbOGlDQcP9kIcC4gH1saPvZWf7QSHZCmwclxxinXTbbh4/8
5WLRTy2KsnjmhvWJxBRFjCUdzqfrhqmPp14AY9XXgL4z1QUwWUILkT/o5n34mGMF
Zs7dIf7rhqCZoXu53JiIrdSHC8ZOxvQ5khX1opif7NOIWPf7mqkyWFPTSNLk6REG
cQP0hcvnoVi9eleujitP3C62cVMws5HDTvIlcDXFHJZD9rWW3er87YQZBDJ3Dh7f
8SrR5+ia8Vz7EwwR+b0msa2MV9SDlhr4mUwpjZiPQrj/DOTvo/rkb0CCBTpLQb59
3h+1Beu9cWOTyepJueGu6wpmccFxzuI5LOua6dMmJf2apyDR0pF5VpaFsBT4daDe
SiEu+OgqParUJpNkKbx8o3G9BDlwCbD1AIZPDCjIQQIC+r/PJhqFtO6UY1g+80EJ
nfS6rdFAvZvEW26R8lGw1PmTXQ9EYzmPtwLRFcB4j80lLKo3OyE=
=YfN+
-----END PGP SIGNATURE-----

--d4m7y7cit7wjxc2k--


