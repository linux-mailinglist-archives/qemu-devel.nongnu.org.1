Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5FE98D457
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 15:19:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzFw-0002dW-1Q; Wed, 02 Oct 2024 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svzFt-0002cx-FG; Wed, 02 Oct 2024 09:19:01 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svzFq-00078O-Eo; Wed, 02 Oct 2024 09:19:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 27D2A60A8F;
 Wed,  2 Oct 2024 16:18:53 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qIbdJB2IlOs0-sdUl2P7j; Wed, 02 Oct 2024 16:18:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727875132;
 bh=iiOazYh2w5WfxDgnJPLS1UTaUa6z8cptYj+KFe9aS58=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GHL65IxFIKVED47JXErAXzF5fnvVaEBtUUcjT+EQJzJi7qmBHgjuffuiOr2nCzfEv
 0orOHxtxdPPisZFrJBahPP7PfzE5TsxtBrhCw5UMF4fWODfb6VD6bKsLpnpljdk9de
 ij0YRSl9vokPshwJPuw4tKcTww4UHFyiZb5c7MRQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <39881877-ab7b-4c69-ab0f-7c0b974747ee@yandex-team.ru>
Date: Wed, 2 Oct 2024 16:18:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit in
 QMP
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>
References: <20240809161828.1342831-4-eblake@redhat.com>
 <20240809161828.1342831-6-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240809161828.1342831-6-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 09.08.24 19:14, Eric Blake wrote:
> Although defaulting the handshake limit to 10 seconds was a nice QoI
> change to weed out intentionally slow clients, it can interfere with
> integration testing done with manual NBD_OPT commands over 'nbdsh
> --opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
> to alter the timeout away from the default.
> 
> The parameter name here intentionally matches the spelling of the
> constant added in commit fb1c2aaa98, and not the command-line spelling
> added in the previous patch for qemu-nbd; that's because in QMP,
> longer names serve as good self-documentation, and unlike the command
> line, machines don't have problems generating longer spellings.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   qapi/block-export.json         | 10 ++++++++++
>   include/block/nbd.h            |  6 +++---
>   block/monitor/block-hmp-cmds.c |  4 ++--
>   blockdev-nbd.c                 | 26 ++++++++++++++++++--------
>   4 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index ce33fe378df..c110dd375ad 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -17,6 +17,10 @@
>   #
>   # @addr: Address on which to listen.
>   #
> +# @handshake-max-secs: Time limit, in seconds, at which a client that
> +#     has not completed the negotiation handshake will be disconnected,
> +#     or 0 for no limit (since 9.2; default: 10).
> +#
>   # @tls-creds: ID of the TLS credentials object (since 2.6).
>   #
>   # @tls-authz: ID of the QAuthZ authorization object used to validate
> @@ -34,6 +38,7 @@
>   ##
>   { 'struct': 'NbdServerOptions',
>     'data': { 'addr': 'SocketAddress',
> +            '*handshake-max-secs': 'uint32',
>               '*tls-creds': 'str',
>               '*tls-authz': 'str',
>               '*max-connections': 'uint32' } }
> @@ -52,6 +57,10 @@
>   #
>   # @addr: Address on which to listen.
>   #
> +# @handshake-max-secs: Time limit, in seconds, at which a client that
> +#     has not completed the negotiation handshake will be disconnected,
> +#     or 0 for no limit (since 9.2; default: 10).
> +#
>   # @tls-creds: ID of the TLS credentials object (since 2.6).
>   #
>   # @tls-authz: ID of the QAuthZ authorization object used to validate
> @@ -72,6 +81,7 @@
>   ##
>   { 'command': 'nbd-server-start',
>     'data': { 'addr': 'SocketAddressLegacy',
> +            '*handshake-max-secs': 'uint32',
>               '*tls-creds': 'str',
>               '*tls-authz': 'str',
>               '*max-connections': 'uint32' },

Hmm, can we make common base for these two structures, to avoid adding things always in two places? At some point would be good to somehow deprecate old syntax and finally remove it. SocketAddressLegacy is marked as deprecated in comment in qapi/sockets.json, but no word in deprecated.rst, and I'm unsure how is it possible to deprecate this.. May be, the only way is introducing new command, and deprecate nbd-server-start altogether. Aha, that should happen when add a possibility to start multiple nbd servers.

-- 
Best regards,
Vladimir


