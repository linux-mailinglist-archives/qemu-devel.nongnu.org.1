Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3A7E519F
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 09:05:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0dXj-0004c7-Jh; Wed, 08 Nov 2023 03:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dXi-0004bh-9t; Wed, 08 Nov 2023 03:04:06 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dXf-00069W-9H; Wed, 08 Nov 2023 03:04:05 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7788f727dd7so424786585a.1; 
 Wed, 08 Nov 2023 00:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699430642; x=1700035442; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoU0gWLGPETzujnJTBtBOqd0BejdgAquzqJCAxmjlvg=;
 b=gLt0E5xiftamHPJaRBk1sxZqAw2F0Vbr/s9NtPjHgW8Qc8OUi/XXbJL7qeXYkRHA6s
 Vjl7yu2Ej/PZd9bno2UsbddYqYG0CTD288xQiqfcDSoevmCXB7cGrysbHB2v/ohC94S0
 NIW0wqeVzY5sNETo0Czva0pR8B3E/QlwJj98MFFdPala7DvAcT409I3SsUG2V3pY4uDc
 lhOcI+A0qQFFuAqhKQ3sTSc+D5uMzNWjH84YLcvZACdJGJNSZ2eup3YHVYMs9E4Wobwp
 YBCGPctY4SBntxdPst3OVfVty82hKmnZTGmR+KeKGAWBR5StPTBjNNgBgBzxMBN7ODSh
 8Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699430642; x=1700035442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoU0gWLGPETzujnJTBtBOqd0BejdgAquzqJCAxmjlvg=;
 b=u1MTPkUtQw9iGANRHme7+6z7U523d61S6o6P1/iHhXd7F/05kobLxCPBPT1Vs7dm47
 zMTOxJXAN0COy4aRnm16bXBrSHjLuH0Xr0RF0EsLfQow33/RlaEzzUi4kQ3EpIOhcvJD
 BuVJblmDk5fWmA7K/rigY+R+mfkA+reXpbEuqt9PaHzQvLMK1WRarug/X1tlnhKMFaWH
 9b63WA+rAsdxtwjpe5c3L08kGcOle7M7L+gC6XN5WoWPJ+YS254N+mMf0FxpRixfYdm/
 R7ZLD15PvUPDjGsUHK2inKD2eNjl3DrkqhUqJenr2Ooeid9iWcqHFkvJ10rXPmiL5kPE
 1Qog==
X-Gm-Message-State: AOJu0YxmVJmS0ueyjg6OGESluZ7v3BEwnx1j6gmuo22mF9pZj/Hc3Av8
 B5ahxpbBDt6P8B5vN/8YGS7qpW+bCAJ/N5YARdU=
X-Google-Smtp-Source: AGHT+IHefiXLd/INmchuiZ2Gwae5RQGGLdhK2yxDWgNd1P+EzPT37e3fFiJ0fk5ElSbjp5zcrr7UVibdRqt8ksSFLkw=
X-Received: by 2002:a05:6214:2344:b0:66d:6869:5e62 with SMTP id
 hu4-20020a056214234400b0066d68695e62mr1237527qvb.46.1699430641758; Wed, 08
 Nov 2023 00:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20231107142048.22422-1-frankja@linux.ibm.com>
 <20231107142048.22422-2-frankja@linux.ibm.com>
In-Reply-To: <20231107142048.22422-2-frankja@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Nov 2023 12:03:49 +0400
Message-ID: <CAJ+F1CL2anS58w0bffJGzN_76To30ORafstQYT=REUYa42h+nQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dump: Set dump info function pointers to NULL
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, 
 imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
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
> Better to not rely on the struct zeroing since NULL is not necessarily
> 0.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  dump/dump.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index d355ada62e..1d38274925 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1706,6 +1706,9 @@ static void dump_state_prepare(DumpState *s)
>  {
>      /* zero the struct, setting status to active */
>      *s =3D (DumpState) { .status =3D DUMP_STATUS_ACTIVE };
> +    s->dump_info.arch_sections_add_fn =3D NULL;
> +    s->dump_info.arch_sections_write_hdr_fn =3D NULL;
> +    s->dump_info.arch_sections_write_fn =3D NULL;
>  }

I think we would be in trouble if NULL is not 0. Do you have a better argum=
ent?



--=20
Marc-Andr=C3=A9 Lureau

