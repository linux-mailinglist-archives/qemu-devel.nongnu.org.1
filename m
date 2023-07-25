Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B4761E1C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKbx-0005d8-DO; Tue, 25 Jul 2023 12:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKbv-0005cy-ET
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKbt-0001I7-JH
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690301403;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6mPKmuMeFqPSMk5xNMIsv+RDgIrfVp7uo8DmxMdkOss=;
 b=EIhNzg1Fr5+SCZ6azdpl6UYunXcLLjCsJjKNs7yx0EgMYZCncpdMhIMSgSCCbIMQqC6FCT
 xjBJVxR9iEhuzXU0JfUfg2VNeKzyngKIkPcGx25iLFV7JDvUtUSWxNMR8fP07NPWhL4XbG
 Hc4aH8RD+Mm3du7EBIs/xoWAAPZhicQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-5aLddiwWMYOwt7m-sg76bg-1; Tue, 25 Jul 2023 12:10:01 -0400
X-MC-Unique: 5aLddiwWMYOwt7m-sg76bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B5E5856F67;
 Tue, 25 Jul 2023 16:10:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01CB14094DC0;
 Tue, 25 Jul 2023 16:09:59 +0000 (UTC)
Date: Tue, 25 Jul 2023 17:09:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZL/z1e/VATzZN10E@redhat.com>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com> <ZL7VZsaFxkIq4+cP@x1n>
 <ZL+TBBtL+RiMrOXJ@redhat.com> <ZL/wTBP/7ZdM9Xd4@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZL/wTBP/7ZdM9Xd4@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: permerror client-ip=216.145.221.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
 TO_EQ_FM_DOM_SPF_FAIL=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jul 25, 2023 at 11:54:52AM -0400, Peter Xu wrote:
> We can make the semantics specific, no strong opinion here.  I wished it
> can be as generic / easy as possible but maybe I went too far.
> 
> Though, is there anything else we can choose from besides
> "max-convergence-bandwidth"? Or am I the only one that thinks it's hard to
> understand when put "max" and "convergence" together?
> 
> When I take one step back to look at the whole "bandwidth" parameters, I am
> not sure why we'd even need both "convergence" and "postcopy" bandwidth
> being separate.  With my current understanding of migration, we may
> actually need:
> 
>   - One bandwidth that we may want to run the background migration, aka,
>     precopy migration, where we don't rush on pushing data.
> 
>   - One bandwidth that is whatever we can have maximum; for dedicated NIC
>     that's the line speed.  We should always use this full speed for
>     important things.  I'd say postcopy falls into this, and this
>     "convergence" calculation should also rely on this.

I don't think postcopy should be assumed to run at line speed.

At the point where you flip to post-copy mode, there could
conceivably still be GB's worth of data still dirty and
pending transfer.

The migration convergance step is reasonable to put at line
speed, because the max downtime parameter caps how long this
burst will be, genrally to some fraction of a second.

Once in post-copy mode, while the remaining data to transfer
is finite, the wall clock time to complete that transfer may
still be huge. It is unreasonable to assume users want to
run at max linespeed for many minutes to finish post-copy
at least in terms of the background transfer. You could make
a  case for the page fault handling to run at a higher bandwidth
cap than the background transfer, but I think it is still probably
not reasonable to run page fault fetches at line speed by default.

IOW, I don't think we can put the same bandwidth limit on the
short convergance operation, as on the longer post-copy operation.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


