Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDD37D7117
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvg0H-00027d-0D; Wed, 25 Oct 2023 11:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvg0E-00027G-Op
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvg0C-0000Nn-R9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698248458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBoKypcjb35WhcPZyttXz2svO5/ArIr14Pbvxd5Kt2I=;
 b=HAzQL8tEeN8VlgdgVV1TXaTUQRa/mbH2tTOSYOyPlS+EjVkL1o3Pv14QttKSuY2pK8AcmB
 6gHjgrptH80OF1Dt23dcjwz6HKu3EPjFj1W2rs9d4uV3JIODiDWKs3+ocLLs3e9ao/uMdV
 UqKcHo5qayul96lXIzVc0oCO5eEYZ4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-60cS3eYjMXC1Kvlek6XO_w-1; Wed, 25 Oct 2023 11:40:56 -0400
X-MC-Unique: 60cS3eYjMXC1Kvlek6XO_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B0778871C3;
 Wed, 25 Oct 2023 15:40:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA592500C;
 Wed, 25 Oct 2023 15:40:54 +0000 (UTC)
Date: Wed, 25 Oct 2023 16:40:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
Message-ID: <ZTk3BJD5cVbIhesr@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de>
 <ZTjWV9wQ5obKTpOG@redhat.com> <87y1fqerev.fsf@suse.de>
 <ZTkkICSD6j6Xf/KK@redhat.com> <ZTktCM/ccipYaJ80@x1n>
 <ZTkzY0nKtdeZJojP@redhat.com> <ZTk1++TzE+SiT3UH@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTk1++TzE+SiT3UH@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Oct 25, 2023 at 11:36:27AM -0400, Peter Xu wrote:
> On Wed, Oct 25, 2023 at 04:25:23PM +0100, Daniel P. Berrangé wrote:
> > > Libvirt will still use fixed-ram for live snapshot purpose, especially for
> > > Windows?  Then auto-pause may still be useful to identify that from what
> > > Fabiano wants to achieve here (which is in reality, non-live)?
> > > 
> > > IIRC of previous discussion that was the major point that libvirt can still
> > > leverage fixed-ram for a live case - since Windows lacks efficient live
> > > snapshot (background-snapshot feature).
> > 
> > Libvirt will use fixed-ram for all APIs it has that involve saving to
> > disk, with CPUs both running and paused.
> 
> There are still two scenarios.  How should we identify them, then?  For
> sure we can always make it live, but QEMU needs that information to make it
> efficient for non-live.
> 
> Considering when there's no auto-pause, then Libvirt will still need to
> know the scenario first then to decide whether pausing VM before migration
> or do nothing, am I right?

libvirt will issue a 'stop' before invoking 'migrate' if it
needs to. QEMU should be able to optimize that scenario if
it sees CPUs already stopped when migrate is started ?

> If so, can Libvirt replace that "pause VM" operation with setting
> auto-pause=on here?  Again, the benefit is QEMU can benefit from it.
> 
> I think when pausing Libvirt can still receive an event, then it can
> cooperate with state changes?  Meanwhile auto-pause=on will be set by
> Libvirt too, so Libvirt will even have that expectation that QMP migrate
> later on will pause the VM.
> 
> > 
> > > From that POV it sounds like auto-pause is a good knob for that.
> > 
> > From libvirt's POV auto-pause will create extra work for integration
> > for no gain.
> 
> Yes, I agree for Libvirt there's no gain, as the gain is on QEMU's side.
> Could you elaborate what is the complexity for Libvirt to support it?

It increases the code paths because we will have to support
and test different behaviour wrt CPU state for fixed-ram
vs non-fixed ram usage.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


