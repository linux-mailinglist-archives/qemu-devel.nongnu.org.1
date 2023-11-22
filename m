Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7AD7F4BC3
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 16:58:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5pcL-0004Ud-Ji; Wed, 22 Nov 2023 10:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5pcJ-0004UV-Ag
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:58:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5pcH-0007fJ-Rl
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700668696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8WGq3M2cAnEu1qmpeMOqjhyHPElkrM6RGlzlrOGiG4Q=;
 b=QOTNSoNNznZc5ncjlUGMUmu08GB7leGFGUnMhABD5uaRoLM8G68rmK8/HYE1WUmlky5fBt
 SZI6ay/fKyVOwfQAN9hwI1IrjVJ/hcDQGLJfveQCMWjF5ikQzyTmVdGAVkqUtI/f7JBIxa
 hAArpy5gD1QqqiIGzG4WVJO5IuwEPnw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-vU4AkZfrNvepiJbvtoKTlA-1; Wed, 22 Nov 2023 10:58:15 -0500
X-MC-Unique: vU4AkZfrNvepiJbvtoKTlA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5b9344d72bbso8769907a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 07:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700668694; x=1701273494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WGq3M2cAnEu1qmpeMOqjhyHPElkrM6RGlzlrOGiG4Q=;
 b=rGVwVmsRsNosgnWLMTvR9oLp7aLZ68eSKV9BNAgv+UbIqf1og7/imLWqmETWun+3R4
 ptdzpy+CkXIkJUWJ/9F53A7B1aGsc3jO87lN4j8461TAvTcqVZvGutHlBR+/Fy/OFWam
 BXApqElUPkhEimOQNxASlvOjpit9s9jbibLm3ZD+dQd4ADTlnYtDJ9HRmoubsKtzTGke
 XrJk9J2HE1biWPsAzzgYr3ghf0OLSj+IQEYzYb3kCfzE94TWUgsH9WYrGjk0eVRTvgBC
 hYbXdS+76N8b3IxdSiXMkxUnkqJikuS/tmzSigNTydhv46PEBa1d3rmLZO5BHtDUqkkK
 USZA==
X-Gm-Message-State: AOJu0YyHPmBNsVl4PGClwRcqgsQQIvpNpwwVygGJG6VeQ3PHmGm3/k04
 dPyJmMjJwwnxFDEyHgbdYdOdMFJBS97nJo9D0OyWpZjvk4jERNFBVxO+Io6cKUMyNgAuhHmgk4w
 Hrbnij2COPGC7QPeWgKHunr1iirOZX2TlomRD92A=
X-Received: by 2002:a17:90b:3884:b0:285:24bb:457c with SMTP id
 mu4-20020a17090b388400b0028524bb457cmr2946840pjb.26.1700668693973; 
 Wed, 22 Nov 2023 07:58:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEAF66s6KjJxHfrv7rRF9CdOIkiCH5Ox5AjAeGgpYSCfQ7qPmgpbQT3KElwKe94UJP4LpwstTuQetXbiwema0=
X-Received: by 2002:a17:90b:3884:b0:285:24bb:457c with SMTP id
 mu4-20020a17090b388400b0028524bb457cmr2946822pjb.26.1700668693628; Wed, 22
 Nov 2023 07:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-12-jsnow@redhat.com>
 <874jhedjv0.fsf@pond.sub.org>
In-Reply-To: <874jhedjv0.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 22 Nov 2023 10:58:02 -0500
Message-ID: <CAFn=p-YZAZtX1SKAs2mFpGL7XhFPvsr68ipFqv+E_ZM_wV_Kig@mail.gmail.com>
Subject: Re: [PATCH 11/19] qapi/schema: fix QAPISchemaArrayType.check's call
 to resolve_type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Wed, Nov 22, 2023 at 7:59=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > There's more conditionals in here than we can reasonably pack into a
> > terse little statement, so break it apart into something more explicit.
> >
> > (When would a built-in array ever cause a QAPISemError? I don't know,
> > maybe never - but the type system wasn't happy all the same.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 462acb2bb61..164d86c4064 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -384,9 +384,16 @@ def need_has_if_optional(self):
> >
> >      def check(self, schema):
> >          super().check(schema)
> > +
> > +        if self.info:
> > +            assert self.info.defn_meta  # guaranteed to be set by expr=
.py
> > +            what =3D self.info.defn_meta
> > +        else:
> > +            what =3D 'built-in array'
> > +
> >          self._element_type =3D schema.resolve_type(
> > -            self._element_type_name, self.info,
> > -            self.info and self.info.defn_meta)
> > +            self._element_type_name, self.info, what
> > +        )
> >          assert not isinstance(self.element_type, QAPISchemaArrayType)
> >
> >      def set_module(self, schema):
>
> What problem are you solving here?
>

1. "self.info and self.info.defn_meta" is the wrong type ifn't self.info
2. self.info.defn_meta is *also* not guaranteed by static types

ultimately: we need to assert self.info and self.info.defn_meta both;
but it's possible (?) that we don't have self.info in the case that
we're a built-in array, so I handle that.


