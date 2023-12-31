Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25224820BEB
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 17:03:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJyFm-0006zw-JG; Sun, 31 Dec 2023 11:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rJyFb-0006zJ-GY
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 11:01:19 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rJyFZ-0005PU-MM
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 11:01:19 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 05264756094;
 Sun, 31 Dec 2023 17:01:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pqj7BqPQsqTo; Sun, 31 Dec 2023 17:01:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1F27E75607B; Sun, 31 Dec 2023 17:01:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1DC0F756066;
 Sun, 31 Dec 2023 17:01:09 +0100 (CET)
Date: Sun, 31 Dec 2023 17:01:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH 1/8] vga: remove unused macros
In-Reply-To: <20231231093918.239549-2-pbonzini@redhat.com>
Message-ID: <7ed77225-bd72-9cf1-bd57-eec34d6226c0@eik.bme.hu>
References: <20231231093918.239549-1-pbonzini@redhat.com>
 <20231231093918.239549-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Sun, 31 Dec 2023, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/display/vga.c | 14 --------------
> 1 file changed, 14 deletions(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 37557c3442a..18d966ecd3e 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -103,12 +103,6 @@ const uint8_t gr_mask[16] = {
> #define PAT(x) (x)
> #endif

While at it you could also move this definiton dows to where it's used so 
it's clear where it's needed.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> -#if HOST_BIG_ENDIAN
> -#define BIG 1
> -#else
> -#define BIG 0
> -#endif
> -
> #if HOST_BIG_ENDIAN
> #define GET_PLANE(data, p) (((data) >> (24 - (p) * 8)) & 0xff)
> #else
> @@ -134,14 +128,6 @@ static const uint32_t mask16[16] = {
>     PAT(0xffffffff),
> };
>
> -#undef PAT
> -
> -#if HOST_BIG_ENDIAN
> -#define PAT(x) (x)
> -#else
> -#define PAT(x) cbswap_32(x)
> -#endif
> -
> static uint32_t expand4[256];
> static uint16_t expand2[256];
> static uint8_t expand4to8[16];
>

