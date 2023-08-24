Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF62787050
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZASK-00020W-JB; Thu, 24 Aug 2023 09:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZASG-0001rI-D3
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZASE-0005P9-4P
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692883973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mxl3ii1xfts+9u1DjtJ56OigdGkKMlh9adCdvY0Sm0U=;
 b=PA9IaJEMYKQJ3hvYgVBqyyly70WZo41bbN4yEaofbVTbYmUKet3U57Xx7wqcPgMIVEKuzQ
 Tsfko5wkLwQA5Up6FacAQGJ2mvzKaCRXcpF9CpjzOzteNJSZdo5cqdoTlxnmRp8ChMHeZV
 UaLVvSrBFhvBezNnLX/vjJTYEsWEhaQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-tNdb-l2mM-CDZrNuF0COfw-1; Thu, 24 Aug 2023 09:32:48 -0400
X-MC-Unique: tNdb-l2mM-CDZrNuF0COfw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D95421C09A46;
 Thu, 24 Aug 2023 13:32:47 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F280492C13;
 Thu, 24 Aug 2023 13:32:47 +0000 (UTC)
Date: Thu, 24 Aug 2023 09:32:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org,
 john.levon@nutanix.com, Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, armbru@redhat.com
Subject: Re: [PATCH v2 1/4] softmmu: Support concurrent bounce buffers
Message-ID: <20230824133245.GA1412804@fedora>
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
 <20230823092905.2259418-2-mnissler@rivosinc.com>
 <ZOZDQVgboMaiZ4x6@x1n>
 <CAGNS4TY2-scz3pu16tUF1bA-FEk+pe86QsgjW8L=qjidw5TqOQ@mail.gmail.com>
 <ZOZx7vMqFRfaIwSp@x1n>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="P64KNBm6ybtLlYDh"
Content-Disposition: inline
In-Reply-To: <ZOZx7vMqFRfaIwSp@x1n>
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


--P64KNBm6ybtLlYDh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 04:54:06PM -0400, Peter Xu wrote:
> On Wed, Aug 23, 2023 at 10:08:08PM +0200, Mattias Nissler wrote:
> > On Wed, Aug 23, 2023 at 7:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > > On Wed, Aug 23, 2023 at 02:29:02AM -0700, Mattias Nissler wrote:
> > > > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > > > index b0b96f67fa..dbe52f5ea1 100644
> > > > --- a/softmmu/vl.c
> > > > +++ b/softmmu/vl.c
> > > > @@ -3469,6 +3469,12 @@ void qemu_init(int argc, char **argv)
> > > >                  exit(1);
> > > >  #endif
> > > >                  break;
> > > > +            case QEMU_OPTION_max_bounce_buffer_size:
> > > > +                if (qemu_strtosz(optarg, NULL, &max_bounce_buffer_=
size) < 0) {
> > > > +                    error_report("invalid -max-ounce-buffer-size v=
alue");
> > > > +                    exit(1);
> > > > +                }
> > > > +                break;
> > >
> > > PS: I had a vague memory that we do not recommend adding more qemu cm=
dline
> > > options, but I don't know enough on the plan to say anything real.
> >=20
> > I am aware of that, and I'm really not happy with the command line
> > option myself. Consider the command line flag a straw man I put in to
> > see whether any reviewers have better ideas :)
> >=20
> > More seriously, I actually did look around to see whether I can add
> > the parameter to one of the existing option groupings somewhere, but
> > neither do I have a suitable QOM object that I can attach the
> > parameter to, nor did I find any global option groups that fits: this
> > is not really memory configuration, and it's not really CPU
> > configuration, it's more related to shared device model
> > infrastructure... If you have a good idea for a home for this, I'm all
> > ears.
>=20
> No good & simple suggestion here, sorry.  We can keep the option there
> until someone jumps in, then the better alternative could also come along.
>=20
> After all I expect if we can choose a sensible enough default value, this
> new option shouldn't be used by anyone for real.

QEMU commits to stability in its external interfaces. Once the
command-line option is added, it needs to be supported in the future or
go through the deprecation process. I think we should agree on the
command-line option now.

Two ways to avoid the issue:
1. Drop the command-line option until someone needs it.
2. Make it an experimental option (with an "x-" prefix).

The closest to a proper solution that I found was adding it as a
-machine property. What bothers me is that if QEMU supports
multi-machine emulation in a single process some day, then the property
doesn't make sense since it's global rather than specific to a machine.

CCing Markus Armbruster for ideas.

Stefan

--P64KNBm6ybtLlYDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnW/0ACgkQnKSrs4Gr
c8ivQAf/Xa27k8pOaeMCCTEdtON5fzw3Lq9AUNch4yKtPmYH0cRN5BMY/mx8HAx6
Vo8Y+m5ahee7Fo8cY+TWRkj70QKWqB9Q961vdNJ8apjGHzrrcLcyvvvkA8f5Lvky
WiW402UG3gX0OmP078clOA5/U7oz4FGQNM2oWOklQT4ZSbJ2n2Eih0btkzxwlcfh
0TBy7SidPpv8Dys/5wNA+dwAPfx7+jw7o9MU9+xzrR6ec6Rjn4fiTUFbXjlBxU/e
MvU00IEPMcKy15ua7S9VCwWn98xLXFrSjF7cnrxHGlH8EnUsZRs4JtOmt/ygO69B
nnRQfB3/Ievs7xhXG7NJeSi3UjNwTQ==
=FJNJ
-----END PGP SIGNATURE-----

--P64KNBm6ybtLlYDh--


