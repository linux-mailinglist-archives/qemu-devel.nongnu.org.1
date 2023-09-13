Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FA79ED41
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRvC-0005je-Tb; Wed, 13 Sep 2023 11:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgRv9-0005jQ-A4
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgRv7-0005ha-4X
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694619407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xw3+5wAmVjJKEr5YXXGK9QuIWsOMMh8dR/V10sySsI=;
 b=BRwvqIOSnjPxgip4VRyroK7FVwIH0MdfJrujKgqkz2x8VG5MljFe/tz3ahdVcEeMDnqzYp
 QrAlNDjGGeLMyaea1qeBuEzURyWBWN2uLT+FIOKE1/Q31EAZckBLN7OBlEQTb9G8FD8EAL
 v2NqNCfFBu4t2Izn8z4v2Z59G5l0bzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-xxpH4SZJM0K3_mX8eC5ZqQ-1; Wed, 13 Sep 2023 11:36:43 -0400
X-MC-Unique: xxpH4SZJM0K3_mX8eC5ZqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 625C7100DDD5;
 Wed, 13 Sep 2023 15:36:43 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99ED46468B;
 Wed, 13 Sep 2023 15:36:42 +0000 (UTC)
Date: Wed, 13 Sep 2023 10:36:35 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Message-ID: <22hgodp4wygkyjypqvfk7qfxbrwzvhhiwa6b7ajvh4dgayly3o@fnbvlimzupar>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906140917.559129-4-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 06, 2023 at 04:09:17PM +0200, Denis V. Lunev wrote:
> Each particular testcase could skipped intentionally and accidentally.
> For example the test is not designed for a particular image format or
> is not run due to the missed library.
> 
> The latter case is unwanted in reality. Though the discussion has
> revealed that failing the test in such a case would be bad. Thus the
> patch tries to do different thing. It adds additional status for
> the test case - 'skipped' and bound intentinal cases to that state.

intentional

> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/qemu-iotests/common.rc     | 23 ++++++++++++++++-------
>  tests/qemu-iotests/iotests.py    | 19 +++++++++++++++----
>  tests/qemu-iotests/testrunner.py | 17 +++++++++++++++--
>  3 files changed, 46 insertions(+), 13 deletions(-)

I agree that this makes it easier to identify skipped tests that can
never be run (not designed for that combination) vs tests that can
plausibly be run by addressing missing dependencies (such as
installing additional libraries, a different file system, ...).

Reviewed-by: Eric Blake <eblake@redhat.com>

Because patch 1 impacts NBD testing, I can queue the series through my
NBD tree if no one else picks it up first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


