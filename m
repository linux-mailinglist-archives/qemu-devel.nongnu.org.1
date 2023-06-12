Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74172C880
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 16:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8iWA-00072X-IU; Mon, 12 Jun 2023 10:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8iW7-00070U-Bm; Mon, 12 Jun 2023 10:27:35 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8iW4-0006bb-A5; Mon, 12 Jun 2023 10:27:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 89C8160376;
 Mon, 12 Jun 2023 17:27:20 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8910::1:11] (unknown
 [2a02:6b8:b081:8910::1:11])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JRaXXT1Oc8c0-QFIVnA9E; Mon, 12 Jun 2023 17:27:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686580039; bh=XtSNvFXmbTd0HYmNvOLuq82BceXa2AcBnhQIeeaeOMg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=eKwHxWrAPVVgo1Dz5U6E7QXnN34YQCbIYQGZB4PftrhVUPyQPm9ZA/QFV5Yfexk23
 PF7lrcSJyRACAG4WHKa6Jekx4/QjMSDu/ylMR0OHMQJ9IMU2sZM/Jth4wffLm9+0yy
 tC+p+RqJlPDzvY4kxsIRBGKfMyEgAl7Pam92OACE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c85245c5-cfa9-bb52-a1a7-a260ad194b60@yandex-team.ru>
Date: Mon, 12 Jun 2023 17:27:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 06/24] nbd/client: Simplify cookie vs. index computation
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-7-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 08.06.23 16:56, Eric Blake wrote:
> Our code relies on a sentinel cookie value of zero for deciding when a
> packet has been handled, as well as relying on array indices between 0
> and MAX_NBD_REQUESTS-1 for dereferencing purposes.  As long as we can
> symmetrically convert between two forms, there is no reason to go with
> the odd choice of using XOR with a random pointer, when we can instead
> simplify the mappings with a mere offset of 1.

Should we go further and use (uint64)-1 as a sentinel cookie value, and just use index as a cookie?  Or, using zero cookie in a wire looks too asymmetric?

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
> 
> v4: new patch
> ---
>   block/nbd.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index be3c46c6fee..5322e66166c 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -50,8 +50,8 @@
>   #define EN_OPTSTR ":exportname="
>   #define MAX_NBD_REQUESTS    16
> 
> -#define COOKIE_TO_INDEX(bs, cookie) ((cookie) ^ (uint64_t)(intptr_t)(bs))
> -#define INDEX_TO_COOKIE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))

That looked like some security trick to hide real indices. But I don't think that index of request in a list is a secret information.

> +#define COOKIE_TO_INDEX(cookie) ((cookie) - 1)
> +#define INDEX_TO_COOKIE(index)  ((index) + 1)
> 

[..]

-- 
Best regards,
Vladimir


