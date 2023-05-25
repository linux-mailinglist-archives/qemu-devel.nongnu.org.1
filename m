Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1A7108F9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 11:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27LT-00067y-CF; Thu, 25 May 2023 05:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q27LR-00067m-6u
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q27LP-00056h-2C
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685007193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZIEimjz+ttg394lY3rDlCId4IhIo68BzUhyhEUeTHA=;
 b=hL1bmIe/jhEaksvhzhdrRUE439mho/cBCBX7JesQsGBSvTS9bIano4jXluOQ8N2ZBtcXE2
 zOgYadh5l+pD+erMVI82/9kJKoJu6C8DSUHsr4Z1cyOBIBjg/Cn5vcmgxNF0nDzgEMPHIT
 B56izJ4c0tqtncsOMtZgIbo5Ov8JWm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-7pc0vlW0MGO5bdntgTvWgA-1; Thu, 25 May 2023 05:33:10 -0400
X-MC-Unique: 7pc0vlW0MGO5bdntgTvWgA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62B90185A78E;
 Thu, 25 May 2023 09:33:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37894492B00;
 Thu, 25 May 2023 09:33:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 263B521E692E; Thu, 25 May 2023 11:33:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>,  Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Juan Quintela <quintela@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yishai Hadas
 <yishaih@nvidia.com>,  Jason Gunthorpe <jgg@nvidia.com>,  Maor Gottlieb
 <maorg@nvidia.com>,  Kirti Wankhede <kwankhede@nvidia.com>,  Tarun Gupta
 <targupta@nvidia.com>,  Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v3 1/7] migration: Add switchover ack capability
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-2-avihaih@nvidia.com>
Date: Thu, 25 May 2023 11:33:08 +0200
In-Reply-To: <20230521151808.24804-2-avihaih@nvidia.com> (Avihai Horon's
 message of "Sun, 21 May 2023 18:18:02 +0300")
Message-ID: <87edn4u563.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Avihai Horon <avihaih@nvidia.com> writes:

> Migration downtime estimation is calculated based on bandwidth and
> remaining migration data. This assumes that loading of migration data in
> the destination takes a negligible amount of time and that downtime
> depends only on network speed.
>
> While this may be true for RAM, it's not necessarily true for other
> migration users. For example, loading the data of a VFIO device in the
> destination might require from the device to allocate resources, prepare
> internal data structures and so on. These operations can take a
> significant amount of time which can increase migration downtime.
>
> This patch adds a new capability "switchover ack" that prevents the
> source from stopping the VM and completing the migration until an ACK
> is received from the destination that it's OK to do so.
>
> This can be used by migrated devices in various ways to reduce downtime.
> For example, a device can send initial precopy metadata to pre-allocate
> resources in the destination and use this capability to make sure that
> the pre-allocation is completed before the source VM is stopped, so it
> will have full effect.
>
> This new capability relies on the return path capability to communicate
> from the destination back to the source.
>
> The actual implementation of the capability will be added in the
> following patches.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


