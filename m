Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5CD7E98C5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:20:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2T5r-0003Jb-PD; Mon, 13 Nov 2023 04:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r2T5p-0003JL-L5
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:18:53 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r2T5n-00066M-JS
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:18:53 -0500
Received: (qmail 28115 invoked by uid 484); 13 Nov 2023 09:18:32 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.075538 secs); 13 Nov 2023 09:18:32 -0000
Received: from nedpc1.intern.lauterbach.com (HELO [10.2.11.92])
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <philmd@linaro.org>; 13 Nov 2023 09:18:31 -0000
Message-ID: <ef9b8e51-e29e-40f9-8039-f3d561f162a8@lauterbach.com>
Date: Mon, 13 Nov 2023 10:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] mcdstub: tcp packet processing added
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Boenig <christian.boenig@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <20231107130323.4126-6-nicolas.eder@lauterbach.com>
 <fbc70e51-5a09-497e-a22f-48416eb688d1@linaro.org>
From: "nicolas.eder@lauterbach.com" <nicolas.eder@lauterbach.com>
In-Reply-To: <fbc70e51-5a09-497e-a22f-48416eb688d1@linaro.org>
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

as of right now, there is no official spec for the TCP packet contents. 
However, in the client code it is rather easy see how the packets are 
constructed. I hope I will get the client code online by the end of the 
week.
I will also look into qtest. We definetely need a test like this and I 
think your example is a good idea.

Best Regards,
Nicolas


On 08/11/2023 15:33, Philippe Mathieu-Daudé wrote:
> Hi Nicolas,
>
> On 7/11/23 14:03, Nicolas Eder wrote:
>> ---
>>   include/mcdstub/mcdstub.h | 144 ++++++++++++++++++++
>>   mcdstub/mcdstub.c         | 277 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 421 insertions(+)
>>
>> diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
>> index 36058157ae..1461d0e1cb 100644
>> --- a/include/mcdstub/mcdstub.h
>> +++ b/include/mcdstub/mcdstub.h
>> @@ -25,6 +25,21 @@ typedef struct MCDProcess {
>>       char target_xml[1024];
>>   } MCDProcess;
>>   +typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
>> +typedef struct MCDCmdParseEntry {
>> +    MCDCmdHandler handler;
>> +    const char *cmd;
>> +    char schema[CMD_SCHEMA_LENGTH];
>> +} MCDCmdParseEntry;
>> +
>> +typedef union MCDCmdVariant {
>> +    const char *data;
>> +    uint32_t data_uint32_t;
>> +    uint64_t data_uint64_t;
>> +    uint32_t query_handle;
>> +    uint32_t cpu_id;
>> +} MCDCmdVariant;
>
> [...]
>
> Can we add an URL to the spec in this file header?
>
> It should be relatively easy to add a qtest for MCB, with raw
> packets to:
> - read memory
> - write memory
> - read register
> - write register
> - register breakpoint
> - run vcpu
> - stop vcpu
>
> Maybe we can write a tiny code that loop incrementing a static
> variable, run for few ms and check the variable got incremented?
> That would exercise most of these commands.
>
> Regards,
>
> Phil.

