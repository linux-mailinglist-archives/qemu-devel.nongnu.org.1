Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98D82B2F5
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:29:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxvJ-0005Uv-Oq; Thu, 11 Jan 2024 11:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rNxvF-0005U5-TK
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rNxvE-00037b-0O
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704990527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqdwlfedjKe1aWq06E6J7iyq8M1rLbfXY3zF5bNERo4=;
 b=HTh+9nn07GcAxIAYeDgAluezIlI41GOH31V7d+icR/HabZw01BltXaKzFuy7ZnU1ilxvJU
 wSFHbqv+jO+YRuG16cPebD0zkx1I2frLpuf8BjJuc0wAdb39spEeL8Betgj3500t8+6Lao
 b6JM3liILx2mJp8rwy1pK7Vg262sNB4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-trft5rk-OEep2g9xzGinHw-1; Thu,
 11 Jan 2024 11:28:43 -0500
X-MC-Unique: trft5rk-OEep2g9xzGinHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01881283780F;
 Thu, 11 Jan 2024 16:28:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C839351D5;
 Thu, 11 Jan 2024 16:28:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A5926180079A; Thu, 11 Jan 2024 17:28:41 +0100 (CET)
Date: Thu, 11 Jan 2024 17:28:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: Re: [PULL 0/6] Firmware/edk2 20231213 patches
Message-ID: <e2hpw77r6t2ge6h233cq75qdadou6koz62sfktcsrlc2gzeqnq@4ejyxysmmulo>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
 <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
 <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 11, 2024 at 04:02:38PM +0000, Peter Maydell wrote:
> On Thu, 11 Jan 2024 at 15:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 11 Jan 2024 at 14:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Ping.
> > >
> > > As expected this missed the 8.2 boat.  Now the devel tree is open again
> > > and people are back from xmas + new year vacations, can this be picked
> > > up for master and eventually 8.2-stable?
> >
> > I can queue it, sure. Do we need to respin it to add cc: qemu-stable
> > tags, or can it be applied as-is ?
> 
> ...PS did you mean to cc qemu-stable, not the nonexistent edk2-stable
> on this pullreq email?

Yes, Cc'ing qemu-stable was the intention, thanks for fixing it up.

I'd leave it to the stable maintainer(s).  If they prefer a respin with
Cc qemu-stable added to all patches I surely can do that.  If being
notified with this reply is good enough I'm happy too.

take care,
  Gerd


