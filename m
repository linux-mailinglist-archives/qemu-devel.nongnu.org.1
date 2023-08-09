Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E663776470
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTlVR-0006RC-Rb; Wed, 09 Aug 2023 11:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTlVQ-0006Qs-13
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:53:52 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTlVN-0007Lf-Aj
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691596425; x=1692201225; i=deller@gmx.de;
 bh=zV2G6TuzSLhDh4a3QDfRwuced6EPYGRi1Ol9w0Nr8qM=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=RRPzR4vCrbYmRGEARtAGDj7xBREpgEZzbNCrFWwuECvZjGjz45vBdyfmXmkT84+8bub6qPY
 8h/joEUiW59fjiGgiOmDF3fSkKJqpZqX8as2VKkf2B4bHCejThVxwTkY7JRRaI5JwP8opI5PN
 zPv0L6C8HubZ76FwfoV2Mv9jpJtevBeqlO+ttljRRe30e4+TFIGpvhXmJnfejkoMUUevzpx7+
 L9qsPMsF2yP7AYOY+B+z3pOXNbmpwtDO7eu9F2zjOu5fXQA6apMe+FWEoo1dvbLyFTaKx6GqW
 Fw1r+lqhsJTG3oBFFcj0XzVXk2Z3yzMMm/cFkNQRIB8RJH0SGXgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.156.76]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1pZIwG2s8T-00wmFe; Wed, 09
 Aug 2023 17:53:45 +0200
Message-ID: <6f4c3b1d-4254-526a-4cf1-6aefbba6796d@gmx.de>
Date: Wed, 9 Aug 2023 17:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fix interval_tree_iter_first() to check root node value
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
 <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org> <ZNOsq6Z7t/eyIG/9@p100>
 <9251069c-95e5-aff5-9ee9-de7a493b23bf@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <9251069c-95e5-aff5-9ee9-de7a493b23bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ukde404qBvb8nozofy3Obt0TB83bY2A61dJLTJ+YZND3X5R83zF
 1+NXnctfz0wiIFtSteehPbkTIZxbFUBHrnWfN8LjHXJIB4PGPhcAjaFrfxEf5JjBaLpXsci
 1e9wJx8CeqDk6T8zO+b27PrGBtu3LtG43xg1KhO/DRfe15/HReYfo3/gH9VPZRMLK/o9YBi
 bukjn8dDFXIS2ZB9GHqDA==
UI-OutboundReport: notjunk:1;M01:P0:ucC4k7pGvjs=;vOY0ITWOD64kJ8tT5lIz+iYwdz3
 NY1Zmo6JHwqusu92fEp85fGTU2EtSfcA7mwY1iAZRv2blIrVrLUgwAggnacGp/V8ZOIYyW/FH
 fV5Ss/XaY2Qi93FIeP6qN+UUxlX4MvLRz3LZfj7xjun9LKpjvLJVxS/KhcX/0vA8DSwVHPpHF
 lld7B0/+4cWmhFQGSi7GBbpactCIYOu2P5b8lBYI6hLK+Y4lIk699CkrtGkLcwjuW2xm09cAN
 maAi9dhMzOEhN99UV/7+jL3YTqrmWVGoZoB3nDq4+nwKjpOxAZEFWFu+1UYKu7PsvcPj0FBG3
 dUJQybXdTLIJMMqlRFeWVjQXdIWcalssK/Man/fZlXqEVI9M8C89J5GO86b01BtTnPWwi32Dx
 Iu5/Sitn9f2RaI4Zs28ndfEVDCo0YGCaJ/73200L0VUBWIjPAugeHo/djDjdkLD4DrtPT8CZ7
 jRUN0FGAfoQE5hoM8FD8ow+ldIER4xJ8wQpWnAbG7buYgcm+rOXzvDpCvJZrXN9Yl0vmcvqeg
 xbgnyoUW/UqZSJPvfPKqB/+obZa3grQz90JoXkIQUroBJDaMgRGJt4hgUUx80Sq/2tmxgxxTj
 YhzZVCws6cPxOqLL5vG3nbjV8hkU2VKvL/j2dxoh4e0VM7jWVz95NwRRia9mY/N28vwSgzrsr
 diWLTN47mD4b9pw+5Xtc1CUmCVikj8Blgkz1y9MO+KiPVyDxtiS5YpZFOcfOULrD4Ap/LmlGZ
 fefYkbd0kK7623REQZ4W7QhxHdBxmFL2ToAAnFq6bFdAy6wVBKf9los3Sllfn9Z2gXqi7gpPK
 rqPVj4LMAQhpF4vC8dc3Hf0CeaZKPxKJAdpesimaKFsq/PerFo0kOUwKteOPY5xmGBrccx9mR
 nbXkQAGVAysUnWEEBLB5w0JKyefbK8andZlAlW1YeghzucHto85eJEbl+1LVrivkwLXUHoDkV
 qxQBpFp90Io22xqu7Bi21GmQB2s=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-4.14, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/9/23 17:23, Richard Henderson wrote:
> On 8/9/23 08:11, Helge Deller wrote:
>> Fix a crash in qemu-user when running
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 cat /proc/self/maps
>>
>> in a chroot, where /proc isn't mounted.
>>
>> The problem was introduced by commit 3ce3dd8ca965 ("util/selfmap:
>> Rewrite using qemu/interval-tree.h") where in open_self_maps_1() the
>> function read_self_maps() is called and which returns NULL if it can't
>> read the hosts /proc/self/maps file. Afterwards that NULL is fed into
>> interval_tree_iter_first() which doesn't check if the root node is NULL=
.
>>
>> Fix it by adding a check if root is NULL and return NULL in that case.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Fixes: 3ce3dd8ca965 ("util/selfmap: Rewrite using qemu/interval-tree.h"=
)
>>
>> diff --git a/util/interval-tree.c b/util/interval-tree.c
>> index f2866aa7d3..53465182e6 100644
>> --- a/util/interval-tree.c
>> +++ b/util/interval-tree.c
>> @@ -797,7 +797,7 @@ IntervalTreeNode *interval_tree_iter_first(Interval=
TreeRoot *root,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IntervalTreeNode *node, *leftmost;
>>
>> -=C2=A0=C2=A0=C2=A0 if (!root->rb_root.rb_node) {
>> +=C2=A0=C2=A0=C2=A0 if (!root || !root->rb_root.rb_node) {
>
>
> I guess this is good enough for 8.1.=C2=A0 Before the conversion to inte=
rval-tree we would also emit nothing.

Yes and yes.

> I've already done a rewrite for 8.2, and I noticed this problem.
> There I emit what mapping information that I have, which is
> everything except for the device+path data.

nice.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Shall I send a pull request?
If so, is it OK that I include this patch in the pull-request as well?
   linux-user: Fix openat() emulation to correctly detect accesses to /pro=
c
   https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg00165.html
which already has been R-b: Daniel P. Berrang=C3=A9

Helge

