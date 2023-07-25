Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102EE761FD8
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 19:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOLYT-0006Sg-Ck; Tue, 25 Jul 2023 13:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOLYQ-0006SG-U4
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 13:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOLYP-0005oU-6D
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 13:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690305031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FETE+GbCONQ+2eGsGncFy4IN79ye2UnMH5mKUPLxDzU=;
 b=ATixpuOvQeP2x4g037gv9NCXCqGcoBUh82Mb1jygXi6inDvn7geRp3hdObcSJJww10j0b6
 NiqscIvses16ySTo/+823siFZcvO9BL/bwofCGjqzxPkPradfv1IR+J3daIf5iQaaPnAXR
 1cegItEOtsvSBY4h/5tYDPCsDl6WwtE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-fgeiNAphO_aQArwzXvqEjg-1; Tue, 25 Jul 2023 13:10:30 -0400
X-MC-Unique: fgeiNAphO_aQArwzXvqEjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6FBB1044593;
 Tue, 25 Jul 2023 17:10:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A8D1492C13;
 Tue, 25 Jul 2023 17:10:20 +0000 (UTC)
Date: Tue, 25 Jul 2023 18:10:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZMAB+tI9kIid0kBI@redhat.com>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com> <ZL7VZsaFxkIq4+cP@x1n>
 <ZL+TBBtL+RiMrOXJ@redhat.com> <ZL/wTBP/7ZdM9Xd4@x1n>
 <ZL/z1e/VATzZN10E@redhat.com> <ZL/6f7nNLw+iVHYL@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZL/6f7nNLw+iVHYL@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Tue, Jul 25, 2023 at 12:38:23PM -0400, Peter Xu wrote:
> I see you used "convergance" explicitly even after PeterM's reply, is that
> what you prefer over "convergence"?  I do see more occurances of
> "convergence" as a word in migration context, though.

Ignore my speling erors :-)

>                                                       Any better name you
> can come up with, before I just go with "max-convergence-bandwidth" (I
> really cannot come up with anything better than this or available-bandwidth
> for now)?

Anothre idea could be 'max-switchover-bandwidth'  ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


