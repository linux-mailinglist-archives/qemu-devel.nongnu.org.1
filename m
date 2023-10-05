Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A317B9B46
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:14:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIYt-0001mS-Mw; Thu, 05 Oct 2023 03:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoIYr-0001m7-Bl
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoIYp-0001iB-KW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696490049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rh63+c2VCK3ysJAcXuT2NDHr9Vgnn6OB53iMfhpllig=;
 b=dDhya4vp9kZb/ASrQV4+/vMKcs+QETxTVswED0HGoODtkYN7+PMxBJDrfQ2CFnG0dbPJdN
 a2vUjnQGzZKocHnfRA7m34jbz3x3VNq2uMuFALoMWKcqP9o2jtYdkem3VrOPXYNAOE/fAk
 Re/2hWpYolzEXKJRJKbZvJiyPpH5Tkk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-869vTMR7O8a9ertJwQqF_w-1; Thu, 05 Oct 2023 03:14:06 -0400
X-MC-Unique: 869vTMR7O8a9ertJwQqF_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CC638039C8;
 Thu,  5 Oct 2023 07:14:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ED7340C6EA8;
 Thu,  5 Oct 2023 07:14:05 +0000 (UTC)
Date: Thu, 5 Oct 2023 08:14:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, leobras@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
Message-ID: <ZR5iO9vAwbR8lIAb@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
 <ZQnojJOqoFu73995@redhat.com> <87bkdes1x9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bkdes1x9.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 04, 2023 at 08:00:34PM +0200, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Tue, Sep 19, 2023 at 12:49:46PM -0400, Peter Xu wrote:
> >> On Mon, Sep 18, 2023 at 04:41:14PM +0200, Markus Armbruster wrote:
> >> > Oh dear, where to start.  There's so much wrong, and in pretty obvious
> >> > ways.  This code should never have passed review.  I'm refraining from
> >> > saying more; see the commit messages instead.
> >> > 
> >> > Issues remaining after this series include:
> >> > 
> >> > * Terrible error messages
> >> > 
> >> > * Some error message cascades remain
> >> > 
> >> > * There is no written contract for QEMUFileHooks, and the
> >> >   responsibility for reporting errors is unclear
> >> 
> >> Even being removed.. because no one is really extending that..
> >> 
> >> https://lore.kernel.org/all/20230509120700.78359-1-quintela@redhat.com/#t
> >
> > One day (in another 5-10 years) I still hope we'll get to
> > the point where QEMUFile itself is obsolete :-)
> 
> If you see the patches on list, I have move rate limit check outside of
> QEMUFile, so right now it is only a buffer to write in the main
> migration thread.

Can you point me to that patch(es) as I'm not identifying
them yet.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


