Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EC7065B5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:53:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzEmE-0001GW-79; Wed, 17 May 2023 06:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzEmB-0001Fn-58; Wed, 17 May 2023 06:52:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzEm9-0002CC-BO; Wed, 17 May 2023 06:52:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7584E696D;
 Wed, 17 May 2023 13:52:54 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B170C5FCC;
 Wed, 17 May 2023 13:52:53 +0300 (MSK)
Message-ID: <2b07603f-6623-9fbf-15df-a86849d9aca3@msgid.tls.msk.ru>
Date: Wed, 17 May 2023 13:52:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] xen/pt: fix igd passthrough for pc machine with xen
 accelerator
Content-Language: en-US
To: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-stable@nongnu.org
References: <a304213d26506b066021f803c39b87f6a262ed86.1675820085.git.brchuckz.ref@aol.com>
 <a304213d26506b066021f803c39b87f6a262ed86.1675820085.git.brchuckz@aol.com>
 <986d9eca-5fab-cacb-05c7-b85e4d58665b@msgid.tls.msk.ru>
 <47ed3568-2127-a865-4e4f-ff5902484231@aol.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <47ed3568-2127-a865-4e4f-ff5902484231@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -82
X-Spam_score: -8.3
X-Spam_bar: --------
X-Spam_report: (-8.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.412,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

17.05.2023 12:47, Chuck Zmudzinski wrote:
> On 5/17/2023 2:39 AM, Michael Tokarev wrote:
>> 08.02.2023 05:03, Chuck Zmudzinski wrote:...
>>> Fixes: 998250e97661 ("xen, gfx passthrough: register host bridge specific to passthrough")
>>> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
>>
>> Has this change been forgotten?  Is it not needed anymore?
> 
> Short answer:
> 
> After 4f67543b ("xen/pt: reserve PCI slot 2 for Intel igd-passthru ") was
> applied, I was inclined to think this change is not needed anymore, but
> it would not hurt to add this change also, and now I think it might be
> more correct to also add this change.
...

Well, there were two machines with broken IDG passthrough in xen, now
there's one machine with broken IDG passthrough. Let's fix them all :)
Note this patch is tagged -stable as well.

> If you want to add this change also, let's make sure recent changes to the
> xen header files do not require the patch to be rebased before committing
> it.

It doesn't require rebasing, it looks like, - just built 8.0 and current master
qemu with it applied.  I haven't tried the actual IDG passthrough, though.

It just neeeds to be picked up the usual way as all other qemu changes goes in.

Thanks,

/mjt

