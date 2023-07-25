Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1141761B94
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:26:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIzQ-0001Vs-LW; Tue, 25 Jul 2023 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOIzN-0001Uk-EP; Tue, 25 Jul 2023 10:26:13 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOIzL-0002vr-Df; Tue, 25 Jul 2023 10:26:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3b26:0:640:9085:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id C34F46021B;
 Tue, 25 Jul 2023 17:25:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1223::1:1f] (unknown
 [2a02:6b8:b081:1223::1:1f])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vPLfNj0OgOs0-wsKvJVYt; Tue, 25 Jul 2023 17:25:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690295158; bh=i/mpwZvD9mb2RSgJJwh98LEdOGKpjJ1Y3bqDf61/428=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xe90Wt5NJsPHIW1dmOJeZ7ygT41saCPNUoRZdwFvQBKPP0Z/eazqNo+hVjttGS7W3
 GFGW8eXu8av0gABphNicFnQBTuHawep5HITGJMiIL3PvdOdQXltxzgAWGGAor1fdse
 b9lGnj7Ax8lKsFqqungJoL1oNAAZHEhkrXDtFI+Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9e3f6e08-92d5-7292-e94c-5f626f65d6c2@yandex-team.ru>
Date: Tue, 25 Jul 2023 17:25:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] block/stream:add flush l2_table_cache,ensure data
 integrity
To: Evanzhang <Evanzhang@archeros.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 "Denis V. Lunev" <den@openvz.org>
References: <cover.1690166344.git.Evanzhang@archeros.com>
 <bce1328c87f7e5d877dead476e9e66036cc4f7d8.1690166344.git.Evanzhang@archeros.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <bce1328c87f7e5d877dead476e9e66036cc4f7d8.1690166344.git.Evanzhang@archeros.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 24.07.23 10:30, Evanzhang wrote:
> block_stream will not actively flush l2_table_cache,when qemu
> process exception exit,causing disk data loss
> 
> Signed-off-by: Evanzhang <Evanzhang@archeros.com>
> ---
>   block/stream.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/stream.c b/block/stream.c
> index e522bbd..a5e08da 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -207,6 +207,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>           }
>       }
>   
> +    /*
> +     * Complete stream_populate,force flush l2_table_cache,to
> +     * avoid unexpected termination of process, l2_table loss
> +     */
> +    qcow2_cache_flush(bs, ((BDRVQcow2State *)bs->opaque)->l2_table_cache);
> +
>       /* Do not remove the backing file if an error was there but ignored. */
>       return error;
>   }

Hi!

I think, it's more correct just call bdrv_co_flush(bs), which should do all the job. Also, stream_run() should fail if flush fails.

Also, I remember I've done it for all (or at least several) blockjobs generically, so that any blockjob must succesfully flush target to report success.. But now I can find neither my patches nor the code :( Den, Kevin, Hanna, don't you remember this topic?

-- 
Best regards,
Vladimir


