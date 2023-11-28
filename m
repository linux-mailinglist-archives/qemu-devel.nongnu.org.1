Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8117FBD56
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:54:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7zSr-00040g-T5; Tue, 28 Nov 2023 09:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r7zSq-00040T-2n
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:53:28 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r7zSn-0001Xz-Oi
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:53:27 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2DE2441059;
 Tue, 28 Nov 2023 15:53:22 +0100 (CET)
Message-ID: <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
Date: Tue, 28 Nov 2023 15:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZWX1n7OWh81Dd2tJ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 28.11.23 um 15:13 schrieb Daniel P. Berrangé:
> On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote:
>> we received some reports about the new default causing issues for
>> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot fails
>> and Microsoft Windows, where querying an UUID set via QEMU cmdline
>> -smbios 'type=1,uuid=a4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
>> in Powershell with
>> get-wmiobject win32_computersystemproduct | Select-Object
>> -expandProperty UUID
>> doesn't return any value anymore and can trip up some guest
>> applications. The original report is about Windows 10 and I reproduced
>> this with Windows Server 2019 and the German (but I hope it doesn't
>> matter this time) version of Windows Server 2022.
>>
>> Using machine type 8.0 or the machine option smbios-entry-point-type=32
>> are workarounds.
>>
>> Since Windows is widely used, that seems a bit unfortunate. Just wanted
>> to ask if you are aware of the issue and if there is something else that
>> can be done other than specifying the more specific machine commandline
>> for those OSes?
> 
> I don't recall seeing this issue mentioned before. Could you file a
> bug at https://gitlab.com/qemu-project/qemu
> 

I made one for the Windows issue:
https://gitlab.com/qemu-project/qemu/-/issues/2008

It's not clear to me if this is a bug in QEMU or just a bug/limitation
of the guest OS when 64 bit entry is used by SMBIOS.

I didn't create one for vSRX, because I'm not using it myself and since
it's based on FreeBSD and FreeBSD 13.1 can boot just fine with both 32
and 64 bit entry, it might be an issue on their side.

Best Regards,
Fiona


