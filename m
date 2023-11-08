Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0097E51D1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 09:19:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0dlU-0002rv-EK; Wed, 08 Nov 2023 03:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dlN-0002kb-C9; Wed, 08 Nov 2023 03:18:15 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dlK-0000cv-Qn; Wed, 08 Nov 2023 03:18:12 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d9a518d66a1so6837918276.0; 
 Wed, 08 Nov 2023 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699431489; x=1700036289; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+xR3Hz8s6Kk20CvfyDIid5CCdY/fplNkYiYxjDOteM=;
 b=eECcERvO2a679AqaVTBaoEwR/57DajpTd/5SD3zwNEhmsyp6lSYOUCK25JKgMFCgI4
 dSoa4Zgm8sZnk2C/Lxli16XCwmfBUbAevsfujK1ItndpqZ6dlINu6s11FgY2j8I4U5VR
 PJ5GbKk9rsFwlfvxc1JpY9bWxzQdDbsnViM2WG2PB1ZqFc1ahkJPi0pHSYYyMUGLnIWn
 WSoHMzX/JEBuNQOU2uRBUb+3JW/Mn85XVl1H6dPBDq/fpTL1fc9lqQF8uq2DAKm5GQVa
 UwLd9N5GtTDTLqqOcnTy9X3imqugbd5QNdjNmfBWoFliCgWTOCUs/ZyKaUHvGFwYhtYr
 AIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699431489; x=1700036289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+xR3Hz8s6Kk20CvfyDIid5CCdY/fplNkYiYxjDOteM=;
 b=Rwt3j8yLpsmcLaXmCd2jBDsVhJ4Z8kz40OV+jKaBErLqA5vUDM4f2qcREK53aEHahu
 s1S6hfxpsyFPeWkqdtlweTk9K490ZmCgJF3yv+Bq7pwkDFBF4WoF4SJCwdCKiz0Pu6jQ
 qL9u+u3qvagfWU3b4HJ/dhJ+mR2E/Hik+xuwdCEJ/KLGh53KUpc10P+s4bTzTI6Dn6D5
 Yc7g9YQkc14jSrKVQv6fa/wzvtPCj9eIlMqtqkJoKq1+jTl1ql1pVMMLds0Z2V/AB4VJ
 PVQ2jpuCgfJnu0OYB9X3BkvH1lC8sPgpFNlP1mMTEyvIHvdCTOPtP/SgNriLA4wSUVA1
 ZoeQ==
X-Gm-Message-State: AOJu0YzmqSoDv4Z9vH37nMgvIXjCGVLGeJFOlfJ+57ynEXJChhB02ACj
 9ywxg/Ikylrk3dWepPL1D/QOZEhddHnwegkIxy4=
X-Google-Smtp-Source: AGHT+IGNZ2tOOkI3iW4jGkytJdOS0yBNoMf1QZqmIVi9kqyx6FPIZ0+RuP/yls4/KwkLhddtJ4EuhvvrRM3IwXQPxKk=
X-Received: by 2002:a25:73cf:0:b0:d9b:ea48:e5c8 with SMTP id
 o198-20020a2573cf000000b00d9bea48e5c8mr1126333ybc.59.1699431489053; Wed, 08
 Nov 2023 00:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20231107142048.22422-1-frankja@linux.ibm.com>
 <20231107142048.22422-5-frankja@linux.ibm.com>
In-Reply-To: <20231107142048.22422-5-frankja@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Nov 2023 12:17:58 +0400
Message-ID: <CAJ+F1C+fMoRJr9DovZ-RG-sz+Kk43pg9h+9uvej+42XkRCErvw@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/s390x/arch_dump: Add arch cleanup function for
 PV dumps
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, 
 imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi

On Tue, Nov 7, 2023 at 6:22=E2=80=AFPM Janosch Frank <frankja@linux.ibm.com=
> wrote:
>
> PV dumps block vcpu runs until dump end is reached. If there's an
> error between PV dump init and PV dump end the vm will never be able
> to run again. One example of such an error is insufficient disk space
> for the dump file.
>
> Let's add a cleanup function that tries to do a dump end. The dump
> completion data is discarded but there's no point in writing it to a
> file anyway if there's a possibility that other PV dump data is
> missing.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/arch_dump.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
> index bdb0bfa0e7..70146d7e84 100644
> --- a/target/s390x/arch_dump.c
> +++ b/target/s390x/arch_dump.c
> @@ -433,6 +433,22 @@ static int arch_sections_write(DumpState *s, uint8_t=
 *buff)
>      return 0;
>  }
>
> +static void arch_cleanup(DumpState *s)
> +{
> +    uint8_t *buff =3D g_malloc(kvm_s390_pv_dmp_get_size_completion_data(=
));
> +    int rc;
> +
> +    if (!pv_dump_initialized || !buff) {

this may leak if bluff !=3D NULL && !pv_dump_initialized

Better use g_autofree.

No need to check bluff !=3D NULL. (g_malloc abort() if it failed)

> +        return;
> +    }
> +
> +    rc =3D kvm_s390_dump_completion_data(buff);
> +    if (!rc) {
> +            pv_dump_initialized =3D false;
> +    }
> +    g_free(buff);
> +}
> +
>  int cpu_get_dump_info(ArchDumpInfo *info,
>                        const struct GuestPhysBlockList *guest_phys_blocks=
)
>  {
> @@ -448,6 +464,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>          info->arch_sections_add_fn =3D *arch_sections_add;
>          info->arch_sections_write_hdr_fn =3D *arch_sections_write_hdr;
>          info->arch_sections_write_fn =3D *arch_sections_write;
> +        info->arch_cleanup_fn =3D *arch_cleanup;
>      }
>      return 0;
>  }
> --
> 2.34.1
>
>

otherwise, seems ok

--=20
Marc-Andr=C3=A9 Lureau

