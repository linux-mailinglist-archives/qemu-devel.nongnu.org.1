Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E733382006A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 16:58:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJFEO-0000Pq-J9; Fri, 29 Dec 2023 10:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rJFEM-0000Pe-LE; Fri, 29 Dec 2023 10:57:02 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rJFEK-0003ws-9g; Fri, 29 Dec 2023 10:57:02 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 82D7061F76;
 Fri, 29 Dec 2023 18:56:51 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1304::1:34] (unknown
 [2a02:6b8:b081:1304::1:34])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nuYQiKDiBmI0-atlojnfn; Fri, 29 Dec 2023 18:56:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1703865411;
 bh=fviJjNoFT6h056R8WrA/rEKjCN4646m/Zxon/Xbq6cc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EX0E67yPuEfarXDdjrN4UKDGoA1s3ZkKqFfJ7crbIIlPb4xHZ3toQGOKhFZ2iiglW
 qhl/fA1OZlDMpoCNrck1SLStTT6HFHZgFz5omr+AdmL3dB0NpK+Y6NFa+RnG0gtv/M
 UxEOc0itdwDefVd1sbTmzIOfk5IesbGtyY9CP7ok=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1bdea01b-9e78-4210-b457-d0c630560315@yandex-team.ru>
Date: Fri, 29 Dec 2023 18:56:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blockcommit: Reopen base image as RO after abort
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <20231130101104.127356-1-alexander.ivanov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231130101104.127356-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 30.11.23 13:11, Alexander Ivanov wrote:
> If a blockcommit is aborted the base image remains in RW mode, that leads
> to a fail of subsequent live migration.
> 
> How to reproduce:
>    $ virsh snapshot-create-as vm snp1 --disk-only
> 
>    *** write something to the disk ***
> 
>    $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
>    $ lsof /vzt/vm.qcow2
>    COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
>    qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
>    $ cat /proc/433203/fdinfo/45
>    pos:    0
>    flags:  02140002
> 
> Reopen the base image in RO mode in mirror_exit_common() if the blockjob
> is aborted.
> 
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/mirror.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index dcd88de2e3..50a2825b1c 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -789,6 +789,10 @@ static int mirror_exit_common(Job *job)
>       block_job_remove_all_bdrv(bjob);
>       bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
>   
> +    if (abort && !bdrv_is_read_only(target_bs)) {

I think, we also should check here, that we did bdrv_reopen_set_read_only(false) at job start (probably we didn't, or we are in mirror job)

> +        bdrv_reopen_set_read_only(target_bs, true, NULL);
> +    }
> +
>       bs_opaque->job = NULL;
>   
>       bdrv_drained_end(src);

-- 
Best regards,
Vladimir


