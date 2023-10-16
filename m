Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20C7CAB9E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 16:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsOfV-0002BW-JP; Mon, 16 Oct 2023 10:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qsOfR-00028L-Lk; Mon, 16 Oct 2023 10:34:01 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qsOfP-0008Vn-Vz; Mon, 16 Oct 2023 10:34:01 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so758127566b.1; 
 Mon, 16 Oct 2023 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697466837; x=1698071637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7AmF2ibfSbsLuTd01TRyHljcOYGwQRWQaNrYJOlcmo=;
 b=Rqp0yP8Y5SlXxzSd6/Jq2/GmNI9QoqqaCsD3Zs9ePFSHhCFAkf+q0hDkEvheInMbJW
 uTlKpIpkAPvv/xVGjQ5ZAPTLge8jUJm17Y4VazBbn446Ayy5v05J4Rsv08t5h0nHnIiV
 tJdoTVQgZ9p0Z62MAHEb7DuzZTNotEcq8La09OP0eDu500F3P0Nxy/IHOKyaGLciYvdg
 qjwE7sgeyoC087DL4SO5soc7CEuLThEvGxfdIde5ZSdc2Ga7Rkpp2bpiypXi+NccAuh8
 bUxe1daZCWCNnScin93uZI5G88aHKRaUstku3aOrpnLc32ANQJe4w0OMrBCo48DO2Hxg
 tcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697466837; x=1698071637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7AmF2ibfSbsLuTd01TRyHljcOYGwQRWQaNrYJOlcmo=;
 b=rI7BYJuesuwPmRhiSS6PA7uN/yCNlqCNkjnqd+ARZAtSmCV8A8iLtyUNfuYdLgFVDN
 ZoTaySZxyRH8RSdwGgYkc6InAkJTD2AxNvFNTJhCAmqTR2+variXbIEDjL2wlFuKicbj
 AjCFz4swegWT9Wz8ek4xwvwvcfq/UcuXHbdYb2YzGFYTilr1RLtlEregRsZGenJleqMP
 7EIL8BCF3N29YqWsoUuJLAcW/U2VsDqborlj7qrqKYPWxLejjhCio91cdeZaJmCUKNa9
 x4Fp7qyl9NI5g/zVaGklqpN3h6vXGPeNnuzheLa0pJDJ+EEO5m+OKKKAe3YJznhZJKlL
 5k3g==
X-Gm-Message-State: AOJu0YzkAst13Vj6Xio9cCwUJ/C/Bv9d0sc0IKI8ucxqq1YTV/Zd5EA4
 xP7s7R+wqZbKfedlhQlVii+Fr2P7kamzlBRAs0iO88CgBtI=
X-Google-Smtp-Source: AGHT+IEyXCY54TqN/kJzMiFbGqacvBimcxFF1RuuIapQf8kYeI9oPKJtBqMXH/L6cUBtLQmTDT7tEWG2K7uadqliIo0=
X-Received: by 2002:a17:907:2715:b0:9b2:babd:cd44 with SMTP id
 w21-20020a170907271500b009b2babdcd44mr29266918ejk.44.1697466836351; Mon, 16
 Oct 2023 07:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230825040556.4217-1-faithilikerun@gmail.com>
In-Reply-To: <20230825040556.4217-1-faithilikerun@gmail.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 16 Oct 2023 22:33:29 +0800
Message-ID: <CAAAx-8KYqACA2wfRVud7FQtBRUphvxjF3ZyHGGnF2vu2EEKaAA@mail.gmail.com>
Subject: Re: [PATCH v2] block/file-posix: fix update_zones_wp() caller
To: qemu-devel@nongnu.org
Cc: hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 dlemoal@kernel.org, stefanha@redhat.com, qemu-block@nongnu.org, 
 dmitry.fomichev@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Sam Li <faithilikerun@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=94 12:06=E5=86=99=E9=81=93=EF=BC=9A
>
> When the zoned request fail, it needs to update only the wp of
> the target zones for not disrupting the in-flight writes on
> these other zones. The wp is updated successfully after the
> request completes.
>
> Fixed the callers with right offset and nr_zones.
>
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Ping?

>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b16e9c21a1..55e7f06a2f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2522,7 +2522,8 @@ out:
>          }
>      } else {
>          if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> -            update_zones_wp(bs, s->fd, 0, 1);
> +            /* write and append write are not allowed to cross zone boun=
aries */
> +            update_zones_wp(bs, s->fd, offset, 1);
>          }
>      }
>
> @@ -3472,7 +3473,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDrive=
rState *bs, BlockZoneOp op,
>                          len >> BDRV_SECTOR_BITS);
>      ret =3D raw_thread_pool_submit(handle_aiocb_zone_mgmt, &acb);
>      if (ret !=3D 0) {
> -        update_zones_wp(bs, s->fd, offset, i);
> +        update_zones_wp(bs, s->fd, offset, nrz);
>          error_report("ioctl %s failed %d", op_name, ret);
>          return ret;
>      }
> --
> 2.40.1
>

