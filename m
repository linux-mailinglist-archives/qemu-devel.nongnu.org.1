Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE2D7CC5E1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskzw-0002FA-84; Tue, 17 Oct 2023 10:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1qskzr-0002AR-N9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:24:36 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>) id 1qskzl-00083G-Ts
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:24:35 -0400
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 93269608008E;
 Tue, 17 Oct 2023 16:24:03 +0200 (CEST)
Message-ID: <b3c02051-5925-4b27-92bf-4e82736c859b@csgraf.de>
Date: Tue, 17 Oct 2023 16:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] tpm_crb: use the ISA bus
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-6-j@getutm.app>
 <20230717154630.64759bd1@imammedo.users.ipa.redhat.com>
 <efb02b9c-e8ff-c78f-b4c0-10dc0f41bb16@linux.ibm.com>
 <CA+E+eSBJkXJKJq6_6y3UtyJ5KbonwhRvCb1=Pb9RQer=XXwpRQ@mail.gmail.com>
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <CA+E+eSBJkXJKJq6_6y3UtyJ5KbonwhRvCb1=Pb9RQer=XXwpRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi Joelle,

On 01.08.23 03:46, Joelle van Dyne wrote:
> On Tue, Jul 18, 2023 at 7:16 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>> On 7/17/23 09:46, Igor Mammedov wrote:
>>> On Fri, 14 Jul 2023 00:09:21 -0700
>>> Joelle van Dyne <j@getutm.app> wrote:
>>>
>>>> Since this device is gated to only build for targets with the PC
>>>> configuration, we should use the ISA bus like with TPM TIS.
>>> does it affect migration in any way?
>>>   From guest pov it looks like there a new ISA device will appear
>>> and then if you do ping pong migration between old - new QEMU will really it work?
>>
>>> If it will, then commit message here shall describe why it safe and why it works
>>>
>> I would just leave the existing device as-is. This seems safest and we know thta it works.
>>      Stefan
> Alexander, do you have any comments here? I know you wanted to move
> away from the default bus. The concern is that switching from the
> default bus to the ISA bus may cause issues in migration. The current
> course of action is to drop this patch.


The big problem I have with the CRB device is this code:

https://gitlab.com/qemu-project/qemu/-/blob/master/hw/tpm/tpm_crb.c?ref_type=heads#L297-305

It's a device that maps itself autonomously into system memory. The way 
mapping is supposed to work is that the parent of the device maps it 
into a bus region. If the parent is a machine, it is free to also map it 
into system memory. But a device should not even know what system memory 
is :).

That said, I'm happy if we just introduce a new "sane" sysdev TPM CRB 
device that we use for non-PCs and leave the current layering violating 
one as is.


Alex


