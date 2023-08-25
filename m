Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4F78849A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTsb-0004S9-C6; Fri, 25 Aug 2023 06:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qZTsW-0004Nv-FG; Fri, 25 Aug 2023 06:17:22 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qZTsT-0003Pl-56; Fri, 25 Aug 2023 06:17:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9D07F44716;
 Fri, 25 Aug 2023 12:17:13 +0200 (CEST)
Message-ID: <dec39419-cecf-ce7f-2b8c-af47575f80f2@proxmox.com>
Date: Fri, 25 Aug 2023 12:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [POC 2/2] add test exposing AHCI reset issue
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 srowe@mose.org.uk, mike.maslenkin@gmail.com, qemu-block@nongnu.org,
 t.lamprecht@proxmox.com, a.lauterer@proxmox.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230824133831.617833-1-f.ebner@proxmox.com>
 <20230824133831.617833-2-f.ebner@proxmox.com>
In-Reply-To: <20230824133831.617833-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.919,
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

Am 24.08.23 um 15:38 schrieb Fiona Ebner:
> Fails without the previous commit "hw/ide: reset: cancel async DMA
> operation before reseting state".
> 
> I haven't ever written such a test before, but I wanted something to
> expose the problem more easily. It hardcodes the behavior that the
> pending write actually is done during reset, which might not be ideal.
> It could just check that the first sector is still intact instead.
> 
> If I should make this a proper test, I'd be happy about some guidance,
> but not sure if required for such a specific one-off issue. After all,
> a different variation of the bug might have written to some other
> sector not covered by this test.
> 

While trying to turn it into a proper test with Philippe's and Thomas's
suggestions, I wanted to add a comment about the buffer size. So I tried
figuring out what the "magic" value is. At the very beginning, I had
tried 4 KiB, but then the callback wouldn't be pending, so I just picked
512 KiB for my proof-of-concept. It turns out to be racy though, and
with a buffer size of 64 KiB, it is flaky whether or not the callback is
still pending on my system. Should I just pick a large enough buffer
size (maybe 4 MiB) and hope for the best?

Best Regards,
Fiona


