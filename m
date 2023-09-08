Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A247798B25
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:04:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeesl-0003xs-RM; Fri, 08 Sep 2023 13:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeesj-0003xH-4m; Fri, 08 Sep 2023 13:02:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeesg-0000Ui-JL; Fri, 08 Sep 2023 13:02:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3436620323;
 Fri,  8 Sep 2023 20:03:31 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 928BF26BEC;
 Fri,  8 Sep 2023 20:02:41 +0300 (MSK)
Message-ID: <aa6e37b6-3bd9-5551-daf5-d040b926518e@tls.msk.ru>
Date: Fri, 8 Sep 2023 20:02:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] hw/cxl: Fix CFMW config memory leak
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, fan.ni@samsung.com,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20230531060706.11840-1-lizhijian@cn.fujitsu.com>
 <5ac2e71e-7bc0-ee84-fce2-8d0b6e137a3e@linaro.org>
 <20230531120823.00001a6c@Huawei.com>
 <0adbfa43-719c-6d8e-9ec9-5d4a402be384@tls.msk.ru>
 <20230808154430.0000291e@Huawei.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230808154430.0000291e@Huawei.com>
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

08.08.2023 17:44, Jonathan Cameron:

> Sorry, I'm running a bit behind.  Have this one a few other fixes
> still queued up - I didn't consider any of them particularly critical
> for the release so wasn't rushing.
> 
> I'll aim to get them out as a series soon though so they are
> available for start of next cycle if not for slipping in before
> the release.

A month later, friendly ping? :)
(this is sent to -stable too, fwiw).

/mjt


