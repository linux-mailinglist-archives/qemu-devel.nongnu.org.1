Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3F79ED4D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:38:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRwU-0007JO-2N; Wed, 13 Sep 2023 11:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qgRwR-0007IS-QW
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qgRwP-0005p6-ED
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694619488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tbf26W22LiDq8r7w+y8aY2att2AhTDuYUArnOI5otlg=;
 b=aomK3shVBkNST1HXLf8DQIgm+EVDHBHd3znHtQX4+XcG9spX3IqP8/GY1cpPK8EoUrG38K
 /d/f+V5SNmT5k3I2mAk5QCQEf05EDD5h/QSMJF8CWzYivHvtcut+3jFDXBnMTyYUtMfzNX
 nEVJJOz4j9fz4rbhKbppOZ4zpkOpxeI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-x6OUwpx6O9GD5I-nzW9PPw-1; Wed, 13 Sep 2023 11:38:05 -0400
X-MC-Unique: x6OUwpx6O9GD5I-nzW9PPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC38B88B7A1;
 Wed, 13 Sep 2023 15:38:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A26C10F1BE7;
 Wed, 13 Sep 2023 15:38:04 +0000 (UTC)
Date: Wed, 13 Sep 2023 17:38:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-8.0.5 00/66] v2 Patch Round-up for stable 8.0.5, freeze
 on 2023-09-19
Message-ID: <ZQHXW74CpyTIVYET@redhat.com>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 13.09.2023 um 15:17 hat Michael Tokarev geschrieben:
> The following patches are queued for QEMU stable v8.0.5:
> 
>   https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0
> 
> Patch freeze is 2023-09-19, and the release is planned for 2023-09-21:
> 
>   https://wiki.qemu.org/Planning/8.0
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.
> 
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.
> 
> The v2 version includes reentrancy fixes the same way as staging-7.2, -
> thought I'd not make the two different from each other in this context.
> It also includes a few more changes accumulated to date.
> 
> I'm not sure about this change for now:
>  56 92e2e6a86733 Kevin Wolf:
>    virtio: Drop out of coroutine context in virtio_load()
> 
> since it introduces regression on mips ( https://gitlab.com/qemu-project/qemu/-/issues/1866 )  -
> should it be in 8.0 (or 7.2) to begin with?  I think I should wait for
> a while and include it in earlier versions only after the fix for the
> regression will be found, and include this change in 8.1 only for now.
> (Cc'ing Kevin for this).

What is the change in commit 92e2e6a86733 that could affect this bug? I
only changed the migration code path, but the Gitlab issue doesn't
mention migration at all. In the issue itself, I can only see it linked
to a different commit (0d58c660 softmmu: Use async_run_on_cpu in
tcg_commit).

Did you mean a different commit or a different issue?

Kevin


