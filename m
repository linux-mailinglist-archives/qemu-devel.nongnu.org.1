Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B119C72A2B1
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hJY-0008C8-7k; Fri, 09 Jun 2023 14:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q7hJW-0008BZ-HR
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:58:22 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q7hJU-0004wx-Ct
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:58:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 3D4F45F1DE;
 Fri,  9 Jun 2023 21:58:11 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b727::1:d] (unknown
 [2a02:6b8:b081:b727::1:d])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwbmmQ0OdKo0-lkQk86GF; Fri, 09 Jun 2023 21:58:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686337090; bh=wg7fLtl+KQ6tlCEO2b7LA9wlHLVcL2fO1BaEMcZrBJ4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CPCj1ZtZYziBHofUXAhKmb8z4zG7hQjA3s9/LXQxHnR3zKpv1GoBQs10g92qoj6zh
 ubFeZlFuViEuAO60N6ayNnoP9SqLAI1AIHUpxMjHJdoumzkr/bvROyuvbYsI48cWrA
 ax5Q2mBgncT7B47bnCgdWqDbyzT1Ig4kM4NE5/ig=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a00f1ead-43d3-396c-8715-8b0bb2a6e19d@yandex-team.ru>
Date: Fri, 9 Jun 2023 21:58:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/1] ROM migration
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 david@redhat.com, peterx@redhat.com, pbonzini@redhat.com,
 den-plotnikov@yandex-team.ru, lersek@redhat.com, kraxel@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com
References: <20230522201740.88960-1-vsementsov@yandex-team.ru>
 <5a9ed961-0356-33d0-21a4-42032621c13a@yandex-team.ru>
 <20230609115508-mutt-send-email-mst@kernel.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230609115508-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 09.06.23 18:55, Michael S. Tsirkin wrote:
> This is tagged, pull request will be delayed due to kvm forum though.

OK, thanks!

> 
> On Fri, Jun 09, 2023 at 04:32:40PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> ping.
>>
>> On 22.05.23 23:17, Vladimir Sementsov-Ogievskiy wrote:
>>> v4:
>>> preparation patches are already merged to master
>>> 01: fix false-positive "error: ‘size’ may be used uninitialized",
>>>       keep r-bs
>>>
>>> Vladimir Sementsov-Ogievskiy (1):
>>>     pci: ROM preallocation for incoming migration
>>>
>>>    hw/pci/pci.c | 79 ++++++++++++++++++++++++++++++----------------------
>>>    1 file changed, 46 insertions(+), 33 deletions(-)
>>>
>>
>> -- 
>> Best regards,
>> Vladimir
> 

-- 
Best regards,
Vladimir


