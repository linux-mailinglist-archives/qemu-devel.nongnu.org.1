Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E843F7C4064
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIlU-0004RC-EH; Tue, 10 Oct 2023 15:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqIlM-0004QC-6U; Tue, 10 Oct 2023 15:51:28 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqIlI-0003tB-4q; Tue, 10 Oct 2023 15:51:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 3859C618F4;
 Tue, 10 Oct 2023 22:51:19 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7319::1:4] (unknown
 [2a02:6b8:b081:7319::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IpjVDI1OlOs0-GnHvutoJ; Tue, 10 Oct 2023 22:51:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696967478;
 bh=NhhkFXudM6BN/l4g5mdWHfVIWNLwxrPFHbgqdGkidBM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qnP4aoonOryQr1pjT0DumN9cat39demDCjnacF/NdfqhEhZX/7rZAbJcn0WERIbH2
 ddcAX7l7eJOu7UzcT6gHR5pXNhomsr+LoIr+VgQ+HvIaPe3pFhLHWrzUI+ZUIF/Iz6
 hxmc1KJvOf8tg/R2LBFgo7bj44etnCEOt9YNZgW4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <200c3721-e4ce-478d-8cd4-6c3c0fa48a0c@yandex-team.ru>
Date: Tue, 10 Oct 2023 22:51:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] blockjob: query driver-specific info via a new
 'query' driver method
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <20231009094619.469668-9-f.ebner@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231009094619.469668-9-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09.10.23 12:46, Fiona Ebner wrote:
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> No changes in v2.
> 
>   blockjob.c                   | 4 ++++
>   include/block/blockjob_int.h | 5 +++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/blockjob.c b/blockjob.c
> index f8cf6e58e2..7e8cfad0fd 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -376,6 +376,7 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
>   {
>       BlockJobInfo *info;
>       uint64_t progress_current, progress_total;
> +    const BlockJobDriver *drv = block_job_driver(job);
>   
>       GLOBAL_STATE_CODE();
>   
> @@ -405,6 +406,9 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
>                           g_strdup(error_get_pretty(job->job.err)) :
>                           g_strdup(strerror(-job->job.ret));
>       }
> +    if (drv->query) {
> +        drv->query(job, info);

Other handlers are called with job lock dropped.

> +    }
>       return info;
>   }
>   
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index f604985315..4ab88b3c97 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -72,6 +72,11 @@ struct BlockJobDriver {
>        * Change the @job's options according to @opts.
>        */
>       void (*change)(BlockJob *job, BlockJobChangeOptions *opts, Error **errp);
> +
> +    /*
> +     * Query information specific to this kind of block job.
> +     */
> +    void (*query)(BlockJob *job, BlockJobInfo *info);
>   };
>   
>   /*

-- 
Best regards,
Vladimir


