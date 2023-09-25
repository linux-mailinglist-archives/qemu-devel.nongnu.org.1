Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E37AE021
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkreL-0004NH-AS; Mon, 25 Sep 2023 15:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qkreH-0004MM-4B
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qkreE-00072P-Ia
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695671617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIAJnKys778E1s7HgJuzrIgW8GJPn0NnFTWsTTTGebo=;
 b=dVenjliz/8LMTHub/xQZwzQ0WabuF3ms1V1Q7m2nKD4CJUZsdz/mHFnPxLwq+WEcgKHXni
 CwuRVz5mZhIQiqFYBXZFgeyQvg1cdOgeLSVQkmINcHveYzNCN3ihZyrDkroiGUSIYxX3SJ
 ml/ab77pQE8KgxWfp4oIgSNGRV1YO80=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Xy2ARMkqNVazOsGVqpHIhw-1; Mon, 25 Sep 2023 15:53:35 -0400
X-MC-Unique: Xy2ARMkqNVazOsGVqpHIhw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2775642edfcso3025529a91.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 12:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695671614; x=1696276414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIAJnKys778E1s7HgJuzrIgW8GJPn0NnFTWsTTTGebo=;
 b=kgsWwZX3LuhfdHDbh4d4snhIv5ql58GI9wq60xs/Od8Yt8rwyDKtV/EGUNL9DlZe+V
 AgvVDowDtAE5QHDIOm/PJdEsMD0hn9tXKlW6sFV/n0vaykeyjJsI1QykQ3tB7D3L3rON
 60srTwmpfk5M7AqxCqYLais86/pxNiQjkA3ijyrrpTYu042Y4wXIRSvZK67I1mlncqny
 GADIKaToRUtcpKJklwFeSRiK2voizRCRQigJzR6rNT1ITOANg/npzVnRmUP17KxuS76P
 gIBoLhywqDnyO9r22NuGq21K4ka4ElpLkp635MOIDwLqbBv2AtOU91p8fB7UJfup0H6M
 hSbg==
X-Gm-Message-State: AOJu0YwMO1NX6lBFD36WOX3zYNTXusUvzmEmQLeExmg/Eb9CjHzWqYxt
 gAPk0bCadQrfN/FKeUHzixQBHB4gAEs5VM/sPF4o1fdcpJQTM1O2FKeJVAJ4pV2MiJng5DqnQd0
 j/4wg+BH/PHPWsInnGTlOkg+2/DC2sb4=
X-Received: by 2002:a17:90b:716:b0:274:4e9b:7a1a with SMTP id
 s22-20020a17090b071600b002744e9b7a1amr5304815pjz.44.1695671614246; 
 Mon, 25 Sep 2023 12:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCopf67MfmrK13j+KzRk9GX2BoU5fYvH0+jNcpZp9vFom5BjPwxH8omd1gQMpmofg8hAftZpGKBW+RKTABNjg=
X-Received: by 2002:a17:90b:716:b0:274:4e9b:7a1a with SMTP id
 s22-20020a17090b071600b002744e9b7a1amr5304807pjz.44.1695671613991; Mon, 25
 Sep 2023 12:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
In-Reply-To: <20230921160712.99521-2-simon.rowe@nutanix.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 25 Sep 2023 15:53:23 -0400
Message-ID: <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
To: Niklas Cassel <niklas.cassel@wdc.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, f.ebner@proxmox.com, 
 Simon Rowe <simon.rowe@nutanix.com>, Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Niklas, I'm sorry to lean on you here a little bit - You've been
working on the SATA side of this a bit more often, can you let me know
if you think this patch is safe?

I'm not immediately sure what the impact of applying it is, but I have
some questions about it:

(1) When does ide_dma_cb get invoked when DRQ_STAT is set but the
return code we were passed is not < 0, and

(2) what's the impact of just *not* executing the end-of-transfer
block here; what happens to the state machine?

On Thu, Sep 21, 2023 at 12:07=E2=80=AFPM Simon Rowe <simon.rowe@nutanix.com=
> wrote:
>
> When an IDE controller is reset, its internal state is being cleared
> before any outstanding I/O is cancelled. If a response to DMA is
> received in this window, the aio callback will incorrectly continue
> with the next part of the transfer (now using sector 0 from
> the cleared controller state).

Eugh, yikes. It feels like we should fix the cancellation ... I'm
worried that if we've reset the state machine and we need to bail on a
DMA callback that the heuristics we use for that will eventually be
wrong, unless I am mistaken and this is totally safe and reliable for
a reason I don't intuitively see right away.

Thoughts?

>
> For a write operation, this results in user data being written to the
> MBR, replacing the first stage bootloader and/or partition table. A
> malicious user could exploit this bug to first read the MBR and then
> rewrite it with user-controller bootloader code.

Oh, good.

>
> This addresses the bug by checking if DRQ_STAT is still set in the DMA
> callback (as it is otherwise cleared at the start of the bus
> reset). If it is not, treat the transfer as ended.
>
> This only appears to affect SATA controllers, plain IDE does not use
> aio.
>
> Fixes: CVE-2023-5088
> Signed-off-by: Simon Rowe <simon.rowe@nutanix.com>
> Cc: Felipe Franciosi <felipe@nutanix.com>
> ---
>  hw/ide/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index b5e0dcd29b..826b7eaeeb 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -906,8 +906,12 @@ static void ide_dma_cb(void *opaque, int ret)
>          s->nsector -=3D n;
>      }
>
> -    /* end of transfer ? */
> -    if (s->nsector =3D=3D 0) {
> +    /*
> +     * End of transfer ?
> +     * If a bus reset occurs immediately before the callback is invoked =
the
> +     * bus state will have been cleared. Terminate the transfer.
> +     */
> +    if (s->nsector =3D=3D 0 || !(s->status & DRQ_STAT)) {
>          s->status =3D READY_STAT | SEEK_STAT;
>          ide_bus_set_irq(s->bus);
>          goto eot;
> --
> 2.22.3
>


