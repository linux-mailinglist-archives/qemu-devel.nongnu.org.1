Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69B7A06F9
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:12:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgn3L-0007Gw-Pd; Thu, 14 Sep 2023 10:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgn3F-0007E7-SB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgn39-000330-OH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DiD4duRcSFDsiO3SfDcQWHYT9oSjB8PWpczkLYV+/qc=;
 b=A1rOGEEsfP/hffEdjbl1sscYNpLADbe9nl0uSA/an0v0cwv3efzMZNI4rfxTFRZj6DDnA6
 JXFDB3fwuuC1cTqngf9UOEGbhQnVBbZo8euKcSsMLQWA++cikAuBpbt1E/ouD5Xughp7vy
 v/ulNad7V66xOEMpsSNSccA5qs+kw/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-XwFnupGdPZCkMzvUXawyIw-1; Thu, 14 Sep 2023 10:10:27 -0400
X-MC-Unique: XwFnupGdPZCkMzvUXawyIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 232E480159F;
 Thu, 14 Sep 2023 14:10:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F56A10F1BE7;
 Thu, 14 Sep 2023 14:10:19 +0000 (UTC)
Date: Thu, 14 Sep 2023 09:10:17 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Message-ID: <urbpb7gwraskgsj5vplmeo5ik53ujqubzpeeaxn6x4of4bkycj@p32fhinqgcsm>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
 <22hgodp4wygkyjypqvfk7qfxbrwzvhhiwa6b7ajvh4dgayly3o@fnbvlimzupar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22hgodp4wygkyjypqvfk7qfxbrwzvhhiwa6b7ajvh4dgayly3o@fnbvlimzupar>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 13, 2023 at 10:36:35AM -0500, Eric Blake wrote:
> On Wed, Sep 06, 2023 at 04:09:17PM +0200, Denis V. Lunev wrote:
> > Each particular testcase could skipped intentionally and accidentally.
> > For example the test is not designed for a particular image format or
> > is not run due to the missed library.
> > 
> > The latter case is unwanted in reality. Though the discussion has
> > revealed that failing the test in such a case would be bad. Thus the
> > patch tries to do different thing. It adds additional status for
> > the test case - 'skipped' and bound intentinal cases to that state.
> 
> intentional
> 
> > 
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Kevin Wolf <kwolf@redhat.com>
> > CC: Hanna Reitz <hreitz@redhat.com>
> > CC: Eric Blake <eblake@redhat.com>
> > CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >  tests/qemu-iotests/common.rc     | 23 ++++++++++++++++-------
> >  tests/qemu-iotests/iotests.py    | 19 +++++++++++++++----
> >  tests/qemu-iotests/testrunner.py | 17 +++++++++++++++--
> >  3 files changed, 46 insertions(+), 13 deletions(-)
> 
> I agree that this makes it easier to identify skipped tests that can
> never be run (not designed for that combination) vs tests that can
> plausibly be run by addressing missing dependencies (such as
> installing additional libraries, a different file system, ...).
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Because patch 1 impacts NBD testing, I can queue the series through my
> NBD tree if no one else picks it up first.

Given further conversation, I've removed patch 3 from my queue while
conversation continues, but patch 1 and 2 are still queued (they are
independently useful, whether or not we add another result category)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


