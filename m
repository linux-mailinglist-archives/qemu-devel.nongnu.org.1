Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0172CED2
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 20:57:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8mis-0001J4-GB; Mon, 12 Jun 2023 14:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mip-0001Hw-Ng; Mon, 12 Jun 2023 14:56:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mio-0006EO-2V; Mon, 12 Jun 2023 14:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SuU8/W9tK/QTuhyvDmeFj2DmHDJaYC+bvoboIo1UDQw=; b=hMhg3F8gTjDBSA4hbxHyIZ7Zuf
 SsLay0MG60rDHyAs3V17fY7Ih2RSZOpgFDb1/bnjmz5ZGA/ySPwQRpiKxMUx4xQ89mT0eA9XRuAy1
 X386fkPHUroiKMF+AI0jcPRjDxMhfjgLY28seCXwIHLj8w4bZk/fe+htYYtpbe03ZIjoJHIJ21rTG
 h9d9VPJpNXLjflO9vus8Us3jQLvMyeC8phBI46/RSkNPDYevzRwsgGNdH+3qRCxGl9sDXBFlyVCY4
 IjFWcud1WjhEicF1okVecHxL5js4ZsJX3ONBkcwd7K3wDBAuMK5zkcMzfnkRHxWHDACMk10k2QUQ+
 xZ1vSROakI987shyRBJ3eP9q4j7IwadJXZ5eFAQT6bke6VNZdUjI1rYAmHuhZiCZWR9d0HqAUGvHL
 c7aS3DJQm4ybSAwoIelDTxcdY3sSarlUc+cWv4A2xpAT3SgOnxtphFbYpPgCYRVTd4Y1lC3mwdWXN
 PsMSKuBbyt/mhTiqGeQXmO6EF1Fyilw95Komy8O1sAuAjiMwpbgTUDE4pxLNRwkdoT3AixFvL1Mxg
 4Eojsu1F88gbxShENZqZpJK3QGrd9qJfWAKyRg1woAfVja6YOnkk3Y/ugeRlgdOOXwgb0FcoAGoGB
 xJ50W/lNJqgOG0l+uDqXPWHIvD1YWvseD9VYNvfPk=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mid-0009GE-DR; Mon, 12 Jun 2023 19:56:51 +0100
Message-ID: <6c52add1-863e-b3d8-5711-979d064df2b2@ilande.co.uk>
Date: Mon, 12 Jun 2023 19:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
 <20230609185119.691152-3-mark.cave-ayland@ilande.co.uk>
 <3A202437-705C-49FB-BB8D-FA3CEFF0CAD7@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <3A202437-705C-49FB-BB8D-FA3CEFF0CAD7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/5] cmd646: create separate header and QOM type for
 CMD646_IDE
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/06/2023 10:21, Bernhard Beschow wrote:

> Am 9. Juni 2023 18:51:16 UTC schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>> This will enable CMD646-specific fields to be added to CMD6464IDEState in
>> future.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> hw/ide/cmd646.c         |  4 +++-
>> include/hw/ide/cmd646.h | 38 ++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 41 insertions(+), 1 deletion(-)
>> create mode 100644 include/hw/ide/cmd646.h
>>
>> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
>> index 20f1e41d57..a3e227fba7 100644
>> --- a/hw/ide/cmd646.c
>> +++ b/hw/ide/cmd646.c
>> @@ -33,6 +33,7 @@
>> #include "sysemu/reset.h"
>>
>> #include "hw/ide/pci.h"
>> +#include "hw/ide/cmd646.h"
>> #include "trace.h"
>>
>> /* CMD646 specific */
>> @@ -339,9 +340,10 @@ static void cmd646_ide_class_init(ObjectClass *klass, void *data)
>> }
>>
>> static const TypeInfo cmd646_ide_info = {
>> -    .name          = "cmd646-ide",
>> +    .name          = TYPE_CMD646_IDE,
>>      .parent        = TYPE_PCI_IDE,
>>      .class_init    = cmd646_ide_class_init,
>> +    .instance_size = sizeof(CMD646IDEState),
>> };
>>
>> static void cmd646_ide_register_types(void)
>> diff --git a/include/hw/ide/cmd646.h b/include/hw/ide/cmd646.h
>> new file mode 100644
>> index 0000000000..4780b1132c
>> --- /dev/null
>> +++ b/include/hw/ide/cmd646.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * QEMU IDE Emulation: PCI cmd646 support.
>> + *
>> + * Copyright (c) 2003 Fabrice Bellard
>> + * Copyright (c) 2006 Openedhand Ltd.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_IDE_CMD646_H
>> +#define HW_IDE_CMD646_H
>> +
>> +#define TYPE_CMD646_IDE "cmd646-ide"
>> +OBJECT_DECLARE_SIMPLE_TYPE(CMD646IDEState, CMD646_IDE)
>> +
>> +#include "hw/ide/pci.h"
>> +
>> +struct CMD646IDEState {
>> +    PCIIDEState parent_obj;
> 
> No public / private sections here? From the naming this attribute is often considered private and the rest public. I guess what this scheme communicates is that `parent_obj` should be accessed via `IDE_PCI()` only.

Whilst the public/private comments were included in the original QOM documentation, 
it's not something that tends to be used now. These days people are looking to use 
interfaces such as SysBus to indicated which MemoryRegions and IRQs are "public", but 
certainly the detail is still up for active discussion.

The QOM cast macros will allow the object referenced to be converted to any of the 
parent types directly, so indeed there should be no direct references to parent_obj.


ATB,

Mark.


