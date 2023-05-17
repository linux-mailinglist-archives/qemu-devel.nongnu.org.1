Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F4870740B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 23:20:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzOYN-0007y9-Hd; Wed, 17 May 2023 17:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOYD-0007xZ-A2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOYB-0007dn-Jg
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684358350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObQ7/GNJd0ThM3/akh8idBTpnypKxXecnCNEgqTw0Bw=;
 b=CmZICOcXW7IfvWgPs+gnTcTfvRhPOSgkeQ7lDrrQvSQVUZ7LUpb7PksqEkOQM7w7zMEKpB
 +Cw1yFdQtatf2pThU/dvRIjxoovcVcDIs0cUOqV3hczpZWanujlR+HQVzxct71C/y6Ys+2
 LFfGfp7hlt/9aa5GtzfgWxBB1Zyr51k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-uZ2u-dJ5PEezyViQdxaCGQ-1; Wed, 17 May 2023 17:19:07 -0400
X-MC-Unique: uZ2u-dJ5PEezyViQdxaCGQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-24ffa913678so854839a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 14:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684358346; x=1686950346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObQ7/GNJd0ThM3/akh8idBTpnypKxXecnCNEgqTw0Bw=;
 b=X47ElhPbr13tADNDfHDGj8kf6yvxzn0uJ9sPN9q4ecl83Ywnry6Fnhjo8eebIqKiD/
 pMZLqX7FMJ6WmqZAg5RU9XLL0TNEM41H6G/8j29WPe9XJO0zgi0zFDBpVoWANeOQ33MM
 e+zhi/bRQf5uFK8BzsYkzLtCLHvO26Y+TUEBkC9XjrL09K3iIe42AFpsMQOUBcRDwGRU
 RMUfFK/CHCJvvzqHGxiog71vRKVNYC0iOjywoNXaSJ+b4Jupnsvgd7ZRSx9y8vVIKLFL
 3CsKk+7shetbH839BIfWmGNVjLMmK461M2Wo/4pBh88TaaJnvlKxApLtJEiL3iM9S1fd
 5M0Q==
X-Gm-Message-State: AC+VfDy7723WuL3GP7nHdvD/Jkvhz+mjC7nefyZZxdkI88fJmHp09/Bv
 i5C+tnPqSPNjtDlz8Hx1me3+rqGFUjyCH7Nh52Ndxn7hf59jPL4CLGReidMBipZuqbnQgrwmeSH
 jInA1btZCOlsoD2EBznbDpzMYjLReSrc=
X-Received: by 2002:a17:90a:b94a:b0:24e:1a7:9976 with SMTP id
 f10-20020a17090ab94a00b0024e01a79976mr249239pjw.10.1684358346278; 
 Wed, 17 May 2023 14:19:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CfAnM77chklBQIkwuHAE6ImutP3h8VJoeg5pC4F3EmeS79ISfUlrpHd7WvRA43qvdfXb0qZdWKKonPb4lhJo=
X-Received: by 2002:a17:90a:b94a:b0:24e:1a7:9976 with SMTP id
 f10-20020a17090ab94a00b0024e01a79976mr249224pjw.10.1684358345963; Wed, 17 May
 2023 14:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132124.670840-1-nks@flawful.org>
 <20230428132124.670840-4-nks@flawful.org>
In-Reply-To: <20230428132124.670840-4-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 17:18:54 -0400
Message-ID: <CAFn=p-b4wm2ZaFXnXkm22+tSExjQFWYMTrSy8zG4M-MzuLWtzQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] hw/ide/ahci: write D2H FIS on when processing NCQ
 command
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

