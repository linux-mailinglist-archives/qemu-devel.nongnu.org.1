Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBC816B27
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 11:30:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFArh-0006CL-3j; Mon, 18 Dec 2023 05:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFArd-0006BR-DA
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 05:28:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFArb-0006n5-Hf
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 05:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702895322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWwpokJxzh/zFMj7WtwruIa5/wWdWQYGt6c8h67H36Q=;
 b=BQwP1GMJosctPWu0Y7nHKEJH+kMoOSIqVOI/oGAhYOFLubxwKbhf5nD+rsYTX5YGGyEA41
 PG4ME5RI4Ye08wgHF6Bj+IOU+fPx/xSatJd+UpObg+kuAjER1hDsKoFIBhJ9VKAHlUN8yY
 yEg/IRfYOE/lc6q5PTY4bYYkiEEG2LE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-xCh-4qbUNFuCcp8pn7HJTA-1; Mon,
 18 Dec 2023 05:28:38 -0500
X-MC-Unique: xCh-4qbUNFuCcp8pn7HJTA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 375B1280C28A;
 Mon, 18 Dec 2023 10:28:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87598492BC6;
 Mon, 18 Dec 2023 10:28:36 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:28:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] scsi: eliminate AioContext lock
Message-ID: <ZYAe06nz-KRshz0b@redhat.com>
References: <20231204164259.1515217-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204164259.1515217-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

[ Cc: qemu-block ]

Am 04.12.2023 um 17:42 hat Stefan Hajnoczi geschrieben:
> v2:
> - Reschedule BH in new AioContext if change is detected [Kevin]
> - Drop stray "remember" in Patch 2's commit description [Eric]
> 
> The SCSI subsystem uses the AioContext lock to protect internal state. This is
> necessary because the main loop and the IOThread can access SCSI state in
> parallel. This inter-thread access happens during scsi_device_purge_requests()
> and scsi_dma_restart_cb().
> 
> This patch series modifies the code so SCSI state is only accessed from the
> IOThread that is executing requests. Once this has been achieved the AioContext
> lock is no longer necessary.
> 
> Note that a few aio_context_acquire()/aio_context_release() calls still remain
> after this series. They surround API calls that invoke AIO_WAIT_WHILE() and
> therefore still rely on the AioContext lock for now.
> 
> Stefan Hajnoczi (4):
>   scsi: only access SCSIDevice->requests from one thread
>   virtio-scsi: don't lock AioContext around
>     virtio_queue_aio_attach_host_notifier()
>   scsi: don't lock AioContext in I/O code path
>   dma-helpers: don't lock AioContext in dma_blk_cb()

Thanks, applied to the block branch.

Kevin


