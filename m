Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306D835FE5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 11:41:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRrjE-00067x-0O; Mon, 22 Jan 2024 05:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rRrjA-00067T-VG
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:40:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rRrj9-0005sX-HC
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705920026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mCqD7t8hxqe/534mIJpK3BKL7PCySwTHXRSipQzuuOs=;
 b=HOIjc5aAB0tkfhGv6zpw6wn7W56amogQV8OSTB9DHbqBaSgk6/4jVZdZ842UYkOT0yU9/i
 VS89/gapmUqMxaoRuU/98FEPaNGIgroEKjfC29vpBUMVtNfcGfX3kcfW41PYHfbomgH4yt
 ji2JPcmDYmK+Aay6wE2ujhWtEljMgmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-Xa9oFC4hOduugKYYq5nihA-1; Mon, 22 Jan 2024 05:40:21 -0500
X-MC-Unique: Xa9oFC4hOduugKYYq5nihA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0594C80007C;
 Mon, 22 Jan 2024 10:40:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7EF92026F95;
 Mon, 22 Jan 2024 10:40:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E24EF180038B; Mon, 22 Jan 2024 11:40:19 +0100 (CET)
Date: Mon, 22 Jan 2024 11:40:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: Re: [PATCH v2 0/3] hw/pflash: implement update buffer for block
 writes
Message-ID: <l2hfr22wl4ztjvwnm4e7f7dvour3fbe4yoydvofy2ktsjbfwfk@hnknxiljcjdm>
References: <20240108160900.104835-1-kraxel@redhat.com>
 <789d8190-6d14-46ff-89a8-c7f2457ecc15@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789d8190-6d14-46ff-89a8-c7f2457ecc15@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jan 20, 2024 at 01:18:14PM +0300, Michael Tokarev wrote:
> 08.01.2024 19:08, Gerd Hoffmann:
> > When running qemu with edk2 efi firmware on aarch64 the efi
> > variable store in pflash can get corrupted.  qemu not doing
> > proper block writes -- flush all or nothing to storage -- is
> > a hot candidate for being the root cause.
> > 
> > This little series tries to fix that with an update buffer
> > where block writes are staged, so we can commit or discard
> > the changes when the block write is completed or canceled.
> 
> It looks like we can pick this up for stable too.  It's not
> usual to pick up new features for stable, but this one fixes
> actual bug and if not applied, can easily lead to data corruption.
> 
> I'd pick it up for 8.2.x and 8.1.x at least.

Well, it turned out there was a edk2 bug causing flash corruption.
While debugging edk2 I was using a qemu build with fixed pflash.

So on one hand I don't know for sure whenever the incorrect block
flash emulation /alone/ can cause pflash corruption too.

On the other hand the edk2 debugging session also was a stress
test for the pflash fix, so I'm pretty confident it works
correctly.

I think it makes sense to include it.

take care,
  Gerd


