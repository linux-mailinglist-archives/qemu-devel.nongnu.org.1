Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC37091A2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvRb-00060s-Mn; Fri, 19 May 2023 04:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzvRZ-00060N-UE
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzvRY-0003b2-9N
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684484791;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/VQc5CMJd9Uwb6Y2ierTNa5I2weukOfjBSHZ6aRR7hg=;
 b=dUTDgHFPsVYqlB5EV2yEEwoLE1BzMEwm/jMAHEht0SgIth+DEqGEkpQTx5i70j61h3lKBi
 DG1yYTAXKT2AoM5dJ+4AK1EeppjkyrmSvQQ1de2stjuQIOT5gUFOPJ6CjTc97eQcL19i1q
 s+BzcuSWoPqOhh6+MA+x6SqDdaAV8vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-Xw1BrYQMMnSUiNpoOOC-Xg-1; Fri, 19 May 2023 04:26:27 -0400
X-MC-Unique: Xw1BrYQMMnSUiNpoOOC-Xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 606A3101A531;
 Fri, 19 May 2023 08:26:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C75A140E954;
 Fri, 19 May 2023 08:26:26 +0000 (UTC)
Date: Fri, 19 May 2023 09:26:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, quintela@redhat.com,
 lei4.wang@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGcyr9d2qpYpV5As@redhat.com>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGZ6Yqx2+dOp+Q73@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 18, 2023 at 03:20:02PM -0400, Peter Xu wrote:
> On Fri, May 19, 2023 at 12:00:26AM +0800, Wei Wang wrote:
> > qemu_start_incoming_migration needs to check the number of multifd
> > channels or postcopy ram channels to configure the backlog parameter (i.e.
> > the maximum length to which the queue of pending connections for sockfd
> > may grow) of listen(). So multifd and postcopy-preempt caps require the
> > use of deferred incoming, that is, calling qemu_start_incoming_migration
> > should be deferred via qmp or hmp commands after the cap of multifd and
> > postcopy-preempt are configured.
> > 
> > Check if deferred incoming is used when enabling multifd or
> > postcopy-preempt, and fail the check with error messages if not.
> > 
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> 
> IIUC this will unfortunately break things like:
> 
>   -global migration.x-postcopy-preempt=on
> 
> where the cap is actually applied before incoming starts even with !defer
> so it should still work.
> 
> Can we just make socket_start_incoming_migration_internal() listen on a
> static but larger value?

Why do we need todo that ? I thought we just determined the problem was
a configuration error, not a code error.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


