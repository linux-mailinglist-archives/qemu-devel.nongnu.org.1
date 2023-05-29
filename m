Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B6D714C0F
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dq4-0005m9-1n; Mon, 29 May 2023 10:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3dq1-0005lt-Sr; Mon, 29 May 2023 10:27:10 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3dpv-00060Q-R7; Mon, 29 May 2023 10:27:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1421:0:640:53a0:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 8C2BE6134E;
 Mon, 29 May 2023 17:26:51 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b64e::1:1e] (unknown
 [2a02:6b8:b081:b64e::1:1e])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oQMp5F6OnCg0-vHvfvdq8; Mon, 29 May 2023 17:26:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685370411; bh=lqrpr3QShX6k7lsYtBFjCBZEWPqEav9FqttWTbj07WA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BQBfo6pMqe4nRcNN2VzNmvXPYpAY9oIjKeSLrQDh0Qgss1EbD16yJx5tVi10TZCXv
 SDfLSbNATTxFRyayMVZPgKUllmuHEecdzplU5AlVbWT0raOeOMt6JosB1tKCEUTm4U
 G5cwyfecjWJ2LeeRKfQdAmkwz8BUyZTfM/wH9RSg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7f9afa94-4817-d33a-4565-20b654190e3d@yandex-team.ru>
Date: Mon, 29 May 2023 17:26:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/14] nbd/server: Prepare for alternate-size headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-4-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 15.05.23 22:53, Eric Blake wrote:
> Upstream NBD now documents[1] an extension that supports 64-bit effect
> lengths in requests.  As part of that extension, the size of the reply
> headers will change in order to permit a 64-bit length in the reply
> for symmetry[2].  Additionally, where the reply header is currently
> 16 bytes for simple reply, and 20 bytes for structured reply; with the
> extension enabled, there will only be one structured reply type, of 32
> bytes.  Since we are already wired up to use iovecs, it is easiest to
> allow for this change in header size by splitting each structured
> reply across two iovecs, one for the header (which will become
> variable-length in a future patch according to client negotiation),
> and the other for the payload, and removing the header from the
> payload struct definitions.  Interestingly, the client side code never
> utilized the packed types, so only the server code needs to be
> updated.

Actually, it does, since previous patch :) But, it becomes even better now? Anyway some note somewhere is needed I think.

> 
> [1] https://github.com/NetworkBlockDevice/nbd/blob/extension-ext-header/doc/proto.md
> as of NBD commit e6f3b94a934
> 
> [2] Note that on the surface, this is because some future server might
> permit a 4G+ NBD_CMD_READ and need to reply with that much data in one
> transaction.  But even though the extended reply length is widened to
> 64 bits, for now the NBD spec is clear that servers will not reply
> with more than a maximum payload bounded by the 32-bit
> NBD_INFO_BLOCK_SIZE field; allowing a client and server to mutually
> agree to transactions larger than 4G would require yet another
> extension.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   include/block/nbd.h |  8 +++---
>   nbd/server.c        | 64 ++++++++++++++++++++++++++++-----------------
>   2 files changed, 44 insertions(+), 28 deletions(-)
> 

[..]

> 
> -static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
> -                                uint16_t type, uint64_t handle, uint32_t length)
> +static inline void set_be_chunk(NBDClient *client, struct iovec *iov,

Suggestion: pass niov here too, and caluculate "length" as a sum of iov lengths starting from second extent automatically.

Also, worth documenting that set_be_chunk() expects half-initialized iov, with .iov_base pointing to NBDReply (IN parameter) and .iov_len unset (OUT parameter), as that's not usual practice

> +                                uint16_t flags, uint16_t type,
> +                                uint64_t handle, uint32_t length)
>   {
> +    NBDStructuredReplyChunk *chunk = iov->iov_base;
> +
> +    iov->iov_len = sizeof(*chunk);
>       stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
>       stw_be_p(&chunk->flags, flags);
>       stw_be_p(&chunk->type, type);

[..]

-- 
Best regards,
Vladimir


