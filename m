Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B753F7BC66F
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 11:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp3cD-00077B-FX; Sat, 07 Oct 2023 05:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qp3c3-00076U-SC; Sat, 07 Oct 2023 05:28:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qp3c2-0007Vh-76; Sat, 07 Oct 2023 05:28:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A445328550;
 Sat,  7 Oct 2023 12:28:33 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 106292D7E3;
 Sat,  7 Oct 2023 12:28:27 +0300 (MSK)
Message-ID: <88329105-bec2-461e-8c40-bbb5b66636b1@tls.msk.ru>
Date: Sat, 7 Oct 2023 12:28:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Silence compiler warnings in vhost code
 when using -Wshadow
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20231004114809.105672-1-thuth@redhat.com>
 <18f1faab-71f4-4dbd-a319-fcd65721f58b@tls.msk.ru>
 <87h6n4p1ts.fsf@pond.sub.org>
 <29a2a188-ec5b-452f-be63-92e8f0ec7110@tls.msk.ru>
 <20231006072416-mutt-send-email-mst@kernel.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231006072416-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

06.10.2023 14:24, Michael S. Tsirkin:
> On Fri, Oct 06, 2023 at 01:45:51PM +0300, Michael Tokarev wrote:
>> 06.10.2023 11:55, Markus Armbruster пишет:
>>> Michael Tokarev <mjt@tls.msk.ru> writes:
>>>
>>>> Applied to my trivial-patches tree, thanks!
>>>>
>>>> Marcus, you picked up previous patches of this theme, --
>>>> you can continue this tradition if you like :)
>>>
>>> I intend to post a pull request for the -Wshadow patches that have
>>> R-bys.  I'm also tracking the unreviewed ones, and hope they get
>>> reviewed.
>>
>> Ahh, ok.
>>
>> I've added my own R-bys for the ones I picked up, and for this one
>> by Thomas too:
>>
>> Reviewed-By: Michael Tokarev <mjt@tls.msk.ru>
> 
> it would be better to deal with all of them in one place tbh.

This is exactly why I asked Marcus about this in the first place,
being confused a bit with the stuff being especially sent to
qemu-trivial@ :)

/mjt


