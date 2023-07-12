Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F959750FC6
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 19:36:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJdkK-0000eo-IZ; Wed, 12 Jul 2023 13:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJdkI-0000dt-DI; Wed, 12 Jul 2023 13:35:22 -0400
Received: from mail.raptorengineering.com ([23.155.224.40]
 helo=raptorengineering.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJdkF-00034k-Tc; Wed, 12 Jul 2023 13:35:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 520CE82856E5;
 Wed, 12 Jul 2023 12:35:17 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id shQdL1QnnzWl; Wed, 12 Jul 2023 12:35:16 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 1084B8285723;
 Wed, 12 Jul 2023 12:35:16 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 1084B8285723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1689183316; bh=o7A10Ge5DXYmE6/MhWNsLB5KA2kxalF05FtNig7GRbA=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=hs0k9f1h2110xgmg1vdLem4KN9btZn5VLC9GJe2osyY86RJMMoCOIBixvqBkskhYr
 s7oo6GYzTEte2jttgnorhsGVAbfE868EzA/gzghFLg7I7pMRjT88sRypN95XCsivaM
 YESx8/wwGoF4T/tKEiR/anY1xyFb0kpLtIZOAlvE=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gE6OG2CP9VXT; Wed, 12 Jul 2023 12:35:15 -0500 (CDT)
Received: from [10.11.0.2] (5.edge.rptsys.com [23.155.224.38])
 by mail.rptsys.com (Postfix) with ESMTPSA id 6489082856E5;
 Wed, 12 Jul 2023 12:35:15 -0500 (CDT)
Message-ID: <1004ffbe-8855-75d1-45e7-65360bfd1807@raptorengineering.com>
Date: Wed, 12 Jul 2023 12:35:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] target/ppc: Generate storage interrupts for radix RC
 changes
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
References: <20230712161322.2729950-1-sanastasio@raptorengineering.com>
 <c76c0d05-4c69-aa4f-5d20-3dfdb165a765@kaod.org>
From: Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <c76c0d05-4c69-aa4f-5d20-3dfdb165a765@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.155.224.40;
 envelope-from=sanastasio@raptorengineering.com; helo=raptorengineering.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

On 7/12/23 11:56 AM, C=C3=A9dric Le Goater wrote:
> Hello Shawn,
>=20
> On 7/12/23 18:13, Shawn Anastasio wrote:
>> Change radix model to always generate a storage interrupt when the R/C
>> bits are not set appropriately in a PTE instead of setting the bits
>> itself.  According to the ISA both behaviors are valid, but in practic=
e
>> this change more closely matches behavior observed on the POWER9 CPU.
>=20
> How did you spotted this dark corner case in emulation ? Do you have
> MMU unit tests ?

I'm currently porting Xen to Power and have been using QEMU's powernv
model extensively for early bring up. I noticed the issue when my radix
implementation worked in QEMU but failed on actual hardware since I
didn't have a proper storage interrupt handler implemented.

>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Much appreciated.

> Thanks,
>=20
> C.

Thanks,
Shawn

