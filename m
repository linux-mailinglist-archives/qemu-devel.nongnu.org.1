Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7047ADF69
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqs1-0004Co-7R; Mon, 25 Sep 2023 15:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqrv-00044L-Un
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqru-0005jp-Iu
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SF13kfLZmTSLk8qZGhSI3eHq4mFonKveXvZla4O4HU=;
 b=A391eUuS+HaVAaIUm1zSwX1Q9yP3i0zOGwVPWcPQIEI1q3XAuqRqcxUyhYx5KkSHSl8d77
 5wkpvE971VkxIj0dqEtBZC8lN1iAvTwZHr8ZUbWMpaKYf0qoIAY15MgdHIpHQAV/eb6CAZ
 VPIgw4DdOfx4rRiC3soORQG0q63K7ok=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-MifOrBVnPNm8a35oN7yhVg-1; Mon, 25 Sep 2023 15:03:40 -0400
X-MC-Unique: MifOrBVnPNm8a35oN7yhVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABABE1C06509;
 Mon, 25 Sep 2023 19:03:39 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE9EF2026D76;
 Mon, 25 Sep 2023 19:03:38 +0000 (UTC)
Date: Mon, 25 Sep 2023 14:03:37 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v6 05/17] nbd/server: Refactor handling of command sanity
 checks
Message-ID: <awd26yidr6abdxazgobiw3qqkc7s2thmceqy7yhaxn6gtjpqbt@vy5zmb2j6dsr>
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-24-eblake@redhat.com>
 <2ad497a6-7432-4ffd-138f-1c96ce7e3fce@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad497a6-7432-4ffd-138f-1c96ce7e3fce@yandex-team.ru>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On Mon, Sep 04, 2023 at 07:53:10PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 29.08.23 20:58, Eric Blake wrote:
> > Upcoming additions to support NBD 64-bit effect lengths will add a new
> > command flag NBD_CMD_FLAG_PAYLOAD_LEN that needs to be considered in
> > our sanity checks of the client's messages (that is, more than just
> > CMD_WRITE have the potential to carry a client payload when extended
> > headers are in effect).  But before we can start to support that, it
> > is easier to first refactor the existing set of various if statements
> > over open-coded combinations of request->type to instead be a single
> > switch statement over all command types that sets witnesses, then
> > straight-line processing based on the witnesses.  No semantic change
> > is intended.
> > 
> > Signed-off-by: Eric Blake<eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Patches 1-5 queued through my latest NBD pull request; will respin
patches 6 and following on top of latest master and post a v7 for one
more round of reviews.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


