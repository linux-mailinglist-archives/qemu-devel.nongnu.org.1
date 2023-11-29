Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11C7FD330
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 10:48:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8HAF-0002Ru-VL; Wed, 29 Nov 2023 04:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.656708a1.v1-48503b51cc9f467ebb5f549c4f6d8b28@bounce.vates.tech>)
 id 1r8HAE-0002QG-60
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 04:47:26 -0500
Received: from mail17.wdc04.mandrillapp.com ([205.201.139.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.656708a1.v1-48503b51cc9f467ebb5f549c4f6d8b28@bounce.vates.tech>)
 id 1r8HA4-0007MQ-MD
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 04:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 s=mandrill; t=1701251233; x=1701511733;
 i=thierry.escande@vates.tech;
 bh=rKIDxgBMMeuR/URKFcK3pMCfb46noIOP7MUypE9m96Y=;
 h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=ERHbk/uIKJZNUXjjBvApVy7GCcorgIvRilIJitMr5a5Cb3vuHBKyyVf4hUaz/bBNP
 5HNOT0L/573zAcL16Wja6X9n34GEGrMD0a4mCVyAZzt7CNlYZPUQSVLKIVOpky6CH9
 Y2qJICMfq4HJS5VXe//u2J9idZZ0sJMsk/aVAkQY=
Received: from pmta16.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail17.wdc04.mandrillapp.com (Mailchimp) with ESMTP id 4SgDxs3gW0zRKLdtR
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 09:47:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1701251233; h=from :
 subject : message-id : to : cc : references : in-reply-to : date :
 mime-version : content-type : content-transfer-encoding : from :
 x-mandrill-user : list-unsubscribe;
 bh=rKIDxgBMMeuR/URKFcK3pMCfb46noIOP7MUypE9m96Y=;
 b=N4DVo0ETUKmZcOpeAZNjl2Ygy4t7+gB6dD63kqh5KX5DUGRLqJcxuFQk5tA6s8zCall1i
 FFmDSN0EPN3gvMyHm6rnKq8YOmd2jCIvCWekgQf7uoCk+9uShOvkHIH+IUeNtwUER50zETq
 eyf50g0SBiOmMzUIsd53CloPYJIHgbQ=
From: Thierry Escande <thierry.escande@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=200/4]=20ICH9=20root=20PCI=20hotplug?=
Received: from [37.26.189.201] by mandrillapp.com id
 48503b51cc9f467ebb5f549c4f6d8b28; Wed, 29 Nov 2023 09:47:13 +0000
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1701251232247
Message-Id: <be4f338c-7b9e-4bc9-9092-01473ae24548@vates.tech>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231124150135.0b99deeb@imammedo.users.ipa.redhat.com>
 <20231124094535-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231124094535-mutt-send-email-mst@kernel.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.48503b51cc9f467ebb5f549c4f6d8b28?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20231129:md
Date: Wed, 29 Nov 2023 09:47:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.201.139.17;
 envelope-from=bounce-md_30504962.656708a1.v1-48503b51cc9f467ebb5f549c4f6d8b28@bounce.vates.tech;
 helo=mail17.wdc04.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/11/2023 15:54, Michael S. Tsirkin wrote:
> On Fri, Nov 24, 2023 at 03:01:35PM +0100, Igor Mammedov wrote:
>> On Wed, 15 Nov 2023 17:18:53 +0000
>> Thierry Escande <thierry.escande@vates.tech> wrote:
>>
>>> Hi,
>>>
>>> This series fixes acpi_hotplug_bridge accessor names, adds new accessors
>>> for acpi-root-pci-hotplug property, and enables root PCI hotplug by
>>> default for Q35 machine.
>>
>> hotplug on Q35 hostbridge is not implemented intentionally
>> to keep machine close to the real world.
> 
>> PCIe spec 3.1a, 1.3.2.3. Root Complex Integrated Endpoint Rules
>> "
>> A Root Complex Integrated Endpoint may not be hot-plugged independent of the Root
>> Complex as a whole.
>> "
>> )
> 
> To be more precise close to native hotplug.
> But we used ACPI for several years now and it seems to be fine.
> Maybe it's time we lifted the limitation?

And for what it's worth, lifting this limitation would allow PCIe 
devices passthrough on Q35 VMs with Xen as such devices are hotplugged.

> 
> 
>>
>> PS:
>> but patch 1/4 is good cleanup, pls include Reviewed-by's and resend it
>> as a separate patch after 8.2 has been released (so it wouldn't get lost in the traffic).
>>
>>>
>>> Thierry Escande (4):
>>>    ich9: Remove unused hotplug field from ICH9LPCPMRegs struct
>>>    ich9: Renamed use_acpi_hotplug_bridge accessors
>>>    ich9: Add accessors for acpi-root-pci-hotplug
>>>    ich9: Enable root PCI hotplug by default
>>>
>>>   hw/acpi/ich9.c         | 23 +++++++++++++++++++++--
>>>   include/hw/acpi/ich9.h |  1 -
>>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>>
>

