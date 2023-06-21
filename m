Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B575E73825A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:43:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwEE-0008Nw-Ew; Wed, 21 Jun 2023 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBwDq-0008Ej-09
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:42:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBwDh-0007oz-HH
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:41:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0E66C746E5A;
 Wed, 21 Jun 2023 13:41:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CFE8A74632B; Wed, 21 Jun 2023 13:41:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CE81B746377;
 Wed, 21 Jun 2023 13:41:39 +0200 (CEST)
Date: Wed, 21 Jun 2023 13:41:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 02/24] q800: add missing space after parent object in
 GLUEState
In-Reply-To: <20230621085353.113233-3-mark.cave-ayland@ilande.co.uk>
Message-ID: <2f1b2a44-0d0a-751d-4f3f-2de1f4ce4729@eik.bme.hu>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-245591865-1687347699=:25233"
X-Spam-Probability: 9%
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-245591865-1687347699=:25233
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
> This brings GLUEState in line with our current QOM guidelines.

Are these guidelines documented somewhere? I like this better than the 
public/private comments (although I prefer no space at all with just 
documenting that QOM object parents should not be accessed directly) but I 
haven't seen it discussed and agreed upon so it looks like a convention 
you defined but not documented anywhere. But it could be I missed the 
patch to coding style or QOM docs to establish this convention.

If we really want to make these QOM object states stand out we might even 
consider formatting these as

struct GLUEState { SysBusDevice parent_obj;
     M68kCPU *cpu;
     ...
}

unless checkpatch would not like that or something.

Regards,
BALATON Zoltan

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
> hw/m68k/q800.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index dda57c60bf..465c510c18 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -100,6 +100,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
>
> struct GLUEState {
>     SysBusDevice parent_obj;
> +
>     M68kCPU *cpu;
>     uint8_t ipr;
>     uint8_t auxmode;
>
--3866299591-245591865-1687347699=:25233--

