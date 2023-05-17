Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70E70604F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzApG-0002kT-Kk; Wed, 17 May 2023 02:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzApE-0002jb-Aq; Wed, 17 May 2023 02:39:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzApC-00019g-Fw; Wed, 17 May 2023 02:39:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A4D0A66D9;
 Wed, 17 May 2023 09:39:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3B8745D88;
 Wed, 17 May 2023 09:39:47 +0300 (MSK)
Message-ID: <986d9eca-5fab-cacb-05c7-b85e4d58665b@msgid.tls.msk.ru>
Date: Wed, 17 May 2023 09:39:47 +0300
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
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <a304213d26506b066021f803c39b87f6a262ed86.1675820085.git.brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.666,
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

08.02.2023 05:03, Chuck Zmudzinski wrote:
> Commit 998250e97661 ("xen, gfx passthrough: register host bridge specific
> to passthrough") uses the igd-passthrough-i440FX pci host device with
> the xenfv machine type and igd-passthru=on, but using it for the pc
> machine type, xen accelerator, and igd-passtru=on was omitted from that
> commit.
> 
> The igd-passthru-i440FX pci host device is also needed for guests
> configured with the pc machine type, the xen accelerator, and
> igd-passthru=on. Specifically, tests show that not using the igd-specific
> pci host device with the Intel igd passed through to the guest results
> in slower startup performance and reduced resolution of the display
> during startup. This patch fixes this issue.
> 
> To simplify the logic that is needed to support both the --enable-xen
> and the --disable-xen configure options, introduce the boolean symbol
> pc_xen_igd_gfx_pt_enabled() whose value is set appropriately in the
> sysemu/xen.h header file as the test to determine whether or not
> to use the igd-passthrough-i440FX pci host device instead of the
> normal i440FX pci host device.
> 
> Fixes: 998250e97661 ("xen, gfx passthrough: register host bridge specific to passthrough")
> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>

Has this change been forgotten?  Is it not needed anymore?

Thanks,

/mjt

