Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC127FD414
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 11:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Hkk-0003lr-AF; Wed, 29 Nov 2023 05:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8Hke-0003jG-OO; Wed, 29 Nov 2023 05:25:04 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8Hkc-0007tw-13; Wed, 29 Nov 2023 05:25:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id D21CF6129B;
 Wed, 29 Nov 2023 13:24:57 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:27::1:23] (unknown [2a02:6b8:b081:27::1:23])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vOSbJa01JOs0-thDNvgtJ; Wed, 29 Nov 2023 13:24:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1701253497;
 bh=sP5c2BvMVg1GcTCwO2OzCKTOEjCiEumsh+q7Q9/BjKE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wbHuBfJ5oG8hrOomOG06Q3UKM1szLMWY1Ujufqtk0zCJRIxjes3rscRr35EirZgcv
 OA/J6PmINnZmsHaB9RZRDXP2et3X1W8P7H3ZYFSgtTaXDzUAGlhUCMSvXQvn4HI5GY
 HyMG58vOncAwNKAWhKtCE16hrsEZaIq2R5LUG1aE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <95c38d36-d12e-4d94-8411-07f2cca48e77@yandex-team.ru>
Date: Wed, 29 Nov 2023 13:24:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: stream: Allow users to request only format
 driver names in backing file format
Content-Language: en-US
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
References: <cover.1700837066.git.pkrempa@redhat.com>
 <3a18ad1c3ed99d07f80be03f706779d46bd508c0.1700837066.git.pkrempa@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <3a18ad1c3ed99d07f80be03f706779d46bd508c0.1700837066.git.pkrempa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24.11.23 17:52, Peter Krempa wrote:
> Introduce a new flag 'backing_file_format_no_protocol' for the
> block-commit QMP command which instructs the internals to use 'raw'
> instead of the protocol driver in case when a image is used without a
> dummy 'raw' wrapper.
> 
> The flag is designed such that it can be always asserted by management
> tools even when there isn't any update to backing files.
> 
> The flag will be used by libvirt so that the backing images still
> reference the proper format even when libvirt will stop using the dummy
> raw driver (raw driver with no other config). Libvirt needs this so that
> the images stay compatible with older libvirt versions which didn't
> expect that a protocol driver name can appear in the backing file format
> field.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>   block/monitor/block-hmp-cmds.c         |  2 +-
>   block/stream.c                         | 10 +++++++++-
>   blockdev.c                             |  7 +++++++
>   include/block/block_int-global-state.h |  3 +++
>   qapi/block-core.json                   | 11 ++++++++++-
>   5 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index c729cbf1eb..28e708a981 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -509,7 +509,7 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
>       const char *base = qdict_get_try_str(qdict, "base");
>       int64_t speed = qdict_get_try_int(qdict, "speed", 0);
> 
> -    qmp_block_stream(device, device, base, NULL, NULL, NULL,
> +    qmp_block_stream(device, device, base, NULL, NULL, NULL, false, false,

that should be

+    qmp_block_stream(device, device, base, NULL, NULL, false, false, NULL,


( definitely we lack named arguments of python in C :)


with that fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

>                        qdict_haskey(qdict, "speed"), speed,
>                        true, BLOCKDEV_ON_ERROR_REPORT, NULL,
>                        false, false, false, false, &error);

...

> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2408,6 +2408,8 @@ void qmp_block_stream(const char *job_id, const char *device,
>                         const char *base,
>                         const char *base_node,
>                         const char *backing_file,
> +                      bool has_backing_file_format_no_protocol,
> +                      bool backing_file_format_no_protocol,
>                         const char *bottom,
>                         bool has_speed, int64_t speed,
>                         bool has_on_error, BlockdevOnError on_error,

-- 
Best regards,
Vladimir


