Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88D7FA939
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 19:47:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7gch-0005wi-Q7; Mon, 27 Nov 2023 13:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7gcf-0005uw-NO
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 13:46:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7gce-0007qr-BM
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 13:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701110778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ll5V6VgvufLd+KtrVwn90o/0v8J8D0d1kpkYo7od0k=;
 b=Pc2iN6Q3SQ6SWtP8lV1na3xX7gFw9YpWPVLeUyfaTU69LV9RpzkOgESBANNyNvPt04n2Ch
 UNe0/FRTHj2S29ajGqRer+REzldV+zURfyh8Y8OV6gOJ8rBBWMSn9MP9p/J9blxQLH/fkf
 KBq7Ms73T9qaDWyxXPtL4ERw+JjZ+Qc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-KFqQlwshPDaFzGiUJ1iuhQ-1; Mon, 27 Nov 2023 13:46:14 -0500
X-MC-Unique: KFqQlwshPDaFzGiUJ1iuhQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D32F9101B04E;
 Mon, 27 Nov 2023 18:46:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EB5D492BFA;
 Mon, 27 Nov 2023 18:46:11 +0000 (UTC)
Date: Mon, 27 Nov 2023 12:46:09 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 4/4] dma-helpers: don't lock AioContext in dma_blk_cb()
Message-ID: <fcick3cpcoiyirxicsenayi4sbzoumrngppag6yjz3ih22gkfq@pljof5a5kzy3>
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123194931.171598-5-stefanha@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 23, 2023 at 02:49:31PM -0500, Stefan Hajnoczi wrote:
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
> ---
>  system/dma-helpers.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


