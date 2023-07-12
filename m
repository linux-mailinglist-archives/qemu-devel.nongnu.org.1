Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FB7502AB
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 11:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJVxN-0007ex-M7; Wed, 12 Jul 2023 05:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qJVxH-0007ec-QG; Wed, 12 Jul 2023 05:16:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qJVxC-0003QA-0w; Wed, 12 Jul 2023 05:16:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8A38013401;
 Wed, 12 Jul 2023 12:16:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 66793145C1;
 Wed, 12 Jul 2023 12:15:56 +0300 (MSK)
Message-ID: <83c56e22-845c-2336-2402-4788ac1c7c2d@tls.msk.ru>
Date: Wed, 12 Jul 2023 12:15:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] io: remove io watch if TLS channel is closed during
 handshake
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 jiangyegen <jiangyegen@huawei.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20230705181718.387522-1-berrange@redhat.com>
 <CAJ+F1CJt1PPSVwMAstLRog5PtPvAvA4xuccZgenTDc5SBLTGQQ@mail.gmail.com>
 <ZKfc+kL7PEEZ7h96@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZKfc+kL7PEEZ7h96@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

07.07.2023 12:38, Daniel P. Berrangé wrote:
> On Fri, Jul 07, 2023 at 01:30:16PM +0400, Marc-André Lureau wrote:
...>>> @@ -378,6 +380,10 @@ static int qio_channel_tls_close(QIOChannel *ioc,
>>>   {
>>>       QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
>>>
>>> +    if (tioc->hs_ioc_tag) {
>>> +        g_source_remove(tioc->hs_ioc_tag);
>>>
>>
>> set it to 0 ?
>> or
>> g_clear_handle_id(&tios->hs_ioc_tag, g_source_remove);
> 
> Yes, close can be called mutliple times, so we must set to zero.

Ping, for qemu 8.1 and -stable ?

Thanks,

/mjt

