Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818178FA0C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:38:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzex-0004lx-6i; Fri, 01 Sep 2023 04:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbzeu-0004lQ-Re
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbzes-0005ZA-9l
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693557457;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=x/0Fkp8e2t6+XIPCo1j60T9ButBXrCSxVqlsuqyqE0E=;
 b=gbKWr1Wgs1laXmw+//T7ppStSzHdew8XOcZ7iDkHLIT2YKN3AVO29Z/yzxk2drsSmCmlB9
 0QFPS6aseUJUdAplh78cA9zgNxqBTQjSywX1cJRl5VpkkUSAEDRRF8XCkV/2dhKCqONCND
 /KysQEWSbYiLBr1f5eZqg+/OM11EnLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-vzhm4u8QNsu7lR2To7wtcw-1; Fri, 01 Sep 2023 04:37:36 -0400
X-MC-Unique: vzhm4u8QNsu7lR2To7wtcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5428800CAB;
 Fri,  1 Sep 2023 08:37:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4256540C2063;
 Fri,  1 Sep 2023 08:37:34 +0000 (UTC)
Date: Fri, 1 Sep 2023 09:37:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify
 migration switchover bandwidth
Message-ID: <ZPGizMa52LF7Qek1@redhat.com>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
 <8bb36b56-e2f6-ece8-0d8f-90b87a3b5c40@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bb36b56-e2f6-ece8-0d8f-90b87a3b5c40@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Fri, Sep 01, 2023 at 02:55:08PM +0800, Wang, Lei wrote:
> On 8/3/2023 23:53, Peter Xu wrote:
> > Migration bandwidth is a very important value to live migration.  It's
> > because it's one of the major factors that we'll make decision on when to
> > switchover to destination in a precopy process.
> > 
> > This value is currently estimated by QEMU during the whole live migration
> > process by monitoring how fast we were sending the data.  This can be the
> > most accurate bandwidth if in the ideal world, where we're always feeding
> > unlimited data to the migration channel, and then it'll be limited to the
> > bandwidth that is available.
> > 
> > However in reality it may be very different, e.g., over a 10Gbps network we
> > can see query-migrate showing migration bandwidth of only a few tens of
> > MB/s just because there are plenty of other things the migration thread
> > might be doing.  For example, the migration thread can be busy scanning
> > zero pages, or it can be fetching dirty bitmap from other external dirty
> > sources (like vhost or KVM).  It means we may not be pushing data as much
> > as possible to migration channel, so the bandwidth estimated from "how many
> > data we sent in the channel" can be dramatically inaccurate sometimes,
> > e.g., that a few tens of MB/s even if 10Gbps available, and then the
> > decision to switchover will be further affected by this.
> > 
> > The migration may not even converge at all with the downtime specified,
> > with that wrong estimation of bandwidth.
> > 
> > The issue is QEMU itself may not be able to avoid those uncertainties on
> > measuing the real "available migration bandwidth".  At least not something
> > I can think of so far.
> > 
> > One way to fix this is when the user is fully aware of the available
> > bandwidth, then we can allow the user to help providing an accurate value.
> > 
> > For example, if the user has a dedicated channel of 10Gbps for migration
> > for this specific VM, the user can specify this bandwidth so QEMU can
> > always do the calculation based on this fact, trusting the user as long as
> > specified.
> > 
> > A new parameter "max-switchover-bandwidth" is introduced just for this. So
> > when the user specified this parameter, instead of trusting the estimated
> > value from QEMU itself (based on the QEMUFile send speed), let's trust the
> > user more by using this value to decide when to switchover, assuming that
> > we'll have such bandwidth available then.
> > 
> > When the user wants to have migration only use 5Gbps out of that 10Gbps,
> > one can set max-bandwidth to 5Gbps, along with max-switchover-bandwidth to
> > 5Gbps so it'll never use over 5Gbps too (so the user can have the rest
> 
> Hi Peter. I'm curious if we specify max-switchover-bandwidth to 5Gbps over a
> 10Gbps network, in the completion stage will it send the remaining data in 5Gbps
> using downtime_limit time or in 10Gbps (saturate the network) using the
> downtime_limit / 2 time? Seems this parameter won't rate limit the final stage:)

Effectively the mgmt app is telling QEMU to assume that this
much bandwidth is available for use during switchover. If QEMU
determines that, given this available bandwidth, the remaining
data can be sent over the link within the downtime limit, it
will perform the switchover. When sending this sitchover data,
it will actually transmit the data at full line rate IIUC.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


