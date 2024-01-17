Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E58BE830A61
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:07:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Ri-0005RP-S4; Wed, 17 Jan 2024 11:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ8Re-0005Qy-EU
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ8Rd-0000Ce-1g
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705507632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5yp2mtzsRMc20TlZavIcOmL37upnF0BO2CvpOIQSqg=;
 b=WxENkFy7Hac6rhRoZY6NeRVjhhDE1bHhQoS9LCWkqV9Ty9GD1oj8yExkXPZtlLq8IxRkGC
 ycn4M8UQ8Jvja4kdReTH5NKoIuBAdrmZ76zPzfSJ4o56N0ofKlPlfRd1eBAzs8dL1pnZkN
 FPQU8y+15oyD3d3uM69C1GhG+pE8eLI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-8yfZZEDUMbea5AVFKJ0CCg-1; Wed, 17 Jan 2024 11:07:10 -0500
X-MC-Unique: 8yfZZEDUMbea5AVFKJ0CCg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf1c5f68dcso7147819a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705507629; x=1706112429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5yp2mtzsRMc20TlZavIcOmL37upnF0BO2CvpOIQSqg=;
 b=s+NQEQnQbtIrCOx/iBZeU031M2tHhrmlYULP/pMgDle3RO3Bv+6rivVsDndD4wfurT
 x35shDRqGKwP0g5Q2iuxc9uOtp/6oCD28K6z6xpRWWUvYRbOEA2x7ev8IC4Xalg75/55
 AdtmGoy1AXFsBr6Hk5Q8caOALlx+NkzeW9cXJz9MdRHHsdtgNdS/pGdiQ6jKbMlfZdI/
 j/APBOmNjwJGwkYDPpYuydtxBL7hE/Yd7PWW8AKYXKzVHqlhmEyISA6t9CU8njYz9rwN
 ZkWMb+BqMo99I4nNRbgIefv+rAfEZkyXZX88eHwWav5ktK7S5z6RzSVK0nApwlNNwjtV
 grsQ==
X-Gm-Message-State: AOJu0YyOzVzO9IBuyOCKJ3Q9yQ5Uy/JVd+W7IQfeyLJbHmYePkljI+2Y
 KLmKsv3SguH2AKcU3b1jbjpomlV70ZY/gYGRLErETN3pNWVt6uVFFi3HK/6NNxVcqgAFi7iunWU
 GIcJUBjuqG027LKUJA9COkg52Q5urbhfi3hJTM+Y=
X-Received: by 2002:a17:902:9341:b0:1d5:d00:c197 with SMTP id
 g1-20020a170902934100b001d50d00c197mr8204158plp.19.1705507629332; 
 Wed, 17 Jan 2024 08:07:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJtoqet6oe2eRwJKiNOW09dGEaZ+wCdEKrtAwwOQVGWwJDJo9x9GMPAd2gohQ6Bovv00A3ZU97tXFfsCHzVmc=
X-Received: by 2002:a17:902:9341:b0:1d5:d00:c197 with SMTP id
 g1-20020a170902934100b001d50d00c197mr8204151plp.19.1705507628988; Wed, 17 Jan
 2024 08:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-6-jsnow@redhat.com>
 <87fryybsua.fsf@pond.sub.org>
In-Reply-To: <87fryybsua.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 Jan 2024 11:06:57 -0500
Message-ID: <CAFn=p-b+wEXpnDN+6MRytaFS7bHxy7OkycAnsXdtk8mEQDkGxA@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] qapi/schema: declare type for
 QAPISchemaArrayType.element_type
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

On Mon, Jan 15, 2024 at 8:59=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > This field should always be present and defined after check() is
> > called. Declare the property but allow its initialization to be delayed
> > until check() so that it can be typed without the use of `Optional`.
> >
> > This helps simplify typing by avoiding the need to interrogate the valu=
e
> > for None at multiple callsites; the overwhelming majority of uses assum=
e
> > a fully-initialized object.
>
> If you like my version of the previous patch's commit message, we could
> reuse it here.

Sure, I tweaked and re-used it.

--js

>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 48a51dcd188..e45d9545eda 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -389,7 +389,7 @@ def __init__(self, name, info, element_type):
> >          super().__init__(name, info, None)
> >          assert isinstance(element_type, str)
> >          self._element_type_name =3D element_type
> > -        self.element_type =3D None
> > +        self.element_type: QAPISchemaType
> >
> >      def need_has_if_optional(self):
> >          # When FOO is an array, we still need has_FOO to distinguish
>


