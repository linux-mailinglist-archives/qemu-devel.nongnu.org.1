Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B756E830B70
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:49:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ95l-0007ts-MY; Wed, 17 Jan 2024 11:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ95j-0007sk-J3
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ95h-0002YJ-M0
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705510114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEJxPoL1rBUcNmHCjC8b6uEbkkQZKtfQv7MmC3gECek=;
 b=b2nTO4YWu/GCb1Gs9oR19sluyutulJRvn6LoFjawAqNu5JP1AZqF1bcqRl4V5hUIQ3v1bI
 pTaB4igOnlS+fK2292ZRufHQL9kLjrB5TIMNesK/owYrxUA0loY08Wyy9zFV3Bl4z3EIrU
 myzbjUJUnVgXkDD7ISLshbkvTHKCks0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113--NKXwm6VNQ29MjiKnnEjLA-1; Wed, 17 Jan 2024 11:48:32 -0500
X-MC-Unique: -NKXwm6VNQ29MjiKnnEjLA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c659339436so3959846a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705510112; x=1706114912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEJxPoL1rBUcNmHCjC8b6uEbkkQZKtfQv7MmC3gECek=;
 b=gu4C53RNc+TNpGqmE9gBADRYudgXJtOdS4xXZ5v3FBZr1zNCh95+4KSPFJv3A3KTV7
 7+xPlJdU4v2jqjOvPzrvjpTOdCVY6efHoihXRky/j1xqTD38EUtOGyB4nRAerGUaw/Df
 ZajBmVuI/vqeiLWeclozZt3zh13vw3F1lN4EhH0EhbnzrcjLhVp+GFrWp9NbpsiBHFo3
 3srIxuc0/RlbYU3HlepcierKXGJgQ0NsPv24jIenj/F4gputFU2Vb0EEaJxYOc5QS6Ci
 35KcAqmJYppFH4U+eDgB9YB6mo/Rwgt+dey76k3MfLXJF8+Lz/2DRnt+/UeGlLH3X7qw
 e6cw==
X-Gm-Message-State: AOJu0YwFKNL56vxKwOmEF0inmCdjidS6BDbjx8LkCQqvaKtdoY0BoFrf
 pmCKshSDlAm77vzlgeTnYS2cwfAodKQZXUhX9PMLjEX8XOF5hKKgF2O63Ss/mqzUExVoxh1cNwS
 bMgwwTwnPkOsUyZHuL0qMYrE5m8CjpMtO6v2PZSA=
X-Received: by 2002:a17:90b:2302:b0:28f:ef6c:784d with SMTP id
 mt2-20020a17090b230200b0028fef6c784dmr1359369pjb.71.1705510111868; 
 Wed, 17 Jan 2024 08:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIhe9Q8/3naa6QKWgWWaE3QniFqsj0bZFrHT6E+M9ASXOKoPURvPa1Xcjv9J25h3awK0m2tLUmoUYAEuCF66A=
X-Received: by 2002:a17:90b:2302:b0:28f:ef6c:784d with SMTP id
 mt2-20020a17090b230200b0028fef6c784dmr1359360pjb.71.1705510111591; Wed, 17
 Jan 2024 08:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-12-jsnow@redhat.com>
 <87le8ptqv7.fsf@pond.sub.org>
In-Reply-To: <87le8ptqv7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 Jan 2024 11:48:20 -0500
Message-ID: <CAFn=p-YuZhn5tBBvkTeDvFH+Sgt0knnpjcJb003FX1FUsBnrXw@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] qapi/schema: fix QAPISchemaArrayType.check's
 call to resolve_type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Tue, Jan 16, 2024 at 7:17=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Adjust the expression at the callsite to eliminate weak type
> > introspection that believes this value can resolve to QAPISourceInfo; i=
t
> > cannot.
>
> What do you mean by "weak type introspection"?  mypy being underpowered?

Yeah, s'what I meant.

>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 35638c7708a..43af756ed47 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -403,7 +403,7 @@ def check(self, schema):
> >          super().check(schema)
> >          self.element_type =3D schema.resolve_type(
> >              self._element_type_name, self.info,
> > -            self.info and self.info.defn_meta)
> > +            self.info.defn_meta if self.info else None)
> >          assert not isinstance(self.element_type, QAPISchemaArrayType)
> >
> >      def set_module(self, schema):
>


