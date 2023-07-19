Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576F759478
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 13:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5XN-00064H-36; Wed, 19 Jul 2023 07:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qM5XJ-00062p-6F
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:40:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qM5XG-0001qR-P0
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:40:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 116CA14CE8;
 Wed, 19 Jul 2023 14:39:51 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA392180D4;
 Wed, 19 Jul 2023 14:39:49 +0300 (MSK)
Message-ID: <6764475b-c83e-3e77-b057-0cd3c3d8afdb@tls.msk.ru>
Date: Wed, 19 Jul 2023 14:39:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] linux-user: brk() syscall fixes and armhf static
 binary fix
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: Song Gao <gaosong@loongson.cn>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230717213545.142598-1-deller@gmx.de>
 <703ab494-1778-c50a-d46f-988fab846da3@loongson.cn>
 <774e9287-87df-f45a-f6a5-e257de0eb058@tls.msk.ru>
In-Reply-To: <774e9287-87df-f45a-f6a5-e257de0eb058@tls.msk.ru>
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

18.07.2023 11:30, Michael Tokarev wrote:
> 18.07.2023 06:03, Song Gao пишет:
>> Hi,  Helge
>>
>> Could you see the following bugs:
>> https://gitlab.com/qemu-project/qemu/-/issues/1707
>>
>> This issue is also caused by  the commit  86f04735ac.
> 
> This issue has been fixed in master already and even in 8.0.3 stable release
> (I haven't checked which commit did that, though).

This claim turned out to be false: the prob is fixed in *debian* build of
qemu v8.0.3, which includes an additional change on top of qemu v8.0.3,
"linux-user: Make sure initial brk(0) is page-aligned" - the one which is being
reverted in this patchset, apparenly incorrectly.

So, in short, https://gitlab.com/qemu-project/qemu/-/issues/1707 is fixed
in qemu master but not in qemu v8.0.3 stable. Hopefully the fix will be in v8.0.4
(together with other fixes from this thread).

Thanks,  and sorry for my mistake.

/mjt

