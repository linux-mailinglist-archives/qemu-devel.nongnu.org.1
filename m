Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 838377E98C6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:20:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2T78-0003sS-87; Mon, 13 Nov 2023 04:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r2T76-0003sJ-RD
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:20:12 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r2T75-0006ZS-2c
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:20:12 -0500
Received: (qmail 28542 invoked by uid 484); 13 Nov 2023 09:20:09 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.071437 secs); 13 Nov 2023 09:20:09 -0000
Received: from nedpc1.intern.lauterbach.com (HELO [10.2.11.92])
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <philmd@linaro.org>; 13 Nov 2023 09:20:08 -0000
Message-ID: <c8071ac6-438d-43e2-92bb-1d92bb53d224@lauterbach.com>
Date: Mon, 13 Nov 2023 10:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] first version of mcdstub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Boenig <christian.boenig@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <2ed8e417-438e-4d44-9e1b-f391328afc4d@linaro.org>
From: "nicolas.eder@lauterbach.com" <nicolas.eder@lauterbach.com>
In-Reply-To: <2ed8e417-438e-4d44-9e1b-f391328afc4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Phil,

okay thanks! I'll add the license.

Regards,
Nicolas
On 08/11/2023 15:27, Philippe Mathieu-Daudé wrote:
> Hi Nicolas,
>
> On 7/11/23 14:03, Nicolas Eder wrote:
>> SUMMARY
>> =======
>>
>> This patch-set introduces the first version of the mcdstub.
>
>
>>   30 files changed, 3749 insertions(+), 38 deletions(-)
>>   create mode 100644 debug/debug-common.c
>>   create mode 100644 debug/debug-gdb.c
>>   create mode 100644 debug/debug-mcd.c
>>   create mode 100644 include/cutils.h
>>   create mode 100644 include/mcdstub/arm_mcdstub.h
>>   create mode 100644 include/mcdstub/mcd_shared_defines.h
>>   create mode 100644 include/mcdstub/mcdstub.h
>>   create mode 100644 include/mcdstub/mcdstub_common.h
>>   create mode 100644 include/qemu/debug.h
>>   create mode 100644 mcdstub/mcdstub.c
>>   create mode 100644 mcdstub/meson.build
>>   create mode 100644 target/arm/mcdstub.c
>
> These files are missing a license. Adding:
> /* SPDX-License-Identifier: GPL-2.0-or-later */
> on the first line is usually enough.
>
> No need to respin a v4 yet, let's wait for technical
> comments on your patches.
>
> Regards,
>
> Phil.

