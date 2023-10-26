Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D37D858E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:07:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw1vi-000051-2p; Thu, 26 Oct 2023 11:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin.ryabitsev@linux.dev>)
 id 1qw0cw-0007z3-Uj
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 09:42:22 -0400
Received: from out-173.mta1.migadu.com ([2001:41d0:203:375::ad])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin.ryabitsev@linux.dev>)
 id 1qw0ct-0005wN-5P
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 09:42:22 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1698327725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkSO/nz9WMWozAL901XFRE8IkAlqrHHFLzt43J1c4a0=;
 b=BTsmn4flNphkTh5tkTNyoYKWxU2D/b/89kudVJK5smHxWcYIBvDI2QXWYcyniBNEuBeD3v
 SL/09pZGs7VJiVcXN6wRMCLHBlT6abM380qCdbIzLdu5LeDhCvXt7jIj8+FQ6gFbZHq0VM
 wIjcF+raFoJPgN2UeE8ypAyFjxs26Hw=
Date: Thu, 26 Oct 2023 13:42:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <53411f8f00c7abf3915d9f6e425e588d25740ded@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 0/3] vfio/pci: Fix buffer overrun when writing the VF
 token
To: "=?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=" <clg@redhat.com>, "Denis V. Lunev"
 <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: "Stefan Hajnoczi" <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, "Kevin Wolf" <kwolf@redhat.com>, "Hanna Reitz"
 <hreitz@redhat.com>, "Stefan Weil" <sw@weilnetz.de>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "=?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?="
 <berrange@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>, "Maciej S .
 Szmigiero" <maciej.szmigiero@oracle.com>, "Fam Zheng" <fam@euphon.net>, "Juan
 Quintela" <quintela@redhat.com>, "Peter Xu" <peterx@redhat.com>, "Fabiano
 Rosas" <farosas@suse.de>, "Leonardo Bras" <leobras@redhat.com>
In-Reply-To: <bad03ec1-049c-46e2-a4da-dd2d6d88bad1@redhat.com>
References: <bad03ec1-049c-46e2-a4da-dd2d6d88bad1@redhat.com>
 <20231026070636.1165037-1-clg@redhat.com>
 <5d9ab399-c5b2-41cd-9f2d-73d478e3c72a@virtuozzo.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ad;
 envelope-from=konstantin.ryabitsev@linux.dev; helo=out-173.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Oct 2023 11:05:48 -0400
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

October 26, 2023 at 5:58 AM, "C=C3=A9dric Le Goater" <clg@redhat.com> wro=
te:
> >  Reviwed-by: Denis V. Lunev <den@openvz.org>
> >=20
>=20
> I changed that to "Reviewed-by".
>=20
>=20Interesting to see that b4 was ok with this new tag.

When we see an email address in the trailer contents, we don't check it a=
gainst a known-trailers list, because there are just too many things like=
 "Co-developed-by", "Reviewed-and-acked-by", etc. We could add some kind =
of logic to break these apart and compare individual parts to a list of k=
nown person-trailers (e.g. ["co", "reviewed", "developed", "and", "by", .=
..]), but we currently don't, which is why typos like this one sneak thro=
ugh.

-K

