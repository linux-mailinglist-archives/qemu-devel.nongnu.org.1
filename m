Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ABE790975
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 22:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcWwJ-0008JF-C0; Sat, 02 Sep 2023 16:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qcWwG-0008Ir-Bz
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 16:09:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qcWwD-0003tq-T3
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 16:09:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 944981EA26
 for <qemu-devel@nongnu.org>; Sat,  2 Sep 2023 23:10:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E2E0225450
 for <qemu-devel@nongnu.org>; Sat,  2 Sep 2023 23:09:29 +0300 (MSK)
Message-ID: <7223931c-d5c7-9f51-f703-aea41ab7f11f@tls.msk.ru>
Date: Sat, 2 Sep 2023 23:09:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
 <bcc0df2f-5fb7-41be-035a-210eccc5a495@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <bcc0df2f-5fb7-41be-035a-210eccc5a495@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

02.09.2023 23:01, Marcin Juszkiewicz wrote:
...
>> The offending code in `/util/cpuinfo-aarch64.c` is:
>>
>  > ```c
>  > #ifdef CONFIG_LINUX
>  >      unsigned long hwcap = qemu_getauxval(AT_HWCAP);
>  >      info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
>  >      info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
>  >      info |= (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
>  > #endif
>  > ```
>>
>> The reason is that on this distribution the <bits/hwcap.h> header
>> file does not define HWCAP_USCAT:
> 
> I would recommend either upgrading your distro or staying at QEMU 8.1
> release.
> 
> HWCAP_USCAT was added to glibc in June 2018. As your distribution is not supported anymore you can also patch glibc in your system.
> 
>> I don't know if other distributions are also affected, my build
>> platform for all xPack standalone binaries is Ubuntu 18.04 LTS.
> 
> I do not know any supported distribution release without it.

In this very case it's trivial to work-around this by using

#ifndef HWCAP_USCAT
# define HWCAP_USCAT 0
#endif

or just commenting-out this line.

But 18.04 being unsupported is true still.

/mjt


