Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF439B9A11E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 15:39:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1PiU-0007e5-Cu; Wed, 24 Sep 2025 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1v1Pi5-0007Vw-Sh
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:39:09 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1v1Phw-0004wo-F1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:39:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A64EB80923;
 Wed, 24 Sep 2025 16:38:46 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c4e::1:9] (unknown [2a02:6bf:8080:c4e::1:9])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jcYIic0Gk0U0-s4lVLaHm; Wed, 24 Sep 2025 16:38:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758721125;
 bh=jmh3BE35PV+eHxmfHsaDPj6ITUym70wZguDstCNyBYo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0GSkBIzlmVx84DGQ77c0oY5xdn2f6d3+4ROBxGjZai2SmBa9D0tvp2J3EqJ25GdCN
 UHwREC614lTQbCTs2AA9kuOhkgboWV3MEzGvbwRoDucF5IhetBKkDSscu3ApMhhfBl
 MdsasEHonms8QSxa4WDN54fokktSbHPnrn64JgCE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bfc63b9c-461f-4d64-8d77-4f223be8726c@yandex-team.ru>
Date: Wed, 24 Sep 2025 16:38:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net/stream: remove deprecated 'reconnect' option
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jasowang@redhat.com,
 devel@lists.libvirt.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
 <20250924133309.334631-3-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250924133309.334631-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 9/24/25 4:33 PM, Vladimir Sementsov-Ogievskiy wrote:

> It was deprecated in 9.2, time to remove.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

> ---
>   docs/about/deprecated.rst       |  9 ---------
>   docs/about/removed-features.rst | 10 ++++++++++
>   net/stream.c                    | 20 +++++---------------
>   qapi/net.json                   | 13 +------------
>   4 files changed, 16 insertions(+), 36 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ba0be97513..4452c08bf5 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -439,15 +439,6 @@ Backend ``memory`` (since 9.0)
>   ``memory`` is a deprecated synonym for ``ringbuf``.
>   
>   
> -Net device options
> -''''''''''''''''''
> -
> -Stream ``reconnect`` (since 9.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The ``reconnect`` option only allows specifying second granularity timeouts,
> -which is not enough for all types of use cases, use ``reconnect-ms`` instead.
> -
>   CPU device properties
>   '''''''''''''''''''''
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index d67928956a..ae7d7287fc 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1373,4 +1373,14 @@ Character device options
>   The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
>   better precision.
>   
> +Net device options
> +''''''''''''''''''
> +
> +Stream ``reconnect`` (removed in 10.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
> +better precision.
> +
> +
>   .. _Intel discontinuance notification: https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
> diff --git a/net/stream.c b/net/stream.c
> index 94f823a2a7..ea83f4a763 100644
> --- a/net/stream.c
> +++ b/net/stream.c
> @@ -274,23 +274,13 @@ int net_init_stream(const Netdev *netdev, const char *name,
>       sock = &netdev->u.stream;
>   
>       if (!sock->has_server || !sock->server) {
> -        uint32_t reconnect_ms = 0;
> -
> -        if (sock->has_reconnect && sock->has_reconnect_ms) {
> -            error_setg(errp, "'reconnect' and 'reconnect-ms' are mutually "
> -                             "exclusive");
> -            return -1;
> -        } else if (sock->has_reconnect_ms) {
> -            reconnect_ms = sock->reconnect_ms;
> -        } else if (sock->has_reconnect) {
> -            reconnect_ms = sock->reconnect * 1000u;
> -        }
> -
>           return net_stream_client_init(peer, "stream", name, sock->addr,
> -                                      reconnect_ms, errp);
> +                                      sock->has_reconnect_ms ?
> +                                          sock->reconnect_ms : 0,
> +                                      errp);
>       }
> -    if (sock->has_reconnect || sock->has_reconnect_ms) {
> -        error_setg(errp, "'reconnect' and 'reconnect-ms' options are "
> +    if (sock->has_reconnect_ms) {
> +        error_setg(errp, "'reconnect-ms' option is "
>                            "incompatible with socket in server mode");
>           return -1;
>       }
> diff --git a/qapi/net.json b/qapi/net.json
> index 78bcc9871e..642d4d03cd 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -770,29 +770,18 @@
>   #
>   # @server: create server socket (default: false)
>   #
> -# @reconnect: For a client socket, if a socket is disconnected, then
> -#     attempt a reconnect after the given number of seconds.  Setting
> -#     this to zero disables this function.  (default: 0) (since 8.0)
> -#
>   # @reconnect-ms: For a client socket, if a socket is disconnected, then
>   #     attempt a reconnect after the given number of milliseconds.  Setting
> -#     this to zero disables this function.  This member is mutually
> -#     exclusive with @reconnect.  (default: 0) (Since: 9.2)
> +#     this to zero disables this function.  (default: 0) (Since: 9.2)
>   #
>   # Only `SocketAddress` types 'unix', 'inet' and 'fd' are supported.
>   #
> -# Features:
> -#
> -# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
> -#     instead.
> -#
>   # Since: 7.2
>   ##
>   { 'struct': 'NetdevStreamOptions',
>     'data': {
>       'addr':   'SocketAddress',
>       '*server': 'bool',
> -    '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
>       '*reconnect-ms': 'int' } }
>   
>   ##

