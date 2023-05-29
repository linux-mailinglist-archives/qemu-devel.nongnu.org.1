Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDAE714643
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 10:26:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3YC8-0003DB-De; Mon, 29 May 2023 04:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3YBu-0003BB-Q5; Mon, 29 May 2023 04:25:24 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3YBt-0006Bb-5T; Mon, 29 May 2023 04:25:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:20ad:0:640:50e2:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id B22B85EE52;
 Mon, 29 May 2023 11:25:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b64e::1:1e] (unknown
 [2a02:6b8:b081:b64e::1:1e])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BPGLG72Oe0U0-ThTzfe76; Mon, 29 May 2023 11:25:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685348712; bh=8udelbU3HLhSXwiW+03qn/pAIRJ+jLyQ2vLExG8MnaU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0GuULqi5Xz0vzl4Odkxu32dKkC3utQdcD/xudFymh1BlQFL7gu9rcAX91PqErUWGz
 5nz0ke2afqlP2kUZ+YIiVNSAyBKFpSotUXlTPmqrsf+rZpBdP8xtr2gB9cSepRO5GD
 BKUPv/uSPmdXZ4Awa2HfHPvarUWVlBmQgzosCtQw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6cbb832d-30b1-1b95-d4ec-6f6e7433c246@yandex-team.ru>
Date: Mon, 29 May 2023 11:25:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 02/14] nbd/client: Add safety check on chunk payload
 length
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-3-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 15.05.23 22:53, Eric Blake wrote:
> Our existing use of structured replies either reads into a qiov capped
> at 32M (NBD_CMD_READ) or caps allocation to 1000 bytes (see
> NBD_MAX_MALLOC_PAYLOAD in block/nbd.c).  But the existing length
> checks are rather late; if we encounter a buggy (or malicious) server
> that sends a super-large payload length, we should drop the connection
> right then rather than assuming the layer on top will be careful.
> This becomes more important when we permit 64-bit lengths which are
> even more likely to have the potential for attempted denial of service
> abuse.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


