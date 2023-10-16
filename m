Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD57C9EAE
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 07:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsG6o-0002hT-1t; Mon, 16 Oct 2023 01:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qsG6l-0002hK-UK
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 01:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qsG6k-0003cz-8U
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 01:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697433936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtvdtLk47cjCWpkFthBwPhpUY8fE3XoyOli0wH32fjU=;
 b=QQJuXbptJEzeYKicljEJ0sDUcJc3HI3iHJ0poF+QulcEBsmHV+LHorWE39ESV7WtH5GGEP
 ytUfbszjW/puTjq9KazxZYUcvQ4CCrOEEQg4K3J4iHAdB7zfMVWK7uGWkZof1JjJ4JncLS
 GYoN4yx304e1QA4XkkAK7ZLpcX7U4b8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-TJxeFAb5NwS34xeFcybJeg-1; Mon, 16 Oct 2023 01:25:34 -0400
X-MC-Unique: TJxeFAb5NwS34xeFcybJeg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5043353efbdso3627060e87.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 22:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697433933; x=1698038733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtvdtLk47cjCWpkFthBwPhpUY8fE3XoyOli0wH32fjU=;
 b=SEF0HoZ+BzTOwDVAF5QWTY/D0xmr1oJH+znDaqsTcXcVbyFR2oMRy9FTh7wOjN17bU
 n2D/zMQ3VbOfVrTC/3Ag38GtCpa/S4Ifkmawe3fawt/KOfUrHshngxezFT87QL5c7CY2
 YvNMIyRXLIJzjAMYKUY2hVjL6nfeh0EPUBOocPCRlOoX+kFFPqus9ZYaAnSK3WAmdAAv
 pya0MSn3F+F3VPRwPJwH67NjctZgHsHtIWL4XEQpXWA9EXjuOFmf013wFG5vaGb4ZvWj
 BEnxSK4hIrn9gkX6hQEdv8GXtIomEwTXYHpfVAnz2Ham65hQreuvrwCBwNBSV4xCZEej
 Dc7g==
X-Gm-Message-State: AOJu0Yw8nE/tsSMf2bu0Fn4bErqFP1m8e5znV5fOQiH5yBsmugQ5V99b
 OZUB2Djq+IXPxb7tz+iY5OZ+ePWpLM8GXNZx8A5KGI04mnrtnakAVv6ACJn7u0gRUxRvUsJgsip
 roHDVzf0tY0itpkHR54epnhHKDcR6QgA=
X-Received: by 2002:a19:6d1a:0:b0:4ff:7e80:4f1d with SMTP id
 i26-20020a196d1a000000b004ff7e804f1dmr25267089lfc.57.1697433932810; 
 Sun, 15 Oct 2023 22:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF8R+iEtpO7gf0PsvjvgHzDVHRFwuGQ/Z8PMZjVCvFsjsojOzcPmE5VmrbJVu6NNcrdpNFPXETt8VlGOxHTI4=
X-Received: by 2002:a19:6d1a:0:b0:4ff:7e80:4f1d with SMTP id
 i26-20020a196d1a000000b004ff7e804f1dmr25267078lfc.57.1697433932440; Sun, 15
 Oct 2023 22:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
 <CACGkMEuEs2MLJYKMB9qAgT2ixkKLC8LPPE6DsBvfwx0CEaCA_A@mail.gmail.com>
 <12412f11-4395-460f-9523-930ad9270188@daynix.com>
In-Reply-To: <12412f11-4395-460f-9523-930ad9270188@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Oct 2023 13:25:21 +0800
Message-ID: <CACGkMEvg37na-2rUAjUoJOhLrKg+mz+O_D_=UnMJr-qoxPSkLQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Fri, Oct 13, 2023 at 1:26=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/10/13 14:00, Jason Wang wrote:
> > On Fri, Oct 13, 2023 at 12:14=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2023/10/13 10:38, Jason Wang wrote:
> >>> On Wed, Oct 11, 2023 at 11:40=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> It was necessary since an Linux older than 2.6.35 may implement the
> >>>> virtio-net header but may not allow to change its length. Remove it
> >>>> since such an old Linux is no longer supported.
> >>>
> >>> Where can I see this agreement?
> >>
> >> docs/about/build-platforms.rst says:
> >>   > The project aims to support the most recent major version at all t=
imes
> >>   > for up to five years after its initial release. Support for the
> >>   > previous major version will be dropped 2 years after the new major
> >>   > version is released or when the vendor itself drops support, which=
ever
> >>   > comes first. In this context, third-party efforts to extend the
> >>   > lifetime of a distro are not considered, even when they are endors=
ed
> >>   > by the vendor (eg. Debian LTS); the same is true of repositories t=
hat
> >>   > contain packages backported from later releases (e.g. Debian
> >>   > backports). Within each major release, only the most recent minor
> >>   > release is considered.
> >>   >
> >>   > For the purposes of identifying supported software versions availa=
ble
> >>   > on Linux, the project will look at CentOS, Debian, Fedora, openSUS=
E,
> >>   > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
> >>   > similar software versions.
> >
> > Well it also says:
> >
> > """
> > If a platform is not listed here, it does not imply that QEMU won't
> > work. If an unlisted platform has comparable software versions to a
> > listed platform, there is every expectation that it will work.
> > """
> >
> > A lot of downstream have customized build scripts.
>
> Still Linux versions older than 2.6.35 do not look like "comparable
> software versions to a listed platform" in my opinion.

Linux provides ABI compatibility so I don't know why, unless there is
a strong dependency on a specific new syscall introduced after 2.6.35.

>
> > And is something similar to such removal that has been done for other
> > subsystems?
>
> With commit c42e77a90d ("qemu/osdep: Remove fallback for
> MAP_FIXED_NOREPLACE"), I remove the support for glibc older than 2.28.
> Linux 2.6.35 is even older.
>

Ok, this explains things a little bit. Btw, we also have soliars
support for TAP, time to drop that as well?

Thanks


