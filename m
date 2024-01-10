Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C803D829194
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 01:44:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNMgK-0001r4-DO; Tue, 09 Jan 2024 19:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNMgG-0001qt-CW
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 19:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNMgE-000540-1e
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 19:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704847368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSTDmCb5ebYUCfjLWjiuNxDqmdREt5vdbJqsTpzj2rM=;
 b=WcntKW2efN046oK++S5D4wMmztbbEVA+3L6s9mDji8GgQWYsHOzOk8su9BSohIxbWVVifc
 B7mVW/1RdhS3UiH5WKg/s2uTPTLzj+gFXtfmwsseCCHIxfu/kUnW2OyyQOBTP6O0gNsmpb
 w8Pc33TaZ12w1Gz4u/qhmxC9u3CZrlE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-HSREt08tM1WcSfxyrbfgxA-1; Tue, 09 Jan 2024 19:42:47 -0500
X-MC-Unique: HSREt08tM1WcSfxyrbfgxA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d2fa6b23eso28525485e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 16:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704847366; x=1705452166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSTDmCb5ebYUCfjLWjiuNxDqmdREt5vdbJqsTpzj2rM=;
 b=HspH9ZJDYdnC6HhnHDuEtg2F48NpV9dGrrSGYi1YF+Yd/384AaYsLQ8PwDjwgc6vFE
 jRuw4cAdNJcdpMmYUwb/NAC3vclBibNs6RR5bsPeGDTStmCWmQjkbLMuxPlzzLKulySh
 QPE588im2YnpH4z+ytPQMbFQtvCy0EGJ1LXwyyEdJgFfMx6uFrIqlTJGQjf1PkJWynG7
 90btEoPsXLRHpzhHEoZ9jpJ2igP7/EmX1VQxJjC0BPKWMMJPDkOguvVmiWdLh7oDVeG8
 J3K4wLN/kB9UruJarKwmZ3rp+TM0E9lwQiXmnwfZ+3b25mxt6Gq+t3Hw+gtHvEvUGbXW
 7uJQ==
X-Gm-Message-State: AOJu0YygJ9RVKXfjBgO6NomX+IB21MFJ+yy/NGdSYsp/X3LENQgIXNRb
 yXyhsBbtpcAvVFMqbIofWJVJEXyUUwtMosUXxHL+ptxEyr71U2FoSDnN0YsZipleKRHjSTwMGyI
 vDMZFYtj8qX/kV5PzsPQ/bdjwkSH+2UeNnIfeKzo=
X-Received: by 2002:a05:600c:5403:b0:40e:43a0:2a0e with SMTP id
 he3-20020a05600c540300b0040e43a02a0emr51593wmb.223.1704847365982; 
 Tue, 09 Jan 2024 16:42:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFel2sACCrxWaQ+0t1NAczXU5+W/GCkxb3KBcESszeXp2qaWeLxlBw2ttvfsk32l/9yaMxVAXwAE6HoMRZTdpE=
X-Received: by 2002:a05:600c:5403:b0:40e:43a0:2a0e with SMTP id
 he3-20020a05600c540300b0040e43a02a0emr51587wmb.223.1704847365654; Tue, 09 Jan
 2024 16:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-15-jsnow@redhat.com>
 <87a5r44lxs.fsf@pond.sub.org>
In-Reply-To: <87a5r44lxs.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jan 2024 19:42:33 -0500
Message-ID: <CAFn=p-Yhq2Jg42ZDbsfcqz0iLGV4vTgxvDBadkZCTn5aMNUh+g@mail.gmail.com>
Subject: Re: [PATCH 14/19] qapi/schema: assert QAPISchemaVariants are
 QAPISchemaObjectType
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 23, 2023 at 8:51=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > I'm actually not too sure about this one, it seems to hold up at runtim=
e
> > but instead of lying and coming up with an elaborate ruse as a commit
> > message I'm just going to admit I just cribbed my own notes from the
> > last time I typed schema.py and I no longer remember why or if this is
> > correct.
> >
> > Cool!
> >
> > With more seriousness, variants are only guaranteed to house a
> > QAPISchemaType as per the definition of QAPISchemaObjectTypeMember but
> > the only classes/types that have a check_clash method are descendents o=
f
> > QAPISchemaMember and the QAPISchemaVariants class itself.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 476b19aed61..ce5b01b3182 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -717,6 +717,7 @@ def check_clash(self, info, seen):
> >          for v in self.variants:
> >              # Reset seen map for each variant, since qapi names from o=
ne
> >              # branch do not affect another branch
> > +            assert isinstance(v.type, QAPISchemaObjectType)  # I think=
, anyway?
> >              v.type.check_clash(info, dict(seen))
>
> Have a look at .check() right above:
>
>        def check(
>            self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
>        ) -> None:
>            [...]
>            if not self.variants:
>                raise QAPISemError(self.info, "union has no branches")
>            for v in self.variants:
>                v.check(schema)
>                # Union names must match enum values; alternate names are
>                # checked separately. Use 'seen' to tell the two apart.
>                if seen:
>                    if v.name not in self.tag_member.type.member_names():
>                        raise QAPISemError(
>                            self.info,
>                            "branch '%s' is not a value of %s"
>                            % (v.name, self.tag_member.type.describe()))
> --->               if not isinstance(v.type, QAPISchemaObjectType):
> --->                   raise QAPISemError(
>                            self.info,
>                            "%s cannot use %s"
>                            % (v.describe(self.info), v.type.describe()))
>                    v.type.check(schema)
>
> Since .check() runs before .check_clash(), your assertion holds.
>
> Clearer now?
>

OK, I think this just needs a better commit message and comment, then.

--js


