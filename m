Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A077BB51
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 16:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVYLV-0002OV-2u; Mon, 14 Aug 2023 10:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qVYLL-0002DF-6E
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qVYLI-0002UW-UP
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692022487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+Kg+zq7EUpTIM0mTd66+Hf784bEBMRQF2yrB1/s0ko=;
 b=V9+zsH4JR7xOy5+lp7ZuumVz0EE++v+gOHyqBkz4fxaG2nDGc51NrQyWc0W6BXk+tVXl9S
 DZ3kJc1ohStxdNhL2u93OQNSnxMz8Qu4rYtCgGUBOz0n1N5hiElS1mItf2LnyrjDhbtmBF
 s6mxMNRZjXkRZwKfaKIraRhrpucfaWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-T3j8t4hXNrOuK2Uxem1elQ-1; Mon, 14 Aug 2023 10:14:44 -0400
X-MC-Unique: T3j8t4hXNrOuK2Uxem1elQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41DFE85CBE5;
 Mon, 14 Aug 2023 14:14:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 167FC44104;
 Mon, 14 Aug 2023 14:14:42 +0000 (UTC)
Date: Mon, 14 Aug 2023 16:14:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Message-ID: <ZNo20bIZCRjypsIN@redhat.com>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717145544.194786-3-den@openvz.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 17.07.2023 um 16:55 hat Denis V. Lunev geschrieben:
> Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
>     Author: Hanna Reitz <hreitz@redhat.com>
>     Date:   Wed May 8 23:18:18 2019 +0200
>     qemu-nbd: Do not close stderr
> has introduced an interesting regression. Original behavior of
>     ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
> was the following:
>  * qemu-nbd was started as a daemon
>  * the command execution is done and ssh exited with success
> 
> The patch has changed this behavior and 'ssh' command now hangs forever.
> 
> According to the normal specification of the daemon() call, we should
> endup with STDERR pointing to /dev/null. That should be done at the
> very end of the successful startup sequence when the pipe to the
> bootstrap process (used for diagnostics) is no longer needed.
> 
> This could be achived in the same way as done for 'qemu-nbd -c' case.
> That was commit 0eaf453e, also fixing up e6df58a5. STDOUT copying to
> STDERR does the trick.
> 
> This also leads to proper 'ssh' connection closing which fixes my
> original problem.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: <qemu-stable@nongnu.org>

This broke qemu-iotests 233 (Eric, please make sure to run the full
qemu-iotests suite before sending block related pull requests):

--- /home/kwolf/source/qemu/tests/qemu-iotests/233.out
+++ /home/kwolf/source/qemu/build-clang/scratch/raw-file-233/233.out.bad
@@ -99,14 +99,4 @@
 qemu-nbd: TLS handshake failed: The TLS connection was non-properly terminated.

 == final server log ==
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
-qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
-qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
-qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
 *** done

Do we really want to lose these error messages? This looks wrong to me.

Kevin


