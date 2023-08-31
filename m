Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3378EEA7
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:31:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhl0-00072Y-AL; Thu, 31 Aug 2023 09:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qbhkx-0006yb-ED
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qbhkv-00009Q-AL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693488639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZStodor8UvA+WFF4kgP2Laqj2k1UuSJXAI70p5sSKTo=;
 b=Z0kHpspiU51Euzllg1MAaT076rhCd2YL5ifUxFzeePOeuHvaJPI65gCTrAtC8vNR75t9YM
 nOLzOfSTh3WeEf6FPvv/NQAHh8tM1kyDruK4JQtsqJDVoUvhFWwTkdF4jPQJIb4W8fBw7n
 GgLCZ3I4BusdNLnFU0aykVLXsn1whj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-oDmAEscBNHqwiM0GXsUpOw-1; Thu, 31 Aug 2023 09:30:36 -0400
X-MC-Unique: oDmAEscBNHqwiM0GXsUpOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7B2F801005;
 Thu, 31 Aug 2023 13:30:35 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BF385CC05;
 Thu, 31 Aug 2023 13:30:34 +0000 (UTC)
Date: Thu, 31 Aug 2023 08:30:32 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Leonardo Bras <leobras@redhat.com>, farosas@suse.de, kwolf@redhat.com,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] io: follow coroutine AioContext in
 qio_channel_yield()
Message-ID: <xbfk576felak5tp37pt6qjhvac52udshrzl3nmayxe7eijx3bk@ydpdz5bx6x3h>
References: <20230829160623.277411-1-stefanha@redhat.com>
 <20230829160623.277411-5-stefanha@redhat.com>
 <z6rrcwlphydkdsg53sq66hv45ogdg47js6di6wl6ndxbibudci@cql6lnmzhvfk>
 <ZO71wKBFNT2BECAS@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO71wKBFNT2BECAS@redhat.com>
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

On Wed, Aug 30, 2023 at 08:54:40AM +0100, Daniel P. Berrangé wrote:
> > 
> > With those minor fixes,
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Eric, feel free to merge the two io subsystem changes at the same time
> as the NBD changes.

Ok; I'm queuing this series through my NBD branch, and will send a
pull request within the next few days.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


