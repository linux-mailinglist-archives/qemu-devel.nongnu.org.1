Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7FA5A592
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Mar 2025 22:06:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trkJe-0000fV-6w; Mon, 10 Mar 2025 17:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkJU-0000O0-Fc
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkJS-0005Uu-9Z
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741640723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXx82qNHSWsCBOckdtbgrfg5VsDZK/dx7DyAYgsAiTc=;
 b=Pv7zIogXSmzdkwOv7zYuOsuvIVT4vgwyiFjCxLrv6u21HobFwMsyOH5UxhScpeBE1KgDR5
 PAGyAE6xz1Xi3IG/WucacDLCjvhKF7/xTH0I8qK3VqQIJqDEEn1a4jWvWdA+BQfNeNw7el
 zOwc3aYYH3DK/4t/jrK2lGWRn1LmqkA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-Az-hORC8M0a3ra4OdkixQA-1; Mon, 10 Mar 2025 17:05:20 -0400
X-MC-Unique: Az-hORC8M0a3ra4OdkixQA-1
X-Mimecast-MFC-AGG-ID: Az-hORC8M0a3ra4OdkixQA_1741640720
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22403329f9eso78786375ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741640719; x=1742245519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lXx82qNHSWsCBOckdtbgrfg5VsDZK/dx7DyAYgsAiTc=;
 b=oV6HYdJ08fRo6pg8l0u3sufqGAArem+YkHNZlHsEimzBvcS3F6FiiaCli7ZEqhdpvN
 LE4l6jS028LW/jQC6jFY/yY0PvwEGcJxmo9X2GpPOewPISpyZjsqMKNvRxPhczsChvy5
 dwBioU51HjJyJPsCTZMzYTYWUjPhaLhH8HksYkgOLNSEuZI+FPK1VWiIKPTz/4/NtSUR
 pPD/DKKrh1RcyDaZxa0RMxPHnOVSMizLI30AArsZADvEc31qJOwJT0qyc7HE69mX8dVy
 pBEiXK8tWLgtkCVkG8JPipivgVcXUXnU0mp2G3RPr6ij4xqR3Ci2U8gyKgWNy79uqyGt
 w1MA==
X-Gm-Message-State: AOJu0YwBYaMpq4YtYnEiKZ925JuXAO+28s2nw+PUzMYxtzhl+moapegA
 6uS90QhoXJ2Tz7r/SVc3qTGys6lDQrMBMUhlaCq3J1xJUcZ5NqLfsz/CfSxwTkD1DSqtLmV3egG
 bIxjGKvpiuQIq2UGqNs7onsBMby+0MNSr8x6awD2cIey6E34EN7tMhZNljokoLIMkJ5HGNTwlG8
 CPaZ/52FzWyyPMBB3rZS2EC0ErjHM=
X-Gm-Gg: ASbGncuGgwd0KhbL2RL/rlP7ZKMC1wCbmwZFZ7NT7JGV0cq7iLwVkPRcMDe2HzZLL1o
 Q7h/ewULL4lyyzfwrf0OHmo6MExsZgqGvmgtoXOTZ+4g3SG/uBNvVdiCcqzdbs5JLTymfHXQW75
 aO3siaAxEDRJQi9cjj+EucArbT9a7l
X-Received: by 2002:a17:902:ecc2:b0:221:7e36:b13e with SMTP id
 d9443c01a7336-22428899c47mr249054415ad.12.1741640719531; 
 Mon, 10 Mar 2025 14:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5wrp2SAjaODSTEsMqdw26lZCCBtTA+nvIdOb+nHvG6BGCYzs2xvjfC9toAYKQXzhodsMRt/NxvVAToIlbbP8=
X-Received: by 2002:a17:902:ecc2:b0:221:7e36:b13e with SMTP id
 d9443c01a7336-22428899c47mr249054005ad.12.1741640719108; Mon, 10 Mar 2025
 14:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-44-jsnow@redhat.com>
 <878qpdzzl4.fsf@pond.sub.org>
In-Reply-To: <878qpdzzl4.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Mar 2025 17:05:07 -0400
X-Gm-Features: AQ5f1Jq668fRoOWlHsE05tqMvDaqCHY4eOACtPMCZkw_TpJ1dqihLfIZq6YxRJQ
Message-ID: <CAFn=p-aCgniz3nDYOketOE5Y6_GF7gaiOpV27H29RSwV7kaOag@mail.gmail.com>
Subject: Re: [PATCH v2 43/62] docs/qapidoc: add preamble() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000063b2db06300354c5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000063b2db06300354c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:03=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This method adds the options/preamble to each definition block. Notably=
,
> > :since: and :ifcond: are added, as are any "special features" such as
> > :deprecated: and :unstable:.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index cf5dbb0133d..d8bf0073dfa 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -37,7 +37,12 @@
> >  from docutils.parsers.rst import Directive, directives
> >  from docutils.statemachine import StringList
> >  from qapi.error import QAPIError
> > -from qapi.schema import QAPISchema, QAPISchemaVisitor
> > +from qapi.parser import QAPIDoc
> > +from qapi.schema import (
> > +    QAPISchema,
> > +    QAPISchemaDefinition,
> > +    QAPISchemaVisitor,
> > +)
> >  from qapi.source import QAPISourceInfo
> >
> >  from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
> > @@ -56,8 +61,6 @@
> >          Sequence,
> >      )
> >
> > -    from qapi.parser import QAPIDoc
> > -
>
> Accident?
>

I don't know. isort decided to move it and none of my tooling complains
about it.


