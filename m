Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB281839E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 09:42:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFVf0-0006Al-Lc; Tue, 19 Dec 2023 03:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rFVex-00069l-KV; Tue, 19 Dec 2023 03:41:03 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rFVeu-0001eu-UJ; Tue, 19 Dec 2023 03:41:03 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E7EC5484C2;
 Tue, 19 Dec 2023 09:40:57 +0100 (CET)
Message-ID: <e4c456d1-b3dc-41bf-9a02-1649dd84947e@proxmox.com>
Date: Tue, 19 Dec 2023 09:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <ba257408-5fb2-41d3-8b43-297ebcd312ea@proxmox.com>
 <20231214195352.GB1645604@fedora>
 <61c149da-ee22-418b-8575-b128b6836e38@proxmox.com>
 <CABgObfZn4snAzgPhWV_8tJ8DEU4hw_Hc7EDa9wrPTvqe3+jWyg@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CABgObfZn4snAzgPhWV_8tJ8DEU4hw_Hc7EDa9wrPTvqe3+jWyg@mail.gmail.com>
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

Am 18.12.23 um 15:49 schrieb Paolo Bonzini:
> On Mon, Dec 18, 2023 at 1:41 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>> I think it's because of nested drains, because when additionally
>> checking that the drain count is zero and only executing the loop then,
>> that issue doesn't seem to manifest
> 
> But isn't virtio_scsi_drained_end only run if bus->drain_count == 0?
> 
>     if (bus->drain_count-- == 1) {
>         trace_scsi_bus_drained_end(bus, sdev);
>         if (bus->info->drained_end) {
>             bus->info->drained_end(bus);
>         }
>     }
> 

You're right. Sorry, I must've messed up my testing yesterday :(
Sometimes the CPU spikes are very short-lived. Now I see the same issue
with both variants.

Unfortunately, I haven't been able to figure out why it happens yet.

Best Regards,
Fiona


