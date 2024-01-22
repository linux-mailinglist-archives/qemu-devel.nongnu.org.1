Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B88373A0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:21:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS0m0-0007wn-Fy; Mon, 22 Jan 2024 15:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rS0lx-0007wE-SX
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rS0lv-0006pc-SQ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705954794;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NDP6GWEpopIKfodKNhjQVPUZP2gJpifnyTanF9jIfo=;
 b=igX8J/AdDwBiEOtc9QmoXQntRmjGfoCzN5mXmyBRzObP2fx+fPtnhCwcqsvmCSQaOl9+Vk
 h3P++ug/Qd2SlHwErcI6ckEliJbUnJtGnq0kwo929YfTx4j5frEZkBLcPZlodmVuG/wpnD
 id9PvbED6sVRVpC7QVj5XamShhD0v9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-V2EOq_VfNP6EVHmOax0P2w-1; Mon, 22 Jan 2024 15:19:50 -0500
X-MC-Unique: V2EOq_VfNP6EVHmOax0P2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92139848A11;
 Mon, 22 Jan 2024 20:19:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D9C6295C;
 Mon, 22 Jan 2024 20:19:45 +0000 (UTC)
Date: Mon, 22 Jan 2024 20:19:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cristian =?utf-8?Q?Rodr=C3=ADguez?= <cristian@rodriguez.im>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] crypto/gcrypt: prefer kernel as direct source of entropy
Message-ID: <Za7N3pIUXQB4lAkl@redhat.com>
References: <20240119203950.6434-1-cristian@rodriguez.im>
 <Za6ALDkMyW9Pdspd@redhat.com>
 <CAPBLoAfbj51gFZ-=41jYHytPBvM_AagsB1ixySPpwr5Y4SPJpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPBLoAfbj51gFZ-=41jYHytPBvM_AagsB1ixySPpwr5Y4SPJpA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jan 22, 2024 at 05:08:16PM -0300, Cristian Rodríguez wrote:
> On Mon, Jan 22, 2024 at 11:48 AM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Fri, Jan 19, 2024 at 05:39:40PM -0300, Cristian Rodríguez wrote:
> > > gcrypt by default uses an userspace RNG, which cannot know
> > > when it is time to discard/invalidate its buffer
> > > (suspend, resume, vm forks, other corner cases)
> > > as a "when to discard" event is unavailable to userspace.
> >
> > So in this scenario QEMU is impacted when QEMU is running inside
> > another VM. ie the L0 QEMU "forks" the guest, and the L1 QEMU
> > needs to re-init its RNG.
> >
> > > Set GCRYCTL_SET_PREFERRED_RNG_TYPE to GCRY_RNG_TYPE_SYSTEM
> > > which must be done before the first call to gcry_check_version()
> >
> > QEMU is just one out of many applications that use libgcrypt and
> > I see no reason why QEMU should be special cased in this respect.
> >
> > Updating each application to hardcode use of GCRY_RNG_TYPE_SYSTEM
> > does not feel like a good solution. If this was a good default
> > to use everywhere, then gcrypt should have set this default
> > already, rather than requiring every app to solve the forking
> > problem itself.
> >
> 
> this default is because either other OSs had problems or in the past the
> linux rng was not as performant as it is right now,
>  now it outputs 100's of MB per second on a potato.
> 
> Updating every app that uses gcrypt is not really practical
> > in terms of time investment anyway.
> >
> 
> Yeah, it will be pretty time consuming so I have so far only sent a few
> patches for things I consider important.
> 
> >
> > If gcrypt doesn't want to make this its global default, then
> > I would suggest that gcrypt should make its default be
> > configurable. I see from its docs:
> >
> >
> > https://gnupg.org/documentation/manuals/gcrypt/Configuration.html#Configuration
> >
> > that it already supports a /etc/gcrypt/random.conf file.
> > Perhaps they would extend that to allow selection of the
> > default RNG backend, system-wide.
> 
> 
> And things will remain problematic by default , because of all the
> obscurity and that FIPS mode overrides
> all defaults you choose anyways, including if I hardcode the preference in
> the source code like I did here.

If the DRBG is required for FIPS compliance, and QEMU hardcoded
the system RNG, then QEMU can't be used in a FIPS environment.
So I still think this question of defaults is something to be
fixed in the gcrypt code centrally, not in individual apps.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


