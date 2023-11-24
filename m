Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27C7F7268
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:07:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6U0K-0004hz-PD; Fri, 24 Nov 2023 06:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6Tzy-0004Rn-5t; Fri, 24 Nov 2023 06:05:27 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6Tz2-0003tN-Fd; Fri, 24 Nov 2023 06:05:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ScBv96Zc4z4xRj;
 Fri, 24 Nov 2023 22:04:21 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ScBv765Svz4xPQ;
 Fri, 24 Nov 2023 22:04:19 +1100 (AEDT)
Message-ID: <3f3919a7-5a46-4810-afa3-c5cd4d6d29fc@kaod.org>
Date: Fri, 24 Nov 2023 12:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Add powernv10 I2C devices and tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
 <ff4eb381-4b9f-431f-ba79-68afa8c75859@kaod.org>
 <CX6Z7AI6T2YY.CMHUGU3CYCJE@wheely>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CX6Z7AI6T2YY.CMHUGU3CYCJE@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/24/23 11:39, Nicholas Piggin wrote:
> On Fri Nov 24, 2023 at 6:36 PM AEST, Cédric Le Goater wrote:
>> On 11/21/23 20:09, Glenn Miles wrote:
>>> This series of patches includes support, tests and fixes for
>>> adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.
>>>
>>> The PCA9552 device is used for PCIe slot hotplug power control
>>> and monitoring, while the PCA9554 device is used for presence
>>> detection of IBM CableCard devices.  Both devices are required
>>> by the Power Hypervisor Firmware on the Power10 Ranier platform.
>>>
>>> Changes from previous version:
>>>     - Removed two already merged patches
>>>     - Various formatting changes
>>>     - Capitalized "Rainier" in machine description string
>>>     - Changed powernv10-rainier parent to MACHINE_TYPE_NAME("powernv10")
>>
>>
>> Nick,
>>
>> could this series go through the ppc-next queue ?
> 
> Sure, for after 8.2. I'll start gathering up patches and push out
> a test tree before then.
> 
> Are patches 1/2 okay with that? Patch 1 looks a bit like a bug
> fix...

yes but since they are only relevant for the subsequent patches,
it is better to keep the series as a whole I think.

Thanks,

C.

