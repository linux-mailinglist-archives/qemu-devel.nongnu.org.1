Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73A710FDF
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D9g-0002bN-Q4; Thu, 25 May 2023 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2D9Z-0002ag-AH
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2D9X-0003Ui-Qi
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685029523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JZwJIRgrfElkmTW5YQ+IMU9taNnO0GE/G6375uaebE=;
 b=ESRmCNRPqDMmSt0W8S0b97vWYHpPWn1/cmYM9XGT78kprSFko1aKGph39YgYeiKwxR/h5U
 PgaYqXLE6bBlnS1M1cO1sF+0Tdc4t9Dm1Kw4fkrFT0HyQJ6IO5vPNStoiGGyp5JVo+ltwd
 kbGuC9Kn+cpRhV/J/LY3BgvlM9D/Mhw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-qFYnWynfPRqN-pWalr5rcA-1; Thu, 25 May 2023 11:45:21 -0400
X-MC-Unique: qFYnWynfPRqN-pWalr5rcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 228C8185A792;
 Thu, 25 May 2023 15:45:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57DCB1121314;
 Thu, 25 May 2023 15:45:20 +0000 (UTC)
Date: Thu, 25 May 2023 10:45:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?Sm/Do28=?= Silva <jsilva@suse.de>, 
 Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>, 
 Dario Faggioli <dfaggioli@suse.com>
Subject: Re: [RFC PATCH 6/6] block: Add a thread-pool version of fstat
Message-ID: <tgkuil4lqa3x7tkzup4shdeie2z2j6uzzrn7ccf42uimjm64yz@7ksw3twdshye>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523213903.18418-7-farosas@suse.de>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Tue, May 23, 2023 at 06:39:03PM -0300, Fabiano Rosas wrote:
> From: João Silva <jsilva@suse.de>
> 
> The fstat call can take a long time to finish when running over
> NFS. Add a version of it that runs in the thread pool.
> 
> Adapt one of its users, raw_co_get_allocated_file size to use the new
> version. That function is called via QMP under the qemu_global_mutex
> so it has a large chance of blocking VCPU threads in case it takes too
> long to finish.
> 
> Signed-off-by: João Silva <jsilva@suse.de>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  block/file-posix.c      | 40 +++++++++++++++++++++++++++++++++++++---
>  include/block/raw-aio.h |  4 +++-
>  2 files changed, 40 insertions(+), 4 deletions(-)

Should this change occur earlier in the series, before calling
commands are marked with QAPI coroutine flags?  Otherwise, you have a
bisection bug, where something marked coroutine can end up hanging
when it calls a blocking syscall in the wrong context without the help
of this patch offloading the syscall into a helper thread.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


