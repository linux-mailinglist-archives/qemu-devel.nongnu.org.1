Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C681677D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 08:38:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF8Ax-0005Qe-14; Mon, 18 Dec 2023 02:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hahn@univention.de>)
 id 1rF8Al-0005Lq-GN
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:36:20 -0500
Received: from mail.univention.de ([82.198.197.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hahn@univention.de>)
 id 1rF8Ag-0002Ol-OI
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:36:18 -0500
Received: from localhost (localhost [127.0.0.1])
 by lankmoj.knut.univention.de (Postfix) with ESMTP id 6DC12105A40;
 Mon, 18 Dec 2023 08:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
 s=202111; t=1702884970;
 bh=W3CXMLro7MMnoP4mZEGaPYZoqDHaleWKVQWVGY7wTpA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=leS+qVef7cfCnHqubks59AWUZHrZBkvq/GhFmg+jjE215/42GiEZ+CcTdACuqK99T
 jWpIQKYDg59ciX/wueLNwF1BFJ/jorVUIVUj5YRhOUyIdLU7SsZLiC+puI9n8PHtV+
 IWg7DEF/bhOawuGwhS3nEF50F+ycteJDBAXcZeiyjk6JIGMUFAreThU5tRSEshyzjP
 XxnDjECU6vAsc8Igd2FoQAbEMr+PsZT/IlM69NXJn4BWmahQPeiGNWS3C3E4J9caM8
 41UlAZNK9XoJjNQh0WsD+bZzh2hggP+z/gyOP1bXITEFXOWpqWt/1/+uoWFrRxx5Gq
 CE6FkqPJeHhWQ==
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at
 knut.univention.de
Received: from mail.univention.de ([127.0.0.1])
 by localhost (lankmoj.knut.univention.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UBwzx5Ed0Z95; Mon, 18 Dec 2023 08:36:09 +0100 (CET)
Received: from [192.168.178.65] (p5b21e557.dip0.t-ipconnect.de [91.33.229.87])
 by lankmoj.knut.univention.de (Postfix) with ESMTPSA id BD6CB105CB1; 
 Mon, 18 Dec 2023 08:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
 s=202111; t=1702884969;
 bh=W3CXMLro7MMnoP4mZEGaPYZoqDHaleWKVQWVGY7wTpA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Nt41QYz0ErQFMQXV3vcb1HVDCoI+3hGZcJvSAM/uuwzIU06i+gbANOBFdlufjEMBG
 Uf8sZScxtVU2LooXnH+w/s0QgOG9lxsLEAkpegT3PP2hyvkniwNGXgH+Frlr+flTBU
 KO7v31q3KqlS1/SzlXlTJb7+8838v7AcClxUAXisUa+BB9B3JHwQ5u/1AQImUCtl7x
 3voHCAGSTGnjkFFoYRgwHW6ExfbCNZHTxoVgsoTorwgSskBtQfQ42pKh+c7WNnoHh7
 D6jC07CkVWBgi+/DReE/BzuI3wAaWytHQu+ahrQbff8D1sVYV6a2k/prvhMd+pURg+
 Tqq1YI4Dvrpgw==
Message-ID: <4cb8f555-d1ab-4fe6-a1af-943d5ab0c6d8@univention.de>
Date: Mon, 18 Dec 2023 08:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "Instant clone" with Qemu?
Content-Language: de-DE
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
References: <9447a47d-751c-4913-a60b-8d92f87f2998@univention.de>
 <CAJSP0QX_7NtrxjYMCXNtHZkGLV7nXRZ8RUK7m4-ypcf9-8Pr_Q@mail.gmail.com>
 <e0454916-9ee9-46b8-9699-4225fa06fa63@univention.de>
 <CAJSP0QVkiE_kky47++dHReXbajVeiiJJKcaGfmFHjVjFphK7Yw@mail.gmail.com>
From: Philipp Hahn <hahn@univention.de>
Autocrypt: addr=hahn@univention.de; keydata=
 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 3toP
Organization: Univention GmbH
In-Reply-To: <CAJSP0QVkiE_kky47++dHReXbajVeiiJJKcaGfmFHjVjFphK7Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=82.198.197.8; envelope-from=hahn@univention.de;
 helo=mail.univention.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hello Stefan,

Am 15.12.23 um 16:21 schrieb Stefan Hajnoczi:
>> Am 05.12.23 um 15:44 schrieb Stefan Hajnoczi:
>>> On Tue, 5 Dec 2023 at 04:53, Philipp Hahn <hahn@univention.de> wrote:
>>   >
>>>> by accident I stumbled over "VMware Instant Clone" ¹, which allows
>>>> cloning of running VMs by copy-on-write-sharing the disk images and
>>>> memory content; the network MAC address gets changed (or a different
>>>> bridge is used?).
>>>> I wonder if something similar can also be done with Qemu? My current
>>>> solution would be to:
>>>> - start and install the VM
>>>> - create a live-snapshot into the qcow2 file
>>>> - clone the disk image, e.g. put a qcow2 overlay on it per clone
>>>> - start and restore the clones from that live-snapshot
>>>> - put the clones in individual bridges and let the host do some network
>>>> address translation (NAT) to give each clone a unique external IP address.
>>>>
>>>> Has someone done something similar or is there even a better alternative?
>>>>
>>>> Background: our test suite currently provisions a set of multiple VMs,
>>>> which are dependent on each other. Provisioning them takes sometimes
>>>> many hours. After that the test suite runs inside these VMs and again
>>>> takes many hours.
>>>> I'd like to speed that up by parallelizing these tests, e.g.
>>>> 1. setup the VM environment once
>>>> 2. clone the VM environments as the resources allow
>>>> 3. distribute tests over these environments to run in parallel and to
>>>> allow running flaky tests multiple times from a clean clone again
>>>
>>> It would be simplest to use qcow2 backing files and boot each new
>>> instance from scratch. This involves setting up a master image and
>>> then "qemu-img create -f qcow2 -b master.img vm001.qcow2" to create
>>> the instance image. You may be able to use systemd or your distro's
>>> "first boot" functionality to recreate unique IDs and cryptographic
>>> keys when the new instance boots.
>>
>> Actually I do not want to modify the clones at all: While the machine ID
>> is probably less interesting to others, I can even live with re-using
>> the SSH keys as this is only for *internal* testing: I can tell `ssh` to
>> not check the keys as I can control all the networking, so security is
>> of little concern here.
>>
>>> If you really want to use a RAM snapshot then I suggest creating a
>>> qcow2 master image with the savevm command and using "cp
>>> --reflink=always master.qcow2 vm001.qcow2" to create an efficient copy
>>> of the qcow2 file. You'll need some custom scripts to recreate unique
>>> IDs and cryptographic keys inside the new instance after loadvm.
>>
>> Is there a major difference between doing a "savevm" to an external file
>> and doing a live snapshot, which stores the "savevm" inside the qcow2
>> file itself. The later has the benefit for me, that I only have to
>> handle one file; I could even store it for later use if needed.
> 
> With the reflink approach you still snapshot the VM into the original
> qcow2 file (with the "savevm" command), not into an external file. The
> reflink creates an efficient copy of the file for each instance of the
> VM that you with to clone. But since you've said you don't want to
> modify the clones at all, maybe this approach is overkill because you
> have to manage these new qcow2 files.
> 
> Have you tried the -snapshot command-line option?

Thank you for the reminder, I already used it in other contexts but 
forgot it here. I'll add it to my toolshed.

Regarding reflink: that requires FS support, which AFAIKS is only 
supported by BTRFS and XFS (and OCFS2). So using `-snapshot` or an 
explicit `qemu-img create -f qcow2 -b $base.qcow2 $overlay.qcow2` works 
on any FS.

>> My main problem currently is cloning the MAC address: As our product is
>> an operating system the MAC addresses of the involved systems is stored
>> in some databases; while in most cases they are not required, I do not
>> want to hunt for these in all kind of different locations and change
>> them to some cloned MAC address.
>> I already had a look at "Virtual Routing and Forwarding"², which allows
>> me to resue the same MAC addresses in different network bridge
>> interfaces, but what I did not yet get to work is the "routing" between
>> them. I found some very nice articles³⁴ on how to do NAT with VRF, but
>> it is not yet working.
> 
> I'm not knowledgeable about VRF. You could also use -netdev
> user,hostfwd=tcp::$VM_SSH_NAT_PORT-:22 where VM_SSH_NAT_PORT is a
> unique port assigned by the script that launches the guest. That way
> each guest can have the same MAC address and IP address but receive
> incoming SSH connections.

Good to know, thank you. My problem is that I have to clone multiple VMs 
belonging together, they must be able to communicate with each other 
using their unmodified IP addresses; I only need to connect to one of 
them from the outside; something like a "jump host".

Thanks again
Philipp

