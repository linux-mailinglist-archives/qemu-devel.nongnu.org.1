Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96307B512E8
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 11:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHKl-0004Yx-6f; Wed, 10 Sep 2025 05:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHKg-0004YA-58
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHKY-00008N-Cq
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757497291;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=By0RgP3I19x+gUS/dbc2sMIiyrdmQmnlvuetLmi6s+s=;
 b=b+uY6EX4ohHXWEWNyXh7exbFVUBLunTZdITjy3vjAjAF6wNUhLF6SUPbTHQwe5/xgIozA0
 zYb51e/jb67oKfQ1PJbik9goF43puMstQuoiH5XOPwy2KmSlWloGsfJx2sYPNrV3BWyZR0
 JOZb/Q263rFgHGYu+uzTGucE/R1vGPg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-JKQT8iu_PDe2nE4wjcFXsA-1; Wed,
 10 Sep 2025 05:41:25 -0400
X-MC-Unique: JKQT8iu_PDe2nE4wjcFXsA-1
X-Mimecast-MFC-AGG-ID: JKQT8iu_PDe2nE4wjcFXsA_1757497284
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 146E11800299; Wed, 10 Sep 2025 09:41:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF3DB1800576; Wed, 10 Sep 2025 09:41:19 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:41:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
Message-ID: <aMFHvN3MDneJ59C9@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
 <aL9Vuohpnyn8IcsI@x1.local>
 <f7ca50b0-b20d-451e-addb-693772239b34@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7ca50b0-b20d-451e-addb-693772239b34@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 11:19:39AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 09.09.25 01:16, Peter Xu wrote:
> > On Wed, Sep 03, 2025 at 12:44:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Use common qemu_set_blocking() instead.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> > Posix's qemu_socket_set_nonblock() asserts the retval.. While Windows's one
> > doesn't.  IIUC that's the only reason you provided the generic error
> > path in all callers, just in case some of them might fail on Windows?
> 
> Honestly, I thought that checking error on Linux is good too.. It may fail,
> why not to check, where possible?

Yep, it diagnoses the case where the FD might be invalid, or where
QEMU might not have access to it. This could potentially avoid killing
the VM if a FD was passed to QEMU over monitor that had access limited
by SELinux.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


