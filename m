Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FC07CBB7F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:43:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmp-0000OA-5w; Tue, 17 Oct 2023 02:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=acei=F7=kaod.org=clg@ozlabs.org>)
 id 1qsdm4-00080p-KI; Tue, 17 Oct 2023 02:41:54 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=acei=F7=kaod.org=clg@ozlabs.org>)
 id 1qsdlz-0001vg-5V; Tue, 17 Oct 2023 02:41:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S8ksV6R60z4xG0;
 Tue, 17 Oct 2023 17:41:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8ksQ23xSz4wnt;
 Tue, 17 Oct 2023 17:41:29 +1100 (AEDT)
Message-ID: <2da850f5-6a06-4900-983b-957b1912e37a@kaod.org>
Date: Tue, 17 Oct 2023 08:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add emulation of AmigaOne XE board
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, philmd@linaro.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1697311794.git.balaton@eik.bme.hu>
 <81c6d451-a457-16ad-2f5d-5764bd32b4d5@eik.bme.hu>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <81c6d451-a457-16ad-2f5d-5764bd32b4d5@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=acei=F7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/17/23 00:25, BALATON Zoltan wrote:
> On Sat, 14 Oct 2023, BALATON Zoltan wrote:
>> Changes in v3:
>> - Update values, comment and commit message in patch 1 again
>>
>> Changes in v2:
>> - Update comment and commit message in patch 1 (Mark)
>> - Fix irq mapping in patch 2 (Volker)
>>
>> Regards,
>> BALATON Zoltan
>>
>> BALATON Zoltan (3):
>>  via-ide: Fix legacy mode emulation
>>  hw/pci-host: Add emulation of Mai Logic Articia S
>>  hw/ppc: Add emulation of AmigaOne XE board
> 
> Nick, Daniel, Cédric,
> 
> Patch 1 is not related to PPC and is still debated but just to make sure we don't get too close to freeze again I ask about patch 2 and 3 in the maintime. Not sure who will merge this series at the end but if you can give an Acked-by for the last two patches maybe Philippe can take care of the series or is any of you plan to take it via ppc?

ppc should be in Nick's hands now, Daniel and I as backups.

What would help is to propose avocado tests for the machines
you maintain. Avocado can do many things, like downloading
a .zip to extract a kernel.

Thanks,

C.


