Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6B791A92
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 17:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdBQH-0002Kv-R5; Mon, 04 Sep 2023 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdBQF-0002KD-A1; Mon, 04 Sep 2023 11:23:27 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdBQB-0004kg-9M; Mon, 04 Sep 2023 11:23:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id DB7505F323;
 Mon,  4 Sep 2023 18:23:15 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b518::1:22] (unknown
 [2a02:6b8:b081:b518::1:22])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ENYXtM0Og8c0-jgpPU8OF; Mon, 04 Sep 2023 18:23:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1693840995;
 bh=mB8NwH7Dd9ormYsWmyMmxsS6OxTyaSC+jtFLSA9JUZI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dZQwGefHsSPjdewV+sADXCUKc5EIMyXcIhZ+eh1oYdFD+jrofALo6DPqHo1PoW4Am
 J+h3LU54y0WoWzeSxAI8xjJ+YSQHjYFufUFNCql0gBunHLDdQ9Epqr6nA0z8EjAjuE
 hpeBtloJG+zLXK08AfJnSh4NkdRoL+gXCGUDNqmI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <07efabfb-24c5-c2ad-cac6-b414834e0b0c@yandex-team.ru>
Date: Mon, 4 Sep 2023 18:23:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 01/17] nbd: Replace bool structured_reply with mode enum
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-20-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230829175826.377251-20-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
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

On 29.08.23 20:58, Eric Blake wrote:
> The upcoming patches for 64-bit extensions requires various points in
> the protocol to make decisions based on what was negotiated.  While we
> could easily add a 'bool extended_headers' alongside the existing
> 'bool structured_reply', this does not scale well if more modes are
> added in the future.  Better is to expose the mode enum added in the
> recent commit bfe04d0a7d out to a wider use in the code base.
> 
> Where the code previously checked for structured_reply being set or
> clear, it now prefers checking for an inequality; this works because
> the nodes are in a continuum of increasing abilities, and allows us to
> touch fewer places if we ever insert other modes in the middle of the
> enum.  There should be no semantic change in this patch.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


