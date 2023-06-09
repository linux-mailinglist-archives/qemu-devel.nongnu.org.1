Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E87729229
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 10:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7X6U-0001OJ-31; Fri, 09 Jun 2023 04:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q7X6P-0001Nu-Nh
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:04:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q7X6L-0002g2-HJ
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:04:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82C28BB7F;
 Fri,  9 Jun 2023 11:04:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0BD0CADF8;
 Fri,  9 Jun 2023 11:04:02 +0300 (MSK)
Message-ID: <6d6aa523-ad1a-d515-f5ef-2e950f46ce94@tls.msk.ru>
Date: Fri, 9 Jun 2023 11:04:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user: Return EINVAL for getgroups() with negative
 gidsetsize
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230602174806.2060683-1-peter.maydell@linaro.org>
 <ef271188-c523-8be4-664c-da600b484898@tls.msk.ru>
In-Reply-To: <ef271188-c523-8be4-664c-da600b484898@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

03.06.2023 20:11, Michael Tokarev wrote:
> 02.06.2023 20:48, Peter Maydell wrote:
> 
>> @@ -11574,7 +11574,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>>               g_autofree gid_t *grouplist = NULL;
>>               int i;
>> -            if (gidsetsize > NGROUPS_MAX) {
>> +            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
>>                   return -TARGET_EINVAL;
>>               }
>>               if (gidsetsize > 0) {
> 
> FWIW, there's another piece of code exactly like this one,
> for TARGET_NR_getgroups32.  The same change is needed there too.

Peter, will you respin this (to include getgroups32 case), or should I ?
(The change is trivial enough to carry though -trivial@).

Thanks,

/mjt

