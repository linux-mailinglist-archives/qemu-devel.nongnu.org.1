Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D327AA9E7
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaPT-000757-L8; Fri, 22 Sep 2023 03:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjaPK-00073R-UD
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:16:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjaPJ-0001dV-0y
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:16:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 865EE242C5;
 Fri, 22 Sep 2023 10:17:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7B11929EEC;
 Fri, 22 Sep 2023 10:16:53 +0300 (MSK)
Message-ID: <42df1308-5574-1bb2-fa90-a8b2ad8eaecc@tls.msk.ru>
Date: Fri, 22 Sep 2023 10:16:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Bug 1819289] Re: Windows 95 and Windows 98 will not install or
 run
Content-Language: en-US
To: Bug 1819289 <1819289@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
 <163031397124.5151.7828028292289278229.malone@gac.canonical.com>
 <CA+Ay21K_JS4c0oDfJhhNr8N-bHVhvKxfrBr+dhRYF8CRiH1QoA@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CA+Ay21K_JS4c0oDfJhhNr8N-bHVhvKxfrBr+dhRYF8CRiH1QoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

21.09.2023 19:26, John M wrote:
> This is happening again in 8.1. I used Windows 95 for a while in 6.1 and it
> was fine, but when I tried to upgrade to 8.1, it started happening again. I
> tried reducing the memory and it still happens. Not an urgent issue though.

Can you show me a way to install & run win95/98? Is it available on a CD
image somewhere?

/mjt

