Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69C859602
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Feb 2024 10:32:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbdXF-0003sW-SC; Sun, 18 Feb 2024 04:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rbdXE-0003sO-9w
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 04:32:32 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rbdXC-0000QD-LG
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 04:32:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 234564E3C2;
 Sun, 18 Feb 2024 12:32:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EE1E282E88;
 Sun, 18 Feb 2024 12:32:27 +0300 (MSK)
Message-ID: <bfd2f1e7-ac90-4972-ace7-517b27c666df@tls.msk.ru>
Date: Sun, 18 Feb 2024 12:32:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/qemu-binfmt-conf.sh: refresh
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230721115031.3224648-1-mjt@tls.msk.ru>
 <f7656ee0-586a-a89d-6815-d2d378195811@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <f7656ee0-586a-a89d-6815-d2d378195811@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

09.09.2023 16:23, Michael Tokarev :
> A friendly ping?

A friendly ping #2?

Thanks,

/mjt

> 21.07.2023 14:50, Michael Tokarev wrote:
>> Currently qemu-binfmt-conf.sh does a number of strange things.
>>
>> 1. --systemd requires an argument - the CPU type to register,
>>     while --debian (which is actually --binfmt-support) does not
>>     accept such an argument, so it is not possible to specify which
>>     CPU(s) to register for debian.
>>
>> 2. Why this "ALL" at all?
>>
>> 3. it just ignores extra command-line arguments.  It would be
>>     logical to specify which CPUs to register (multiple!) as the
>>     additional arguments.
>>
>> 4. Even if a CPU is explicitly requested, it does not register
>>     anything if this CPU is of the same family as host one. But
>>     this is wrong, since quite often it *is* desirable to do this
>>     registration, - like, when running in i386 when the system is
>>     not capable of running x86-64 binaries, and countless other
>>     examples
>>
>> 5. It ignores errors
>>
>> 6. It ignores wrong command line arguments
>>
>> Fix this, and simplify things a bit.
>>
>> 1. Stop accepting an argument for --systemd.  With getopt_long,
>>     this argument, if given, will be returned as a non-optional
>>     parameter so compatibility with current version is preserved.
>>
>> 2. Accept optional arguments and generate registration for the
>>     given CPUs only.  In case no extra arguments are given, register
>>     for all supportd CPUs except of the same family as host.
>>
>> 3. Recognze "ALL" "CPU" to keep compatibility with current version
>>     (but do not document it).
>>
>> 4. Warn but perform registration anyway if a cpu of the same family
>>     has been requested.
>>
>> 5. In help text, use --debian and --systemd as alternatives to each
>>     other, to make it clear the two can not be used at the same time.
>>
>> 6. Tiny optimization of eval expression.
>>
>> 7. Fold the list of supported CPUs to fit in 80 columns.
>>
>> 8. Exit with non-zero code in case registration fails or the command
>>     line is wrong.
>>
>> 9. Remove explicit checking for writability of various things.
>>
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   scripts/qemu-binfmt-conf.sh | 89 +++++++++++++++++--------------------
>>   1 file changed, 40 insertions(+), 49 deletions(-)
> 
> 


