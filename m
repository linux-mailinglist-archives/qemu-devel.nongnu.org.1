Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E267D7C883B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJgI-0003OR-Lg; Fri, 13 Oct 2023 11:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrJg1-0003Le-9W
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrJfu-0005i1-Dp
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697209320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIkHBzEZWx5EnuyBfCyNdTs0+GcSxqMb3f5Ja523vEM=;
 b=VTgRiHd7zMVpHGCYDG0XTDk5m79A16TR4tJpRwfohkBfnNHfX2PQt4uqmwQFR+DFf7Kx4W
 QG+e9+n/gsJnzdDsD/NDSH3XYC86ToepzS9xltLwO26qDOQ33z4ZK6m7AI2eKWryxOiEC3
 WZ2ODlhR+kiaFnlxpG3KkE3HRwSezgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Iv5jdPuMOIWzgCoUa-cq6w-1; Fri, 13 Oct 2023 11:01:54 -0400
X-MC-Unique: Iv5jdPuMOIWzgCoUa-cq6w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4065ca278b3so15524085e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697209313; x=1697814113;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EIkHBzEZWx5EnuyBfCyNdTs0+GcSxqMb3f5Ja523vEM=;
 b=YjXUZInOjI1FhiOcIo5IqrT/wmvCJWRYWR/ewVRSrOubo2s3ZLFyEyOUcoeV7gqQpX
 DJvrosf3WbbXcRoKGsfVN0d0PgdxfYSmfhirqlxe3SXMNGU4x6LTblTVxINzXDCuoyQ6
 tM8Q8cK14hFP9ecj1J5VK2xZXIA/5S0YTVdu9RKKgE5pzfAnaWQHqNo2hAN/UjLeKIsr
 m3wnjiOp6zqA03A7fOoRT5SKVjGzr1trmdYwU2rjyfj3PU2v/xZ8EDCDGsd/ftMBcMWq
 3WKQHjCNWnQVM2PA0klQEMLcdawgfQVd76FqvJfL+sr6/rlwFfrdU+5Uxtr05tJS0CPz
 AsHw==
X-Gm-Message-State: AOJu0YyRqUxHAGggXQ0cmyLKO+kHRHZxQCrrDWH5mhcD0ZPDTjaLgapB
 rIWmwMOcFgeqp+pj7tjEugLWuaScOb1Wg4CCvY+pOe5Ls0JkE8xAUZ5J5kf45l9yig76n2l0dUF
 CgacLosJTfOdETm7LZq4PLlWsOw==
X-Received: by 2002:a7b:cc8f:0:b0:403:7b2:6d8f with SMTP id
 p15-20020a7bcc8f000000b0040307b26d8fmr23816646wma.2.1697209312740; 
 Fri, 13 Oct 2023 08:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMP5qQdKPYGjFKwUDPn5pTkD6rYn42IGMy6AKI9+gXgGAZ0OOucT/hlmQShQDIFREgGC7S5w==
X-Received: by 2002:a7b:cc8f:0:b0:403:7b2:6d8f with SMTP id
 p15-20020a7bcc8f000000b0040307b26d8fmr23816612wma.2.1697209312318; 
 Fri, 13 Oct 2023 08:01:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:cf7d:d542:c2ef:a65c:aaad])
 by smtp.gmail.com with ESMTPSA id
 az25-20020a05600c601900b003fc16ee2864sm345413wmb.48.2023.10.13.08.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:01:51 -0700 (PDT)
Date: Fri, 13 Oct 2023 11:01:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
Message-ID: <20231013110140-mutt-send-email-mst@kernel.org>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
 <CACGkMEuEs2MLJYKMB9qAgT2ixkKLC8LPPE6DsBvfwx0CEaCA_A@mail.gmail.com>
 <12412f11-4395-460f-9523-930ad9270188@daynix.com>
 <20231013101508-mutt-send-email-mst@kernel.org>
 <29fef0dd-86b6-4cd6-bbbc-812b832d8fcf@daynix.com>
 <20231013103151-mutt-send-email-mst@kernel.org>
 <fd3ddb90-83e2-4f48-bf31-227f632af027@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3ddb90-83e2-4f48-bf31-227f632af027@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Oct 13, 2023 at 11:34:54PM +0900, Akihiko Odaki wrote:
> On 2023/10/13 23:32, Michael S. Tsirkin wrote:
> > On Fri, Oct 13, 2023 at 11:22:10PM +0900, Akihiko Odaki wrote:
> > > On 2023/10/13 23:17, Michael S. Tsirkin wrote:
> > > > On Fri, Oct 13, 2023 at 02:26:03PM +0900, Akihiko Odaki wrote:
> > > > > On 2023/10/13 14:00, Jason Wang wrote:
> > > > > > On Fri, Oct 13, 2023 at 12:14 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > > > > > 
> > > > > > > On 2023/10/13 10:38, Jason Wang wrote:
> > > > > > > > On Wed, Oct 11, 2023 at 11:40 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > > > > > > > 
> > > > > > > > > It was necessary since an Linux older than 2.6.35 may implement the
> > > > > > > > > virtio-net header but may not allow to change its length. Remove it
> > > > > > > > > since such an old Linux is no longer supported.
> > > > > > > > 
> > > > > > > > Where can I see this agreement?
> > > > > > > 
> > > > > > > docs/about/build-platforms.rst says:
> > > > > > >     > The project aims to support the most recent major version at all times
> > > > > > >     > for up to five years after its initial release. Support for the
> > > > > > >     > previous major version will be dropped 2 years after the new major
> > > > > > >     > version is released or when the vendor itself drops support, whichever
> > > > > > >     > comes first. In this context, third-party efforts to extend the
> > > > > > >     > lifetime of a distro are not considered, even when they are endorsed
> > > > > > >     > by the vendor (eg. Debian LTS); the same is true of repositories that
> > > > > > >     > contain packages backported from later releases (e.g. Debian
> > > > > > >     > backports). Within each major release, only the most recent minor
> > > > > > >     > release is considered.
> > > > > > >     >
> > > > > > >     > For the purposes of identifying supported software versions available
> > > > > > >     > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
> > > > > > >     > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
> > > > > > >     > similar software versions.
> > > > > > 
> > > > > > Well it also says:
> > > > > > 
> > > > > > """
> > > > > > If a platform is not listed here, it does not imply that QEMU won't
> > > > > > work. If an unlisted platform has comparable software versions to a
> > > > > > listed platform, there is every expectation that it will work.
> > > > > > """
> > > > > > 
> > > > > > A lot of downstream have customized build scripts.
> > > > > 
> > > > > Still Linux versions older than 2.6.35 do not look like "comparable software
> > > > > versions to a listed platform" in my opinion.
> > > > 
> > > > 
> > > > This is fine - I would be ok to replace support with an error message
> > > > and failure. Not checking that a capability is supported however
> > > > isn't a good idea. And once we do - do we still gain anything by
> > > > not working around that?
> > > 
> > > tap does still check if setting the header length succeeds so it should be
> > > fine.
> > 
> > It asserts though doesn't it? Hardly user friendly ...
> 
> It prints an error message so the user should be able to figure out what's
> missing:
>         fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
>                 strerror(errno));

OK.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


