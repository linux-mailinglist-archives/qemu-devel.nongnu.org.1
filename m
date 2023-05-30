Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AF716935
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:25:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q429O-0001wE-8i; Tue, 30 May 2023 12:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q429G-0001rJ-JR
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q429E-00069X-B9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685463875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+PO7OF1UJIEyhl34/BsyVvrG83vEPKJb7h1Om/b9M+g=;
 b=TFYWPr1ShaeaFr3cSXk1OBlbi8QoodYj8eac86v8iRCAe5NxQ6OBHrwWF6iGc2KauDb//h
 t10qTB7HgEM6MsoXeA2DpV9MuLsAhs2yyce8ZYS3GZNl/FfxCSU9GFwCcuE1ccLmmiZZHr
 nyat6kOyIoN+5OU4i9pJoxrvsfXRByU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-ahITsgYMPYCTa1zF2WpWBg-1; Tue, 30 May 2023 12:24:33 -0400
X-MC-Unique: ahITsgYMPYCTa1zF2WpWBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0662F87282F;
 Tue, 30 May 2023 16:24:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E24581121330;
 Tue, 30 May 2023 16:24:14 +0000 (UTC)
Date: Tue, 30 May 2023 18:24:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Peter Xu <peterx@redhat.com>, xen-devel@lists.xenproject.org,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Julia Suvorova <jusual@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, eesposit@redhat.com,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paul Durrant <paul@xen.org>,
 Stefan Weil <sw@weilnetz.de>, Anthony Perard <anthony.perard@citrix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v6 00/20] block: remove aio_disable_external() API
Message-ID: <ZHYjLQ3pb+GBav6i@redhat.com>
References: <20230516190238.8401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516190238.8401-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Am 16.05.2023 um 21:02 hat Stefan Hajnoczi geschrieben:
> The aio_disable_external() API temporarily suspends file descriptor monitoring
> in the event loop. The block layer uses this to prevent new I/O requests being
> submitted from the guest and elsewhere between bdrv_drained_begin() and
> bdrv_drained_end().
> 
> While the block layer still needs to prevent new I/O requests in drained
> sections, the aio_disable_external() API can be replaced with
> .drained_begin/end/poll() callbacks that have been added to BdrvChildClass and
> BlockDevOps.
> 
> This newer .bdrained_begin/end/poll() approach is attractive because it works
> without specifying a specific AioContext. The block layer is moving towards
> multi-queue and that means multiple AioContexts may be processing I/O
> simultaneously.
> 
> The aio_disable_external() was always somewhat hacky. It suspends all file
> descriptors that were registered with is_external=true, even if they have
> nothing to do with the BlockDriverState graph nodes that are being drained.
> It's better to solve a block layer problem in the block layer than to have an
> odd event loop API solution.
> 
> The approach in this patch series is to implement BlockDevOps
> .drained_begin/end() callbacks that temporarily stop file descriptor handlers.
> This ensures that new I/O requests are not submitted in drained sections.

Thanks, applied to the block branch.

Kevin


