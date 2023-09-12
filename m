Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE7179D67A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6Nj-0008MF-4d; Tue, 12 Sep 2023 12:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qg6NU-0008Kd-Bc
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qg6NP-00015x-Vi
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694536589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2OrPQ9o9KXadqUOiX8MdOmAdnpp1vJB3vuhGnzzfbI=;
 b=LdRnevDKTTALAFwxUoXvZD7rMrKthLigR2QWuuRyPr3tlKHG/uQe1X6VQXpi/mWZ3OVlle
 eoXNK54br6QdrJloaKe+Op+vhTDJR3aT5kOPwLnxZViLXj3sCXX94i1v3Xbq9+90XMdAQ3
 2h3gVOmC8IKxT/50ZD3LIgi4vblQPZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-hvA1vWMaNoecZefKMEUNVw-1; Tue, 12 Sep 2023 12:36:28 -0400
X-MC-Unique: hvA1vWMaNoecZefKMEUNVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CF82101FAA2;
 Tue, 12 Sep 2023 16:36:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8942140C2064;
 Tue, 12 Sep 2023 16:36:26 +0000 (UTC)
Date: Tue, 12 Sep 2023 18:36:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 2/3] rcu: add drain_call_rcu_co() API
Message-ID: <ZQCTiTULn6rSDJSf@redhat.com>
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <20230906190141.1286893-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906190141.1286893-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 06.09.2023 um 21:01 hat Stefan Hajnoczi geschrieben:
> call_drain_rcu() has limitations that make it unsuitable for use in
> qmp_device_add().

This sounds a bit vague with only alluding to some unnamed limitations.
I assume that you mean the two points you add to rcu.txt. If so, maybe
it would be better to add a reference to that in the commit message.

> Introduce a new coroutine version of drain_call_rcu()
> with the same functionality but that does not drop the BQL. The next
> patch will use it to fix qmp_device_add().
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

I don't understand the reasoning here. How does yielding from the
coroutine not effectively release the BQL, too? It's just that you won't
have explicit code here, but the mainloop will do it for you while
waiting for new events.

Is this about not dropping the BQL specifically in nested event loops,
but letting the coroutine wait until we return to the real main loop
where dropping the BQL is hopefully not a problem?

call_rcu_thread() still waits for the BQL to be dropped somewhere, so
from the perspective of the coroutine, it will definitely be dropped
during the yield.

So if this was your intention, the change probably makes sense, but the
description could be clearer. Took me a bit to understand what this is
really doing.

Kevin


