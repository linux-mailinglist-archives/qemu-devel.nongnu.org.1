Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34CB7FA572
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:59:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7e0s-0008St-DT; Mon, 27 Nov 2023 10:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7e0q-0008Si-Vd
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:59:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7e0o-0000Fs-RA
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701100745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kK4WrFGMgOkZhrtabBf7fSuhlD9WIndeBxuMsKTjAqs=;
 b=HTRuCIAiKrqJgDdRlU871qJ2bxxq6IkZ3P0IRxtV/925iW2QplCzmj7CLD/2SALGrULj0c
 mRovAi7mR1cSeOLMHGoG/k1+40S1E8klfrliDBT1Yvc44BtOLSpIbmlCuQF3zKV4DRNyRs
 PKuY5aOysdXvcjoC2TPuObDLHtI4Y9s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-cWsBnjXuN7K6aWN6bXvdCw-1; Mon,
 27 Nov 2023 10:59:01 -0500
X-MC-Unique: cWsBnjXuN7K6aWN6bXvdCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11E883813BC5;
 Mon, 27 Nov 2023 15:59:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A17C32166B26;
 Mon, 27 Nov 2023 15:58:59 +0000 (UTC)
Date: Mon, 27 Nov 2023 09:58:57 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 3/4] scsi: don't lock AioContext in I/O code path
Message-ID: <bm7xuytk7kunjoeucb4fel3mjprqw33w7hqdlnrt4wx3tekqx3@o66wrxw3dxen>
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123194931.171598-4-stefanha@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

On Thu, Nov 23, 2023 at 02:49:30PM -0500, Stefan Hajnoczi wrote:
> blk_aio_*() doesn't require the AioContext lock and the SCSI subsystem's
> internal state also does not anymore.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/scsi/scsi-disk.c    | 23 -----------------------
>  hw/scsi/scsi-generic.c | 20 +++-----------------
>  2 files changed, 3 insertions(+), 40 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


