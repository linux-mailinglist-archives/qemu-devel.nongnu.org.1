Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151AB7FA438
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:16:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dKW-00072Z-Pb; Mon, 27 Nov 2023 10:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7dKQ-00071z-Vk
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7dK8-0008J2-Ry
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701098098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JYuN41ddI9c1ToERlGMiCAXzmseMNcZVUSDiCBHl04=;
 b=PpI/RGjhOM2qyzlmFYVuUoqd9XXgPaPcX+CW5CSAYTpJRzrcJMNOwtXpufN5Gn8F/1yNsO
 oCdklFoe9P1UaNhiAA7ojrBb/yvhrhcvt+/4aNnT51GKMgL2KPt76d+iqjcJbvuJUUiEX6
 YLr7esUC+teQgMtTySnfgY19nMVrMFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-u1SEm0DmNh6Z42fyPoO4Lw-1; Mon, 27 Nov 2023 10:14:55 -0500
X-MC-Unique: u1SEm0DmNh6Z42fyPoO4Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EF42917D1A;
 Mon, 27 Nov 2023 15:14:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 605D51C060B0;
 Mon, 27 Nov 2023 15:14:53 +0000 (UTC)
Date: Mon, 27 Nov 2023 09:14:51 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/4] scsi: only access SCSIDevice->requests from one thread
Message-ID: <t6hcdnxouy2r54l4tzvgnrsov5zondv2crcs7q3qqukyazszsu@zpxjetadfdwa>
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123194931.171598-2-stefanha@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Nov 23, 2023 at 02:49:28PM -0500, Stefan Hajnoczi wrote:
> Stop depending on the AioContext lock and instead access
> SCSIDevice->requests from only one thread at a time:
> - When the VM is running only the BlockBackend's AioContext may access
>   the requests list.
> - When the VM is stopped only the main loop may access the requests
>   list.
> 
> These constraints protect the requests list without the need for locking
> in the I/O code path.
> 
> Note that multiple IOThreads are not supported yet because the code
> assumes all SCSIRequests are executed from a single AioContext. Leave
> that as future work.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/scsi/scsi.h |   7 +-
>  hw/scsi/scsi-bus.c     | 174 ++++++++++++++++++++++++++++-------------
>  2 files changed, 124 insertions(+), 57 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


