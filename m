Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B07160A0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:53:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yqv-00016v-Je; Tue, 30 May 2023 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3yqp-00015w-9g
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3yqj-0007Ps-PP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685451196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uGpwsbXMH0Oq3sB35Oip0o3UHK9xVQhVFPdSwssEiA=;
 b=O8CgFRS7PfURmpnnXCnpkjgExnW6uOdVymHXwK6va6wCDubf8GUxsi6/dvKP3htXNnqn/O
 5OdrmW/osIYPHeiNe7AmbyWYHS2g2h4lJgitEid0R1ChpcgB7DnBMux7SaJ1INcwxrQ4oU
 tKIypyWb560MiJywDBKhp9xP/MFHJFQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-PlhKuUXHN9OtdCpos4C9GQ-1; Tue, 30 May 2023 08:53:15 -0400
X-MC-Unique: PlhKuUXHN9OtdCpos4C9GQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-78369c2c6d9so1264584241.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451194; x=1688043194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uGpwsbXMH0Oq3sB35Oip0o3UHK9xVQhVFPdSwssEiA=;
 b=KR377PBLaiR2S9/bFG170jlVk9gUwl1um6UTNNTjqRZJAwcHqFb/NAZpyBcmVfODqW
 fp3I/WURjXQ0UafXUyRt0L7pfRdwS0sbfu2HcLL7pehmxcXl4xGKE5Wu+LVjlmdS3Ykt
 Jg7rGO4ABsBOTyNUlcJtSfPZiyipFQ7x4Tf2uxtNDhG/PXMNqLfA/i98LzrhP/aoXYNb
 ztw37peD1QW/JmDsfP3zlSiVIwlgSeWaw5SvLagYgjSwmLRcPMytyv/da4VRfyiiKHEn
 ZxFlKL6v5Q+GmDb7CCQm2FVryd9i25bjsYybv/c2ZrdJaP9LrhQc94wwyR5r0fi3Gbcv
 PrAA==
X-Gm-Message-State: AC+VfDy/LpiyWSaFzzY9E7+rcoQb5Wv2mh44jl41I8Go3Y360lV3xV9u
 8Lh+hxF1FdO4dqBYwfM1Sah6lng7sa/IAuikNLJBOVzCktxRPrDnn34izBGctRHqu/vh3opoG/o
 xuqcI4IFxo7FtBRkmiO9WRHWAEIILOg/6CHtcQOSHaA==
X-Received: by 2002:a67:be16:0:b0:439:5db0:c6ef with SMTP id
 x22-20020a67be16000000b004395db0c6efmr610030vsq.6.1685451194425; 
 Tue, 30 May 2023 05:53:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7B3a+/mJtOSiC9S9rdgkcIsc5ESnpmlYsWqFwaydpdIMc2nzQ9L1S/C0ZThOyaBzMfziFz0s8JZ8tQlDoI9D0=
X-Received: by 2002:a67:be16:0:b0:439:5db0:c6ef with SMTP id
 x22-20020a67be16000000b004395db0c6efmr610022vsq.6.1685451194184; Tue, 30 May
 2023 05:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-5-pbonzini@redhat.com>
 <1981c8e3-9109-7562-0d64-1fa091a28e3c@redhat.com>
In-Reply-To: <1981c8e3-9109-7562-0d64-1fa091a28e3c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 May 2023 14:53:03 +0200
Message-ID: <CABgObfaKt36_iOTw-EOkoEDJz_Br=15PRMJm9xd6YBu2k99i3A@mail.gmail.com>
Subject: Re: [PATCH 4/5] configure: check for SLOF submodule before building
 pc-bios/s390-ccw
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 30, 2023 at 2:04=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
> On 27/05/2023 11.28, Paolo Bonzini wrote:
> > SLOF is required for building the s390-ccw firmware on s390x,
> > since it is using the libnet code from SLOF for network booting.
> >
> > If SLOF is absent and submodules are not updated, pc-bios/s390-ccw
> > cannot be built.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   configure | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 1d1b8736c0eb..c92a3b30b9a4 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1662,7 +1662,8 @@ fi
> >
> >   # Only build s390-ccw bios if the compiler has -march=3Dz900 or -marc=
h=3Dz10
> >   # (which is the lowest architecture level that Clang supports)
> > -if have_target s390x-softmmu && probe_target_compiler s390x-softmmu; t=
hen
> > +if have_target s390x-softmmu && probe_target_compiler s390x-softmmu &&=
 \
> > +    ( test "$git_submodules_action" !=3D ignore || test -f roms/SLOF/V=
ERSION ); then
> >     write_c_skeleton
> >     do_compiler "$target_cc" $target_cc_cflags -march=3Dz900 -o $TMPO -=
c $TMPC
> >     has_z900=3D$?
>
> Not sure if we really need this. Only the networking part of the s390-ccw
> bios cannot be build without SLOF, but the main binary still builds fine
> also without it.

Thinking more about it---considering we have prebuilt s390-ccw
binaries, why would someone want to rebuild only one of the ROMs and
risk breaking the other? Should we keep this patch, and also include
$(SRC_PATH)/netboot.mak unconditionally from
pc-bios/s390-ccw/Makefile?

Paolo


