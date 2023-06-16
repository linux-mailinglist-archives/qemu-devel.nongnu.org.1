Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C642473383C
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 20:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAEIk-0007g3-J4; Fri, 16 Jun 2023 14:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qAEIi-0007fS-8j; Fri, 16 Jun 2023 14:36:00 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qAEIf-0000Td-6o; Fri, 16 Jun 2023 14:35:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 8DAF760565;
 Fri, 16 Jun 2023 21:35:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4af::1:5] (unknown
 [2a02:6b8:b081:b4af::1:5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iZi4Ek0MeW20-mzinP0zh; Fri, 16 Jun 2023 21:35:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686940545; bh=rSTNAxFDtVBh1mf3z8CjZ8WRb/8nFedu7eD6LO7gqDE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=K5tF+0AoC4O2nJreKwyaYSjH0LVpKbevCMPEC83VxZDESCUGx/TBUsOPxIH++nvvs
 2ppa4iLS1vo8fZGX6QzbYL9OeqK2m1zjjzzSNqB1Ga6oahmF92XGjumpEX/rHlyPc9
 Sqizq9YphYP2w/5G7lSW5Xzc5rHgQCR4QX/XUF7E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b76e5f2f-05ab-2e7d-4a80-dcdd5e43e9b7@yandex-team.ru>
Date: Fri, 16 Jun 2023 21:35:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 14/24] nbd/server: Prepare to receive extended header
 requests
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-15-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-15-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08.06.23 16:56, Eric Blake wrote:
> Although extended mode is not yet enabled, once we do turn it on, we
> need to accept extended requests for all messages.  Previous patches
> have already taken care of supporting 64-bit lengths, now we just need
> to read it off the wire.
> 
> Note that this implementation will block indefinitely on a buggy
> client that sends a non-extended payload (that is, we try to read a
> full packet before we ever check the magic number, but a client that
> mistakenly sends a simple request after negotiating extended headers
> doesn't send us enough bytes), but it's no different from any other
> client that stops talking to us partway through a packet and thus not
> worth coding around.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


