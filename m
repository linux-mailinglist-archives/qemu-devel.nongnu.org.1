Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 339137C406A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIn3-0005Ie-TK; Tue, 10 Oct 2023 15:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqImy-0005Gg-JV; Tue, 10 Oct 2023 15:53:08 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqImw-000483-7J; Tue, 10 Oct 2023 15:53:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id A1F1660C6C;
 Tue, 10 Oct 2023 22:53:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7319::1:4] (unknown
 [2a02:6b8:b081:7319::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1rjRLI1OiuQ0-SmINgpmV; Tue, 10 Oct 2023 22:53:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696967582;
 bh=uQim3oSn85O6bgcSV7wIw+CLtmK6uzdBFrhNQJQegZ8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lXHKE/Y2JbgreIpfItTUDEIBSLOLlqDjJj34TfzShS3Mgj2mRdJGoYqwQtJZrBg/A
 HLqEnsb0adr1FE0nYc+06QCFrYJSIFuJfewdwwHyxhcpHUKygQCVj3T+NlfMFS/o/4
 2LiK1eotk49wVx6Bi/02MhA9K6Mourq/1xrDFkwo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bb400ba6-fc1a-4647-8a59-b2d34dd0e1bf@yandex-team.ru>
Date: Tue, 10 Oct 2023 22:53:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] mirror: return mirror-specific information upon
 query
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <20231009094619.469668-10-f.ebner@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231009094619.469668-10-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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
> To start out, only actively-synced is returned.
> 
> For example, this is useful for jobs that started out in background
> mode and switched to active mode. Once actively-synced is true, it's
> clear that the mode switch has been completed. Note that completion of
> the switch might happen much earlier, e.g. if the switch happens
> before the job is ready, once all background operations have finished.
> It's assumed that whether the disks are actively-synced or not is more
> interesting than whether the mode switch completed. That information
> can still be added if required in the future.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
>      * udpate QEMU version in QAPI
>      * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
>        doc comments to conform to current conventions"))
> 
>   block/mirror.c       | 10 ++++++++++
>   qapi/block-core.json | 16 +++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 83aa4176c2..33b72ec5e5 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1267,6 +1267,15 @@ static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
>       s->copy_mode = MIRROR_COPY_MODE_WRITE_BLOCKING;
>   }
>   
> +static void mirror_query(BlockJob *job, BlockJobInfo *info)
> +{
> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
> +
> +    info->u.mirror = (BlockJobInfoMirror) {
> +        .actively_synced = s->actively_synced,

So, seems we should use atomic operations to access this field too

> +    };
> +}
> +
>   static const BlockJobDriver mirror_job_driver = {
>       .job_driver = {
>           .instance_size          = sizeof(MirrorBlockJob),
> @@ -1282,6 +1291,7 @@ static const BlockJobDriver mirror_job_driver = {
>       },
>       .drained_poll           = mirror_drained_poll,
>       .change                 = mirror_change,
> +    .query                  = mirror_query,
>   };
>   
>   static const BlockJobDriver commit_active_job_driver = {
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 950542b735..35d67410cc 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1352,6 +1352,20 @@
>   { 'enum': 'MirrorCopyMode',
>     'data': ['background', 'write-blocking'] }
>   
> +##
> +# @BlockJobInfoMirror:
> +#
> +# Information specific to mirror block jobs.
> +#
> +# @actively-synced: Whether the source is actively synced to the
> +#     target, i.e. same data and new writes are done synchronously to
> +#     both.
> +#
> +# Since 8.2
> +##
> +{ 'struct': 'BlockJobInfoMirror',
> +  'data': { 'actively-synced': 'bool' } }
> +
>   ##
>   # @BlockJobInfo:
>   #
> @@ -1403,7 +1417,7 @@
>              'auto-finalize': 'bool', 'auto-dismiss': 'bool',
>              '*error': 'str' },
>     'discriminator': 'type',
> -  'data': {} }
> +  'data': { 'mirror': 'BlockJobInfoMirror' } }
>   
>   ##
>   # @query-block-jobs:

-- 
Best regards,
Vladimir


