Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F67CD48B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt090-00035G-Dz; Wed, 18 Oct 2023 02:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt08w-0002zN-Uk; Wed, 18 Oct 2023 02:34:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt08v-0000rw-5C; Wed, 18 Oct 2023 02:34:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9LgH652Vz4xPX;
 Wed, 18 Oct 2023 17:34:51 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9LgF59jhz4xPN;
 Wed, 18 Oct 2023 17:34:49 +1100 (AEDT)
Message-ID: <291a8a9c-0465-4273-82f1-f1b8ca6ede99@kaod.org>
Date: Wed, 18 Oct 2023 08:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] MAINTAINERS: Update PPC TCG target with tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231002155143.400668-1-clg@kaod.org>
 <20231002155143.400668-9-clg@kaod.org>
 <bc9788f5-d9ee-490e-bb8a-f3503dd78016@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <bc9788f5-d9ee-490e-bb8a-f3503dd78016@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=IJBG=GA=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/18/23 08:27, Thomas Huth wrote:
> On 02/10/2023 17.51, Cédric Le Goater wrote:
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e40f7f71d651..174bcfe39210 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3551,6 +3551,7 @@ PPC TCG target
>>   M: Richard Henderson <richard.henderson@linaro.org>
>>   S: Odd Fixes
>>   F: tcg/ppc/
>> +F: tests/tcg/ppc*
> 
> Sorry, but I think this patch is wrong. This section is about the TCG *host* backend (tcg/ppc/), but tests/tcg/ppc* is about the TCG *guest* frontend.
> 
> I just noticed since I just wrote a patch that adds the tests/tcg/ subfolders to the right sections:
> 
>   https://lore.kernel.org/qemu-devel/20231018062401.20746-1-thuth@redhat.com/
> 
> The ppc* subfolders are included there, too, so I'd suggest to drop this patch here.

ok. Good for me.

Thanks,

C.


