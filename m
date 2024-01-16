Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 036BF82F227
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:11:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPm1D-0004RO-Dq; Tue, 16 Jan 2024 11:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPm10-0004Q4-Ib
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:10:15 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPm0v-0007rn-NE
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:10:12 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-559bd483877so645793a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705421408; x=1706026208; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YB/RBeiYddIiM/8+ZagZoA9BHxq5ONfZJ3BXL6Zus64=;
 b=y2525K9cCUqekDjjJSYhLjyEPw3hjwWJgnYWyU9ACNxlfvA4e0/L3SKeoilFjwjkkP
 oKmXUytk5xwbhqHPcfhsooPZa1Ym12cAYWWfgL0Ns8oI7IiZyVvENkWO66jFcFnUlK4f
 6cCu2lTrnXkEfnkEibAuoMK4XoDcBU6L4vLUdU5Zx19vzZyCpPM5iiNsOOFacQIqtvpT
 4kg/wMsR2U/w2aYBPeK4k/0EAfSHHrnuykcEnQSXWS6EOs7i/Xo3R9cjpLoAJOAPmYcQ
 K6iXP1zzLHCW/4oKXIAtvtw4PhdMc8YxKqVZJlpwureiimmeRMAX+KfT0GKBe4n/42to
 k4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705421408; x=1706026208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YB/RBeiYddIiM/8+ZagZoA9BHxq5ONfZJ3BXL6Zus64=;
 b=vQxhvRnSz2tjoPVvCKBT1BrXJlU6LbkejOwv0Um//vqrPg3kWfypZ0X+uXcABWqmbl
 PKXpQflwG6HJPL30KL5BoF13jv3u94o1f2BRxfIDoQD0Is2KRg0w1snwW2IscTNUp+uj
 AQjsaQwwD+PnF9vNQLp4GFr8NdOopTMJuUJQPXceAd7qStVBYcOhkVh8+CoqT0cpcuTe
 WJbhuSZMWDbTvf1WJgA4sAeVdTdUmi6zb+JQWBSQg0Og8EVEdfgEE5ldzmkFFLv4tHwd
 oeicbqfOVMtBM0OF0x7b78Ge9R5onjNNrnv8p6Rgn5Y8ok48pY8oP11d5TSCW4wPN2Rp
 c6SQ==
X-Gm-Message-State: AOJu0YwLXXcINBp5w4Zq5e9ItFLk1YTLt1zxVLDlRbt6wWxVD+hbQPo6
 WdHELY6Cn3DQ0tvSXIEwkfI2Wlb66ZCAkYPKQ3zyvkCL2sZsig==
X-Google-Smtp-Source: AGHT+IE/x6U73+k7rqC8r+I5syaOrJW2ax3HYvL/WCchgfa9Nm8rHZFQU44akC5nEWWqhjhPD2/oHHPScFc0mfwVE58=
X-Received: by 2002:aa7:c993:0:b0:558:4a2:42af with SMTP id
 c19-20020aa7c993000000b0055804a242afmr3810531edt.10.1705421407666; Tue, 16
 Jan 2024 08:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20240108125342.48298-1-philmd@linaro.org>
 <20240108125342.48298-3-philmd@linaro.org>
 <39ff1c41-c7ea-4cdc-ab18-b299b91cafb8@linaro.org>
 <CAFEAcA8ZMHwKeEmwakt9BHt5Z_0DihYXtfTP-sOSBnt2dv6hWg@mail.gmail.com>
 <4b7fe91d-9e96-4de4-af6f-c9be81c43ab1@linaro.org>
