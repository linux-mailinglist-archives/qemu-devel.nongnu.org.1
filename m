Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C267EFE4D
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 08:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Fqv-0007Nh-64; Sat, 18 Nov 2023 02:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4Fqs-0007N0-49; Sat, 18 Nov 2023 02:34:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4Fqp-0004v9-SR; Sat, 18 Nov 2023 02:34:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 735E43460E;
 Sat, 18 Nov 2023 10:34:36 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E6AFF36059;
 Sat, 18 Nov 2023 10:34:34 +0300 (MSK)
Message-ID: <d01c1fdf-dd90-4743-b04b-14069b1b8971@tls.msk.ru>
Date: Sat, 18 Nov 2023 10:34:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ide/ahci: fix legacy software reset
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <nks@flawful.org>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <20231108222657.117984-1-nks@flawful.org>
 <ZU39Fus85X+625bj@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZU39Fus85X+625bj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

10.11.2023 12:51, Kevin Wolf:
> Am 08.11.2023 um 23:26 hat Niklas Cassel geschrieben:
>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> Legacy software contains a standard mechanism for generating a reset to a
>> Serial ATA device - setting the SRST (software reset) bit in the Device
>> Control register.
...
>> Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
>> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Thanks, applied to the block branch.

Another friendly ping?

This change, once again, missed the next stable-8.1.x release, it seems
(the deadline for which is tomorrow).

/mjt


