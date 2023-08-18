Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A5780E63
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX0uA-0001UR-SG; Fri, 18 Aug 2023 10:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX0u8-0001U4-Ut
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 10:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX0u6-00034T-Tk
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 10:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692370606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJMpN3c1f9tcSaK4YCsMZM+5zQ8Qf4ZRtINrb05G9HU=;
 b=LjKDyCFBI7VA5xgUlXNpgO9bavFGkFcI/QvJCHcC3JUeQaoMA7+/MoHGA01eO0Y7uxWpD0
 +6HMdBOYTcZYHT4NkEGiK0oqUl5jechB7la8wggAjQbF9mMMW19jLtQWY7xVJYYmsxWGX8
 S+Y0ekPh7Xjg+E+A4aU8CQhtlsDpRJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-Kg1c_igTPeenD4aNrUQwsw-1; Fri, 18 Aug 2023 10:56:44 -0400
X-MC-Unique: Kg1c_igTPeenD4aNrUQwsw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FEE3185A78F;
 Fri, 18 Aug 2023 14:56:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C80E3492C13;
 Fri, 18 Aug 2023 14:56:42 +0000 (UTC)
Date: Fri, 18 Aug 2023 16:56:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, t.lamprecht@proxmox.com, qemu-block@nongnu.org
Subject: Re: [PATCH] iotests: adapt test output for new qemu_cleanup() behavior
Message-ID: <ZN+GqbebcMSE11SW@redhat.com>
References: <20230817112538.255111-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817112538.255111-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Am 17.08.2023 um 13:25 hat Fiona Ebner geschrieben:
> Since commit ca2a5e630d ("qemu_cleanup: begin drained section after
> vm_shutdown()"), there will be an additional pause for jobs during
> qemu_cleanup(). The reason is that the bdrv_drain_all() call in
> do_vm_stop() is not inside the drained section used by qemu_cleanup()
> anymore. I.e., there is a second drained section now that ends before
> the final one in qemu_cleanup() starts. Thus, job_pause() is called
> twice during cleanup (via child_job_drained_begin()).
> 
> Test 185 needs to be adapted directly too, because it waits for a
> specific number of JOB_STATUS_CHANGE events before the
> BLOCK_JOB_CANCELLED event.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Thanks, applied to the block branch.

Kevin


