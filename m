Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C7A7E35F0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:29:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0GWL-0000ji-Pr; Tue, 07 Nov 2023 02:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0GWH-0000jX-Bj
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:29:05 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0GWF-0004T7-As
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:29:05 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:4e29:0:640:d42a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 61196625ED;
 Tue,  7 Nov 2023 10:28:55 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b676::1:19] (unknown
 [2a02:6b8:b081:b676::1:19])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rSWSVT5OgGk0-65SupeLc; Tue, 07 Nov 2023 10:28:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699342134;
 bh=7lwBjw9UsRYDB0hb6c98MA4+jQKF4kPuhBxz1soM8xo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wyNH1q13E0diJbLnSOo41mWzRzTh/81cBMklLW0bFTUrpZEdRmFCrmVmS6PghACDy
 atysWN3dDS5x/1/s+JoMli6D1IRZJCKbzovdsPA8myof3Do9+YO9wta5V9pl7p0bST
 dWDNL6pJRuEImOuPPQSFlwSDSO0Q6114thdYpvzs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fe4705c3-f216-4c48-94b3-ad5f9a559d5e@yandex-team.ru>
Date: Tue, 7 Nov 2023 10:28:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
To: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 mlevitsk@redhat.com, yc-core@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

[add Michael]

On 03.11.23 13:56, Dmitrii Gavrilov wrote:
> Original goal of addition of drain_call_rcu to qmp_device_add was to cover
> the failure case of qdev_device_add. It seems call of drain_call_rcu was
> misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
> under happy path too. What led to overall performance degradation of
> qmp_device_add.
> 
> In this patch call of drain_call_rcu moved under handling of failure of
> qdev_device_add.
> 
> Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


> ---
>   system/qdev-monitor.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 1b8005a..dc7b02d 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -856,19 +856,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>           return;
>       }
>       dev = qdev_device_add(opts, errp);
> -
> -    /*
> -     * Drain all pending RCU callbacks. This is done because
> -     * some bus related operations can delay a device removal
> -     * (in this case this can happen if device is added and then
> -     * removed due to a configuration error)
> -     * to a RCU callback, but user might expect that this interface
> -     * will finish its job completely once qmp command returns result
> -     * to the user
> -     */
> -    drain_call_rcu();
> -
>       if (!dev) {
> +        /*
> +         * Drain all pending RCU callbacks. This is done because
> +         * some bus related operations can delay a device removal
> +         * (in this case this can happen if device is added and then
> +         * removed due to a configuration error)
> +         * to a RCU callback, but user might expect that this interface
> +         * will finish its job completely once qmp command returns result
> +         * to the user
> +         */
> +        drain_call_rcu();
> +
>           qemu_opts_del(opts);
>           return;
>       }

-- 
Best regards,
Vladimir


