Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A9AB7211
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 19:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFSE-0007QA-Oi; Wed, 14 May 2025 12:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFSB-0007PD-25
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFS9-0006cs-E5
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747241972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tf3o9IT2l2vRejCMaYpXdGYAlgO7UJCLb6hXwiCAMUU=;
 b=JhkAb2enEDXSrODoo8kEZZMj3xjm3AC9S3KpyBUDWjC6jK0PFVh4oyKilYRAT5HsfLeeJa
 LKFWmBGSawjD4Fv13ONjxv7T6uYXQ9gZXj3dCCdsacjte7D1VaiEQIF0jXE+Vbgwrm3Clb
 yakIXhd6ypjJ7QnNjCGNEP3DDnpraow=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-oACW6yAsOsiXB6s28oJi8w-1; Wed,
 14 May 2025 12:59:30 -0400
X-MC-Unique: oACW6yAsOsiXB6s28oJi8w-1
X-Mimecast-MFC-AGG-ID: oACW6yAsOsiXB6s28oJi8w_1747241969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB051800360; Wed, 14 May 2025 16:59:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA7A718008F0; Wed, 14 May 2025 16:59:24 +0000 (UTC)
Date: Wed, 14 May 2025 18:59:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 04/11] block: drain while unlocked in
 bdrv_reopen_parse_file_or_backing()
Message-ID: <aCTL6jeTSntPU1XD@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-5-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-5-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 0085dbfa74..c7c26533c9 100644
> --- a/block.c
> +++ b/block.c
> @@ -4805,10 +4805,11 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
>  
>      if (old_child_bs) {
>          bdrv_ref(old_child_bs);
> +        bdrv_graph_rdunlock_main_loop();
>          bdrv_drained_begin(old_child_bs);
> +    } else {
> +        bdrv_graph_rdunlock_main_loop();
>      }

This pattern is a bit ugly, so good that you get rid of it again later
in the series.

> -
> -    bdrv_graph_rdunlock_main_loop();
>      bdrv_graph_wrlock();
>  
>      ret = bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


