Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A8C77F275
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 10:52:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWYiM-0000GP-Nz; Thu, 17 Aug 2023 04:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qWYiI-0000Ds-3R; Thu, 17 Aug 2023 04:50:43 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qWYiF-0008J1-Bu; Thu, 17 Aug 2023 04:50:41 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B58FD41E7E;
 Thu, 17 Aug 2023 10:50:28 +0200 (CEST)
Message-ID: <f27ae4c2-133b-b013-3325-5f2edc7ed00d@proxmox.com>
Date: Thu, 17 Aug 2023 10:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] qemu_cleanup: begin drained section after vm_shutdown()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, t.lamprecht@proxmox.com,
 qemu-stable@nongnu.org, hreitz@redhat.com, thuth@redhat.com
References: <20230706131418.423713-1-f.ebner@proxmox.com>
 <20230706144356.16209-1-pbonzini@redhat.com> <ZNoxxoSZmCNdy4Ih@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZNoxxoSZmCNdy4Ih@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.165,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 14.08.23 um 15:53 schrieb Kevin Wolf:
> Am 06.07.2023 um 16:43 hat Paolo Bonzini geschrieben:
>> Queued, thanks.
> 
> This patch broke qemu-iotests 109 (for raw images), some block jobs get
> now paused once more. This is probably okay, but please double check and
> fix either the reference output or the code.
> 

Sorry about that! AFAICT, the additional pause happens, because the
bdrv_drain_all() call in do_vm_stop() is now not inside the drained
section used by qemu_cleanup() anymore. I.e., there is a second drained
section now that ends before the final one in qemu_cleanup() starts and
thus job_pause() is called twice via child_job_drained_begin().

I'll try to wrap my head around 185 too.

Best Regards,
Fiona


