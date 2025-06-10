Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DCCAD3527
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 13:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxJw-0004Is-A2; Tue, 10 Jun 2025 07:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uOxJj-0004G6-PC; Tue, 10 Jun 2025 07:39:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uOxJd-0000tb-B3; Tue, 10 Jun 2025 07:38:59 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E229955BC05;
 Tue, 10 Jun 2025 13:38:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4jp2HikUJFEu; Tue, 10 Jun 2025 13:38:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F018E55BC02; Tue, 10 Jun 2025 13:38:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ED946745682;
 Tue, 10 Jun 2025 13:38:46 +0200 (CEST)
Date: Tue, 10 Jun 2025 13:38:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 01/13] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
In-Reply-To: <6b7aa048-bdb7-40a4-995a-9257afc99708@linaro.org>
Message-ID: <bd0e8ffa-7074-1d6d-f86d-8bc3fc875a46@eik.bme.hu>
References: <cover.1746139668.git.balaton@eik.bme.hu>
 <ad355178b2a3fe285854ed2e25b288baf0fd6e05.1746139668.git.balaton@eik.bme.hu>
 <6b7aa048-bdb7-40a4-995a-9257afc99708@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1048944630-1749555526=:47847"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1048944630-1749555526=:47847
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Jun 2025, Philippe Mathieu-Daudé wrote:
> Hi Zoltan,
>
> On 2/5/25 01:20, BALATON Zoltan wrote:
>> Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
>> versions with less parameters based on that. This is inspired by how
>> the OBJECT_DEFINE macros do this in a similar way to allow using the
>> shortened definition in more complex cases too.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   include/hw/boards.h | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 765dc8dd35..6e52d4d10c 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -744,7 +744,8 @@ struct MachineState {
>>           } \
>>       } while (0)
>>   -#define DEFINE_MACHINE(namestr, machine_initfn) \
>> +#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
>> +                                machine_initfn, ABSTRACT, ...) \
>>       static void machine_initfn##_class_init(ObjectClass *oc, const void 
>> *data) \
>>       { \
>>           MachineClass *mc = MACHINE_CLASS(oc); \
>> @@ -752,8 +753,11 @@ struct MachineState {
>>       } \
>>       static const TypeInfo machine_initfn##_typeinfo = { \
>>           .name       = MACHINE_TYPE_NAME(namestr), \
>> -        .parent     = TYPE_MACHINE, \
>> +        .parent     = TYPE_##PARENT_NAME, \
>
> As it doesn't save much, lets simply pass the full PARENT_TYPE,
> not PARENT_NAME. But, do we really need it?

I think this is to keep it similar to corresponding OBJECT_* macros so I'd 
keep it the same.

Regards,
BALATON Zoltan
--3866299591-1048944630-1749555526=:47847--

