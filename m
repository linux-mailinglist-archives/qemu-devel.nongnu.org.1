Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5DF7CFB55
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCr-0003oG-0H; Thu, 19 Oct 2023 09:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qtTCL-0002L8-Fs
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qtTCJ-0001aA-0M
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697722581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTMfDiTUS7Qwi71vPyy/Q7P0sWJHK43vA9M62UrvKS4=;
 b=MeNwjH9IyNZvRSWarSGBC0PebvrB/A69p9hIst/8nSXInSUU1WCBBrAUabWFhBwCSIZwda
 BD56h1Su10Ww86UUGANpXKkIN5H6E8ro3V5LmdS29TpspIisAFwWdXOwl1DO9M3pngl58F
 90e1P+AM/nes6Zy5h2VGXdYMC4BFw9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-Hn8cuqhmN0W5Hb6IPJCaHA-1; Thu, 19 Oct 2023 09:36:18 -0400
X-MC-Unique: Hn8cuqhmN0W5Hb6IPJCaHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCA4E886C6C;
 Thu, 19 Oct 2023 13:36:17 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34FB32166B29;
 Thu, 19 Oct 2023 13:36:16 +0000 (UTC)
Date: Thu, 19 Oct 2023 15:36:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 0/9] mirror: allow switching from background to active
 mode
Message-ID: <ZTEwzi8x6cFfP9+e@redhat.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013092143.365296-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 13.10.2023 um 11:21 hat Fiona Ebner geschrieben:
> Changes in v3:
>     * unlock the job mutex when calling the new block job driver
>       'query' handler
>     * squash patch adapting iotest output into patch that changes the
>       output
>     * turn accesses to copy_mode and actively_synced atomic
>     * slightly rework error handling in mirror_change
> 
> Changes in v2:
>     * move bitmap to filter which allows to avoid draining when
>       changing the copy mode
>     * add patch to determine copy_to_target only once
>     * drop patches returning redundant information upon query
>     * update QEMU version in QAPI
>     * update indentation in QAPI
>     * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
>       doc comments to conform to current conventions"))
>     * add patch to adapt iotest output
> 
> Discussion of v2:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg02290.html
> 
> Discussion of v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg07216.html
> 
> With active mode, the guest write speed is limited by the synchronous
> writes to the mirror target. For this reason, management applications
> might want to start out in background mode and only switch to active
> mode later, when certain conditions are met. This series adds a
> block-job-change QMP command to achieve that, as well as
> job-type-specific information when querying block jobs, which
> can be used to decide when the switch should happen.
> 
> For now, only the direction background -> active is supported.
> 
> The information added upon querying is whether the target is actively
> synced, the total data sent, and the remaining dirty bytes.

Most of this series looks good to me. Apart from the comments I made in
the individual patches, I would like to see iotests coverage of changing
the mirroring mode. At the least to show that the query result changes,
but ideally also that requests really block after switchting to active.
I think with a throttled target node and immediately reading the target
when the write request completes we should be able to check this.

Kevin


