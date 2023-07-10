Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B821274D6F2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqb0-0002dm-Qf; Mon, 10 Jul 2023 09:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qIqax-0002da-8c
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:06:27 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qIqat-0003a9-6i
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:06:26 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EC7CA428D3;
 Mon, 10 Jul 2023 15:06:17 +0200 (CEST)
Message-ID: <d8cb7987-1728-5f4f-1a2b-a650833bbb47@proxmox.com>
Date: Mon, 10 Jul 2023 15:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: strace showing QEMU process doing >99% ppoll
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <db5140a2-6947-564b-afba-e0edda31c515@proxmox.com>
 <ZKv/9wM/nHPeaflB@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZKv/9wM/nHPeaflB@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
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

Am 10.07.23 um 14:56 schrieb Daniel P. Berrangé:
> On Mon, Jul 10, 2023 at 02:34:10PM +0200, Fiona Ebner wrote:
> 
>>> Thread 14 (Thread 0x7efd24d54700 (LWP 1153824) "iou-wrk-50948"):
>>> #0  0x0000000000000000 in ?? ()
>>> Backtrace stopped: Cannot access memory at address 0x0
>>>
>>> Thread 13 (Thread 0x7efd1ffff700 (LWP 1148438) "iou-wrk-50949"):
>>> #0  0x0000000000000000 in ?? ()
>>> Backtrace stopped: Cannot access memory at address 0x0
>>>
>>> Thread 12 (Thread 0x7efd1ffff700 (LWP 1133766) "iou-wrk-50949"):
>>> #0  0x0000000000000000 in ?? ()
>>> Backtrace stopped: Cannot access memory at address 0x0
>>>
>>> Thread 11 (Thread 0x7efd24d54700 (LWP 2639435) "iou-wrk-50948"):
>>> #0  0x0000000000000000 in ?? ()
>>> Backtrace stopped: Cannot access memory at address 0x0
> 
> These thread names look suprising/interestnig to me - 'iou-wrk-XXXXXX'.
> 

These are io_uring workers. We did suspect that for a bit here too (when
we switched to using that as a default two years ago, it caused a few
issues), but there are also reports of people using aio=native and
aio=threads. And for the costumer ticket with the PLT corruption,
switching away from io_uring also didn't help.

> I can't immediately see any code in QEMU creates threads with this
> naming convention.
> 
> Possibly it could be from a library that QEMU is linking to, but I'm
> not finding relevant google hits for this search string 'iou-wrk'.
> 
> Does Proxmox have any local patches to QEMU that are relevant ?
> 
Not anything that should mess with polling AFAIK.

Best Regards,
Fiona


