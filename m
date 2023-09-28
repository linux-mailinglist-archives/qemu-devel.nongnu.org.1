Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1CC7B16DF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 11:11:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qln27-0007Vl-R0; Thu, 28 Sep 2023 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qln23-0007VH-MZ; Thu, 28 Sep 2023 05:10:04 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qln21-0000GW-2G; Thu, 28 Sep 2023 05:10:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id E404C63909;
 Thu, 28 Sep 2023 12:09:52 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b411::1:2f] (unknown
 [2a02:6b8:b081:b411::1:2f])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id p9NWRR0OneA0-ze4UQD4Y; Thu, 28 Sep 2023 12:09:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695892192;
 bh=47NvfwL1pN2jkGRL3f+9uh5aXFYXzZbQuwmPFB4K26A=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=q4GtiECxPkYkwUsiR877Ovsofq9IAwdZd5QpnkNFBWLRO3MIGMf9ew57FpLeYlzMr
 K2tVsNAPyh5o4oFsD2OYf3QGERIDrdt5f6cybamEqKPaulcahH1YOox/3fCJ49Y68V
 5nJnUmO0f4zzlW4RYVhsDUE0gIUJR87cnXSQLKjE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b21eccea-0e95-3ac3-96d2-4d9c9e085a15@yandex-team.ru>
Date: Thu, 28 Sep 2023 12:09:51 +0300
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
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <yi725wlzhqhumdyv7wswuubpprae5py5nuhl2fepdgx5ojo5np@d366mhjatqxc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27.09.23 18:59, Eric Blake wrote:
> We could also try to be a bit more complicated by peeking at the next
> few bytes: if they look like a magic number of the next request,
> assume the client set the bit accidentally but didn't send a payload
> after all; for anything else, assume the client did pass a payload.
> But adding in machinery to peek at a prefix is more complex than
> either assuming a payload is always present (as done in this patch) or
> assuming the bit was in error (and dropping the connection
> unconditionally).  Preferences?


Ohh, you are right, thanks for comprehensive explanation. I really missed some things you are saying about. Yes, now I agree that "payload always exist when flag is set" is the best effort. Finally, that was our aim of the protocol design: make it more context independent. Probably, we may fix that in specification as preferable or at least possible server behavior about non-compliant client.

r-b coming soon, I just need to take another look with corrected picture in mind.

-- 
Best regards,
Vladimir


