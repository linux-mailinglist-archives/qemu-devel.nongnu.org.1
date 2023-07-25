Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7A76217A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:35:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMr9-0004TS-6Y; Tue, 25 Jul 2023 14:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOMr6-0004ST-3A
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOMr1-0008Aj-9A
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690310030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BykIYyQpxrvywt/Y7yWLAGT2hcQ2rP6iIkuZn6U5BdY=;
 b=Akc17bPXKxrE9bTixWG4PaBKDmQDtyoFhmTIfeAB5OkCdGweY+IcFi+Ocr/vNi/1aX5ieG
 pQgPWmpSQEDdXtdv6v9UgkJQwl6Aj+nnJ+7UxBcQF81dUGE3HwbP9gt8LWx3iitPIrAh4S
 EjZHn1mFtqpmKJq2ww4H9OjUD8aHNj8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-HNWt-ZCCPYm7rq14WnHtaQ-1; Tue, 25 Jul 2023 14:33:49 -0400
X-MC-Unique: HNWt-ZCCPYm7rq14WnHtaQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-26814a011deso1251440a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 11:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690310028; x=1690914828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BykIYyQpxrvywt/Y7yWLAGT2hcQ2rP6iIkuZn6U5BdY=;
 b=dniyCulEFyZblX2N2NYIpyqusJEskzrNzxBZio76xRiTBjbRlqG4W4+hiC51Tu1ipd
 RMf/mMD5+soiqFZ4C+K1f/MJslBJiAOWZ9gMo3VB+jhNozieCDQ+2cmyhAF//LMl3Fnv
 BI+nr72noiQF+gyXWZ0gDp345LjNlBYwSntf/5JBhjy8a5SiUQXWQ5eobyIYVuPebjKF
 0Fj5tOSuU0DgzBw0J43hnJ+4KYPpNYUaJ7mAhY/XM1X+NGbGa1sLb5FrWkaxLmSFEp8s
 vF5ai11RiOHmrBIk80goXu3SLw5vjEbVFxwp7PTzvQl9qIQ/TB3jFDi/QvQ8AoVONOFs
 vu/A==
X-Gm-Message-State: ABy/qLaf4U8rUKyBwdcNuL1siFzIgun1bQuDphiQvERa6Rj2VHvQu5Cr
 HnlzRSen8jwaNJnQWeT4UTLPiTlcJyZbvdfKL9hbKo9K1SsgcPO4esycFv7r+vxitv9gYM2iLa5
 4so5xLggvlZZyFUDLz9MM8daEJKgUFs8=
X-Received: by 2002:a17:90a:bc8:b0:262:fe45:85f6 with SMTP id
 x8-20020a17090a0bc800b00262fe4585f6mr41291pjd.0.1690310028157; 
 Tue, 25 Jul 2023 11:33:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGW4ydq6C2FAGdNCfFyO+q59bHZU7hBi9C7Cg5YMxn8P9QkQy+DflMaJrrPvTKRJabhCroEOLCGVFxUz6QOS1E=
X-Received: by 2002:a17:90a:bc8:b0:262:fe45:85f6 with SMTP id
 x8-20020a17090a0bc800b00262fe4585f6mr41272pjd.0.1690310027842; Tue, 25 Jul
 2023 11:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-7-jsnow@redhat.com>
 <ZMAT60PpKSIAemZ7@redhat.com>
In-Reply-To: <ZMAT60PpKSIAemZ7@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Jul 2023 14:33:36 -0400
Message-ID: <CAFn=p-YTohvmxET2kk1NWU1X=psVcD1M0oS7BDEZUH521DEQ_w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] python/machine: remove unused sock_dir argument
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 25, 2023 at 2:26=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Jul 25, 2023 at 02:03:37PM -0400, John Snow wrote:
> > By using a socketpair for all of the sockets managed by the VM class an=
d
> > its extensions, we don't need the sock_dir argument anymore, so remove
> > it.
> >
> > We only added this argument so that we could specify a second, shorter
> > temporary directory for cases where the temp/log dirs were "too long" a=
s
> > a socket name on macOS. We don't need it for this class now. In one
> > case, avocado testing takes over responsibility for creating an
> > appropriate sockdir.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/qemu/machine/machine.py             | 18 ------------------
> >  python/qemu/machine/qtest.py               |  5 +----
> >  tests/avocado/acpi-bits.py                 |  5 +----
> >  tests/avocado/avocado_qemu/__init__.py     |  2 +-
> >  tests/avocado/machine_aspeed.py            |  5 ++++-
> >  tests/qemu-iotests/iotests.py              |  2 +-
> >  tests/qemu-iotests/tests/copy-before-write |  3 +--
> >  7 files changed, 9 insertions(+), 31 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Thanks!

I don't know if we want this for *this* cycle or not, it's "only
testing code" and it should hopefully be harmless. If it makes the
tests more reliable, it might be worth it. I don't have strong
feelings one way or the other, we've lived without it for so long
as-is.

I'll see what Peter says.

--js

> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


