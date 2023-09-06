Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71227793DE2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 15:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdska-0007LH-Kd; Wed, 06 Sep 2023 09:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdskY-0007L3-QO
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:39:18 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdskV-0001en-Va
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:39:18 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4683042B26
 for <qemu-devel@nongnu.org>; Wed,  6 Sep 2023 15:39:13 +0200 (CEST)
Message-ID: <d13ac082-358b-1fc4-03b2-a638eac98aa5@proxmox.com>
Date: Wed, 6 Sep 2023 15:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: strace showing QEMU process doing >99% ppoll
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: QEMU Developers <qemu-devel@nongnu.org>
References: <db5140a2-6947-564b-afba-e0edda31c515@proxmox.com>
In-Reply-To: <db5140a2-6947-564b-afba-e0edda31c515@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

Am 10.07.23 um 14:34 schrieb Fiona Ebner:
> Hi,
> since a while we have about a dozen people reporting [0] VMs rarely
> getting stuck with the QEMU process looping and just doing ppoll() and
> not much else (example strace [1] output and stacktrace [2]).
> 
> Just wanted to ask if anybody here has seen something similar or ideas
> what could go wrong? There seem to be at least two different issues:
> 

If anybody else stumbles upon this:

> 1. QEMU process looping calling only ppoll, guest completely
> non-responsive. I think QMP still working normally, but I had no debug
> access to these unfortunately.
> 

We did have debug access in the mean time and couldn't tell much, just
that all the vCPUs where spinning, QEMU itself seemed to run like usual.
In the end, it turned out to be a KVM bug, fixed in v6.1 by [0] and in
v6.3+ unknowingly by a refactoring.

> 2. Also QEMU looping around ppool, but the PLT (process linkage table)
> is corrupted [3]. I did have debug access to such a machine and saw the
> jump to the wrong address first hand. Call into _ppoll() results landing
> in the middle of internal_fallocate64 instead and the vCPU threads end
> up in preadv64v2() (note that the flags=44672 very much looks like
> KVM_RUN being AE80 in hex). AFAIU that memory should be read-only so
> maybe a kernel bug (the machine I debugged was running on host kernel 5.15)?
> 

No Idea about this one, but we never saw other reports again, so I
suspect some stable backport fixed it too.

Best Regards,
Fiona

[0]:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.51&id=82d811ff566594de3676f35808e8a9e19c5c864c


