Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 819937E371A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:02:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Hy2-0002bi-NT; Tue, 07 Nov 2023 04:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0Hxz-0002bZ-Vp
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:01:48 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0Hxu-0005Ig-SK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:01:47 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 0ED7362183;
 Tue,  7 Nov 2023 12:01:40 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b676::1:19] (unknown
 [2a02:6b8:b081:b676::1:19])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id c1YWRB5Of0U0-fwTVRUNC; Tue, 07 Nov 2023 12:01:39 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699347699;
 bh=vrnt15OQ81+y5Cv/Gx3WedGuA5Rm4RONHM0H9joV9UI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=naqoC2v75PcCJWxqmklS1RWdVNM1hf4vLxrenPw56S1NTQ12pDArjHPde8ntjFQG9
 gBuGKoFh3IEvuaRvCS8SKTyDLS8tk8HU6StCFALbaSvaToo9UYT3WJCqLksEN/tOMA
 7dbYEe0KHqOe/rVHDZfEimFtX5f7LuydKSMOPx3c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f310bbbb-445e-4043-870e-16d5de3f9c2a@yandex-team.ru>
Date: Tue, 7 Nov 2023 12:01:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mlevitsk@redhat.com, yc-core@yandex-team.ru
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
 <20231107023155-mutt-send-email-mst@kernel.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231107023155-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 07.11.23 10:32, Michael S. Tsirkin wrote:
> On Fri, Nov 03, 2023 at 01:56:02PM +0300, Dmitrii Gavrilov wrote:
>> Original goal of addition of drain_call_rcu to qmp_device_add was to cover
>> the failure case of qdev_device_add. It seems call of drain_call_rcu was
>> misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
>> under happy path too. What led to overall performance degradation of
>> qmp_device_add.
>>
>> In this patch call of drain_call_rcu moved under handling of failure of
>> qdev_device_add.
> 
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Right, sorry for missing that

> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

> 
> Also:
> 
> Fixes: 7bed89958b ("device_core: use drain_call_rcu in in qmp_device_add")
> Cc: "Maxim Levitsky" <mlevitsk@redhat.com>
> 
> 
>>
>> Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
>> ---
>>   system/qdev-monitor.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>> index 1b8005a..dc7b02d 100644
>> --- a/system/qdev-monitor.c
>> +++ b/system/qdev-monitor.c
>> @@ -856,19 +856,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>>           return;
>>       }
>>       dev = qdev_device_add(opts, errp);
>> -
>> -    /*
>> -     * Drain all pending RCU callbacks. This is done because
>> -     * some bus related operations can delay a device removal
>> -     * (in this case this can happen if device is added and then
>> -     * removed due to a configuration error)
>> -     * to a RCU callback, but user might expect that this interface
>> -     * will finish its job completely once qmp command returns result
>> -     * to the user
>> -     */
>> -    drain_call_rcu();
>> -
>>       if (!dev) {
>> +        /*
>> +         * Drain all pending RCU callbacks. This is done because
>> +         * some bus related operations can delay a device removal
>> +         * (in this case this can happen if device is added and then
>> +         * removed due to a configuration error)
>> +         * to a RCU callback, but user might expect that this interface
>> +         * will finish its job completely once qmp command returns result
>> +         * to the user
>> +         */
>> +        drain_call_rcu();
>> +
>>           qemu_opts_del(opts);
>>           return;
>>       }
>> -- 
>> 2.34.1
>>
>>
> 

-- 
Best regards,
Vladimir


