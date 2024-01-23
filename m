Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5057838A6D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 10:36:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDC8-0002pQ-UA; Tue, 23 Jan 2024 04:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSDC6-0002pB-Pr; Tue, 23 Jan 2024 04:35:46 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSDC4-0004cj-22; Tue, 23 Jan 2024 04:35:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TK2561yRxz4wcK;
 Tue, 23 Jan 2024 20:35:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TK2522nhdz4wbQ;
 Tue, 23 Jan 2024 20:35:34 +1100 (AEDT)
Message-ID: <e13c655b-7904-4e47-a673-4efd13c26b3d@kaod.org>
Date: Tue, 23 Jan 2024 10:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/arm/aspeed/2600: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Gavin Shan <gshan@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>
References: <20240123063842.35255-1-philmd@linaro.org>
 <20240123063842.35255-7-philmd@linaro.org>
 <1c5cb61a-316a-4cd6-af53-79450025380f@kaod.org>
In-Reply-To: <1c5cb61a-316a-4cd6-af53-79450025380f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9HdW=JB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/23/24 10:27, Cédric Le Goater wrote:
> On 1/23/24 07:38, Philippe Mathieu-Daudé wrote:
>> Restrict MachineClass::valid_cpu_types[] to the single
>> valid CPU type.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/aspeed.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index df627096d2..393c97d55e 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -1157,6 +1157,11 @@ static const char * const ast2500_a1_valid_cpu_types[] = {
>>       NULL
>>   };
>> +static const char * const ast2600_a3_valid_cpu_types[] = {
>> +    ARM_CPU_TYPE_NAME("cortex-a9"),
> 
> This should be "cortex-a7"
> 
> Looking closer, the CPU information is under AspeedSoCClass. Why not build the
> valid_cpu_types array with something like :
> 
>      struct AspeedMachineClass {
>      ...
>      const char *valid_cpu_types[2];
>      };
> 
>      static void aspeed_machine_set_valid_cpu_types(MachineClass *mc)
>      {
>          AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(mc);
>          AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
>          amc->valid_cpu_types[0] = sc->cpu_type;
>          amc->valid_cpu_types[1] = NULL;
>          mc->valid_cpu_types = amc->valid_cpu_types;
>      };

or better, change AspeedSoCClass::cpu_type to an array.

	mc->valid_cpu_types =
		ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name))->cpu_types;

C.


