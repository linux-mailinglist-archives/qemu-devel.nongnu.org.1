Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D4706F27
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKjS-00069t-Ln; Wed, 17 May 2023 13:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzKjQ-00069l-S2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzKjO-00061D-Ij
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684343669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2S5KswpQaDdvOWJlFwe0hnuR1eN0vc6qt0NyzVd+xIg=;
 b=AAEe3uqHJYi8RHlngmH6F9/5jHhIlZjVvIzKqqwzZXF456DOCPUO9u2GFAoNQIkLd+tj1f
 CnF2nBBprLeO06qaJ34/bZaC4cMiJadPjERSzBpv3tdtG0YQo3JBodvIvPI6rDuIIr8vs8
 /Atnn91VYyG+cPD6L8OTKJ4+fYt2ZQg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-_xCTibDRNtO8Uc8h2JikqA-1; Wed, 17 May 2023 13:14:27 -0400
X-MC-Unique: _xCTibDRNtO8Uc8h2JikqA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5309b380b41so579390a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684343667; x=1686935667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2S5KswpQaDdvOWJlFwe0hnuR1eN0vc6qt0NyzVd+xIg=;
 b=helZZcDSmcAEHQD9bwTyBIJdlhTomor0XsmWvZfWPFayWjLjtL9IvW9mBFakloamjr
 tDTgmnnCkFz6KQjhynVHINHSYw/rIuYHcZtCv88PVHZCxln8vUYQ/TqYxEwJE4D5U7/y
 Sls7s8olLAPuvgW0n201L0KW9DmITJFetAQcNUt0+HUI/y75kgGaGP3BOMWgJ3Q+G41b
 MVhB9VNmtvpTr/3h0NfLsw0S/0YBHPZ/e9TOz0Xd3PO1/uQN4EfAvqmJCGMzytTAunBd
 XDwv+EIjeBovvR1jdDHZ9X71832ozIUTwNX2RiIz82VkMNY/gxH8Dz6Q+ALV9PsjtCjO
 xQhA==
X-Gm-Message-State: AC+VfDw2rx9OS77jFUNH0GEMGzntjyL9jBkMaTmUpxv4wtenh9Q3NOfi
 QYS+eDxh4F08+WfL21xH37i43noL1UO79CdGsS/Li0Ikl20VTjLGrYiI1mi2WXhYZKZHWWz67HX
 VOfJOVhyVJxUK6Owsz1UMVOkL+ECj6lM=
X-Received: by 2002:a17:902:be01:b0:1a8:1c9a:f68 with SMTP id
 r1-20020a170902be0100b001a81c9a0f68mr41422909pls.36.1684343666869; 
 Wed, 17 May 2023 10:14:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SamikufbWiWdgRE3I3oNnQHUcEAb0UEXhWJQA5Tri/H5YHf/6h4r7lTrZyr9xxTNktJg7mbxvLhfmn820uN4=
X-Received: by 2002:a17:902:be01:b0:1a8:1c9a:f68 with SMTP id
 r1-20020a170902be0100b001a81c9a0f68mr41422892pls.36.1684343666577; Wed, 17
 May 2023 10:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132124.670840-1-nks@flawful.org>
 <20230428132124.670840-2-nks@flawful.org>
In-Reply-To: <20230428132124.670840-2-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 13:14:15 -0400
Message-ID: <CAFn=p-bSHeJJ6q9Zk8HP3PABwvJbHv1-HLRYbJ9iSLa7DHKqqg@mail.gmail.com>
Subject: Re: [PATCH 1/9] hw/ide/ahci: remove stray backslash
To: Niklas Cassel <nks@flawful.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Fri, Apr 28, 2023 at 9:22=E2=80=AFAM Niklas Cassel <nks@flawful.org> wro=
te:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> This backslash obviously does not belong here, so remove it.

Reviewed-by: John Snow <jsnow@redhat.com>

>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  hw/ide/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 55902e1df7..a36e3fb77c 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -690,7 +690,7 @@ static void ahci_reset_port(AHCIState *s, int port)
>
>      s->dev[port].port_state =3D STATE_RUN;
>      if (ide_state->drive_kind =3D=3D IDE_CD) {
> -        ahci_set_signature(d, SATA_SIGNATURE_CDROM);\
> +        ahci_set_signature(d, SATA_SIGNATURE_CDROM);
>          ide_state->status =3D SEEK_STAT | WRERR_STAT | READY_STAT;
>      } else {
>          ahci_set_signature(d, SATA_SIGNATURE_DISK);
> --
> 2.40.0
>


