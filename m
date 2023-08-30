Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6B78D5E9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 14:36:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbKPP-0002SC-6W; Wed, 30 Aug 2023 08:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qbKPH-0002Ru-4H
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:34:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qbKPD-0007Xw-QY
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:34:46 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B7E69748FF1;
 Wed, 30 Aug 2023 14:34:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 827407456A7; Wed, 30 Aug 2023 14:34:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F5257456AC;
 Wed, 30 Aug 2023 14:34:29 +0200 (CEST)
Date: Wed, 30 Aug 2023 14:34:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 65/67] ppc/kconfig: make SAM460EX depend on PPC &
 PIXMAN
In-Reply-To: <20230830093843.3531473-66-marcandre.lureau@redhat.com>
Message-ID: <cb0e2856-afdc-294b-d111-28be168eeed2@eik.bme.hu>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-66-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1415664129-1693398869=:10171"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1415664129-1693398869=:10171
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 30 Aug 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> SM501 is going to depend on PIXMAN next.

Why is this patch needed when SM501 is the one that depends on PIXMAN and 
should pull in the dependency? Also what's the change in default.mak? 
ati-vga also uses pixman and currently has no fall back. The sm501 already 
has fallback when pixman fails so could work without pixman too, see 
x-pixman property in sm501.c.

Regards,
BALATON Zoltan

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> configs/devices/ppc-softmmu/default.mak | 2 +-
> hw/ppc/Kconfig                          | 2 ++
> 2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
> index a887f5438b..603ed701ed 100644
> --- a/configs/devices/ppc-softmmu/default.mak
> +++ b/configs/devices/ppc-softmmu/default.mak
> @@ -8,7 +8,7 @@ CONFIG_PPC440=y
> CONFIG_VIRTEX=y
>
> # For Sam460ex
> -CONFIG_SAM460EX=y
> +#CONFIG_SAM460EX=n
>
> # For Macs
> CONFIG_MAC_OLDWORLD=y
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 5dfbf47ef5..86d3f5cfca 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -58,6 +58,8 @@ config PPC4XX
>
> config SAM460EX
>     bool
> +    default y
> +    depends on PPC && PIXMAN
>     select PFLASH_CFI01
>     select IDE_SII3112
>     select M41T80
>
--3866299591-1415664129-1693398869=:10171--

