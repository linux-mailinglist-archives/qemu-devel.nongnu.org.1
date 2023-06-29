Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA0774312D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 01:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF1DJ-0004lM-0H; Thu, 29 Jun 2023 19:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qF1DG-0004l6-7q
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 19:38:10 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qF1DD-00074d-71
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 19:38:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A9BD5746361;
 Fri, 30 Jun 2023 01:37:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7860074632B; Fri, 30 Jun 2023 01:37:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7657B745720;
 Fri, 30 Jun 2023 01:37:49 +0200 (CEST)
Date: Fri, 30 Jun 2023 01:37:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Subject: Memory region endianness
Message-ID: <873fa402-8e75-1ea1-6806-26b93d3ac714@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Hello,

Some devices have bits that allow the guest to change endianness of memory 
mapped resources, e.g. ati-vga should allow switching the regs BAR into 
big endian on writing a bit. What's the best way to emulate this?

The naive way could be to just test for the bit in the memory ops call 
backs and do the swap there, but that would add overhead when it's not 
needed (most guests don't need it) and there are two BARs to access the 
same registers (one is in an IO BAR that aliases part of the MEM space 
BAR) and these may need to have different endianness so I'd rather have 
the memory layer handle it.

Now the question is how can the endianness be changed from the memory ops 
call back? Is it allowed to overwrite ops.endianness or replace ops with 
another one that has DEVICE_BIG_ENDIAN? In MemoryRegion the ops field is 
declared const and nothing seems to try to change it so I guess it might 
not be changed.

Then do I need to define two memory regions one with little and another 
with big endian and unmap/map those when the bit is written? Can this be 
done when a write to the bit happens with LE ops then is it possible from 
the callback ro unmap the memory region being written and replace it with 
another? Is there any other easy simple way that I'm missing?

Regards,
BALATON Zoltan

