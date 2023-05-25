Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9F710FF7
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DEa-0005v8-Je; Thu, 25 May 2023 11:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DEY-0005uy-BK
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:50:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DEW-0005ER-E4
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZFrQqok1Hq7+599B0uC0R5E5dPUwYNcPSpmdh2fIk0=; b=t4tC0wtxCz2ipRkQhqN21au2t/
 Uhf8OYf8FG4gJY1qEYskd8NzHNDkTCV6cejl6D+JRZ1EEiDmqyhDkRXrrsntGXiTBknb2xj1v9AmA
 RfB3TpMczGt/uaJ3Yqabp32Sll62HilqaFYPsuU7b4D0g369L75lkcmIQh14T4k03+GTL67OXBoPV
 OO3SKwnTE2bp3cbi4WFWVL2qgYRzx8j988b9BdbrZ4n+cx2Wpc1zj1n6kpABhk4WZIu2QgGq+mJIl
 XSQExOmWBqeiZCTnwC0JUKK06xsw8jUSsudxg+f3LbaqbjpmESCyIsUNdfY7k3cQa9Rfm5ouCa26w
 iPi83JFY3pJd6QUHEpvqeSLsnRSIA9FymVCqo2L5YCf53BykunPOgEoHFTnU9/1853H6AXv+/D0I5
 B/6fdM+lZG7zw5TAQ7AVg7yCDIZhM0xQIfH6MTqiQjaLolpwd9b0vDZJzXXNJFZszs+vtq7QA0AL4
 /M8Txwignxr2JM1hIBA4OE5Prb0SPnIGQcQPARS/QA7tE4n5VrntmFCT+HQ2YENmwIWBoFf9o0Hmp
 jD+1OH/gfsopCRbCPjQAVVogv4rD3ZJCORVe0RVWcCUrjL/ys/cq1G9pf3VyytOry8SZ6r+57bCNR
 6vXUyJSuQRiiFAQvSFhQO1s6qEcDQtiKIwJ3kMiiE=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DEL-00027t-O5; Thu, 25 May 2023 16:50:25 +0100
Message-ID: <05abb096-47b3-dfe8-9739-bee5a7fc3d63@ilande.co.uk>
Date: Thu, 25 May 2023 16:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost
 <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230519084734.220480-1-shentey@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230519084734.220480-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/2] PC: Create RTC controllers in south bridges
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 19/05/2023 09:47, Bernhard Beschow wrote:

> This series contains two patches originating from the PIIX consolidation series
> [1]. Since the two patches represent general PC code modernization (ICH9 is
> modernized as well) and since the PIIX consolidation series is still under
> discussion it made sense to split off these patches.
> 
> Testing done:
> * `make check`
> * `make check-avocado`
> 
> [1] https://lore.kernel.org/qemu-devel/20230518172747-mutt-send-email-mst@kernel.org/
> 
> Bernhard Beschow (2):
>    hw/i386/pc: Create RTC controllers in south bridges
>    hw/i386/pc: No need for rtc_state to be an out-parameter
> 
>   include/hw/i386/pc.h          |  2 +-
>   include/hw/southbridge/ich9.h |  2 ++
>   include/hw/southbridge/piix.h |  3 +++
>   hw/i386/pc.c                  | 16 +++++++++++++---
>   hw/i386/pc_piix.c             | 10 +++++++++-
>   hw/i386/pc_q35.c              |  4 +++-
>   hw/isa/lpc_ich9.c             |  8 ++++++++
>   hw/isa/piix3.c                | 15 +++++++++++++++
>   hw/isa/Kconfig                |  2 ++
>   9 files changed, 56 insertions(+), 6 deletions(-)

These look good to me:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


