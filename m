Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7928C7DD5C6
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:07:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxt84-0002zN-Lq; Tue, 31 Oct 2023 14:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxt81-0002wt-KK
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxt80-0005E2-1a
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698775571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uUMzkUfcZUy2uYm0Oz5X9hzs0R8OA+7QHaddaibW0LE=;
 b=Vio6TF73E5eAeK3dcjc1vSjp0xy92eV6a4ZYatvC0twmNt+awfBngNRdYgcVbytET0lffP
 x6CzUpoxOxaJ4EVxkm/9GD0kAdA93uTv5gQ+iGUJxHK9bIDgcXSBDDjB6AvoSvcnrrpaFp
 VuTxUKWJhfFjtfw9TNho1CdpkHBi6/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-pz7Av5DIPZC11KYBeEhifQ-1; Tue, 31 Oct 2023 14:06:01 -0400
X-MC-Unique: pz7Av5DIPZC11KYBeEhifQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFD7710726A5;
 Tue, 31 Oct 2023 18:06:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66FAC4B43A0;
 Tue, 31 Oct 2023 18:05:59 +0000 (UTC)
Date: Tue, 31 Oct 2023 13:05:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, 
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, 
 den@virtuozzo.com, t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v4 02/10] block/mirror: set actively_synced even after
 the job is ready
Message-ID: <mngg3d74fwsqxwe54uskl7hbrdz4ury7c7mhr52ddjsazkutlz@gbsocrgq2koh>
References: <20231031135431.393137-1-f.ebner@proxmox.com>
 <20231031135431.393137-3-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135431.393137-3-f.ebner@proxmox.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Tue, Oct 31, 2023 at 02:54:23PM +0100, Fiona Ebner wrote:
> In preparation to allow switching from background to active mode. This
> ensures that setting actively_synced will not be missed when the
> switch happens after the job is ready.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> No changes in v4.
> 
>  block/mirror.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


