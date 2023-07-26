Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3FC763512
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 13:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOcmI-0007Hz-8G; Wed, 26 Jul 2023 07:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOcm5-0007Hg-T6
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:33:50 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOcm2-0002x5-QM
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:33:49 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id A75035EA85;
 Wed, 26 Jul 2023 14:33:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68c::1:26] (unknown
 [2a02:6b8:b081:b68c::1:26])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aXJ2510Om8c0-iSRFdJTD; Wed, 26 Jul 2023 14:33:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690371217; bh=DsnocDfzhjVR0+PAtRPj1hzo9HegEc5O1nmYpvzVzKA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=uHJJSdsnsEjUQNLVQxzcWXgLsX2O5KC9RLmGLfFSkTEjy67p1jLuLpfECM2+a+sSv
 BzXVU5H64Ue226VSdmqAdDU5BA1X6eA+2ZkhmzG8zlOyQT6eJLKUYTKRrHdb3nXpHD
 35VWcc+DKCD6iPhGouz6XZKS9Qb7+urDcbbPaBu8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a86c0dc4-a5dc-48cb-57af-92ecdf27ac81@yandex-team.ru>
Date: Wed, 26 Jul 2023 14:33:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 1/5] qapi/block-core: Tidy up BlockLatencyHistogramInfo
 documentation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230726112855.155795-1-armbru@redhat.com>
 <20230726112855.155795-2-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230726112855.155795-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 26.07.23 14:28, Markus Armbruster wrote:
> Documentation for member @bin comes out like
> 
>      list of io request counts corresponding to histogram intervals.
>      len("bins") = len("boundaries") + 1 For the example above, "bins"
>      may be something like [3, 1, 5, 2], and corresponding histogram
>      looks like:
> 
> Note how the equation and the sentence following it run together.
> Replace the equation:
> 
>      list of io request counts corresponding to histogram intervals,
>      same number of elements as "boundaries".  For the example above,

not same, but one more. N points break the line into N+1 intervals

>      "bins" may be something like [3, 1, 5, 2], and corresponding
>      histogram looks like:
> 
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20230720071610.1096458-2-armbru@redhat.com>
> ---
>   qapi/block-core.json | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5dd5f7e4b0..6ca448b6e6 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -652,10 +652,9 @@
>   #     10), [10, 50), [50, 100), [100, +inf).
>   #
>   # @bins: list of io request counts corresponding to histogram
> -#     intervals.
> -#     len(@bins) = len(@boundaries) + 1
> -#     For the example above, @bins may be something like [3, 1, 5, 2],
> -#     and corresponding histogram looks like:
> +#     intervals, same number of elements as @boundaries.  For the
> +#     example above, @bins may be something like [3, 1, 5, 2], and
> +#     corresponding histogram looks like:
>   #
>   # ::
>   #

-- 
Best regards,
Vladimir


