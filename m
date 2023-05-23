Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD670D4DE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MMx-0004xY-1l; Tue, 23 May 2023 03:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1MMq-0004xH-RC
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1MMp-0002EX-E1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684826608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCtgPsbTFFBRZNpEHG/pQpYNw6sqfqlI0JhSLOxSGa0=;
 b=MBR82tdsjs7iMcZuthVIXemlFQd8odmT4Qk2kz/n8wEpzo8Vxm4j4R0wlEbFBUpMfg7pcG
 lHwXQ1DA72Fq/6Kx5vjx6/0lJr/L20aEwW+wT0BxYzMGJEcnwiyiG8V70ZsnWKcfBFFBzu
 7M5zxy0A9fT5eNsiS8sedJphM6IU9/A=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-le-8VvFbMu-rCB4K5Qhp-g-1; Tue, 23 May 2023 03:23:27 -0400
X-MC-Unique: le-8VvFbMu-rCB4K5Qhp-g-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4393f88f1f2so1635633137.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 00:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684826607; x=1687418607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCtgPsbTFFBRZNpEHG/pQpYNw6sqfqlI0JhSLOxSGa0=;
 b=HdJmHOF9izWdQlMpjNyz0FoEFlla1R1KjUHfoN/RKCynWtnaRMs/AdAb9+EvU8zTa6
 rCD+SlhVb5y7l+DmgYijxvyQhF6SecIG2TN3KbZP1AymytWVUCpTLlBggqwePwldFgAd
 2ZqBf3vc/vGVKYwSCjnMSa6W6+rTB6D+VNa7OMsQjpOmd3xQrkGDqIZR7Fbp1TyW4vga
 blX//EOMXoRkMZRxcFreVDfz3HfHvQYeHkqff5Rs4hreZOkJOGGeR657sgkd/Jj+/rQe
 0ld4X36ke2K9wXq3DtKCowWGMY7tnAyr1ACphp5zq964gPdIjn3YQRRpOw1UGxZaBVDl
 S5HQ==
X-Gm-Message-State: AC+VfDzFDoYDc543dDX0werKkoV4L6dr8e+SL10g2+akn5rI5SnzhCHl
 Hh6SAg1qm3b9zun68Mo5KTn5nTT0H7BzVChDMLEP9Ur0fQ3bRdxe4nzo0QqCCGHBhdkL24BcB8a
 MMfHLsn2jXlkPLgc3YkvqFs41vWVLriw=
X-Received: by 2002:a67:fd6f:0:b0:439:4900:c27 with SMTP id
 h15-20020a67fd6f000000b0043949000c27mr1706152vsa.18.1684826606951; 
 Tue, 23 May 2023 00:23:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oWcIuLUChCIu67ukmoBb2xNBS4fAPV3ol2KMftj2KSlKUU6lGZKG10gzNXiI3jXwJTY6jhnYVeaXiRDmvago=
X-Received: by 2002:a67:fd6f:0:b0:439:4900:c27 with SMTP id
 h15-20020a67fd6f000000b0043949000c27mr1706147vsa.18.1684826606709; Tue, 23
 May 2023 00:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230522080816.66320-1-pbonzini@redhat.com>
 <9223027b-07af-7fc6-103f-3281c7562fa9@linaro.org>
In-Reply-To: <9223027b-07af-7fc6-103f-3281c7562fa9@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 May 2023 09:23:15 +0200
Message-ID: <CABgObfZY4ptTkbSz4ZX9oECd6s7g_F9pHHF07AWCjXvGBRve6w@mail.gmail.com>
Subject: Re: [PATCH] meson: remove -no-pie linker flag
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, vr_qemu@t-online.de, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Mon, May 22, 2023 at 4:39=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > +  # What about linker flags?  For a static build, no PIE is implied by=
 -static
> > +  # which we added above.
>
> Is it though?  That was the major problem at the time: it wasn't.

It's what configure was doing:

if test "$static" =3D "yes"; then
  if test "$pie" !=3D "no" && compile_prog "-Werror -fPIE -DPIE"
"-static-pie"; then
    CONFIGURE_CFLAGS=3D"-fPIE -DPIE $CONFIGURE_CFLAGS"
    pie=3D"yes"
  elif test "$pie" =3D "yes"; then
    error_exit "-static-pie not available due to missing toolchain support"
  else
    pie=3D"no"
    QEMU_CFLAGS=3D"-fno-pie $QEMU_CFLAGS"
  fi
elif test "$pie" =3D "no"; then
  if compile_prog "-Werror -fno-pie" "-no-pie"; then
    CONFIGURE_CFLAGS=3D"-fno-pie $CONFIGURE_CFLAGS"
    CONFIGURE_LDFLAGS=3D"-no-pie $CONFIGURE_LDFLAGS"
    QEMU_CFLAGS=3D"-fno-pie -no-pie $QEMU_CFLAGS"
   fi
fi

Note that the code to use -no-pie is only used if test "$static" =3D no.

> Trying both now, e.g. '--static --disable-system --disable-tools --disabl=
e-docs',
> a link line contains
>
> ... -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libhwcore=
.fa ...
>                                         ^^^^
>
> Where does that come from, and why isn't -no-pie the antidote?

That comes from Meson's -Db_pie=3Dtrue, but it is followed by
-static-pie later in the command line so all is good.

In other words, whatever we add second in the command line wins and
that is good for executables; but it is a problem when -no-pie
overrides -shared, thus messing up compilation of any shared library.

Paolo


