Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 772FC7594C0
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:09:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5xh-0007zA-KF; Wed, 19 Jul 2023 08:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qM5xS-0007xh-KK; Wed, 19 Jul 2023 08:07:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qM5xQ-0002dj-4p; Wed, 19 Jul 2023 08:07:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 80E5514CF9;
 Wed, 19 Jul 2023 15:07:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 576C0180E4;
 Wed, 19 Jul 2023 15:06:59 +0300 (MSK)
Message-ID: <fbf8507f-1475-c724-5fde-97d11fb7d61c@tls.msk.ru>
Date: Wed, 19 Jul 2023 15:06:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 8/8] hw/ide/ahci: fix broken SError handling
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230609140844.202795-1-nks@flawful.org>
 <20230609140844.202795-9-nks@flawful.org>
 <e1966f41-5e65-7cd8-d558-46b11a0eb553@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <e1966f41-5e65-7cd8-d558-46b11a0eb553@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

19.07.2023 14:59, Philippe Mathieu-Daudé wrote:
> On 9/6/23 16:08, Niklas Cassel wrote:
>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> When encountering an NCQ error, you should not write the NCQ tag to the
>> SError register. This is completely wrong.
>>
>> The SError register has a clear definition, where each bit represents a
>> different error, see PxSERR definition in AHCI 1.3.1.
>>
>> If we write a random value (like the NCQ tag) in SError, e.g. Linux will
>> read SError, and will trigger arbitrary error handling depending on the
>> NCQ tag that happened to be executing.
>>
>> In case of success, ncq_cb() will call ncq_finish().
>> In case of error, ncq_cb() will call ncq_err() (which will clear
>> ncq_tfs->used), and then call ncq_finish(), thus using ncq_tfs->used is
>> sufficient to tell if finished should get set or not.
>>
> 
> Cc: qemu-stable@nongnu.org
> Fixes: f6ad2e32f8 ("ahci: add ahci emulation")

If going this route, it feels like 7/8 "hw/ide/ahci: fix ahci_write_fis_sdb()"
should be there (-stable) too.

/mjt


