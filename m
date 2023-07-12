Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8BA750424
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 12:10:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJWmF-0001VV-UB; Wed, 12 Jul 2023 06:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qJWmB-0001VF-Jf; Wed, 12 Jul 2023 06:08:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qJWm9-0000Ih-L1; Wed, 12 Jul 2023 06:08:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C9AE13421;
 Wed, 12 Jul 2023 13:08:57 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1C4D9145D8;
 Wed, 12 Jul 2023 13:08:45 +0300 (MSK)
Message-ID: <1caed92a-62a7-ff1a-82a5-492c08e9b6eb@tls.msk.ru>
Date: Wed, 12 Jul 2023 13:08:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ui/vnc-clipboard: fix infinite loop in inflate_buffer
 (CVE-2023-3255)
To: Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, kevin.denis@synacktiv.com,
 qemu-stable <qemu-stable@nongnu.org>
References: <20230704084210.101822-1-mcascell@redhat.com>
 <CAJ+F1CLi54BFaeYjZ_eHq+nixPkAcFOGquLx0kRc_YeUeLZVKA@mail.gmail.com>
 <CAA8xKjUTgUfopThem85v9ufQX0=62J5sZxUiKYt0OO6FH-wqEg@mail.gmail.com>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAA8xKjUTgUfopThem85v9ufQX0=62J5sZxUiKYt0OO6FH-wqEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

04.07.2023 12:39, Mauro Matteo Cascella wrote:
> On Tue, Jul 4, 2023 at 11:03 AM Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>>
>>
>> On Tue, Jul 4, 2023 at 10:42 AM Mauro Matteo Cascella <mcascell@redhat.com> wrote:
>>>
>>> A wrong exit condition may lead to an infinite loop when inflating a
>>> valid zlib buffer containing some extra bytes in the `inflate_buffer`
>>> function. The bug only occurs post-authentication. Return the buffer
>>> immediately if the end of the compressed data has been reached
>>> (Z_STREAM_END).
>>>
>>> Fixes: CVE-2023-3255
>>> Fixes: 0bf41cab ("ui/vnc: clipboard support")
>>> Reported-by: Kevin Denis <kevin.denis@synacktiv.com>
>>> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
>>
>>
>> Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Note: we may want to disconnect the client when there are extra bytes in the message, or print some warnings.
> 
> Sure, I guess we can call vnc_disconnect_finish or vnc_client_error
> for disconnecting, not sure how to properly print warnings. Feel free
> to add that yourself when applying the patch. Or I can try to send v2
> if you prefer.

Ping, for 8.1 and -stable?

Thanks,

/mjt


