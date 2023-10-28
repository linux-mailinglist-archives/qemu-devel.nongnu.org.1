Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B67DA6D9
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 14:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwi69-0002X6-4H; Sat, 28 Oct 2023 08:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1qwi65-0002Wg-TB
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 08:07:21 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1qwi62-0003Vu-W7
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 08:07:20 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso2925897b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698494837; x=1699099637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKJvKcyb2RWdDk274b6iPkQC86bAjXYUlIA5aUdbkBo=;
 b=ARuBsZ0d0nhWX2zhty77t2uJsG0v2yDswbIMeNXgQP1NO+h6tSu4qov9ZR+j36INPH
 SI5Tccvy1siLGgimGWxu2TK6FlUnF6qur5RNEcfOYQsdwp+TekLFtSamxzGIaDanneqC
 wgVxhKQ/Vl+M37jpb0d0uCp7mUUztScDbMlz1K4Ywf1Un75j/rrpQdvbujaMLH1IkJ9f
 CFjLgugb5t8jEf2QlN8vrStnpIv8h0H/v2gRk54v3JH7rknHiOLfciv/P26+/P8dWQg+
 OfbXwzBnSZdeYuI+BKbISbBmoxkWxKmYei+59bB4TjMfbQQvb4hqdWVsZZJtv2oXEfdG
 /l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698494837; x=1699099637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKJvKcyb2RWdDk274b6iPkQC86bAjXYUlIA5aUdbkBo=;
 b=Zu/2p8rx75gpa6670zYrPXxC2PsuoNe1XREpO++fMUiKnSi3XyT5ziLmuBwwKuASbG
 KtylJCVpUKfDLXRP8LEydcruv4zKpF3V9TXPFOBAg324UdZ6OOpCXIuUDmQ0RTZYy2N/
 RQtZcjUbVZLmn/3UPmxPosHRM736O+KLGUd/ehYJrsuekYdu96shjJcvIp3kCWh8SU9I
 Wj/mNtZ6YCUxXnmqElAD9fthvp1aklfiHkuofp32esfihvLkzgtcQzMKCDUGwvQQdh4p
 FfMUDIhX9lAoatn4RyHpjfCdOlKqbUqYvLSjeWiZtx+CjhdHS4oDwCLBFj955QpYc6oA
 kSlg==
X-Gm-Message-State: AOJu0YyzSKqOFOnvGj1vNa+YO+VKzcYjA6TUOyTdwXBAaV0ruKZErPeD
 bTpjMLcfewLm8mXI/irN+pL2JS/Qba9kuwaH/g4=
X-Google-Smtp-Source: AGHT+IEdj5XrMmmITiaCJ/1atu+NuwxiM/2j4rW1PnubHu13oZ74aiFbiLTK1fmTX+M9Q6PFdb17tO0twOE44XNBHk4=
X-Received: by 2002:a05:6a20:748b:b0:17a:de5d:1d7e with SMTP id
 p11-20020a056a20748b00b0017ade5d1d7emr6720018pzd.55.1698494836794; Sat, 28
 Oct 2023 05:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231021134015.1119597-1-daan.j.demeyer@gmail.com>
 <ZTlSPbh2GnhOKExO@redhat.com>
In-Reply-To: <ZTlSPbh2GnhOKExO@redhat.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Sat, 28 Oct 2023 14:07:05 +0200
Message-ID: <CAO8sHcnh1mqaEchGSwYaFr7+LTau9yQRt_4zVJGrFsroWik3ew@mail.gmail.com>
Subject: Re: [PATCH] Add class property to configure KVM device node to use
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-pf1-x433.google.com
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

Anything else needed before this patch can be merged?

Cheers,

Daan

On Wed, 25 Oct 2023 at 19:37, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Sat, Oct 21, 2023 at 03:40:15PM +0200, Daan De Meyer wrote:
> > This allows passing the KVM device node to use as a file
> > descriptor via /dev/fdset/XX. Passing the device node to
> > use as a file descriptor allows running qemu unprivileged
> > even when the user running qemu is not in the kvm group
> > on distributions where access to /dev/kvm is gated behind
> > membership of the kvm group (as long as the process invoking
> > qemu is able to open /dev/kvm and passes the file descriptor
> > to qemu).
> >
> > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > ---
> >  accel/kvm/kvm-all.c      | 25 ++++++++++++++++++++++++-
> >  include/sysemu/kvm_int.h |  1 +
> >  qemu-options.hx          |  8 +++++++-
> >  3 files changed, 32 insertions(+), 2 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

