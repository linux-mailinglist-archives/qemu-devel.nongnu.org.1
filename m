Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3581B762942
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 05:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOVBP-0003sv-Ui; Tue, 25 Jul 2023 23:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOVBM-0003r6-Mz; Tue, 25 Jul 2023 23:27:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOVBK-0004QD-V1; Tue, 25 Jul 2023 23:27:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB45016368;
 Wed, 26 Jul 2023 06:27:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B5811962A;
 Wed, 26 Jul 2023 06:27:08 +0300 (MSK)
Message-ID: <87c8ffae-9a95-da7d-4198-2ad2e5fa464c@tls.msk.ru>
Date: Wed, 26 Jul 2023 06:27:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 10/10] target/tricore: Rename tricore_feature
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230725145829.37782-1-philmd@linaro.org>
 <20230725145829.37782-11-philmd@linaro.org>
 <lhffgwtvanhiv3ahxvho7vdewydqpedssb3uck3j5rkpstfawo@k54muz33hhwo>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <lhffgwtvanhiv3ahxvho7vdewydqpedssb3uck3j5rkpstfawo@k54muz33hhwo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

25.07.2023 22:11, Bastian Koppelmann wrote:
...
> Michael Tokarev has already picked it up. See https://lore.kernel.org/qemu-devel/20230725145829.37782-11-philmd@linaro.org/T/#u

I noticed that too, we did it almost at the same time.

But there's nothing wrong with that.  It doesn't matter
how a particular change enters the tree. When pulling
the same change for the 2nd time, git will notice the
change is already there and do nothing.

/mjt

