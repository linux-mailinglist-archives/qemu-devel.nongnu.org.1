Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D14736AA7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZFU-0000vo-H1; Tue, 20 Jun 2023 07:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBZFL-0000Qv-5Q; Tue, 20 Jun 2023 07:10:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBZFF-0004lx-WD; Tue, 20 Jun 2023 07:10:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 41FFE74638A;
 Tue, 20 Jun 2023 13:09:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 12D4E746377; Tue, 20 Jun 2023 13:09:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1169D745720;
 Tue, 20 Jun 2023 13:09:44 +0200 (CEST)
Date: Tue, 20 Jun 2023 13:09:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/spapr: Test whether TCG is enabled with
 tcg_enabled()
In-Reply-To: <20230620074802.86898-1-philmd@linaro.org>
Message-ID: <bdab30e6-a661-0a28-eb5c-2868a842a711@eik.bme.hu>
References: <20230620074802.86898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1623651901-1687259384=:73461"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1623651901-1687259384=:73461
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 20 Jun 2023, Philippe Mathieu-Daudé wrote:
> Although the PPC target only supports the TCG and KVM
> accelerators, QEMU supports more. We can no assume that

Typo: -> can not assume

Regards,
BALATON Zoltan

> '!kvm == tcg', so test for the correct accelerator. This
> also eases code review, because here we don't care about
> KVM, we really want to test for TCG.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/ppc/spapr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index dcb7f1c70a..c4b666587b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2524,7 +2524,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>     int ret;
>     unsigned int smp_threads = ms->smp.threads;
>
> -    if (!kvm_enabled() && (smp_threads > 1)) {
> +    if (tcg_enabled() && (smp_threads > 1)) {
>         error_setg(errp, "TCG cannot support more than 1 thread/core "
>                    "on a pseries machine");
>         return;
>
--3866299591-1623651901-1687259384=:73461--

