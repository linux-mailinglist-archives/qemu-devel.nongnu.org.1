Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D59763F2C
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhaQ-0004xm-AW; Wed, 26 Jul 2023 12:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOhZj-0004mZ-ID
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOhZg-0007Kp-QC
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690389679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJd9+pM6rY6vdaQRgDGihnRWerMj1V0w053mzjcfdAU=;
 b=NIJkBEetQLcCjhB/n5vfnLBK2Eh4GdUSyUZu9XSemCUF86Jgbm/NSCulx17ROJM5ZNoUEB
 P6wLgM9IF4GPS7GJ6VrhCrXK04czJPS2Subco6rf2LM750WRttbw+2feUUGafFDFr6UxfK
 slzpR89UlFT7bRQoucYDQ6SzweghWEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-rPNPzdSBOHa-Kp3tFJZjKQ-1; Wed, 26 Jul 2023 12:41:16 -0400
X-MC-Unique: rPNPzdSBOHa-Kp3tFJZjKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BF1B88D70A;
 Wed, 26 Jul 2023 16:41:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31CB9145414F;
 Wed, 26 Jul 2023 16:41:15 +0000 (UTC)
Date: Wed, 26 Jul 2023 17:41:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v10 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Message-ID: <ZMFMqRC8WlB3mXD0@redhat.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
 <20230726141833.50252-10-het.gala@nutanix.com>
 <ZMEz1SRK3QhJZG4X@redhat.com>
 <94950119-ea11-4c9b-e50f-09741f100040@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94950119-ea11-4c9b-e50f-09741f100040@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Wed, Jul 26, 2023 at 10:08:05PM +0530, Het Gala wrote:
> 
> On 26/07/23 8:25 pm, Daniel P. Berrangé wrote:
> > On Wed, Jul 26, 2023 at 02:18:32PM +0000, Het Gala wrote:
> > > Integrate MigrateChannelList with all transport backends
> > > (socket, exec and rdma) for both src and dest migration
> > > endpoints for hmp migration.
> > > 
> > > Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> > > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > > ---
> > >   migration/migration-hmp-cmds.c | 15 +++++++++++++--
> > >   migration/migration.c          |  5 ++---
> > >   migration/migration.h          |  3 ++-
> > >   3 files changed, 17 insertions(+), 6 deletions(-)
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> Daniel, I have got reviewed-by / Acked-by from Markus (patch 1 & 6) and you
> (remaining patches). What should be the next steps here ? Do I need to send
> a new patchset / wait for more maintainers for their reviews ? Please
> advice.

At this point it is for Juan (as the migration primary maintainer) to
either queue it, or send you more review comments.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


