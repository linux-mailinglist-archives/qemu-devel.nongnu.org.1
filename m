Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77158730252
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 16:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9RoH-0001uO-Gi; Wed, 14 Jun 2023 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srowe@mose.org.uk>)
 id 1q9RoE-0001u4-L3; Wed, 14 Jun 2023 10:49:18 -0400
Received: from mx2.mythic-beasts.com ([2a00:1098:0:82:1000:0:2:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srowe@mose.org.uk>)
 id 1q9RoA-0004I1-VW; Wed, 14 Jun 2023 10:49:18 -0400
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <srowe@mose.org.uk>)
 id 1q9Ro8-006wGH-2W; Wed, 14 Jun 2023 15:49:12 +0100
Received: from [192.168.3.1] (gilraen.mose.org.uk [192.168.3.1])
 (Authenticated sender: srowe)
 by eden.mose.org.uk (Postfix) with ESMTPSA id B033E27EDFA;
 Wed, 14 Jun 2023 15:48:38 +0100 (BST)
Message-ID: <e53fba5a-dca0-6ccb-00ad-d9123b8fad95@mose.org.uk>
Date: Wed, 14 Jun 2023 15:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Lost partition tables on ide-hd + ahci drive
To: Fiona Ebner <f.ebner@proxmox.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, jsnow@redhat.com
References: <ad7e1294-f19f-5bea-e891-f6adbe323cd5@proxmox.com>
Content-Language: en-GB
From: "Simon J. Rowe" <srowe@mose.org.uk>
In-Reply-To: <ad7e1294-f19f-5bea-e891-f6adbe323cd5@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0
Received-SPF: pass client-ip=2a00:1098:0:82:1000:0:2:1;
 envelope-from=srowe@mose.org.uk; helo=mx2.mythic-beasts.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.098,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: simon.rowe@nutanix.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 02/02/2023 12:08, Fiona Ebner wrote:
> Hi,
> over the years we've got 1-2 dozen reports[0] about suddenly
> missing/corrupted MBR/partition tables. The issue seems to be very rare
> and there was no success in trying to reproduce it yet. I'm asking here
> in the hope that somebody has seen something similar.
>
> The only commonality seems to be the use of an ide-hd drive with ahci bus.
>
> It does seem to happen with both Linux and Windows guests (one of the
> reports even mentions FreeBSD) and backing storages for the VMs include
> ZFS, RBD, LVM-Thin as well as file-based storages.
>
> Relevant part of an example configuration:
>
>>    -device 'ahci,id=ahci0,multifunction=on,bus=pci.0,addr=0x7' \
>>    -drive 'file=/dev/zvol/myzpool/vm-168-disk-0,if=none,id=drive-sata0,format=raw,cache=none,aio=io_uring,detect-zeroes=on' \
>>    -device 'ide-hd,bus=ahci0.0,drive=drive-sata0,id=sata0' \
> The first reports are from before io_uring was used and there are also
> reports with writeback cache mode and discard=on,detect-zeroes=unmap.
>
> Some reports say that the issue occurred under high IO load.
>
> Many reports suspect backups causing the issue. Our backup mechanism
> uses backup_job_create() for each drive and runs the jobs sequentially.
> It uses a custom block driver as the backup target which just forwards
> the writes to the actual target which can be a file or our backup server.
> (If you really want to see the details, apply the patches in [1] and see
> pve-backup.c and block/backup-dump.c).
>
> Of course, the backup job will read sector 0 of the source disk, but I
> really can't see where a stray write would happen, why the issue would
> trigger so rarely or why seemingly only ide-hd+ahci would be affected.
>
> So again, just asking if somebody has seen something similar or has a
> hunch of what the cause might be.
>
> [0]: https://bugzilla.proxmox.com/show_bug.cgi?id=2874
> [1]: https://git.proxmox.com/?p=pve-qemu.git;a=tree;f=debian/patches;hb=HEAD
>
>
We've also seen a handful of similar reports. Again, just the MBR sector 
overwritten by what looks to be guest data (e.g. log messages). The 
common thread with our incidents is again a SATA disk under the AHCI 
controller, we have a network backend (iSCSI) which has experienced a 
failure.

I've tried to repro this with blkdebug and simulated write errors, 
without success.

Regards

Simon


