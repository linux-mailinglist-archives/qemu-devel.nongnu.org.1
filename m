Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D0828471
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 12:02:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN9rP-00029x-CV; Tue, 09 Jan 2024 06:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rN9rD-00028D-OU
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 06:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rN9r8-0007Aa-Uy
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 06:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704798073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZnOJ5qV/1nIX8HkjeJxLjMsfSgeTbCSiSTXnp6eXms=;
 b=MjEXLYiEoKpqyVw2NcqHNhWjqPgwCv/XNFc6ZGmUXvex6MXALfvkwF53EbMsBKEnrFN1o0
 pEJ1yROs+/lfXRpxnxXDV3neD3/nytWvzCokdL+KVhL9wx19cB7HP72M3QKLM00thPmHIa
 eBV3233phx2oY0u6r25mYcy9hK2u0Tc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-NEpP_TQ9Nri5To3UyEiEAQ-1; Tue, 09 Jan 2024 06:01:10 -0500
X-MC-Unique: NEpP_TQ9Nri5To3UyEiEAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3787833A0D;
 Tue,  9 Jan 2024 11:01:09 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B3AC15E6A;
 Tue,  9 Jan 2024 11:01:08 +0000 (UTC)
Date: Tue, 9 Jan 2024 12:01:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] block: Make snapshots fail gracefully on inactive
 images
Message-ID: <ZZ0nc7Z3T5dU2HaS@redhat.com>
References: <20231201142520.32255-1-kwolf@redhat.com>
 <2b505ab7-f01e-4b02-8bbe-295631027bbf@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b505ab7-f01e-4b02-8bbe-295631027bbf@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 22.12.2023 um 20:24 hat Michael Tokarev geschrieben:
> 01.12.2023 17:25, Kevin Wolf :
> > Kevin Wolf (3):
> >    block: Fix crash when loading snapshot on inactive node
> >    vl: Improve error message for conflicting -incoming and -loadvm
> >    iotests: Basic tests for internal snapshots
> 
> This smells like a stable-8.2 material, at least the first change
> (tho I'd pick all 3).  Maybe stable-8.1 too.

Yes, makes sense to me. It was a bit late for 8.2.0, but adding it to a
future stable release is reasonable.

> On the other hand, this is a rarely-used code path.

It is, but if you do hit it, it's still a crash.

Kevin


