Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76F770FFB
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 15:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSHgb-0008P5-NM; Sat, 05 Aug 2023 09:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSHgY-0008NL-TS
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 09:51:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSHgX-00012S-0D
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 09:51:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C203185EA;
 Sat,  5 Aug 2023 16:51:30 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 552C51BA0D;
 Sat,  5 Aug 2023 16:51:08 +0300 (MSK)
Message-ID: <5e1aef4b-65a0-e97e-17cc-d2ccd6a66dcc@tls.msk.ru>
Date: Sat, 5 Aug 2023 16:51:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v9 for-8.1 00/24] linux-user + tcg patch queue
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
 <7390dbf4-169f-5d79-da94-ebc0986f1580@tls.msk.ru>
In-Reply-To: <7390dbf4-169f-5d79-da94-ebc0986f1580@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

05.08.2023 16:28, Michael Tokarev wrote:
...
> qemu-8.1 rc, with or without this patch set, does not work in
> old aarch64 environment at all. F.e. ubuntu xenial or debian
> jessie, like this:
> 
> # chroot /tmp/jessie-arm64/
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault
> 
> dash works, but bash or ls gives such sigsegv
...
> Is it worth to bisect?

Since it was kinda trivial to bisect, I just did. And here's the
result:

commit 59b6b42cd3446862567637f3a7ab31d69c9bef51
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Tue Jun 6 10:19:39 2023 +0100

     target/arm: Enable FEAT_LSE2 for -cpu max

Reverting this patch on top of current master makes old linuxes
to work again.

/mjt

