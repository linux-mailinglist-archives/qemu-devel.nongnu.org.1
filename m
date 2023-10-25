Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C417D6AB7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 14:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvcak-0004Kr-90; Wed, 25 Oct 2023 08:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvcaG-0004Cq-Bi
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 08:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvcaE-0006Cy-Fs
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 08:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698235317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+wqHQhHtlrTNf25oc6VK92ih/LRiInI1fgTYrpSij0=;
 b=WD3kB0oobljG6UG1dWzuS/RoNYXESRELNGousLk57M+/GhG/0dtjlRGprXkQWofYTN4FBp
 eOhHIDqABQ6Jz/oFSN7S5nnxQxtBdaBSv4e+sNJOddXRVt3mVjXtvvEb2vbBM6FAtijQQ6
 QZuxM42sz4yjAydYTcAg7ynUrujw9Ko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-RF-z4zoEMxmz_gdd9rjRYQ-1; Wed, 25 Oct 2023 08:01:51 -0400
X-MC-Unique: RF-z4zoEMxmz_gdd9rjRYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79385101A54C;
 Wed, 25 Oct 2023 12:01:51 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F8F2166B26;
 Wed, 25 Oct 2023 12:01:49 +0000 (UTC)
Date: Wed, 25 Oct 2023 14:01:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 jsnow@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 t.lamprecht@proxmox.com
Subject: Re: [PATCH 0/3] fix a few blockjob-related deadlocks when using
 iothread
Message-ID: <ZTkDrHhIZ/Woas/O@redhat.com>
References: <20231019131936.414246-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019131936.414246-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Am 19.10.2023 um 15:19 hat Fiona Ebner geschrieben:
> The discussion leading up to this series can be found here:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg00729.html
> 
> Fiona Ebner (3):
>   blockjob: drop AioContext lock before calling bdrv_graph_wrlock()
>   block: avoid deadlock during bdrv_graph_wrlock() in bdrv_close()
>   blockdev: mirror: avoid deadlock when using iothread in certain cases

Thanks, applied to the block branch.

Kevin


