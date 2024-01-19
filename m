Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94964832E02
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:19:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsUq-0005is-MJ; Fri, 19 Jan 2024 12:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQsUg-0005gB-Q9
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:17:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQsUf-0005LU-BQ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705684644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CP3zW31LeUzifZwANgeY1Bl3gVqlDqSPiILzMFXza+4=;
 b=RwqyAvluMtK5DuU+1jaVx+l/puLA62WVojGlCcIpEBFXiXis6NI6s78yOoxxXFm3bJcm2A
 YacTciRP6cPA7D0jH6PcT/2/KsAmPB5yJxYy8S9p4NRUpSwrvE9rSGHu4U+18rnCwW53g6
 cqhcdTb7z2ftK+cmW8zS818LXwBKsdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-CzzJqa_BMwmv8GqFrWySfw-1; Fri, 19 Jan 2024 12:17:20 -0500
X-MC-Unique: CzzJqa_BMwmv8GqFrWySfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9291889106E;
 Fri, 19 Jan 2024 17:17:20 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB6F81121306;
 Fri, 19 Jan 2024 17:17:18 +0000 (UTC)
Date: Fri, 19 Jan 2024 18:17:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/6] virtio-blk: iothread-vq-mapping cleanups
Message-ID: <ZaqumG_cpdSprI1U@redhat.com>
References: <20240119135748.270944-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119135748.270944-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 19.01.2024 um 14:57 hat Stefan Hajnoczi geschrieben:
> Kevin Wolf identified some issues with the virtio-blk iothread-vq-mapping patch
> series that was merged at the end of 2023:
> 1. s->rq is restarted from one AioContext and races with the other
>    iothread-vq-mapping AioContexts.
> 2. Failure to set the AioContext is no longer fatal since the IO_CODE APIs can
>    be called from any thread. We can relax the error handling behavior.
> 3. Starting dataplane must self-trigger the ioeventfd even in a drained
>    section. Failure to do so could lead to an unresponsive virtio-blk device.
> 
> This patch series addresses these issues. The first few patches merge the
> hw/block/dataplane/virtio-blk.c code into hw/block/virtio-blk.c so that s->rq
> can easily be restarted in the correct AioContexts.

Thanks, applied to the block branch.

Kevin


