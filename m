Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5189E7CE1C2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:53:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8qZ-0000hr-Sl; Wed, 18 Oct 2023 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qt8qU-0000hM-BP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qt8qQ-0006GR-OS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eu9ZBiY5duOeIVFDlxFxHvQhwWK/A0cuTpa2YGJfPnc=;
 b=A6yWVLGrjM0aT6oQSA2ENj1SvlDkkJiI/UUsMpJ8m1Nr2uhRMcGws/kTcALCAcvJYOgB26
 TMhy48O+j2R3BGvAvL4iyZJ6PoXhBuSW4Be4mV7wrzoIyv4slDqtapzp4bWx5xK1etev8k
 yWvQAeaaENmu6xnTP1vpZqF8xvQ+Zqc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-cHJfOGM_Mm6ROXkwiM5JMA-1; Wed, 18 Oct 2023 11:52:21 -0400
X-MC-Unique: cHJfOGM_Mm6ROXkwiM5JMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85DF91C05AC0;
 Wed, 18 Oct 2023 15:52:20 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAAE240C6F7B;
 Wed, 18 Oct 2023 15:52:18 +0000 (UTC)
Date: Wed, 18 Oct 2023 17:52:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 1/9] blockjob: introduce block-job-change QMP command
Message-ID: <ZS//MVrI7XeJT0Bq@redhat.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-2-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013092143.365296-2-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 13.10.2023 um 11:21 hat Fiona Ebner geschrieben:
> which will allow changing job-type-specific options after job
> creation.
> 
> In the JobVerbTable, the same allow bits as for set-speed are used,
> because set-speed can be considered an existing change command.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> diff --git a/job.c b/job.c
> index 72d57f0934..99a2e54b54 100644
> --- a/job.c
> +++ b/job.c
> @@ -80,6 +80,7 @@ bool JobVerbTable[JOB_VERB__MAX][JOB_STATUS__MAX] = {
>      [JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
>      [JOB_VERB_FINALIZE]             = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
>      [JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
> +    [JOB_VERB_CHANGE]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
>  };

I'm not sure if I would have included JOB_STATUS_CREATED, i.e. before
the job has even started, but it's not necessarily a problem. The
implementation just need to be careful to work even in early stages. But
probably the early stages include some part of JOB_STATUS_RUNNING, too,
so they'd have to do this anyway.

Kevin


