Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED7830813
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:30:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6v4-0000RP-3K; Wed, 17 Jan 2024 09:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rQ6uz-0000Qg-U4
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rQ6ux-00062V-CQ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705501761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCgb0rgW9HN4idOGz/zvpb4diO9fEhPE33wL2VSxtoo=;
 b=Z4T/xWmUNdz3s0je6/MjZZbpJnroC6akkZU5R/lJ1f6TM4fjyY0awX6bY49ffVCSWH67gw
 RDNxqj6TXwDV6twbGdWPrySc16wXWv+9keZXRd+Hy1WDQtjC+K3j4s1ZO6QKVoH4l+5ay5
 o4QUztHL1wj9/h7BOBTzSuyAfouoIcc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-d6R4AmpiM6S9rwRWjolkQg-1; Wed, 17 Jan 2024 09:29:18 -0500
X-MC-Unique: d6R4AmpiM6S9rwRWjolkQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF5B685A588;
 Wed, 17 Jan 2024 14:29:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 965121BDB2;
 Wed, 17 Jan 2024 14:29:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8FD7C1800DC8; Wed, 17 Jan 2024 15:29:16 +0100 (CET)
Date: Wed, 17 Jan 2024 15:29:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: Re: [PULL 0/6] Firmware/edk2 20231213 patches
Message-ID: <7gsflxxdzqdjzeyool3kjgsokjgxbys3tijlcmqf2fusddn7o6@vafldjprddge>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
 <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
 <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
 <e2hpw77r6t2ge6h233cq75qdadou6koz62sfktcsrlc2gzeqnq@4ejyxysmmulo>
 <CAFEAcA_f0Q7LkSQ2+sxgBcRQNSTenykq1R28QMuGyW22PtxW2Q@mail.gmail.com>
 <CAFEAcA_-fF7fWGm_QUJa86LHJvtBk4jKvTw=OvM+EOxQzuYvWA@mail.gmail.com>
 <7u5v67zlt5aapyinxbc4dgdiivtx4cr5mttdck6jzfknfb2ni2@lscetlkzwvjy>
 <b5d14237-5bf3-49dc-b9c4-4f18bd6dec96@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d14237-5bf3-49dc-b9c4-4f18bd6dec96@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Wed, Jan 17, 2024 at 01:16:34PM +0300, Michael Tokarev wrote:
> 15.01.2024 13:20, Gerd Hoffmann :
> >    Hi,
> > 
> > > PS: when are we likely to be able to update to a proper released
> > > EDK2 ? Running with a git snapshot isn't ideal, so if we can
> > > move to an EDK2 release version within this QEMU cycle that would
> > > be nice.
> > 
> > Next release should be tagged by end of February, so if the qemu 9.0
> > schedule is simliar to the 8.0 schedule this is before soft freeze
> > and an update should be no problem.
> 
> So, should we pick this up for 8.2.1, or wait till next release of edk2 ?
> 
> The thing here is that for (some) downstreams, edk2 is a separate package,
> so if qemu relies on changed edk2, it should be there before qemu-side
> changes can be added.  So if we pick this patchset up for 8.2.1, it might
> be a bit surprising for downstreams.

It's not that there changed something in the edk2 <-> qemu interfaces.
This build contains a workaround for the current shim.efi clusterf*ck.

The tl;dr version:  The build is compiled with the (very recently added)
PcdUninstallMemAttrProtocol=TRUE option to workaround a bug in shim.efi.

The extra long version:
    https://www.kraxel.org/blog/2023/12/uefi-nx-linux-boot/

Picking this up for 8.2.1 makes life easier for the downstreams which do
not do their own firmware builds but ship the qemu prebuilds instead.

take care,
  Gerd


