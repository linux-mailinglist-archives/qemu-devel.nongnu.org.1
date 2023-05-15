Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7663670308D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:50:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZVu-0007qh-Nc; Mon, 15 May 2023 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tmaillart@freebox.fr>)
 id 1pyZVr-0007jp-I1
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:49:24 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tmaillart@freebox.fr>)
 id 1pyZVp-0000yS-2z
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:49:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-50bd2d7ba74so112292724a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1684162158; x=1686754158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nju3Jftg/AVDDi6UwK1+X3zvy7gPm/PrdljsjoeCPhY=;
 b=TYBg8v+702gMTkYChpm0S0GuGZ10+Nqr0TSrJpoa0GUMRlFPZjh5gJ0xAd7rGGDrE2
 GgI7xT55bzlqQlOF1zwsdko1R2tWGrSUNNrl9ut3BxZ4e2XFtHYlcgrtDs6Pd3/3Quap
 yI9v3Zmzx+94eA0OoO6wg1DRsMat3Zxh3BdUR7d3K5RmsPDhG8t8ugeGyMsGaUL+k6mh
 rM0QGJRQ9RPKyH6wTa31qnZfMiHQlMihMc8RBzs2hHeECUj6sbxtEkB8QWYX620eDIsY
 NKmahju1HpvxDT/F2LXwl/Otkrpenp8B8xQjEeuU+DojzvtzG8dRNzQhkeXUTqFf+9+b
 E0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684162158; x=1686754158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nju3Jftg/AVDDi6UwK1+X3zvy7gPm/PrdljsjoeCPhY=;
 b=UCOd2IGS7RBXojfHEuC49jYjfXQBWRkB1SwmlLhK1CxvBvSId2CQ2kWogyZw1QWY3c
 U9NwDdkQb6EDROOE8H559zWqw7OSrBi9pzAczJS+gNdi3WgJTeSEPvOiGxQ/Y0v654Dv
 DoYxRpn3LedMKI5zfBrP/CFAH6UCCThItzBFLjCvjXL6OIJP37WpF9PfeQiJovOgNbuD
 DQiwGMGJpYgMikXFojJtHwCMLXE4MUYqyLU49r5GGI/aEOBf7uuAMpO2NgQ593bJmmi2
 50QkV4GxHgVvag804l8ixtCw3UG/jSc4MSpe1kpjQ+9njFC2quGpvJV5lJZnStV7u+fL
 gpLQ==
X-Gm-Message-State: AC+VfDzzR1N9TZYJBrQIM3VnW4ddzZDAo2jekz/y0y5zU8V7oGnrmhPt
 nI3NSWtoJjrGhZP8EeJWaw+YyXt0u2bcUUqrf0J2tA==
X-Google-Smtp-Source: ACHHUZ4hpWx3LVyPvMZs7vnGRlPAn1XySDqNP4EtXHiIqlA7D/YZyGnlsz/KbOEf++tsXtO40efjoLx6nL98sVrHmmg=
X-Received: by 2002:a17:907:1691:b0:94e:b3a1:a3d5 with SMTP id
 hc17-20020a170907169100b0094eb3a1a3d5mr31555504ejc.21.1684162158631; Mon, 15
 May 2023 07:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230515135823.382388-1-pbonzini@redhat.com>
In-Reply-To: <20230515135823.382388-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Th=C3=A9o_Maillart?= <tmaillart@freebox.fr>
Date: Mon, 15 May 2023 16:49:07 +0200
Message-ID: <CANDNypxvFYQSeXyFg=wqqHNpghoAoU=FtJYMpZt5QzbXLJ6=jw@mail.gmail.com>
Subject: Re: [PATCH] scsi-generic: fix buffer overflow on block limits inquiry
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=tmaillart@freebox.fr; helo=mail-ed1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

From my perspective r->buflen can be more than 16 bytes, The Block limits V=
PD
page length is 0x3c (paragraph 5.4.5 page 475 from SCSI Commands Reference
Manual, Rev. J).

On Mon, May 15, 2023 at 3:58=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Using linux 6.x guest, at boot time, an inquiry on a scsi-generic
> device makes qemu crash.  This is caused by a buffer overflow when
> scsi-generic patches the block limits VPD page.
>
> Do the operations on a temporary on-stack buffer that is guaranteed
> to be large enough.
>
> Reported-by: Th=C3=A9o Maillart <tmaillart@freebox.fr>
> Analyzed-by: Th=C3=A9o Maillart <tmaillart@freebox.fr>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index ac9fa662b4e3..373fab0a2a61 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -191,12 +191,15 @@ static int scsi_handle_inquiry_reply(SCSIGenericReq=
 *r, SCSIDevice *s, int len)
>      if ((s->type =3D=3D TYPE_DISK || s->type =3D=3D TYPE_ZBC) &&
>          (r->req.cmd.buf[1] & 0x01)) {
>          page =3D r->req.cmd.buf[2];
> -        if (page =3D=3D 0xb0) {
> +        if (page =3D=3D 0xb0 && r->buflen >=3D 8) {

r->buflen > 8 because if r->buflen =3D=3D 8, the final memcpy will be vain =
?

> +            uint8_t buf[16] =3D {};
>              uint64_t max_transfer =3D calculate_max_transfer(s);
> -            stl_be_p(&r->buf[8], max_transfer);
> -            /* Also take care of the opt xfer len. */
> -            stl_be_p(&r->buf[12],
> -                    MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
> +
> +            memcpy(buf, r->buf, r->buflen);

Should be memcpy(buf, r->buf, MIN(r->buflen, 16)); ?

> +            stl_be_p(&buf[8], max_transfer);
> +            stl_be_p(&buf[12], MIN_NON_ZERO(max_transfer, ldl_be_p(&buf[=
12])));
> +            memcpy(r->buf + 8, buf + 8, r->buflen - 8);

Idem memcpy(r->buf + 8, buf + 8, MIN(r->buflen - 8, 8)); ?

> +
>          } else if (s->needs_vpd_bl_emulation && page =3D=3D 0x00 && r->b=
uflen >=3D 4) {
>              /*
>               * Now we're capable of supplying the VPD Block Limits
> --
> 2.40.1
>

