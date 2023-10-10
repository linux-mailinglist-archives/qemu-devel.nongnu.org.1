Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9497C04C8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIXp-0001Hk-S2; Tue, 10 Oct 2023 15:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqIXn-0001HN-Cq; Tue, 10 Oct 2023 15:37:27 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqIXj-0000yY-Eo; Tue, 10 Oct 2023 15:37:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 821D3612C2;
 Tue, 10 Oct 2023 22:37:15 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7319::1:4] (unknown
 [2a02:6b8:b081:7319::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Ebj3G21Opa60-ayBczhai; Tue, 10 Oct 2023 22:37:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696966635;
 bh=h7514QaAwEpP62+OrYBRxXwz1KFZjOWaMnoHv9fwFwM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=m+UBS1gCpDFNtGfOcZcxeLn+CwncUBBBFCl9n+jjNhe5UEfyPopV3w+/44PhH2ZvM
 pra0X0FIQArgls3Srlen/YtFUpLzE8frYHiVvgEr7a6FUSD+skLmIlXetUnNgk2NOV
 11d7oDENEUr8+aG7OwuzUnSMf06v/KM+2Av5w3ew=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f6987c95-b1c4-4bfa-ae05-931c4f946151@yandex-team.ru>
Date: Tue, 10 Oct 2023 22:37:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] mirror: implement mirror_change method
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <20231009094619.469668-6-f.ebner@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231009094619.469668-6-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
> which allows switching the @copy-mode from 'background' to
> 'write-blocking'.
> 
> This is useful for management applications, so they can start out in
> background mode to avoid limiting guest write speed and switch to
> active mode when certain criteria are fulfilled.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
>      * update QEMU version in QAPI
>      * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
>        doc comments to conform to current conventions"))
>      * drop drained section and disable dirty bitmap call. It's already
>        disabled, because the bitmap is now attached to the filter and
>        set in bdrv_mirror_top_do_write(). See the earlier patch
>        "block/mirror: move dirty bitmap to filter"
> 
>   block/mirror.c       | 22 ++++++++++++++++++++++
>   qapi/block-core.json | 13 ++++++++++++-
>   2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index b84de56734..83aa4176c2 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1246,6 +1246,27 @@ static bool commit_active_cancel(Job *job, bool force)
>       return force || !job_is_ready(job);
>   }
>   
> +static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
> +                          Error **errp)
> +{
> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
> +    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
> +
> +    if (s->copy_mode == change_opts->copy_mode) {
> +        return;
> +    }
> +
> +    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
> +        error_setg(errp, "Cannot switch away from copy mode 'write-blocking'");
> +        return;
> +    }
> +
> +    assert(s->copy_mode == MIRROR_COPY_MODE_BACKGROUND &&
> +           change_opts->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING);
> +
> +    s->copy_mode = MIRROR_COPY_MODE_WRITE_BLOCKING;
> +}

So, s->copy_mode becomes shared between main thread and iothread.

We should either use mutex or atomic operations.

Note, that the only realization of .set_speed uses thread-safe API.

> +
>   static const BlockJobDriver mirror_job_driver = {
>       .job_driver = {
>           .instance_size          = sizeof(MirrorBlockJob),
> @@ -1260,6 +1281,7 @@ static const BlockJobDriver mirror_job_driver = {
>           .cancel                 = mirror_cancel,
>       },
>       .drained_poll           = mirror_drained_poll,
> +    .change                 = mirror_change,
>   };
>   
>   static const BlockJobDriver commit_active_job_driver = {
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c6f31a9399..01427c259a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3044,6 +3044,17 @@
>   { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
>     'allow-preconfig': true }
>   
> +##
> +# @BlockJobChangeOptionsMirror:
> +#
> +# @copy-mode: Switch to this copy mode. Currenlty, only the switch
> +#     from 'background' to 'write-blocking' is implemented.
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'BlockJobChangeOptionsMirror',
> +  'data': { 'copy-mode' : 'MirrorCopyMode' } }
> +
>   ##
>   # @BlockJobChangeOptions:
>   #
> @@ -3058,7 +3069,7 @@
>   { 'union': 'BlockJobChangeOptions',
>     'base': { 'id': 'str', 'type': 'JobType' },
>     'discriminator': 'type',
> -  'data': {} }
> +  'data': { 'mirror': 'BlockJobChangeOptionsMirror' } }
>   
>   ##
>   # @block-job-change:

-- 
Best regards,
Vladimir


