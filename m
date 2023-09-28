Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 943EF7B26DD
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 22:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qly03-0002LS-Po; Thu, 28 Sep 2023 16:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qly01-0002Kv-Ji; Thu, 28 Sep 2023 16:52:41 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlxzy-0002eI-Vi; Thu, 28 Sep 2023 16:52:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5ba3:0:640:9c4:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 93A4F5E97C;
 Thu, 28 Sep 2023 23:52:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b411::1:2f] (unknown
 [2a02:6b8:b081:b411::1:2f])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WqYNPP0Op8c0-mzVmqtbZ; Thu, 28 Sep 2023 23:52:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695934353;
 bh=52xsSePq4bSWxK0iFfguxF7pGh84krIHOIKxCq+Mifg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bSQvuzJnGSGwYdwJ5RAu6DToC5e3Xou2irsqoWRchynGOsC8KxmkAHti78EC6gzzK
 CTi8I0MS7DtoPNs+ebLeDyuvKwAk8vR3jV4p9FxZemnLJbns3rtPyU+TLnCyZ84NQV
 f73z+oCevbNIOWd0sVgr4l4aNG1EyjX0CtR3tgJY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8130ae90-a468-e783-e152-7ce3c4663938@yandex-team.ru>
Date: Thu, 28 Sep 2023 23:52:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 01/12] nbd/server: Support a request payload
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, qemu-block@nongnu.org
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-15-eblake@redhat.com>
 <523f5553-b62d-3e24-6fc7-8a350f2b6606@yandex-team.ru>
 <yi725wlzhqhumdyv7wswuubpprae5py5nuhl2fepdgx5ojo5np@d366mhjatqxc>
 <b21eccea-0e95-3ac3-96d2-4d9c9e085a15@yandex-team.ru>
 <2wnkvptrbyhfvvbkfubohfnfr4prkgzfjus3hh3cl3j4irmhjd@iv2hnge4fn63>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <2wnkvptrbyhfvvbkfubohfnfr4prkgzfjus3hh3cl3j4irmhjd@iv2hnge4fn63>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 28.09.23 17:33, Eric Blake wrote:
> On Thu, Sep 28, 2023 at 12:09:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 27.09.23 18:59, Eric Blake wrote:
>>> We could also try to be a bit more complicated by peeking at the next
>>> few bytes: if they look like a magic number of the next request,
>>> assume the client set the bit accidentally but didn't send a payload
>>> after all; for anything else, assume the client did pass a payload.
>>> But adding in machinery to peek at a prefix is more complex than
>>> either assuming a payload is always present (as done in this patch) or
>>> assuming the bit was in error (and dropping the connection
>>> unconditionally).  Preferences?
>>
>>
>> Ohh, you are right, thanks for comprehensive explanation. I really missed some things you are saying about. Yes, now I agree that "payload always exist when flag is set" is the best effort. Finally, that was our aim of the protocol design: make it more context independent. Probably, we may fix that in specification as preferable or at least possible server behavior about non-compliant client.
> 
> One other possibility I just thought of: have a heuristic where the
> flag set with h->request_length less than 512 bytes is likely to
> indicate an intentional payload (even if for a command where we
> weren't expecting payload, so still a client error); while the flag
> set wtih h->request_length >= 512 bytes is likely to be a mistaken
> setting of the flag (but also still a client error).  NBD_CMD_WRITE is
> probably the only command that will ever need to send a payload larger
> than one sector, but that command already has handling to accept
> payloads of all sizes because we know what to do with them and where
> the client is not in error.
> 

I'd prefer to avoid extra logic for optimizing handling of bad client, better keep code simpler.


-- 
Best regards,
Vladimir