In-Reply-To: <4b7fe91d-9e96-4de4-af6f-c9be81c43ab1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 16:09:56 +0000
Message-ID: <CAFEAcA-xPF0OoG4Whmao7nUwEdJL1cO3BxX--8bLcEp2m_hi_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/pflash: implement update buffer for block writes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 16 Jan 2024 at 16:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 12/1/24 17:54, Peter Maydell wrote:
> > On Mon, 8 Jan 2024 at 13:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
> >>
> >> Hi Gerd,
> >>
> >> On 8/1/24 13:53, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> From: Gerd Hoffmann <kraxel@redhat.com>
> >>>
> >>> Add an update buffer where all block updates are staged.
> >>> Flush or discard updates properly, so we should never see
> >>> half-completed block writes in pflash storage.
> >>>
> >>> Drop a bunch of FIXME comments ;)
> >>>
> >>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >>> Message-ID: <20240105135855.268064-3-kraxel@redhat.com>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>>    hw/block/pflash_cfi01.c | 106 ++++++++++++++++++++++++++++++------=
----
> >>>    1 file changed, 80 insertions(+), 26 deletions(-)
>
>
> >>> +static const VMStateDescription vmstate_pflash_blk_write =3D {
> >>> +    .name =3D "pflash_cfi01_blk_write",
> >>> +    .version_id =3D 1,
> >>> +    .minimum_version_id =3D 1,
> >>> +    .needed =3D pflash_blk_write_state_needed,
> >>> +    .fields =3D (const VMStateField[]) {
> >>> +        VMSTATE_VBUFFER_UINT32(blk_bytes, PFlashCFI01, 0, NULL, writ=
eblock_size),
> >>
> >> I don't get the difference with VMSTATE_VBUFFER_ALLOC_UINT32() which
> >> sets VMS_ALLOC. In this case pflash_cfi01_realize() does the alloc so
> >> we don't need VMS_ALLOC?
> >
> > Yes, that's the idea. A VMS_ALLOC vmstate type means "this
> > block of memory is dynamically sized at runtime, so when the
> > migration code is doing inbound migration it needs to
> > allocate a buffer of the right size first (based on some
> > state struct field we've already migrated) and then put the
> > incoming data into it". VMS_VBUFFER means "the size of the buffer
> > isn't a compile-time constant, so we need to fish it out of
> > some other state struct field". So:
> >
> >   VMSTATE_VBUFFER_UINT32: we need to migrate (a pointer to) an array
> >   of uint32_t; the size of that is in some other struct field,
> >   but it's a runtime constant and we can assume the memory has
> >   already been allocated
> >
> >   VMSTATE_VBUFFER_ALLOC_UINT32: we need to migrate an array
> >   of uint32_t of variable size dependent on the inbound migration
> >   data, and so the migration code must allocate it
>
> Thanks Peter!
>
> Do you mind if we commit your explanation as is? As:
>
> -- >8 --
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 294d2d8486..5c6f6c5c32 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -573,4 +573,6 @@ extern const VMStateInfo vmstate_info_qlist;
>
> -/* a variable length array (i.e. _type *_field) but we know the
> - * length
> +/**
> + * VMSTATE_STRUCT_VARRAY_POINTER_KNOWN:
> + *
> + * A variable length array (i.e. _type *_field) but we know the length.
>    */
> @@ -678,2 +680,10 @@ extern const VMStateInfo vmstate_info_qlist;
>
> +/**
> + * VMSTATE_VBUFFER_UINT32:
> + *
> + * We need to migrate (a pointer to) an array of uint32_t; the size of
> + * that is in some other struct field, but it's a runtime constant and
> + * we can assume the memory has already been allocated.
> +*/
> +
>   #define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test,
> _field_size) { \
> @@ -688,2 +698,9 @@ extern const VMStateInfo vmstate_info_qlist;
>
> +/**
> + * VMSTATE_VBUFFER_ALLOC_UINT32:
> + *
> + * We need to migrate an array of uint32_t of variable size dependent
> + * on the inbound migration data, and so the migration code must
> + * allocate it.
> +*/
>   #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
> ---

Gerd is probably a better source of comments for these macros;
there are some things I don't entirely understand about all
the inner workings, so my comments above are restricted to
only the bit that matters for this particular distinction,
and aren't really intended as documentation of the macro in
general.

-- PMM

