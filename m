Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BC82F1FE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:56:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPlnB-0004vp-Mb; Tue, 16 Jan 2024 10:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rPln8-0004vL-FC
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rPln6-0005IH-OF
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705420552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfBTUTjv64atHp3NMnHF3PNL8Y6QTayxRi8yILG5HKo=;
 b=dpHtVyl3jKry7ndsIX37wzARk/S22LMrn4bm9P+sjSTDWs18z8c32SdmWdag32rk96WqCO
 lWHEsw0EZmjr2RQQYEwkZRDFNzPYtdrwth76J+4pHg7xlE+QacuV85OqhgU6Fdo49LEBAR
 IMGQsV6c3COp5QBsnjL1jopXOZPftrA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Zwzp5PPMMMmzo-XHM_4fXQ-1; Tue, 16 Jan 2024 10:55:50 -0500
X-MC-Unique: Zwzp5PPMMMmzo-XHM_4fXQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ce53c43ea1so5922804a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705420549; x=1706025349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfBTUTjv64atHp3NMnHF3PNL8Y6QTayxRi8yILG5HKo=;
 b=IsbHVmYvprcIwHBvAbP9dEmvXKp8lKU+gxmrYCBntLvVrnOIxm6lp2lgB4qvjJri87
 +AZENeddO0sC7ttzmLdrxVc7ahOXflWaAJWWwumPP4DBQwMzwzm1vVApggOlIhrIquGC
 uG4ZSWa9m31J7DwDgGgHhcdkbAtGXmHDJQ9Urn7czZ4zK9H//RVBrUrOuttwjRVHthla
 +hhrBLdTP1rTqKDuzy7hmqSOOnEt5/DqM2l/8eeWjdW2F3Po54jl0G5KpKs+zugA5v+3
 sUXrKLJHUBuGsNKX4/T6HNFw2ClRo6qAvGOoQrPIPM9nlyi3HRAMBh/tyCkP9x7LC0H+
 xkdA==
X-Gm-Message-State: AOJu0YyC9RsWarzRZH9M5E5PPGboyZNPqfCfSdxePc2X7Rj7Q8UxRCUu
 NPjgQMTpmBguEuwgTYWU86lwAlWZZnD8M6iSDjIjNWYsPXFAFrRfDJ0678TcZe6Xgb/vBCM8xCH
 SxQOOQhJyEFu03tbM6S24U2rXt+XgLxLUlQFBURQ=
X-Received: by 2002:a17:90a:c582:b0:28e:7a18:aa5d with SMTP id
 l2-20020a17090ac58200b0028e7a18aa5dmr799817pjt.39.1705420549570; 
 Tue, 16 Jan 2024 07:55:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7mh+XIbvcFhhmDeDgqGp2dmV92leysBddJ7IUYz/4uLHBisaP5kDvnImK0RtuAC5MgeFrr+VPIVQmmVGjZAs=
X-Received: by 2002:a17:90a:c582:b0:28e:7a18:aa5d with SMTP id
 l2-20020a17090ac58200b0028e7a18aa5dmr799810pjt.39.1705420549291; Tue, 16 Jan
 2024 07:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-5-jsnow@redhat.com>
 <8734uyd7ol.fsf@pond.sub.org>
In-Reply-To: <8734uyd7ol.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jan 2024 10:55:38 -0500
Message-ID: <CAFn=p-aVhr93NU2Fe0U5FT8_NsvRgz=oaHEHczRXv412kbnHug@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] qapi/schema: declare type for
 QAPISchemaObjectTypeMember.type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Mon, Jan 15, 2024 at 8:53=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > declare, but don't initialize the type of "type" to be QAPISchemaType -
>
> Declare
>
> > and allow the value to be initialized during check(). This creates a
> > form of delayed initialization for QAPISchemaType objects where the
> > static typing only represents the fully-realized object, which occurs
> > after check() has been called.
> >
> > This avoids the need for several "assert type is not None" statements
> > littered throughout the code by asserting it "will always be set."
>
> Uh, I find "will always be set" confusing.
>
> I think you mean "cannot be None".

Yuh

>
> But "be set" can also be read as "will have a value".

...yuh

>
> It actually doesn't exist until .check(), and once it exists, it cannot
> be None.
>
> > Note that the static typing information for this object will be
> > incorrect prior to check() being called. If this field is accessed
> > before it is initialized in check(), you'll be treated to an
> > AttributeError exception.
>
> We could now enter a philosophical debate on whether the static typing
> is actually incorrect.  Clearly v: T asserts that the value of @v is
> always a T, and the type checker proves this.  Does it also assert that
> @v exists?  The type checker doesn't care, and that's a feature.

*clutches TAPL and cries*

>
> Maybe start with the problem, and then develop the solution:
>
>   A QAPISchemaObjectTypeMember's type gets resolved only during .check().
>   We have QAPISchemaObjectTypeMember.__init__() initialize self.type =3D
>   None, and .check() assign the actual type.  Using .type before .check()
>   is wrong, and hopefully crashes due to the value being None.  Works.
>
>   However, it makes for awkward typing.  With .type:
>   Optional[QAPISchemaType], mypy is of course unable to see that it's Non=
e
>   before .check(), and a QAPISchemaType after.  To help it over the hump,
>   we'd have to assert self.type is not None before all the (valid) uses.
>   The assertion catches invalid uses, but only at run time; mypy can't
>   flag them.
>
>   Instead, declare .type in .__init__() as QAPISchemaType *without*
>   initializing it.  Using .type before .check() now certainly crashes,
>   which is an improvement.  Mypy still can't flag invalid uses, but that'=
s
>   okay.
>

OK.

--js

> > Fixes stuff like this:
> >
> > qapi/schema.py:657: error: "None" has no attribute "alternate_qtype"  [=
attr-defined]
> > qapi/schema.py:662: error: "None" has no attribute "describe"  [attr-de=
fined]
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index e39ed972a80..48a51dcd188 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -794,7 +794,7 @@ def __init__(self, name, info, typ, optional, ifcon=
d=3DNone, features=3DNone):
> >              assert isinstance(f, QAPISchemaFeature)
> >              f.set_defined_in(name)
> >          self._type_name =3D typ
> > -        self.type =3D None
> > +        self.type: QAPISchemaType  # set during check()
> >          self.optional =3D optional
> >          self.features =3D features or []
>


