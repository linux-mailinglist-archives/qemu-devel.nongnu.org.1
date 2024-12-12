Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49C9EE787
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 14:12:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLiz2-0001So-OK; Thu, 12 Dec 2024 08:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tLiyo-0001ST-Do
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:11:46 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tLiym-00014W-Aq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:11:46 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB69E4E6000;
 Thu, 12 Dec 2024 14:11:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yFPEcJ47vxrT; Thu, 12 Dec 2024 14:11:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B874E4E6076; Thu, 12 Dec 2024 14:11:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B6261746F60;
 Thu, 12 Dec 2024 14:11:38 +0100 (CET)
Date: Thu, 12 Dec 2024 14:11:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Wei Yang <richardw.yang@linux.intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Haozhong Zhang <haozhong.zhang@intel.com>
Subject: Re: [PATCH 2/2] system: Restrict libpmem and libdaxctl CPPFLAGS to
 physmem.c
In-Reply-To: <20241212092632.18538-3-philmd@linaro.org>
Message-ID: <5c323271-8563-342f-35d1-6f9575265f72@eik.bme.hu>
References: <20241212092632.18538-1-philmd@linaro.org>
 <20241212092632.18538-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1470401199-1734009098=:51094"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1470401199-1734009098=:51094
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 12 Dec 2024, Philippe Mathieu-Daudé wrote:
> Only physmem.c includes libpmem and libdaxctl headers.
> No need to pass them to all system_ss[] files.

I think doing this patch first would leave the other one unnecessary so 
you could do both in one patch with less churn and maybe reduce this 
series to a single patch.

Regards,
BALATON Zoltan

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> system/meson.build | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/system/meson.build b/system/meson.build
> index f7e2c8b826f..50d915bd80c 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -2,10 +2,13 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>   'arch_init.c',
>   'ioport.c',
>   'memory.c',
> -  'physmem.c',
>   'watchpoint.c',
> )])
>
> +specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
> +  'physmem.c',
> +), libpmem, libdaxctl])
> +
> system_ss.add(files(
>   'balloon.c',
>   'bootdevice.c',
> @@ -23,7 +26,7 @@ system_ss.add(files(
>   'runstate-hmp-cmds.c',
>   'runstate.c',
>   'tpm-hmp-cmds.c',
> -), libpmem, libdaxctl)
> +))
>
> system_ss.add(files(
>   'vl.c',
>
--3866299591-1470401199-1734009098=:51094--

