Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE0827F8B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6hB-00084b-7H; Tue, 09 Jan 2024 02:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Gpa9=IT=kaod.org=clg@ozlabs.org>)
 id 1rN6h7-00084C-Ck; Tue, 09 Jan 2024 02:38:41 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Gpa9=IT=kaod.org=clg@ozlabs.org>)
 id 1rN6h2-0004nR-OU; Tue, 09 Jan 2024 02:38:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T8N8G6Fdmz4wcg;
 Tue,  9 Jan 2024 18:38:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8N8B6qDZz4wbQ;
 Tue,  9 Jan 2024 18:38:18 +1100 (AEDT)
Message-ID: <e09b5baa-8147-4450-a899-e015a9fd0f35@kaod.org>
Date: Tue, 9 Jan 2024 08:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH v8 06/10] hw/fsi: Aspeed APB2OPB interface
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-7-ninad@linux.ibm.com>
 <9139c58e-4a76-4b13-a1da-c1aafc37fad2@kaod.org>
 <c617be9c-c923-4228-81f6-bc492cc3edfe@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <c617be9c-c923-4228-81f6-bc492cc3edfe@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Gpa9=IT=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Ninad,

>>> +static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
>>> +    int i;
>>> +
>>> +    sysbus_init_irq(sbd, &s->irq);
>>> +
>>> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_apb2opb_ops, s,
>>> +                          TYPE_ASPEED_APB2OPB, 0x1000);
>>> +    sysbus_init_mmio(sbd, &s->iomem);
>>> +
>>> +    for (i = 0; i < ASPEED_FSI_NUM; i++) {
>>> +        if (!qdev_realize_and_unref(DEVICE(&s->fsi[i]), BUS(&s->opb[i]),
>>
>>
>> s->fsi[i] is not allocated. We should use qdev_realize instead.
> 
> I am not sure I understood this. FSIMasterState fsi[ASPEED_FSI_NUM]; is 
> inside structure AspeedAPB2OPBState so it must be allocated, right?

See the documentation :

   https://www.qemu.org/docs/master/devel/qdev-api.html#c.qdev_realize_and_unref

Thanks,

C.

