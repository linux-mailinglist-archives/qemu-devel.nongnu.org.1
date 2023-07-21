Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD475CB78
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:21:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrvi-0000Ng-Q0; Fri, 21 Jul 2023 11:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qMrvg-0000Jt-RX; Fri, 21 Jul 2023 11:20:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qMrve-00043V-RH; Fri, 21 Jul 2023 11:20:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF429157ED;
 Fri, 21 Jul 2023 18:20:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85FD518943;
 Fri, 21 Jul 2023 18:20:23 +0300 (MSK)
Message-ID: <687bbf35-f32a-3bf7-ee97-e9ab478d6a79@tls.msk.ru>
Date: Fri, 21 Jul 2023 18:20:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 5/5] linux-user: Fix qemu-arm to run static armhf binaries
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
References: <20230719155235.244478-1-deller@gmx.de>
 <20230719155235.244478-6-deller@gmx.de>
 <68821f3a-84ce-a44a-aecb-46ad27059205@tls.msk.ru>
In-Reply-To: <68821f3a-84ce-a44a-aecb-46ad27059205@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.094,
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

21.07.2023 18:14, Michael Tokarev пишет:
> 19.07.2023 18:52, Helge Deller wrote:
>> qemu-user crashes immediately when running static binaries on the armhf
>> architecture. The problem is the memory layout where the executable is
>> loaded before the interpreter library, in which case the reserved brk
>> region clashes with the interpreter code and is released before qemu
>> tries to start the program.
>>
>> At load time qemu calculates a brk value for interpreter and executable
>> each.  The fix is to choose the higher one of both.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: Andreas Schwab <schwab@suse.de>
>> Cc: qemu-stable@nongnu.org
>> Reported-by:  Venkata.Pyla@toshiba-tsip.com
>> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1040981
>> ---
>>   linux-user/elfload.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index a26200d9f3..94951630b1 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3615,6 +3615,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>>
>>       if (elf_interpreter) {
>>           load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
>> +        /*
>> +         * adjust brk address if the interpreter was loaded above the main
>> +         * executable, e.g. happens with static binaries on armhf
>> +         */
>> +        if (interp_info.brk > info->brk) {
>> +            info->brk = interp_info.brk;
>> +        }

I've added printf() inside this if() block, on arm64 it produces:

   fixing brk: interp_info.brk=0x5502875358 info=>brk=0x5500032ec0

FWIW,

/mjt

