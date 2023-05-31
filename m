Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CDD718B15
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SLR-0004bM-Ij; Wed, 31 May 2023 16:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SLI-0004Vs-Pu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:22:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SLG-0000lz-ER
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:22:48 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2fQ9-1q4imm3rUF-004FZW; Wed, 31 May 2023 22:22:40 +0200
Message-ID: <e97e72fa-0655-3c92-051b-55e0072dd107@vivier.eu>
Date: Wed, 31 May 2023 22:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 05/23] q800: move CPU object into Q800MachineState
Content-Language: fr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
 <edd9f126-526e-ee57-767b-a1d307008a4d@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <edd9f126-526e-ee57-767b-a1d307008a4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gNZG/zpZK8YESh9u+W8FhW6ojoYSixfd2Py42k/BD6GeDRCRMdX
 bAeA4VFQ1ZfApAFvCgvdeIQ8phlYz6HHw62u4fq/97+sTSo69JDe7YZDg7m5cjkPP0092p3
 8pZLp94wNfgAH701SgTG4klXWdGtvVn4GTkflJqSMv4lmOOW13w3bo+eujKodi3QDQnGmEd
 Ugo4gsTKrfMVPCBCfar1g==
UI-OutboundReport: notjunk:1;M01:P0:H/H87bacqac=;X6v3p39tB7YKwA8SdSOJ2I1qzPB
 qI4/jcjeNgXfcojjsJ6Uw9msFu+s7t+QSZTsE2g2bxnULPqsvyKxx/loRIDa1VKMAWOTimuI+
 fCYAPSrKzEzx8FHQtH9ekiwo2fLH0f4/VH+sRbGfMITgd5IypwPbNt6ruzHrOO8W5cBTwko6/
 0/Nr9Za3jGRtbZ6bvo0SSaSKWoDPJrxROMuGArs+xxUY2wvisf0wilpO7mzlwwqg/2tamL7SQ
 SHC9T8X0HOTliB17y1aTTnPg6jrdvikBLgUuMEwf91gaEjTXe4pv1w4wnBbj24VkzSi4hSncl
 uBlgMbVgnqNccXfhLOy6waK3qnmLLieZKFkO7DqWurpXEJ5FuzPUO/nErO8E/EAXKVMqizv62
 Kor0zQ/RWEblwn3o3tkc+++aUdgjUzWj5UNfLZU9EvbxUqEiCM70aEDyKr1pd/OLcxfAHWZrj
 kK2AT3jwz+mFKCKyWUV0iatcJZ+dntW+/YKazNwyAqfq6Wx+2fDMKrllIOxqpYGXdh/j0mhof
 WwTWDyCsba5bFdJMWAwkkptHQ9+oh7sRsYfp+XfTLl2Jviia1XL/oKdoYkg9xNMkiBPvulgW0
 SRNCY73LFL4N3nYjjTAbVpY0rBQFNHEG2NoBvn8sxrEAv5N04cERenKWc7AEPCWbkefSsIrRt
 nNvUVfLTH7lrXDlz2gzYokc7PGYCKfTaCGk3JaGsfw==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 31/05/2023 à 19:43, Philippe Mathieu-Daudé a écrit :
> On 31/5/23 14:53, Mark Cave-Ayland wrote:
>> Also change the instantiation of the CPU to use object_initialize_child()
>> followed by a separate realisation.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/q800.c         | 13 ++++++++-----
>>   include/hw/m68k/q800.h |  2 ++
>>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> 
>> @@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *machine)
>>       }
>>       /* init CPUs */
>> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
>> -    qemu_register_reset(main_cpu_reset, cpu);
>> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
>> +                            M68K_CPU_TYPE_NAME("m68040"));
> 
> Shouldn't we keep using machine->cpu_type?
> 
> If the m68040 is the single CPU usable, we should set
> MachineClass::valid_cpu_types[] in q800_machine_class_init().
> 

You're right. Quadra 800 only exists with 68040 processor.

Originally I didn't want to stick to the processor and memory limit to be able to experiment, but as 
the work of Mark makes the machine converging to the real hardware specs, I think we can force to 
use only 68040. The "virt" machine is a better vehicule to experiment now.

Thanks,
Laurent

