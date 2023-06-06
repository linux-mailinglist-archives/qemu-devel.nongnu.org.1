Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D4723400
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 02:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6KQm-0006u3-Kb; Mon, 05 Jun 2023 20:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6KQk-0006s6-0z
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 20:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6KQi-0007c4-7G
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 20:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686010806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wj9Fwq4mh8yHBLsGINQEnUPuez7EX0WixRTnsz1cZ3k=;
 b=PtRhDz4FpI7zUHWyT106WvFl3JVgYJkKg5qEBP4426/cHqUUOvfkvSPGjiBq16JdPT17n1
 GrZPu26su50f3iPD2Rc/htS9qgh9osbFXOrqw40+y9U/hl86sVijSO4MTYcmFdSjhJS1Xp
 DP9aSku6XLPRRo5WkSeihndtWwq2oXw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Mc4Z69XSOmCnWvpE9t3efg-1; Mon, 05 Jun 2023 20:19:55 -0400
X-MC-Unique: Mc4Z69XSOmCnWvpE9t3efg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1b1bd4fcc22so15208705ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 17:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686010795; x=1688602795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wj9Fwq4mh8yHBLsGINQEnUPuez7EX0WixRTnsz1cZ3k=;
 b=ibIS0lnEa+/1ohVbeiEgg+UJpeOTC48DPYk1pb8rsGoW0f8NhLRqVyZ/E9gBQPjyQM
 Uc1LxfWvQCaZemb0/jQMxJABRwdmtebnV00WaIZ+xQpppXsd1OPwKiPyK0cRQSGDinaT
 BkG6b5wVik2UALCiXi/146ZrMc1/W9slPmZ+yal3b7jOg+pzFv4NMd4kYyUK2yz1mSP+
 CpYadVL6fjK8V2gfwAYfrhIyC3AmaWRPkafpm5tyLHaBUug4wjiD5GsTmBvwG9C1EMg8
 QkmO49csjUKFVfYIsvbZDtyDAujZ5Ecs9L8k0Z1LrH0JdrBUptxpBpuMUqHHzuu424vW
 6U8w==
X-Gm-Message-State: AC+VfDxcPsQLPyWVyw7kgigfr26L/8OqkpZ4o5dD7uVGt6nP/uc5259R
 Z3yXZBR3fLDjDelfLLgTB8QzRhWoC7+NUgEzaC3LCWJsg/mFCHAw/7aOrdY/rpkFb5jtAWE1wgO
 OJvFr9P56siT4NYNHfJSFYgdxNs8Q97I=
X-Received: by 2002:a17:902:e542:b0:1b1:8292:18c6 with SMTP id
 n2-20020a170902e54200b001b1829218c6mr304755plf.65.1686010794802; 
 Mon, 05 Jun 2023 17:19:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5g5Z/KKatOhN2aZBckTC9JryRiusIoq7ynV6ILdWcnodR2pRpk4Q5UrMqgu0olsD9yoNUVphwujkUN+zlCvro=
X-Received: by 2002:a17:902:e542:b0:1b1:8292:18c6 with SMTP id
 n2-20020a170902e54200b001b1829218c6mr304746plf.65.1686010794491; Mon, 05 Jun
 2023 17:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230601134434.519805-1-nks@flawful.org>
 <20230601134434.519805-6-nks@flawful.org>
In-Reply-To: <20230601134434.519805-6-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 5 Jun 2023 20:19:43 -0400
Message-ID: <CAFn=p-Zy_Sg1GwzmNUS1WwGTDR2kvxoz8_=9KC9Y_r2Ckd5siA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] hw/ide/ahci: PxCI should not get cleared when
 ERR_STAT is set
To: Niklas Cassel <nks@flawful.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 1, 2023 at 9:46=E2=80=AFAM Niklas Cassel <nks@flawful.org> wrot=
e:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> For NCQ, PxCI is cleared on command queued successfully.
> For non-NCQ, PxCI is cleared on command completed successfully.
> Successfully means ERR_STAT, BUSY and DRQ are all cleared.
>
> A command that has ERR_STAT set, does not get to clear PxCI.
> See AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and RegFIS:ClearCI,
> and 5.3.16.5 ERR:FatalTaskfile.
>
> In the case of non-NCQ commands, not clearing PxCI is needed in order
> for host software to be able to see which command slot that failed.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

This patch causes the ahci test suite to hang. You might just need to
update the AHCI test suite.

"make check" will hang on the ahci-test as of this patch.

--js

> ---
>  hw/ide/ahci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 3deaf01add..1237f94ddc 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1518,7 +1518,8 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, ui=
nt8_t slot)
>  {
>      IDEState *ide_state =3D &ad->port.ifs[0];
>
> -    if (!(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
> +    if (!(ide_state->status & ERR_STAT) &&
> +        !(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
>          ad->port_regs.cmd_issue &=3D ~(1 << slot);
>      }
>  }
> @@ -1527,6 +1528,7 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, ui=
nt8_t slot)
>  static void ahci_cmd_done(const IDEDMA *dma)
>  {
>      AHCIDevice *ad =3D DO_UPCAST(AHCIDevice, dma, dma);
> +    IDEState *ide_state =3D &ad->port.ifs[0];
>
>      trace_ahci_cmd_done(ad->hba, ad->port_no);
>
> @@ -1543,7 +1545,8 @@ static void ahci_cmd_done(const IDEDMA *dma)
>       */
>      ahci_write_fis_d2h(ad, true);
>
> -    if (ad->port_regs.cmd_issue && !ad->check_bh) {
> +    if (!(ide_state->status & ERR_STAT) &&
> +        ad->port_regs.cmd_issue && !ad->check_bh) {
>          ad->check_bh =3D qemu_bh_new_guarded(ahci_check_cmd_bh, ad,
>                                             &ad->mem_reentrancy_guard);
>          qemu_bh_schedule(ad->check_bh);
> --
> 2.40.1
>


