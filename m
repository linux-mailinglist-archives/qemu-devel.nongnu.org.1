Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A080108A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 17:50:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r96h5-0000a7-14; Fri, 01 Dec 2023 11:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r96h2-0000Zc-EH
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r96h0-0005Fk-R2
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701449321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6eb4jKXFUSrpEn38V31y8459yUzTVZs3T8NahHPtp4=;
 b=Er0hSBai7RZzZmJDQzJ5oQtutztl5aLpCLTEHS7eTU3t1kLe9qKwFSYY7bPl0/5ApyueeG
 kfMakv6g64SevHprz9HS9QXcIF7xJB6ufGc7YSoW//4onduEHxpAjrC8vUmxz9OQrER8Qq
 TxieA+6dRUW6vOH5X09nd6197GCqQmk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-UydhBTpEMz6pRb1cRCJaRg-1; Fri,
 01 Dec 2023 11:48:38 -0500
X-MC-Unique: UydhBTpEMz6pRb1cRCJaRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D8AA2803027;
 Fri,  1 Dec 2023 16:48:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37787492BFE;
 Fri,  1 Dec 2023 16:48:37 +0000 (UTC)
Date: Fri, 1 Dec 2023 17:48:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 4/4] dma-helpers: don't lock AioContext in dma_blk_cb()
Message-ID: <ZWoOZEZdxbJy5W9x@redhat.com>
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123194931.171598-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 23.11.2023 um 20:49 hat Stefan Hajnoczi geschrieben:
> Commit abfcd2760b3e ("dma-helpers: prevent dma_blk_cb() vs
> dma_aio_cancel() race") acquired the AioContext lock inside dma_blk_cb()
> to avoid a race with scsi_device_purge_requests() running in the main
> loop thread.
> 
> The SCSI code no longer calls dma_aio_cancel() from the main loop thread
> while I/O is running in the IOThread AioContext. Therefore it is no
> longer necessary to take this lock to protect DMAAIOCB fields. The
> ->cb() function also does not require the lock because blk_aio_*() and
> friends do not need the AioContext lock.
> 
> Both hw/ide/core.c and hw/ide/macio.c also call dma_blk_io() but don't
> rely on it taking the AioContext lock, so this change is safe.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

The commit message neglects to talk about dbs->io_func, which is what
took the AioContext lock even before commit abfcd2760b3e. I think the
reason is the same as for the previous patch.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


