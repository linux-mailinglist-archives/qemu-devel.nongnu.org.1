Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1F7F75F5
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:07:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Wot-0003g3-8S; Fri, 24 Nov 2023 09:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1r6Woq-0003aU-4k; Fri, 24 Nov 2023 09:06:08 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1r6Wok-0006EC-Qm; Fri, 24 Nov 2023 09:06:07 -0500
Message-ID: <53dc30ea-1156-f91f-736f-62ddc9401d68@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1700834756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzp/G/rWh9bmmbJ+w16AMHLOcK1YGQpoKm3HH/P04Yo=;
 b=Es9UUqxRQWPnZz99NaGpgD930b6F29tcik6KZ5JT+sPwHBzH1HpIViFMtwoygVEq/Ua7j5
 h0H39z9JttVmjEgeCJgfNe7/srfKx96LghIyNTDK/kqSxfFfesNR8iOh3eE0f50t4s/orz
 TUF4rDLWb6K+A8Czi4fq1AvlT9ma+iY=
Date: Fri, 24 Nov 2023 17:05:56 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] block/monitor: blk_bs() return value check
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: hreitz@redhat.com, qemu-block@nongnu.org, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20231124113037.2477645-1-frolov@swemel.ru>
 <ZWCf3hoaNHaWNECw@redhat.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <ZWCf3hoaNHaWNECw@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
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



On 24.11.2023 16:06, Kevin Wolf wrote:
> Am 24.11.2023 um 12:30 hat Dmitry Frolov geschrieben:
>> blk_bs() may return NULL, which will be dereferenced without a check in
>> bdrv_commit().
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> Do you have a reproducer for a crash?
Actually, there was no crash. This problem was found by static analyzer.
> As far as I can see, it will not be dereferenced, because
> blk_is_available() returns false and we return an error before
> calling bdrv_commit():
As I see, there are 2 reasons, why blk_bs() may return NULL:
blk->root == NULL or blk->root->bs == NULL
At the same time, blk_is_available() checks for blk_co_is_inserted(blk) and
blk_dev_is_tray_open(blk).
Does it also guarantee that blk->root and blk->root->bs are not NULL?
This is not really obvious.

Maybe, in this case, it makes sense to check blk->root before of checking
blk_is_available()?
>      QEMU 8.1.91 monitor - type 'help' for more information
>      (qemu) info block
>      ide1-cd0: [not inserted]
>          Attached to:      /machine/unattached/device[6]
>          Removable device: not locked, tray closed
>
>      floppy0: [not inserted]
>          Attached to:      /machine/unattached/device[16]
>          Removable device: not locked, tray closed
>
>      sd0: [not inserted]
>          Removable device: not locked, tray closed
>      (qemu) commit ide1-cd0
>      Device 'ide1-cd0' has no medium
>
> Kevin
>

