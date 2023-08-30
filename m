Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0078D36E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 08:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbF6o-0004Eq-6t; Wed, 30 Aug 2023 02:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CWUu=EP=kaod.org=clg@ozlabs.org>)
 id 1qbF6i-0004EW-AF
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 02:55:16 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CWUu=EP=kaod.org=clg@ozlabs.org>)
 id 1qbF6f-00029Z-A1
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 02:55:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RbFR861pXz4wy7;
 Wed, 30 Aug 2023 16:55:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbFR504Fnz4wy4;
 Wed, 30 Aug 2023 16:54:56 +1000 (AEST)
Message-ID: <037e85aa-9d0a-f398-25a4-f23991c8942b@kaod.org>
Date: Wed, 30 Aug 2023 08:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bqemu=5d=3a_How_to_use_qemu_to_emulate_MCTP_Over_?=
 =?UTF-8?Q?SMBus_devices=ef=bc=9f?=
Content-Language: en-US
To: www <ouyangxuan10@163.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Klaus Jensen <its@irrelevant.dk>,
 Jeremy Kerr <jk@codeconstruct.com.au>
References: <673a6186.280a.18a449e0da2.Coremail.ouyangxuan10@163.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <673a6186.280a.18a449e0da2.Coremail.ouyangxuan10@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=CWUu=EP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DEAR_SOMETHING=1.973,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Hello Byron,

On 8/30/23 06:05, www wrote:
> Dear Sir，
> 
> I have a few questions for you to ask.
> 1. According to my data collection, MCTP function should not be implemented in qemu.
> I would like to ask you how to simulate MCTP Over SMBus devices？Or do we have a device program with similar functions for reference?
> (The biggest problem with simulating MCTP Over SMBus devices is that there is a master-slave switch between request and response.
> It requires the device to actively respond to the requestor, that is, the device initiates the reply.)
> 
> 2. Among the BMC functions, the communication between the BMC and the OS is a very important and basic function.
> Is there a way to simulate the communication between BMC and OS to test device drivers and applications?
> If we want to implement this feature, how do we go about it?
> 
> I am looking forward to your reply.
> Byron

Initial support for MCTP over I2C is being discussed here :

   https://lore.kernel.org/qemu-devel/20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com/

This is not my domain of expertise. So I am adding a few people who could help.

Thanks,

C.

