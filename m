Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E813C72CEB4
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 20:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8mbv-0007cH-3G; Mon, 12 Jun 2023 14:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mbt-0007by-57; Mon, 12 Jun 2023 14:49:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mbr-0004Ll-FF; Mon, 12 Jun 2023 14:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ssSLfPUBUFPcPPZc7SPwhgze+t5ggiIJ4M2VA9CQYvA=; b=B27Lqi58xIvytAhFd2xB2JFQZ+
 /sB003VfPvEQohIK7XlkyjM4jhay1iw9W+ZPJ1iNUWcRLV/MvnTU/9lBmSVTjJGWdhPVRnO4lqDR5
 dgU86Bi0hk44kTCMvdqwSkcj14lVmQkqb9j1mHVvi7Sq53oac0X6tAGzKzgFuu1uM62WRqnjFQvE1
 SEG5VTvqqnbCCbkAhqDlTPFoI99fDMtgCtt9DVvX9DZAYrEEhkpX16gixXl4kiWVnDtT76cbLSPRE
 VmC/hQ5e1Vb9b7iiePR0QMfixrOTYziDi4pnyS5mRlI1ZpFKqzStXH9eUH5a3/4KIeb3cH4YqSX78
 tg3rZdxAwu4aZfGTROC6UpBPovB+tg4IjyFrAY10EYE+QSKx42PBQ/MJeswfHAjGLtpJ6jgF86pQ4
 m2vHKQDbiniYEl9d9WNGyYpzBweNMRYFNEzeY8lHZaVTIr0i6yrQ+cQcWhGff+TFGF3tHM0369lSS
 s5WWsaZK8tWntL6OjGxHNpdS6tsu0PIH+DIBCIWuMv41TVoobQK/ybfKoyrj+a0d8N2oMZ8rpl6y/
 IViSFSiHWApAaaVSZPs5J/o4k6u3a9R/wyGAmDS63FOu+9wqpwei01A7H6y6t+BygsyaZg235nLAq
 km+QFK9CL+BGjWnL01WweaPcefgqF9T1OPCNpqHT8=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mbd-0009Cm-5S; Mon, 12 Jun 2023 19:49:36 +0100
Message-ID: <74c666c7-c207-fe0d-e941-8fdc60f552ad@ilande.co.uk>
Date: Mon, 12 Jun 2023 19:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230612081238.1742-1-shentey@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230612081238.1742-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/2] Export struct ISAParallelState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 12/06/2023 09:12, Bernhard Beschow wrote:

> This series incorporates rebased versions of the ISAParallelState patches of
> [1] as requested by Mark.
> 
> v2:
> * Add forgotten SoB tags (Zoltan, Phil)
> 
> Changes since [1]:
> * Don't export register definitions (Phil)
> * Rephrase commit message of second patch (Zoltan)
> 
> [1] https://patchew.org/QEMU/20230521123049.312349-1-shentey@gmail.com/
> 
> Bernhard Beschow (2):
>    hw/char/parallel: Export struct ParallelState
>    hw/char/parallel-isa: Export struct ISAParallelState
> 
>   include/hw/char/parallel-isa.h | 46 ++++++++++++++++++++++++++++++++++
>   include/hw/char/parallel.h     | 21 +++++++++++++++-
>   hw/char/parallel-isa.c         |  1 +
>   hw/char/parallel.c             | 32 +----------------------
>   hw/i386/pc_piix.c              |  2 +-
>   hw/i386/pc_q35.c               |  2 +-
>   hw/isa/isa-superio.c           |  1 +
>   hw/sparc64/sun4u.c             |  2 +-
>   8 files changed, 72 insertions(+), 35 deletions(-)
>   create mode 100644 include/hw/char/parallel-isa.h

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


