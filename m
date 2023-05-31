Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979CE71896F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 20:34:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Qdd-0006Sb-E2; Wed, 31 May 2023 14:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4Qdb-0006Ly-4P; Wed, 31 May 2023 14:33:35 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4QdY-0001W6-7F; Wed, 31 May 2023 14:33:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 032A6609ED;
 Wed, 31 May 2023 21:33:22 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KXS9r06OjOs0-pF9tvjKA; Wed, 31 May 2023 21:33:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685558001; bh=fenoJo3SjYSTpz90sLfZEyiKlbA6Ywfz4NDJtse8TwA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=d0Op4xryxHzzrL+PXHeJusaZvsShocv4QLS6hgh7fWMURHlQHv4V98NauGS7O4AID
 8Z7uWKXsxoUXmLwZunH/okqaYoG6uj1Qm0BoOuZUjdi2G1RVgrEYm25GQYBAr/cFEr
 ia+I3Z2PbWSmxiisR/hV8Gw8W8HEjQLeyk8wUIMs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cd83b0bc-0e6b-fc94-1cc2-9bf00d516140@yandex-team.ru>
Date: Wed, 31 May 2023 21:33:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 12/14] nbd/client: Request extended headers during
 negotiation
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-13-eblake@redhat.com>
 <1af7f692-b5de-c767-2568-1fc024a57133@yandex-team.ru>
 <cqb3yww5ceeinh2pb5nqaljrsllu3ejkjsdueuw32cwcocumsn@okgujto2lzmn>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <cqb3yww5ceeinh2pb5nqaljrsllu3ejkjsdueuw32cwcocumsn@okgujto2lzmn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31.05.23 20:54, Eric Blake wrote:
> On Wed, May 31, 2023 at 08:39:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.05.23 22:53, Eric Blake wrote:
>>> All the pieces are in place for a client to finally request extended
>>> headers.  Note that we must not request extended headers when qemu-nbd
>>
>> why must not? It should gracefully report ENOTSUP? Or not?
> 
> The kernel code does not yet know how to send extended requests; once
> extended mode is negotiated, sending a simple request requires the

but how it could be negotiated if kernel doesn't support it?

I mean if we request extended headers during negotiation with kernel, the kernel will just say "unsupported option", isn't it?

Or, in other words, I understand that kernel doesn't support it, I don't understand why you note it here. Is kernel different from other NBD server implementations which doesn't support extended requests at the moment?


-- 
Best regards,
Vladimir


