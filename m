Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986BF7D4E70
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvF7I-00005T-UN; Tue, 24 Oct 2023 06:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qvF7F-0008WV-6u
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qvF7A-0003KZ-09
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698145102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOlCfx1d7+6T7Sze6bScVW5lBYsxC8hrEFVEgRCyqxo=;
 b=RJHZXD7gcgS7JE5AMrY2eGUTqmVAD0lqC2hhRvbDk08mANKMM7andRehPFCnouH+zi7eCs
 bDQJTPX9si1qTM2B3SvmDhOUQugatlWgMHXHF2igwZPBYnr6LzX5mdJtJFGeTmUmkIe3XD
 //AY/FlB6KJ7V9/iKuBJSF0QpTIxGkg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-ZaU9_UDFPiumOCwZ-_0eeg-1; Tue, 24 Oct 2023 06:58:21 -0400
X-MC-Unique: ZaU9_UDFPiumOCwZ-_0eeg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-54045f31f49so1491260a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698145100; x=1698749900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOlCfx1d7+6T7Sze6bScVW5lBYsxC8hrEFVEgRCyqxo=;
 b=f7ODKBObe+gCLX28NDBUMIC81jbq5iljpXmXYMEmxc3cwWKLFMuiX/Pj4jC7YnR3H8
 uJtFd2DKHuVKC5QJpIP/8MlWt47Atbaj2hqEPjRPl4D21YVN//aZ4oUmsWOjYNcxc//D
 0u/wHYRHMxqGNJLgdmfUcwT2DrMNe4hKpsnR0/d7kTHuzGfZ+p6JpRyPG4UqM8XZMtIb
 Rjn0rlWypgk3icfW/aEc8Umatpid91NMDdTEfsOqkKY6yobvX1DKQtg1RT9SrYyWrfUu
 5lQ2/Zfqqf7JH07KMWXDfuuYVS/zjMQZbw4w1bAd2k2xtcSP0xZ0snvePozkyBFf2SeR
 NEfA==
X-Gm-Message-State: AOJu0YyXjWj3ANAO8xD5ItRjOICAatE++o2TIHL6AW+TGqNShzNK9RLs
 MHsf1JtIpH3qOoqWHqf1LbqeDVhIV8HK8Ml0hMU//gdfjzWYps++eWkyYaOxgaoBdNVnbioqyg7
 GuIbJB+/PbGubLXMD+2VLfJOE1q+9mYo=
X-Received: by 2002:a05:6402:510d:b0:53e:4a78:e281 with SMTP id
 m13-20020a056402510d00b0053e4a78e281mr8996467edd.27.1698145099979; 
 Tue, 24 Oct 2023 03:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdL8bPK7iuOaamXQhCJsuHqUWuo6mOG9Ol6G+tnOLlGQKMrNv+K5i6w9bAcmD9JwjdbRxV5D5ZMoNeaFa8Xr0=
X-Received: by 2002:a05:6402:510d:b0:53e:4a78:e281 with SMTP id
 m13-20020a056402510d00b0053e4a78e281mr8996451edd.27.1698145099643; Tue, 24
 Oct 2023 03:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-10-marcandre.lureau@redhat.com>
 <87sf60z499.fsf@secure.mitica>
In-Reply-To: <87sf60z499.fsf@secure.mitica>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Oct 2023 14:58:08 +0400
Message-ID: <CAMxuvazf9_j=oqOrpCAcmhsai3n6rWBSa_X-bZXkRVQum7BQQQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] docs/migration: reflect the changes about needed
 subsections
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Tue, Oct 24, 2023 at 2:47=E2=80=AFPM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/devel/migration.rst | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> > index c3e1400c0c..50f313f178 100644
> > --- a/docs/devel/migration.rst
> > +++ b/docs/devel/migration.rst
> > @@ -240,17 +240,16 @@ a newer form of device, or adding that state that=
 you previously
> >  forgot to migrate.  This is best solved using a subsection.
> >
> >  A subsection is "like" a device vmstate, but with a particularity, it
> > -has a Boolean function that tells if that values are needed to be sent
> > -or not.  If this functions returns false, the subsection is not sent.
> > -Subsections have a unique name, that is looked for on the receiving
> > -side.
> > +has a Boolean function that tells if that values are needed or not. If
> > +this functions returns false, the subsection is not sent. Subsections
> > +have a unique name, that is looked for on the receiving side.
> >
> >  On the receiving side, if we found a subsection for a device that we
> > -don't understand, we just fail the migration.  If we understand all
> > -the subsections, then we load the state with success.  There's no chec=
k
> > -that a subsection is loaded, so a newer QEMU that knows about a subsec=
tion
> > -can (with care) load a stream from an older QEMU that didn't send
> > -the subsection.
> > +don't understand, we just fail the migration. If we understand all the
> > +subsections, then we load the state with success. There's no check
> > +that an optional subsection is loaded, so a newer QEMU that knows
> > +about a subsection can (with care) load a stream from an older QEMU
> > +that didn't send the subsection.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> Just wondering.  What device propmted you to write this series?

When I worked on ramfb, I did various testing with the subsection
handling and was surprised by the default lazy behaviour. I initially
thought it was a bug to ignore missing sections (both needed and
not-needed), then I realize from the doc that it was partially by
design. I thought it was clearer to make "needed' section actually
required on load as well. I wonder though of the potential of breakage
from old QEMU versions, how do we test cross-version migration? Do you
think also "needed" section are actually required? Perhaps we need
better wording and documentation instead...


