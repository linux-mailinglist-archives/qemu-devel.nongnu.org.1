Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9080CE80
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 15:36:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rChMq-00050X-AC; Mon, 11 Dec 2023 09:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rChMo-00050G-3g
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:34:42 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rChMm-00061J-IX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:34:41 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-54d0ae6cf20so6393737a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702305279; x=1702910079; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YdnQkh/WCt/AjLL96JsyZ+K8TtN25z/uzpS0acdy7M=;
 b=OVAXsrKOEBcor/48Aqq5Ub0tY/IjbF9QQSeZKxMRC//oQBwCMtYJqe8wqAsm5103i7
 t/5riE/EfOEeoFefIXpNC92hjs3OpY8yd586J2rkGXTuUDG9x/0XVRf/IoNdHtHwmagi
 OZizrAhHzfrOyU0LjTvw9fiQw2ZN4H7P8Kvfn+QyzLbp+EnHo89nJjNwpYWt3ORG+LS9
 /kdcmX1NnBxhjAkjtdv34Xy4ZFKLKiUypq6dQ7rOqyrFtGzZouO8YV50wLbkSEYRYq5E
 1XWiwGbNxeA07N+uAFbB/eMkuyinJA7rdtxdMIIrBNo2dyNZOsFAwqA8P7XA685Be7g3
 Sp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702305279; x=1702910079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YdnQkh/WCt/AjLL96JsyZ+K8TtN25z/uzpS0acdy7M=;
 b=jOCvvNV4bVaKNOldX0v4CrYWYFI6vPd7XxGpn0yV4g0kxG17Hvb3VgeMn36Bt7xbk/
 Qb+OsPsbthYtQM54vLqv8d2w3dH2ExS74T1LBHCVxHdmRa5W7tk0b8eRYwKM0lLXXMa5
 +RpoXEBTK/oOSlqBVO3HW/XHfvAElKuz+ADlWdrA0bdF394jTnmsIrBXtaocbO9i7x7v
 hpdPWMndEwPajIqzxS7ZfcsxPyRc+4OFYWKAedzMrNXLjkF0LkbWua4SoF/PpSnYNaNI
 I5m8g9laSR3OWPu0iPsSYPoi8jb337MZA/k5PQ71Nt1CYpjjf7DgP+pEue5DXhl8grP3
 sn2Q==
X-Gm-Message-State: AOJu0YwKM0SeEJwj2hd+Y+/pdty+iJ0uQNOKbMgEJnetkVjVYsF7pX5H
 0Xo3heYOMxQdvwHa50FYkHcrTDwKVAQ2Wj2Vfwpnrg==
X-Google-Smtp-Source: AGHT+IGjp6dpy8LTPXiWuX6mQTnt0yt4p7GSkwsFpxDvf/P8cc2V+BVP2s6mzj1OiiFzED208qBSS4UxhFB1Ar0QBTM=
X-Received: by 2002:a50:9992:0:b0:54d:329a:372b with SMTP id
 m18-20020a509992000000b0054d329a372bmr2564336edb.23.1702305278758; Mon, 11
 Dec 2023 06:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-21-richard.henderson@linaro.org>
 <db8f1d15-121c-4597-8f04-15661c7eaa3b@linaro.org>
In-Reply-To: <db8f1d15-121c-4597-8f04-15661c7eaa3b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2023 14:34:27 +0000
Message-ID: <CAFEAcA94EdEEcjvTZLYwnuv=ngQz5sD+ihY7ez+soeJMu=aXow@mail.gmail.com>
Subject: Re: [PATCH 20/21] target/arm/kvm: Unexport and tidy
 kvm_arm_sync_mpstate_to_{kvm, qemu}
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 24 Nov 2023 at 12:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 23/11/23 05:42, Richard Henderson wrote:
> > Drop fprintfs and actually use the return values in the callers.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   target/arm/kvm_arm.h | 20 --------------------
> >   target/arm/kvm.c     | 23 ++++++-----------------
> >   2 files changed, 6 insertions(+), 37 deletions(-)
>
>
> >   /*
> >    * Sync the KVM MP_STATE into QEMU
> >    */
> > -int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
> > +static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
> >   {
> >       if (cap_has_mp_state) {
> >           struct kvm_mp_state mp_state;
> >           int ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_st=
ate);
> >           if (ret) {
> > -            fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
> > -                    __func__, ret, strerror(-ret));
> > -            abort();
>
> I suppose if this abort() had fired, we'd have reworked that code...
> Maybe mention its removal? Otherwise,

Well, it's a "KVM has failed in a way that's fatal for the VM"
kind of error. It's OK to drop the abort() here because since
7191f24c7fcf we will catch error returns from these arch-specific
functions in the accel/kvm generic code. When this was written
before that commit then if we didn't detect and print something
here we'd just have silently dropped the error, I think.

I added a brief note to the commit message to that effect.

-- PMM

