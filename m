Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C413D7DF499
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:08:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYLR-00052Y-CY; Thu, 02 Nov 2023 10:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyYLP-000521-7v
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyYLN-0004eE-8z
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698934004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uG8+u/LoLgwZoU1sdabHIhFOOFaEa7nHamTCPco3UoE=;
 b=FA/d9eu4P2yNITrXFExpTxVhtul1Yv0sWa2Y0LQ4Xo0OyG4EdVbHkrv5YrnCURb49muC96
 dM/hJM4dMtPJx0NXX07pXOhB+Fzn3PahEVFNvMIwf/OngbCG4WZslKTgIqSYQ0HGNvIEe4
 LvDAWn1gLpVC/fEA/5gaiZdlvTt2LhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-UCEpIer8NjWAL04u2gz6lA-1; Thu, 02 Nov 2023 10:06:40 -0400
X-MC-Unique: UCEpIer8NjWAL04u2gz6lA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AD4B812C27;
 Thu,  2 Nov 2023 14:06:40 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33EFA25C0;
 Thu,  2 Nov 2023 14:06:39 +0000 (UTC)
Date: Thu, 2 Nov 2023 15:06:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: -drive if=none: can't we make this the default?
Message-ID: <ZUOs7j823+a6FBD2@redhat.com>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
 <e3bb64a2-fb72-4e8d-a0b2-89ee35365fb3@tls.msk.ru>
 <ZUFK/BHG2WMhAiWG@redhat.com>
 <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
 <ZUN9SZ6VkvLHWNXs@redhat.com>
 <CAFEAcA8hssUvz8kb4VYXNZSyrQhRyo+=AebA-hskm64bmhG-MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8hssUvz8kb4VYXNZSyrQhRyo+=AebA-hskm64bmhG-MA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 02.11.2023 um 12:01 hat Peter Maydell geschrieben:
> On Thu, 2 Nov 2023 at 10:43, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 01.11.2023 um 12:21 hat Peter Maydell geschrieben:
> > > On Tue, 31 Oct 2023 at 18:45, Kevin Wolf <kwolf@redhat.com> wrote:
> > > > Am 16.10.2023 um 13:58 hat Michael Tokarev geschrieben:
> > > > > Almost everyone mentions -blockdev as a replacement for -drive.
> > > >
> > > > More specifically for -drive if=none. I honestly don't know many common
> > > > use cases for that one.
> > >
> > > One use case for it is "create a drive with a qcow2 backend to use
> > > for -snapshot snapshots, but don't plug it into anything". See
> > > https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/
> > > I dunno whether that counts as "common", though :-)
> >
> > Ok, I was already wondering what good -snapshot was for an image that
> > isn't even used, but what the article describes is actually not using
> > -snapshot, but internal snapshots with savevm/loadvm, i.e. using the
> > image to store the VM state.
> >
> > This actually makes a lot of sense for if=none, as one of the few cases
> > where "none" accurately tells what device it will be used with.
> 
> Whoops, have I got the terminology wrong again? To me these are
> "snapshots" (they do store the whole VM state including the current
> state of the disk, and "qemu-img info" lists them as "snapshots"),
> whereas I never use the '-snapshot' option, so I never remember
> that we have two different things here. Sorry for introducing
> confusion :-(

It is confusing, -snapshot really doesn't have the best name.

But anyway, your case with savevm/loadvm should work fine with
-blockdev.

Kevin


