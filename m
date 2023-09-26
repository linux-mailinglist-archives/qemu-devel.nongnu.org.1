Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C0B7AEA32
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:19:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5A3-00068W-08; Tue, 26 Sep 2023 06:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql5A0-00067j-Oy
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:19:20 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql59y-0006gT-Dm
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:19:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id BF752615E0;
 Tue, 26 Sep 2023 13:19:15 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EJMPag0OcuQ0-uu65OhTH; Tue, 26 Sep 2023 13:19:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695723555;
 bh=Vhi17zCaG2BBLCXGBnjZcybVJDBHRASoe1+SbwQECGQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=uPn44QG1a0f6Fsr4uK+zRDOOmOpc3nFlnEyse5cVX1Xv/IendOLNqezineMiaVf4V
 VBTK9+JFx82CUv+8xffqKmAB/uT2P9+bLBdmvhGLvsCrbYgZWtwCGYy5Teb2qC9rgO
 kVfgTv1Lx64oMD+Zn57BK/qQA7E6KXq/xlum7+vI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e496a851-bcdf-6ec8-729b-1ae3cf58a42c@yandex-team.ru>
Date: Tue, 26 Sep 2023 13:19:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/12] io/channel-socket: qio_channel_socket_flush():
 improve msg validation
Content-Language: en-US
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: pbonzini@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-13-vsementsov@yandex-team.ru>
 <2b595d60-ff34-674e-009a-970e623bed84@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <2b595d60-ff34-674e-009a-970e623bed84@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26.09.23 12:04, Maksim Davydov wrote:
> Could you add a comment into the commit message why ee_data must be
> bigger than ee_info?

As I understand, in this case ee_data is lower bound and ee_info is upper bound of notification:

https://docs.kernel.org/networking/msg_zerocopy.html#notification-parsing

and the next line "sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;" actually depends on it.

So, I'll add:

For SO_EE_ORIGIN_ZEROCOPY the 32-bit notification range is encoded
as [ee_info, ee_data] inclusively, so ee_info should be less or
equal to ee_data.

> 
> On 9/25/23 22:40, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   io/channel-socket.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 02ffb51e99..3a899b0608 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -782,6 +782,11 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>                                "Error not from zero copy");
>>               return -1;
>>           }
>> +        if (serr->ee_data < serr->ee_info) {
>> +            error_setg_errno(errp, serr->ee_origin,
>> +                             "Wrong notification bounds");
>> +            return -1;
>> +        }
>>           /* No errors, count successfully finished sendmsg()*/
>>           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> 

-- 
Best regards,
Vladimir


