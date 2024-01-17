Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C1830A9B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:11:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8W0-00028C-Rv; Wed, 17 Jan 2024 11:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ8Vz-000282-9U
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ8Vx-0000uL-Ns
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705507901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg7AXnr0/YE59e4FnnWf9+zmM5NVtONlRbg+IDil1Sc=;
 b=Zf8YD1nh0/Tvkc0TP7i5JviLLXKaClfUBqMSJtQwiDLesJU12cygHBRL7Od8n3K/M0tydl
 YC2rdgeX4ljRCXhtBU5kH5E7bUJA6Kwk9EDYISEK0vUzoGKIUZjxnxu67RVKuU4O5Fg3yj
 nXf+Ol/pDfAg9P0OTU+64sTesDX3L2o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ZBUunaw5PISTx9-lqScuTA-1; Wed, 17 Jan 2024 11:11:38 -0500
X-MC-Unique: ZBUunaw5PISTx9-lqScuTA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d4a645af79so128449985ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705507897; x=1706112697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mg7AXnr0/YE59e4FnnWf9+zmM5NVtONlRbg+IDil1Sc=;
 b=polY6z3punkZz4TzispWl4r34VNgjckJyCDmTXhPKDuVNCmrqvEGgSDb9hzNLEdzg8
 KBcZAqoMpQgSC3Bm7YrUX8agDLeom6z9+aNedV0/M+Zldr79mXBLTsMbo9H8nPbE/1Ap
 nw61sWnS/JZRt88kb41hlAgQvvXXBo76Ax6YFgTld5hdGCfj5hUP0sUt8Bq6v3hGQIMr
 vM3FREDweCGw8kFaToLyU9iwEubIU1cyh87nXWUkzJZUNjjU9UYABYFWxn+vkmyLeWzn
 0dMhT30X38UBLDy7p9Dfs0giB2ENJPQ6PnJZo0uQ8UVlnnlmjmKbevNdMl9Je6cuLETu
 d3LQ==
X-Gm-Message-State: AOJu0Yxu4HYQBiWsmFpAExfb55zLFk/+3jQGTqKcvWRrzTBiDtdYbKVv
 kutF3wJpNb4woD0cJRI8iAMzt6Berzovs4cqkSiLd7UniRFDxvuP5+fNB/0+IhGMeSDRX7y/bua
 jvGbZRRgHNWbJ3un++IHfhUIxMkqa6GZD53Kk2hk=
X-Received: by 2002:a17:902:a585:b0:1d4:3e87:d446 with SMTP id
 az5-20020a170902a58500b001d43e87d446mr9164869plb.127.1705507897407; 
 Wed, 17 Jan 2024 08:11:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEP02YGelCEG9llprYoyLdjC0xdzCULQZgTdwjeTPLLRnWMTb5nqPK31Fi491FtREBVbhZuYbj8BPCd6JWY3A=
X-Received: by 2002:a17:902:a585:b0:1d4:3e87:d446 with SMTP id
 az5-20020a170902a58500b001d43e87d446mr9164855plb.127.1705507897093; Wed, 17
 Jan 2024 08:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-7-jsnow@redhat.com>
 <87bk9mbso1.fsf@pond.sub.org>
In-Reply-To: <87bk9mbso1.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 Jan 2024 11:11:26 -0500
Message-ID: <CAFn=p-aws3+SvHEtcX47RpO5qK8L_dmq51RChKkSsxaLPYYawQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] qapi/schema: make c_type() and json_type()
 abstract methods
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 15, 2024 at 9:03=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > These methods should always return a str, it's only the default abstrac=
t
> > implementation that doesn't. They can be marked "abstract", which
> > requires subclasses to override the method with the proper return type.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index e45d9545eda..8e25dd35562 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -16,6 +16,7 @@
> >
> >  # TODO catching name collisions in generated code would be nice
> >
> > +from abc import ABC, abstractmethod
> >  from collections import OrderedDict
> >  import os
> >  import re
> > @@ -253,10 +254,11 @@ def visit(self, visitor):
> >          visitor.visit_include(self._sub_module.name, self.info)
> >
> >
> > -class QAPISchemaType(QAPISchemaDefinition):
> > +class QAPISchemaType(QAPISchemaDefinition, ABC):
> >      # Return the C type for common use.
> >      # For the types we commonly box, this is a pointer type.
> > -    def c_type(self):
> > +    @abstractmethod
> > +    def c_type(self) -> str:
>
> You additionally add the type hint.  Suggest to either mention it in the
> commit message, or add it only together with the other type hints in
> PATCH 17.

Okie-dokey. (moved type hints to the big patch)

>
> >          pass
> >
> >      # Return the C type to be used in a parameter list.
> > @@ -267,7 +269,8 @@ def c_param_type(self):
> >      def c_unboxed_type(self):
> >          return self.c_type()
> >
> > -    def json_type(self):
> > +    @abstractmethod
> > +    def json_type(self) -> str:
>
> Likewise.
>
> >          pass
> >
> >      def alternate_qtype(self):
>


