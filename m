Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40596821FA1
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:43:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhph-0004dU-27; Tue, 02 Jan 2024 11:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hBD0=IM=kaod.org=clg@ozlabs.org>)
 id 1rKhpd-0004d7-3R; Tue, 02 Jan 2024 11:41:33 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hBD0=IM=kaod.org=clg@ozlabs.org>)
 id 1rKhpa-0000PA-D7; Tue, 02 Jan 2024 11:41:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T4JX374jHz4x5r;
 Wed,  3 Jan 2024 03:41:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4JWw1vlvz4x1t;
 Wed,  3 Jan 2024 03:41:15 +1100 (AEDT)
Message-ID: <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
Date: Tue, 2 Jan 2024 17:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231212162935.42910-1-philmd@linaro.org>
 <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=hBD0=IM=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/2/24 17:15, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> On 2/1/24 15:55, Cédric Le Goater wrote:
>> On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> When a MPCore cluster is used, the Cortex-A cores belong the the
>>> cluster container, not to the board/soc layer. This series move
>>> the creation of vCPUs to the MPCore private container.
>>>
>>> Doing so we consolidate the QOM model, moving common code in a
>>> central place (abstract MPCore parent).
>>
>> Changing the QOM hierarchy has an impact on the state of the machine
>> and some fixups are then required to maintain migration compatibility.
>> This can become a real headache for KVM machines like virt for which
>> migration compatibility is a feature, less for emulated ones.
> 
> All changes are either moving properties (which are not migrated)
> or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
> is still migrated elsewhere). So I don't see any obvious migration
> problem, but I might be missing something, so I Cc'ed Juan :>
We broke migration compatibility by moving the IC object in the QOM
hierarchy of the pseries machines in the past. These changes might
be different. Here is the QOM tree of the ast2600 SoC.

before :

   /soc (ast2600-a3)
     /a7mpcore (a15mpcore_priv)
       /a15mp-priv-container[0] (memory-region)
       /gic (arm_gic)
         /gic_cpu[0] (memory-region)
         /gic_cpu[1] (memory-region)
         /gic_cpu[2] (memory-region)
         /gic_dist[0] (memory-region)
         /gic_vcpu[0] (memory-region)
         /gic_viface[0] (memory-region)
         /gic_viface[1] (memory-region)
         /gic_viface[2] (memory-region)
     /cpu[0] (cortex-a7-arm-cpu)
     /cpu[1] (cortex-a7-arm-cpu)

after :

   /soc (ast2600-a3)
     /a7mpcore (a7mpcore_priv)
       /cpu[0] (cortex-a7-arm-cpu)
       /cpu[1] (cortex-a7-arm-cpu)
       /gic (arm_gic)
         /gic_cpu[0] (memory-region)
         /gic_cpu[1] (memory-region)
         /gic_cpu[2] (memory-region)
         /gic_dist[0] (memory-region)
       /mpcore-priv-container[0] (memory-region)


Thanks,

C.




