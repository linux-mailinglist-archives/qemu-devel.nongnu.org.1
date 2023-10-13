Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0217C7CDE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 07:02:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrAIm-0006Tp-Pr; Fri, 13 Oct 2023 01:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qrAIZ-0006S1-EN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qrAIP-0005XG-Co
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697173267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6ShuRlkxO8hDaXq3lvG3qR4Ma7HGNTGQKH5KWtQawo=;
 b=MeLAp/ZdwTYLxZa0ZSV+SMa42S3d89LhEOK0oRQS5kU8yHgzCiOHxjayhav7/0+JwV7zXe
 Qq/0Q7vdrTbsE1v1J33huI3VIRBmAKsTrZBtTf1cajsb6ZHAAe067o7XvsqWpUbgRa5T+A
 DHlQYhNfM+CaF+IIhonELAuefERbY98=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-5fT5n94xNFufc9JkzUAZzQ-1; Fri, 13 Oct 2023 01:01:05 -0400
X-MC-Unique: 5fT5n94xNFufc9JkzUAZzQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c296e65035so16068851fa.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 22:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697173264; x=1697778064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6ShuRlkxO8hDaXq3lvG3qR4Ma7HGNTGQKH5KWtQawo=;
 b=ckaGYUrgh3Bp040w1LUsFspHR4Crwp/rC1cDMmugThDAErA5XF0RhTlCIkuU/+YeSi
 pl70I4fHGyzxrJ4Ri8QFfINadzhpmEkU6GAN5vN8J9fthGw+QWuC5v1109Z/SvQ/Nt4/
 VzTVfjRwm8wUrV3+2KVHVK7OXz6BRSOA7AUXWIAjxMcuu7MCtWIp1pmxB8Ugc9ow8zkJ
 aLnDhyhD/6LbAGCGic/7VVcqoS/vfTnXBLh5nFbh+wDFN3X6eF6cLBN/4Ocm3wLb9pc1
 K1YQBe7/lEWz20Uk2kp9ix78QEpMQtnv/HmVkAIUNrFLDt+fgizKofLGgShygXcVSmWz
 dyIw==
X-Gm-Message-State: AOJu0YxHFC+wT+aPuuZXuU8pFmYOzrEYBtKIzviKnnCbJVdjG4F7qj7F
 KrtB6QsTQr8P/xmf1Nrz+5V4D80WqA4CSUTfo0WseOFZAiDp4Opy5gtf23+tFE9Mfhwtlk0QCve
 AtqmR0CvXkCtbVlFABHjNhP10wTseoZA=
X-Received: by 2002:a2e:820b:0:b0:2c2:c1f6:3097 with SMTP id
 w11-20020a2e820b000000b002c2c1f63097mr22602459ljg.22.1697173264336; 
 Thu, 12 Oct 2023 22:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCxCR6tgf7W5zyW0QEzzZ0EqvsRleBMpiwQOi/K7sbS9Z6vCO6A3j9fcD9AsI1EsJz+eZ+k5yvnwdc0iLkbg=
X-Received: by 2002:a2e:820b:0:b0:2c2:c1f6:3097 with SMTP id
 w11-20020a2e820b000000b002c2c1f63097mr22602441ljg.22.1697173263955; Thu, 12
 Oct 2023 22:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
In-Reply-To: <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 13:00:52 +0800
Message-ID: <CACGkMEuEs2MLJYKMB9qAgT2ixkKLC8LPPE6DsBvfwx0CEaCA_A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Fri, Oct 13, 2023 at 12:14=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2023/10/13 10:38, Jason Wang wrote:
> > On Wed, Oct 11, 2023 at 11:40=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> It was necessary since an Linux older than 2.6.35 may implement the
> >> virtio-net header but may not allow to change its length. Remove it
> >> since such an old Linux is no longer supported.
> >
> > Where can I see this agreement?
>
> docs/about/build-platforms.rst says:
>  > The project aims to support the most recent major version at all times
>  > for up to five years after its initial release. Support for the
>  > previous major version will be dropped 2 years after the new major
>  > version is released or when the vendor itself drops support, whichever
>  > comes first. In this context, third-party efforts to extend the
>  > lifetime of a distro are not considered, even when they are endorsed
>  > by the vendor (eg. Debian LTS); the same is true of repositories that
>  > contain packages backported from later releases (e.g. Debian
>  > backports). Within each major release, only the most recent minor
>  > release is considered.
>  >
>  > For the purposes of identifying supported software versions available
>  > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
>  > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
>  > similar software versions.

Well it also says:

"""
If a platform is not listed here, it does not imply that QEMU won't
work. If an unlisted platform has comparable software versions to a
listed platform, there is every expectation that it will work.
"""

A lot of downstream have customized build scripts.

And is something similar to such removal that has been done for other
subsystems?

Thanks

>
> All of the previous major versions of these distributions ship far newer
> kernels.
>
> CentOS Stream 8 and RHEL 8 ship 4.18.0.
> Debian bullseye ships 5.10.0.
> Fedora 37 ships 6.5.6.
> openSUSE Leap 15.4 ships 5.14.21.
> SLES 12 ships 4.12.14.
> Ubuntu 20.04 ships 5.4.
>


