Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC17AF01F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlARq-0007PH-Em; Tue, 26 Sep 2023 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlARl-0007NA-7q
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:58:01 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlARj-0007Wm-1t
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:58:00 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77386822cfbso598083685a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695743876; x=1696348676; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kYKFzWoEnKYI/Yhv73xKwyv9VK4ZSvsLf62P/vflGU=;
 b=BI2oC/qMRQS10gjLIfRdV9QS3y04lnfcBl2tv5rxM8dNtLY/0/wS4zLg6Tl2qBxBri
 oAkZxlsFwa0hgM6h26/MdUT0bb96rNISopgyOfVupaRY+HALWz8I1IgLFY0Afrzjfgbi
 1NuCfg2H+lWdFXyYROW6Jixabau1KMNkkZOIiMfoQgzzcQdX3slvFLyxO4M5DAGIYaYD
 m7JvdFUFxU++0/fPLpp9WcSOTegnBTLDD0/mUl32bCXXqTJUldomhrPn6SWiz8Obrqc5
 RYDMizOza3uYqH8AQhQWsJW9H9X2Omh9oP51/ZzzdKLDYg+FqXTbaj7ZWhvqv/8L+Ghf
 GHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695743876; x=1696348676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kYKFzWoEnKYI/Yhv73xKwyv9VK4ZSvsLf62P/vflGU=;
 b=Fumac7/+Rk3bdww++yfg9yWjA7CUcFLFIAzFIYBKXqg4lk269Ptxo/s4N/zhtDCONY
 43Z7pp/XdUJ+L5IlfYoTED1S/bdFvgro07I/KyAv0yAkPZVrNljlOIv0rQ5DlkJeUX0F
 QlqbkrQ68N60zbf36KXosSllrDv7nWTZ8ui5bvLMxnrLU2E/leDACJTus4nroNuGSHsX
 F4hBbhCxif3S6KLaVaOtfKMB19PGzSty7NI6ewEbkuumk2hqTqn3iOkOG/ILWIIYwBv9
 TeMe99ldEDHWlfvWonLdHBzwaeEkS0elERmh2/S6l6Bm+uMmeYCEZGqWUP1NChjEw8gS
 rqHQ==
X-Gm-Message-State: AOJu0Yx4l+uYuv/MZb7AnnQ3tOc8EDpWkAfmoPgqWEAswhWvPPBmiXmY
 kdd9pfnhEbnhqRPm16K/4xZA53FhcT5nCC4WSkE=
X-Google-Smtp-Source: AGHT+IFPMaWfsvKPpptA3Q1vJzuANCvIdvKdYTl5aYHLHTxF58D1hdtz/xszoTNqtOfbEYfPrT/xXc/MhIlpJz6UcmQ=
X-Received: by 2002:ac8:7c44:0:b0:412:1926:3365 with SMTP id
 o4-20020ac87c44000000b0041219263365mr11835070qtv.47.1695743876094; Tue, 26
 Sep 2023 08:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230926154926.728185-1-pbonzini@redhat.com>
In-Reply-To: <20230926154926.728185-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Sep 2023 19:57:45 +0400
Message-ID: <CAJ+F1CLCn0FaKkFOOOMjeuLVt6mahMsg3+hDLGFAcd3-iO-M-g@mail.gmail.com>
Subject: Re: [PATCH] audio: remove shadowed locals
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On Tue, Sep 26, 2023 at 7:50=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/audio.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index 90c7c49d116..2f479657117 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1706,7 +1706,7 @@ static AudioState *audio_init(Audiodev *dev, const =
char *name)
>      size_t i;
>      int done =3D 0;
>      const char *drvname =3D NULL;
> -    VMChangeStateEntry *e;
> +    VMChangeStateEntry *vmse;
>      AudioState *s;
>      struct audio_driver *driver;
>      /* silence gcc warning about uninitialized variable */
> @@ -1824,8 +1824,8 @@ static AudioState *audio_init(Audiodev *dev, const =
char *name)
>          s->period_ticks =3D dev->timer_period * (int64_t)SCALE_US;
>      }
>
> -    e =3D qemu_add_vm_change_state_handler (audio_vm_change_state_handle=
r, s);
> -    if (!e) {
> +    vmse =3D qemu_add_vm_change_state_handler (audio_vm_change_state_han=
dler, s);
> +    if (!vmse) {
>          dolog ("warning: Could not register change state handler\n"
>                 "(Audio can continue looping even after stopping the VM)\=
n");
>      }
> @@ -1900,10 +1900,8 @@ CaptureVoiceOut *AUD_add_capture(
>      cap =3D audio_pcm_capture_find_specific(s, as);
>      if (cap) {
>          QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
> -        return cap;
>      } else {
>          HWVoiceOut *hw;
> -        CaptureVoiceOut *cap;
>
>          cap =3D g_malloc0(sizeof(*cap));
>
> @@ -1937,8 +1935,9 @@ CaptureVoiceOut *AUD_add_capture(
>          QLIST_FOREACH(hw, &s->hw_head_out, entries) {
>              audio_attach_capture (hw);
>          }
> -        return cap;
>      }
> +
> +    return cap;
>  }
>
>  void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

