Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B8814891
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:55:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE7jE-00015C-KW; Fri, 15 Dec 2023 07:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rE7iq-0000wf-II
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rE7ie-00045k-Ao
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702644906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxDggu7BXMs0E8qU7h2Po7QkPeeRBjBHOIDusaHiQHQ=;
 b=bVNuVj42FnFX3a8kfzB6HXfrxXZI5azKHYZb7j58ZzSndZgvWPT3TaN43pAiEAjDYuqv/R
 K9GeDoVqVLh79TGW59uTZtqhhuLzZaV1ZVPIwwDuOqXfPSLAOdzg9Rd0K/1jHvFA9n5yQm
 NI+opfLgWJfbY8U8tGq2e72b7fPA9kg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-4IDigRMMMlCTT1nE_ZZmZA-1; Fri, 15 Dec 2023 07:55:03 -0500
X-MC-Unique: 4IDigRMMMlCTT1nE_ZZmZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C243F85A588;
 Fri, 15 Dec 2023 12:55:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A404840C6EB9;
 Fri, 15 Dec 2023 12:55:01 +0000 (UTC)
Date: Fri, 15 Dec 2023 12:54:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vl: Print display options for -display help
Message-ID: <ZXxMow-5UGOSgWo1@redhat.com>
References: <20231214-help-v1-1-23823ac5a023@daynix.com>
 <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
 <8f8d3317-c28b-3985-89d7-0fbd1ce4b56e@eik.bme.hu>
 <2d1689ea-b0d8-4c74-8101-b90ad626f2a9@daynix.com>
 <d1687e5a-a60e-fda8-5e8c-1ab9adf0e775@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1687e5a-a60e-fda8-5e8c-1ab9adf0e775@eik.bme.hu>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Dec 15, 2023 at 01:43:37PM +0100, BALATON Zoltan wrote:
> On Fri, 15 Dec 2023, Akihiko Odaki wrote:
> > On 2023/12/14 22:00, BALATON Zoltan wrote:
> > > > So we go from:
> > > > 
> > > > $ ./qemu-system-aarch64 -display help
> > > > Available display backend types:
> > > > none
> > > > gtk
> > > > sdl
> > > > curses
> > > > cocoa
> > > > dbus
> > > > 
> > > > to:
> > > > 
> > > > $ ./qemu-system-aarch64 -display help
> > > > -display sdl[,gl=on|core|es|off][,grab-mod=<mod>][,show-cursor=on|off]
> > > >            [,window-close=on|off]
> > > > -display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]
> > > >            [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]
> > > >            [,show-menubar=on|off]
> > > > -display vnc=<display>[,<optargs>]
> > > > -display curses[,charset=<encoding>]
> > > > -display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]
> > > > -display dbus[,addr=<dbusaddr>]
> > > >             [,gl=on|core|es|off][,rendernode=<file>]
> > > > -display cocoa[,show-cursor=on|off][,left-command-key=on|off]
> > > > -display none
> > > >                select display backend type
> > > >                The default display is equivalent to
> > > >                "-display gtk"
> > > > 
> > > > The latter is indeed more helpful.
> > > 
> > > It is more helpful but maybe a bit overwhelming. Would it be
> > > possible to only print the options with -display cocoa,help similar
> > > to how -device help lists devices and -device sm501,help lists
> > > options for one device? Adding info about default to -display help
> > > is really helpful though (that could also be marked with (default)
> > > like in -machine help.
> > 
> > It's copied from what qemu-system-aarch64 -h outputs. At least it's less
> > overwhelming than qemu-system-aarch64 -h.
> 
> This changes what -display help does so if some script depends on that it
> may not be a good idea. Since the same info is already in -help maybe this
> change to add that to -display help as well is not the best solution so I'd
> say drop this patch and leave it as it is for now.

We consider help output to be only for humans.

No scripts should ever be parsing any QEMU output, as we provide
QMP for automated detection/querying of features.

IOW, if some script is parsing help output we are fine to break
them if it improves QEMU's output for humans in a justiable way.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


