Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFC7C8740
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIdr-00033i-MH; Fri, 13 Oct 2023 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrIdp-000337-ET
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrIdn-0000SN-U7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697205346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDMvw+UKdeoXI2h/Js5thn1FtpWB+ogRCxKyq4iV/ig=;
 b=ShLmDcxvcOre4jJT2Dc8grM/I+PeWzFWPhy2ouz2ZXWqbGtoA1HSIVDjksBybCwl/7bBYQ
 C/TsAAqkie11iXc4RUyoXCgEWNy3p4Wb1lJHLLntaJBhsSL5QQAk2W2ISkWltHWHAOgX6E
 3S4nEUigrYe18Arul5ps0hv40XbzfAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-qfS1MNd8MLmxR1H8PWgFGA-1; Fri, 13 Oct 2023 09:55:29 -0400
X-MC-Unique: qfS1MNd8MLmxR1H8PWgFGA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4065478afd3so18706845e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205328; x=1697810128;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cDMvw+UKdeoXI2h/Js5thn1FtpWB+ogRCxKyq4iV/ig=;
 b=hLuGrOVQ0hEna6yKyh9cgJubsPT0TnSo9GcZLXdZ+v+0TYc1Ouu3klqBNJ/xrKP+Jj
 0uX9pIQ8xC8dIX+uSsmsT38OYPRirtCdlt3wXnDYSdt6dIs3L8vHMhjIPy50tnEDCX5g
 ekwWYxUpGuZUqBpbldd/U/uqgQ6opcuwlWfgSodYSEoNKtEjlJXVgxLUyayq94CiNoCM
 1+EFu3PJjKgwfwFZ/Jdd47yorTnnX/oI7d1KhWdt+LguDPiN2YtT18CNwg+kdgoADkB0
 G8xSdbNo/odNABhNEONjLfZJmbJOTEGUG1Dja4iMCMZmCpzvCLoWcML5pdmGxhop1eg4
 MphQ==
X-Gm-Message-State: AOJu0YzbIcfb14qcxaAXCAbhXjzOhobayI/eXpdel8ctPnFlWMj7Udky
 BVwWDPybOJC7LgdQ+MGfaxMjvxHPHDTGQgi8bx/Mb6xa07nO5k4Lh2qcmzfZxa4R5ZoYkC3Ei4X
 PfuRh/cU+nvSWqjw=
X-Received: by 2002:adf:e852:0:b0:315:9e1b:4ea6 with SMTP id
 d18-20020adfe852000000b003159e1b4ea6mr22686358wrn.58.1697205328048; 
 Fri, 13 Oct 2023 06:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdtkpv71xOUPXEc5m69gfIhAX4Zjt83avzG+2MZj5z5Nprf4604rrTmnbiS1Snw1nc0zyAyQ==
X-Received: by 2002:adf:e852:0:b0:315:9e1b:4ea6 with SMTP id
 d18-20020adfe852000000b003159e1b4ea6mr22686342wrn.58.1697205327740; 
 Fri, 13 Oct 2023 06:55:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:cf7d:d542:c2ef:a65c:aaad])
 by smtp.gmail.com with ESMTPSA id
 h12-20020adff18c000000b003232380ffd7sm20940730wro.102.2023.10.13.06.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 06:55:27 -0700 (PDT)
Date: Fri, 13 Oct 2023 09:55:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
Message-ID: <20231013095407-mutt-send-email-mst@kernel.org>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
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

On Fri, Oct 13, 2023 at 01:14:32PM +0900, Akihiko Odaki wrote:
> On 2023/10/13 10:38, Jason Wang wrote:
> > On Wed, Oct 11, 2023 at 11:40 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > 
> > > It was necessary since an Linux older than 2.6.35 may implement the
> > > virtio-net header but may not allow to change its length. Remove it
> > > since such an old Linux is no longer supported.
> > 
> > Where can I see this agreement?
> 
> docs/about/build-platforms.rst says:
> > The project aims to support the most recent major version at all times
> > for up to five years after its initial release. Support for the
> > previous major version will be dropped 2 years after the new major
> > version is released or when the vendor itself drops support, whichever
> > comes first. In this context, third-party efforts to extend the
> > lifetime of a distro are not considered, even when they are endorsed
> > by the vendor (eg. Debian LTS); the same is true of repositories that
> > contain packages backported from later releases (e.g. Debian
> > backports). Within each major release, only the most recent minor
> > release is considered.
> >
> > For the purposes of identifying supported software versions available
> > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
> > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
> > similar software versions.
> 
> All of the previous major versions of these distributions ship far newer
> kernels.
> 
> CentOS Stream 8 and RHEL 8 ship 4.18.0.

Yes but RHEL7 is still in full support.

> Debian bullseye ships 5.10.0.
> Fedora 37 ships 6.5.6.
> openSUSE Leap 15.4 ships 5.14.21.
> SLES 12 ships 4.12.14.
> Ubuntu 20.04 ships 5.4.

It does not matter that a newer version is shipped. What matters is
whether older one is still supported.