>
> >      from sphinx.application import Sphinx
> >      from sphinx.util.typing import ExtensionMetadata
> >
> > @@ -125,6 +128,38 @@ def ensure_blank_line(self) -> None:
> >              # +2: correct for zero/one index, then increment by one.
> >              self.add_line_raw("", fname, line + 2)
> >
> > +    # Transmogrification helpers
> > +
> > +    def preamble(self, ent: QAPISchemaDefinition) -> None:
> > +        """
> > +        Generate option lines for qapi entity directives.
> > +        """
> > +        if ent.doc and ent.doc.since:
> > +            assert ent.doc.since.kind =3D=3D QAPIDoc.Kind.SINCE
> > +            # Generated from the entity's docblock; info location is
> exact.
> > +            self.add_line(f":since: {ent.doc.since.text}",
> ent.doc.since.info)
>
> Break the line aftee the comma?
>
> > +
> > +        if ent.ifcond.is_present():
> > +            doc =3D ent.ifcond.docgen()
> > +            assert ent.info
> > +            # Generated from entity definition; info location is
> approximate.
> > +            self.add_line(f":ifcond: {doc}", ent.info)
> > +
> > +        # Hoist special features such as :deprecated: and :unstable:
> > +        # into the options block for the entity. If, in the future, ne=
w
> > +        # special features are added, qapi-domain will chirp about
> > +        # unrecognized options and fail until they are handled in
> > +        # qapi-domain.
> > +        for feat in ent.features:
> > +            if feat.is_special():
> > +                # FIXME: handle ifcond if present. How to display that
>
> If I remember correctly, you wanted to mention this FIXME in the commit
> message.
>
> > +                # information is TBD.
> > +                # Generated from entity def; info location is
> approximate.
> > +                assert feat.info
> > +                self.add_line(f":{feat.name}:", feat.info)
> > +
> > +        self.ensure_blank_line()
> > +
> >      # Transmogrification core methods
> >
> >      def visit_module(self, path: str) -> None:
>
>

--00000000000063b2db06300354c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 9, =
2025 at 5:03=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This method adds the options/preamble to each definition block. Notabl=
y,<br>
&gt; :since: and :ifcond: are added, as are any &quot;special features&quot=
; such as<br>
&gt; :deprecated: and :unstable:.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++=
++---<br>
&gt;=C2=A0 1 file changed, 38 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index cf5dbb0133d..d8bf0073dfa 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -37,7 +37,12 @@<br>
&gt;=C2=A0 from docutils.parsers.rst import Directive, directives<br>
&gt;=C2=A0 from docutils.statemachine import StringList<br>
&gt;=C2=A0 from qapi.error import QAPIError<br>
&gt; -from qapi.schema import QAPISchema, QAPISchemaVisitor<br>
&gt; +from qapi.parser import QAPIDoc<br>
&gt; +from qapi.schema import (<br>
&gt; +=C2=A0 =C2=A0 QAPISchema,<br>
&gt; +=C2=A0 =C2=A0 QAPISchemaDefinition,<br>
&gt; +=C2=A0 =C2=A0 QAPISchemaVisitor,<br>
&gt; +)<br>
&gt;=C2=A0 from qapi.source import QAPISourceInfo<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from qapidoc_legacy import QAPISchemaGenRSTVisitor=C2=A0 # type:=
 ignore<br>
&gt; @@ -56,8 +61,6 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sequence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 from qapi.parser import QAPIDoc<br>
&gt; -<br>
<br>
Accident?<br></blockquote><div><br></div><div>I don&#39;t know. isort decid=
ed to move it and none of my tooling complains about it.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.application import Sphinx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.typing import ExtensionMetadata<b=
r>
&gt;=C2=A0 <br>
&gt; @@ -125,6 +128,38 @@ def ensure_blank_line(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # +2: correct for zero=
/one index, then increment by one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line_raw(&quo=
t;&quot;, fname, line + 2)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 # Transmogrification helpers<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def preamble(self, ent: QAPISchemaDefinition) -&gt; Non=
e:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Generate option lines for qapi entity dir=
ectives.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.doc and ent.doc.since:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert ent.doc.since.kind =
=3D=3D QAPIDoc.Kind.SINCE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from the entity=
&#39;s docblock; info location is exact.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&quot;:since=
: {ent.doc.since.text}&quot;, <a href=3D"http://ent.doc.since.info" rel=3D"=
noreferrer" target=3D"_blank">ent.doc.since.info</a>)<br>
<br>
Break the line aftee the comma?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.ifcond.is_present():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D ent.ifcond.docgen()=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert <a href=3D"http://en=
t.info" rel=3D"noreferrer" target=3D"_blank">ent.info</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from entity def=
inition; info location is approximate.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&quot;:ifcon=
d: {doc}&quot;, <a href=3D"http://ent.info" rel=3D"noreferrer" target=3D"_b=
lank">ent.info</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Hoist special features such as :depreca=
ted: and :unstable:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # into the options block for the entity. =
If, in the future, new<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # special features are added, qapi-domain=
 will chirp about<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # unrecognized options and fail until the=
y are handled in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # qapi-domain.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for feat in ent.features:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if feat.is_special():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: hand=
le ifcond if present. How to display that<br>
<br>
If I remember correctly, you wanted to mention this FIXME in the commit<br>
message.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # information=
 is TBD.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated f=
rom entity def; info location is approximate.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert <a hre=
f=3D"http://feat.info" rel=3D"noreferrer" target=3D"_blank">feat.info</a><b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line=
(f&quot;:{<a href=3D"http://feat.name" rel=3D"noreferrer" target=3D"_blank"=
>feat.name</a>}:&quot;, <a href=3D"http://feat.info" rel=3D"noreferrer" tar=
get=3D"_blank">feat.info</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Transmogrification core methods<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_module(self, path: str) -&gt; None:<br>
<br>
</blockquote></div></div>

--00000000000063b2db06300354c5--


