Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F37AC372
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 18:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk532-00025O-VP; Sat, 23 Sep 2023 12:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=33G5=FH=kaod.org=clg@ozlabs.org>)
 id 1qk531-00024C-0B; Sat, 23 Sep 2023 11:59:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=33G5=FH=kaod.org=clg@ozlabs.org>)
 id 1qk52r-0007nR-0o; Sat, 23 Sep 2023 11:59:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RtDNb2Npxz4xQX;
 Sun, 24 Sep 2023 01:59:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RtDNY0Lkfz4x2Y;
 Sun, 24 Sep 2023 01:59:40 +1000 (AEST)
Message-ID: <f74e6a0a-b78f-8924-6abf-42cbad6c69eb@kaod.org>
Date: Sat, 23 Sep 2023 17:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/ppc: Rename variables to avoid local variable
 shadowing in VUPKPX
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230923071203.1209663-1-clg@kaod.org>
 <26ec2024-d022-eb3d-8d50-37f9219fc597@tls.msk.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <26ec2024-d022-eb3d-8d50-37f9219fc597@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=33G5=FH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
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

On 9/23/23 10:25, Michael Tokarev wrote:
> 23.09.2023 10:12, Cédric Le Goater:
> 
>> --- a/target/ppc/int_helper.c
>> +++ b/target/ppc/int_helper.c
>> @@ -2022,11 +2022,11 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>>           for (i = 0; i < ARRAY_SIZE(r->u32); i++) {                      \
>>               uint16_t e = b->u16[hi ? i : i + 4];                        \
>>               uint8_t a = (e >> 15) ? 0xff : 0;                           \
>> -            uint8_t r = (e >> 10) & 0x1f;                               \
>> +            uint8_t _r = (e >> 10) & 0x1f;                              \
>>               uint8_t g = (e >> 5) & 0x1f;                                \
>> -            uint8_t b = e & 0x1f;                                       \
>> +            uint8_t _b = e & 0x1f;                                      \
> 
> I'd suggest to rename all of them here to have the same pattern.  Maybe.. :)

or maybe use the field names from the ISA : VRT,VRA,VRB ?

C.




