Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C3779553
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:55:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVPl-0006wE-76; Fri, 11 Aug 2023 12:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUVPg-0006va-Mq
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUVPe-0001zq-8k
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691772896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yVd2PMqBQg4G0sbLgF6bNFYhZ0GipeRPKFxoezQZTe0=;
 b=imvrMorVveInkyiCHfigoGTOqTe78Q3d5H9Ly1tg4kaIIudgv4UtLLbogJUOgKb1UZD6IW
 78loqN0jpxvL8KKT/vFOxVDVe5hVPI/nvzSeodxnwrfxR/IZz4mSZYJ/e9LMzTwj15nvco
 GGPZzvG9ym1RZ4wD3fnSzJoZb1uHyWQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-kUpqRg95NDy1CZ0_n27OzA-1; Fri, 11 Aug 2023 12:54:54 -0400
X-MC-Unique: kUpqRg95NDy1CZ0_n27OzA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a745deaec0so395871b6e.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772893; x=1692377693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVd2PMqBQg4G0sbLgF6bNFYhZ0GipeRPKFxoezQZTe0=;
 b=blZS8gNnTWMKhCLuOHVOcT6voRd1XN1QShzCqrK3y8tDzQAwQPHhFU14i5T3DAoQQ/
 i/uAhPJlsXvf90OZ9MhBcu/CQ/04InoWuSiwPkEolDjHrN4/2GaO8PaEPBTygUF3F5Ag
 cvy3fsCOouEOh0Zxt+qcqwo7jtxJ7ZbpDM7Ez3ZeL2NAeER/eMexR7+jLcOY1bEjkinF
 z6XE+VIXKgDgKXG/p8t25tqJ/xdrdLdQY1YD23XNRpTzgrWeu6JmKBFE8jB0Il6iS/Uo
 DE0pB+xfKExe9jRnby6uiA9V3Ji8a8J7huUPfPT36kfs4Y0Cp2Pxm7Gzvf2vAIhR6gEp
 e1xQ==
X-Gm-Message-State: AOJu0YxMfjwHowSb4jd77Lz7LoQXfiFmGFd4RWAi8tc3zaHAL5k+Mv/2
 nsCkI64QakJgjDHYR4culzaV96O9ifa2X5d9TL113CPCIxxdwtECPLEtjETXH3cSC0DyaCuOuvO
 uLPme402bu8vY6Jw=
X-Received: by 2002:a05:6358:1a85:b0:134:cf15:92e1 with SMTP id
 gm5-20020a0563581a8500b00134cf1592e1mr2103752rwb.2.1691772893208; 
 Fri, 11 Aug 2023 09:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX9SvhbhAQJxiSDAieZ7IjvGI5FvhBOtNGD9fjKyK1ytZEmZQ0cs675y4Rp1D2rlYqThy9OQ==
X-Received: by 2002:a05:6358:1a85:b0:134:cf15:92e1 with SMTP id
 gm5-20020a0563581a8500b00134cf1592e1mr2103740rwb.2.1691772892863; 
 Fri, 11 Aug 2023 09:54:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l25-20020ac84cd9000000b0040331a24f16sm1300473qtv.3.2023.08.11.09.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:54:52 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:54:51 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 libvir-list@redhat.com
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNZn29wEXUyD5Cc2@x1n>
References: <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
 <ZNZez9ICBBf+D/d2@x1n>
 <e07f29a3-482a-3fcb-7aff-c88827c41385@redhat.com>
 <ZNZgRq22IXyqpun7@x1n>
 <b1630542-475a-f5de-bf79-f6519e01a350@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1630542-475a-f5de-bf79-f6519e01a350@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Aug 11, 2023 at 06:25:14PM +0200, David Hildenbrand wrote:
> On 11.08.23 18:22, Peter Xu wrote:
> > On Fri, Aug 11, 2023 at 06:17:05PM +0200, David Hildenbrand wrote:
> > > We wouldn't touch "-mem-path".
> > 
> > But still the same issue when someone uses -object memory-backend-file for
> > hugetlb, mapping privately, expecting ram discard to work?
> > 
> > Basically I see that example as, "hugetlb" in general made the private
> > mapping over RW file usable, so forbidden that anywhere may take a risk.
> 
> These users can be directed to using hugetlb
> 
> a) using MAP_SHARED
> b) using memory-backend-memfd, if MAP_PRIVATE is desired
> 
> Am I missing any important use case? Are we being a bit to careful about
> virtio-balloon and postcopy simply not being available for these corner
> cases?

The current immediate issue is not really mem=rw + fd=rw + private case
(which was a known issue), but how to make mem=rw + fd=ro + private work
for ThinnerBloger, iiuc.

I'd just think it safer to expose that cap to solve problem A (vm
templating) without affecting problem B (fallcate-over-private not working
right), when B is uncertain.

I'm also copy Daniel & libvirt list in case there's quick comment from
there. Say, maybe libvirt never use private mapping on hugetlb files over
memory-backend-file at all, then it's probably fine.

In all cases, you and Igor should have the final grasp; no stand on a
strong opinon from my side.

-- 
Peter Xu


