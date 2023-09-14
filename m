Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDFB7A040B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:38:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglc5-0008Ug-Vh; Thu, 14 Sep 2023 08:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qglc2-0008UL-JN; Thu, 14 Sep 2023 08:38:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qglc0-0000lB-S1; Thu, 14 Sep 2023 08:38:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E78A421E35;
 Thu, 14 Sep 2023 15:38:30 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 14DC62816C;
 Thu, 14 Sep 2023 15:38:23 +0300 (MSK)
Message-ID: <79f03e2f-4cc9-fd44-1101-0dd8a398ff42@tls.msk.ru>
Date: Thu, 14 Sep 2023 15:38:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/cxl: Fix out of bound array access
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: Dmitry Frolov <frolov@swemel.ru>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, qemu-stable <qemu-stable@nongnu.org>
References: <20230913101055.754709-1-frolov@swemel.ru>
 <fb3f6b07-3310-f008-a512-1d155e21c024@tls.msk.ru>
In-Reply-To: <fb3f6b07-3310-f008-a512-1d155e21c024@tls.msk.ru>
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

14.09.2023 15:37, Michael Tokarev:
> 13.09.2023 13:10, Dmitry Frolov wrote:
>> According to cxl_interleave_ways_enc(),
>> fw->num_targets is allowed to be up to 16.
>> This also corresponds to CXL specs.
>> So, the fw->target_hbs[] array is iterated from 0 to 15.
>> But it is staticaly declared of length 8.
>> Thus, out of bound array access may occur.
>>
>> Fixes: c28db9e000 ("hw/pci-bridge: Make PCIe and CXL PXB Devices inherit from TYPE_PXB_DEV")
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> (with the extra empty line removed :)

Also,

Cc: qemu-stable@nongnu.org

for stable-8.1.

/mjt

