Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 949967F3F23
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:45:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5huY-00081D-NT; Wed, 22 Nov 2023 02:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5huW-00080M-8S; Wed, 22 Nov 2023 02:44:36 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5huU-00041B-9e; Wed, 22 Nov 2023 02:44:36 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZtYJ62Dcz4xVt;
 Wed, 22 Nov 2023 18:44:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZtYG6m2Fz4xVP;
 Wed, 22 Nov 2023 18:44:18 +1100 (AEDT)
Message-ID: <cb33c1c1-88df-4f75-b1f5-b754553167a5@kaod.org>
Date: Wed, 22 Nov 2023 08:44:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] ppc/pnv: Wire up pca9552 GPIO pins for PCIe
 hotplug power control
Content-Language: en-US
To: Miles Glenn <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-6-milesg@linux.vnet.ibm.com>
 <85ef1a8b-63c5-4492-9884-f34772a65c28@kaod.org>
 <84600e8239b6aef4915312ab0dd08149f3db4067.camel@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <84600e8239b6aef4915312ab0dd08149f3db4067.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=osAF=HD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Adding Reza.

On 11/21/23 21:03, Miles Glenn wrote:
> On Tue, 2023-11-21 at 19:36 +0100, Cédric Le Goater wrote:
>> On 11/21/23 00:51, Glenn Miles wrote:
>>> For power10-rainier, a pca9552 device is used for PCIe slot hotplug
>>> power control by the Power Hypervisor code.  The code expects that
>>> some time after it enables power to a PCIe slot by asserting one of
>>> the pca9552 GPIO pins 0-4, it should see a "power good" signal
>>> asserted
>>> on one of pca9552 GPIO pins 5-9.
>>
>> And this is what OPAL is not doing :
>>
>>     
>> https://github.com/open-power/skiboot/blob/master/platforms/astbmc/rainier.c#L65
>>
>> Correct ?
>>
> 
> Ah, yes, I believe you are correct!
Thanks,

C.



