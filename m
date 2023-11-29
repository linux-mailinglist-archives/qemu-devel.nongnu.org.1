Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34567FD432
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 11:32:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Hqw-0005jf-RY; Wed, 29 Nov 2023 05:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8Hqu-0005jP-QS; Wed, 29 Nov 2023 05:31:32 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8Hqs-0000gi-0t; Wed, 29 Nov 2023 05:31:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5329:0:640:5ed5:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id CD506626A2;
 Wed, 29 Nov 2023 13:31:25 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:27::1:23] (unknown [2a02:6b8:b081:27::1:23])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OVScqb0IYa60-CxZwwiDx; Wed, 29 Nov 2023 13:31:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1701253885;
 bh=/XESfNnpvItBXklaVCQktbAOiTVJ9py0Wkwjip4X3t4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=oP0Ae81Tvgj5oAmWsfFuBDcMWneHK2e+XlKY8fjhbhw8Cu8aUVDO/0yIT8AaLumW3
 PLBl/e9+fiEaP/BvQVcugLycK+kUAQPAva2wdKHcM+6jbD76KavcRMDTeGrit0f/LF
 z7kC9NdWuH+hLqRTTscwB41Hh8cHSIeWfCLEd6S4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ce71d100-f3d7-4a92-9c79-05c203cf472a@yandex-team.ru>
Date: Wed, 29 Nov 2023 13:31:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: commit/stream: Allow users to request only
 format driver names in backing file format
Content-Language: en-US
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
References: <cover.1700837066.git.pkrempa@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <cover.1700837066.git.pkrempa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 24.11.23 17:52, Peter Krempa wrote:
> Please see patches for rationale.
> 
> Libvirt patches using this new flag will be posted soon-ish (after
> cleanup).
> 
> Peter Krempa (2):
>    block: commit: Allow users to request only format driver names in
>      backing file format
>    block: stream: Allow users to request only format driver names in
>      backing file format
> 
>   block.c                                | 37 +++++++++++++++++++++-----
>   block/commit.c                         |  6 ++++-
>   block/monitor/block-hmp-cmds.c         |  2 +-
>   block/stream.c                         | 10 ++++++-
>   blockdev.c                             | 13 +++++++++
>   include/block/block-global-state.h     |  3 ++-
>   include/block/block_int-common.h       |  4 ++-
>   include/block/block_int-global-state.h |  6 +++++
>   qapi/block-core.json                   | 22 +++++++++++++--
>   tests/unit/test-bdrv-drain.c           |  3 ++-
>   10 files changed, 91 insertions(+), 15 deletions(-)
> 

Now seems good to me. Still:

1. Will need to update "since: 8.2" to 9, right?

2. Probably, use some shorter name... But I don't have good suggestion. Wouldn't that become a longest name in QAPI?)

-- 
Best regards,
Vladimir