On Fri, Apr 28, 2023 at 9:22=E2=80=AFAM Niklas Cassel <nks@flawful.org> wro=
te:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> The way that BUSY + PxCI is cleared for NCQ (FPDMA QUEUED) commands is
> described in SATA 3.5a Gold:
>
> 11.15 FPDMA QUEUED command protocol
> DFPDMAQ2: ClearInterfaceBsy
> "Transmit Register Device to Host FIS with the BSY bit cleared to zero
> and the DRQ bit cleared to zero and Interrupt bit cleared to zero to
> mark interface ready for the next command."
>
> PxCI is currently cleared by handle_cmd(), but we don't write the D2H
> FIS to the FIS Receive Area that actually caused PxCI to be cleared.
>
> Similar to how ahci_pio_transfer() calls ahci_write_fis_pio() with an
> additional parameter to write a PIO Setup FIS without raising an IRQ,
> add a parameter to ahci_write_fis_d2h() so that ahci_write_fis_d2h()
> also can write the FIS to the FIS Receive Area without raising an IRQ.
>
> Change process_ncq_command() to call ahci_write_fis_d2h() without
> raising an IRQ (similar to ahci_pio_transfer()), such that the FIS
> Receive Area is in sync with the PxTFD shadow register.
>
> E.g. Linux reads status and error fields from the FIS Receive Area
> directly, so it is wise to keep the FIS Receive Area and the PxTFD
> shadow register in sync.

I think for some time I wondered if this mattered, because I wasn't
sure when the guest CPU would actually regain control to check an
intermediate state in the memory area before we wrote the next FIS.
But, trusting your quoted blurb, I think this is more obviously
correct.

ACK

(Although, there seems to be a conflict on latest origin/master - can
you rebase, please?)

>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  hw/ide/ahci.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index a36e3fb77c..62aebc8de7 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -43,7 +43,7 @@
>  static void check_cmd(AHCIState *s, int port);
>  static int handle_cmd(AHCIState *s, int port, uint8_t slot);
>  static void ahci_reset_port(AHCIState *s, int port);
> -static bool ahci_write_fis_d2h(AHCIDevice *ad);
> +static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i);
>  static void ahci_init_d2h(AHCIDevice *ad);
>  static int ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit);
>  static bool ahci_map_clb_address(AHCIDevice *ad);
> @@ -618,7 +618,7 @@ static void ahci_init_d2h(AHCIDevice *ad)
>          return;
>      }
>
> -    if (ahci_write_fis_d2h(ad)) {
> +    if (ahci_write_fis_d2h(ad, true)) {
>          ad->init_d2h_sent =3D true;
>          /* We're emulating receiving the first Reg H2D Fis from the devi=
ce;
>           * Update the SIG register, but otherwise proceed as normal. */
> @@ -850,7 +850,7 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint16=
_t len, bool pio_fis_i)
>      }
>  }
>
> -static bool ahci_write_fis_d2h(AHCIDevice *ad)
> +static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i)
>  {
>      AHCIPortRegs *pr =3D &ad->port_regs;
>      uint8_t *d2h_fis;
> @@ -864,7 +864,7 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
>      d2h_fis =3D &ad->res_fis[RES_FIS_RFIS];
>
>      d2h_fis[0] =3D SATA_FIS_TYPE_REGISTER_D2H;
> -    d2h_fis[1] =3D (1 << 6); /* interrupt bit */
> +    d2h_fis[1] =3D d2h_fis_i ? (1 << 6) : 0; /* interrupt bit */
>      d2h_fis[2] =3D s->status;
>      d2h_fis[3] =3D s->error;
>
> @@ -890,7 +890,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
>          ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
>      }
>
> -    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
> +    if (d2h_fis_i) {
> +        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
> +    }
> +
>      return true;
>  }
>
> @@ -1120,6 +1123,8 @@ static void process_ncq_command(AHCIState *s, int p=
ort, const uint8_t *cmd_fis,
>          return;
>      }
>
> +    ahci_write_fis_d2h(ad, false);
> +
>      ncq_tfs->used =3D 1;
>      ncq_tfs->drive =3D ad;
>      ncq_tfs->slot =3D slot;
> @@ -1506,7 +1511,7 @@ static void ahci_cmd_done(const IDEDMA *dma)
>      }
>
>      /* update d2h status */
> -    ahci_write_fis_d2h(ad);
> +    ahci_write_fis_d2h(ad, true);
>
>      if (ad->port_regs.cmd_issue && !ad->check_bh) {
>          ad->check_bh =3D qemu_bh_new(ahci_check_cmd_bh, ad);
> --
> 2.40.0
>


