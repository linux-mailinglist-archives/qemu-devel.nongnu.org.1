Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7967F2B1B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ORy-0007m7-0i; Tue, 21 Nov 2023 05:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5ORo-0007kD-Al; Tue, 21 Nov 2023 05:57:40 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5ORm-0006tn-1l; Tue, 21 Nov 2023 05:57:40 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-777745f1541so356199885a.0; 
 Tue, 21 Nov 2023 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700564256; x=1701169056; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJ+WDl7ap9d4Irav98OxABBWtmFBGJ/2Lqy/4Q7WP2A=;
 b=gwq0k1+S7FvTqxpwiZ4e+QGDH6oEdbu4HBjoei3OzoY9jsUJ9uTwHYtNZpYjlSa/Fq
 XKBMvzHFhgec0bBaQX9TfGVzOqhHZyQrpkeTyQwRnPWym5xk1i4w1pylEKJxMiTI8PVq
 1+V0FOmxiTqnxo+GyqHFUR3+6zJkNudhgfP21O+ho2+hete9FBYBB4D4eejwKPAnZkKX
 3ji+JxLODCajk1+G/lNzdzedTFNcH+PZgqPZpZZ9gCtaQDMFLhk0cLjuTR+XIPJ4lZ2I
 j8xlPnCK5o8fcIXYCwxbvNUjjlpnFUh+h6Yi1aRt6HLWu6n2MHpEmcrwHK4vpYnP5ja/
 i2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700564257; x=1701169057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJ+WDl7ap9d4Irav98OxABBWtmFBGJ/2Lqy/4Q7WP2A=;
 b=grT6B+wdlUCN6qNU6EbmN4prcNQrEHPk+o0/daLKZrDiIRKHD6JG3AQtYZJ7DVZFqe
 jPeRp3M/TUYZZVtCjJlYHm2p8GXx9pGmXjopfN+5+5NfxzNhAML/I5buYvRONZGL2pDU
 cv00gjR6vy9xwF7e3JFkIEVgEbubElkfMz+V50iMGivBRKt3ZgN27Pi+8HROu8yyLiMZ
 qnuxdrGDaKAGwEtVHrQPPUaLemd4Qe2x0/2JqnM1blznJLTf9ZkzhVLc929CP6d2OtNd
 Kj4O5kBIazDa9Wfbbw7hS3+FGunRgpvqxshQFA3uK3wGp2oUJodUUlmng9e4uv0/e8bE
 4CjQ==
X-Gm-Message-State: AOJu0Yz/cG2nA1iAjjA9cyuljE95OPTVmXzH4mVxUDmkZHYBsYF1e1T+
 K+mIFtSe6lf1JDWF0VVk6gQXxYDHEb9aBmvzycY=
X-Google-Smtp-Source: AGHT+IG+itVYM+AUOUqIeSoVw3MEvxDfAeTADoEcqgXVo4VkDVOdQ4BHWwfgSF73Uec0ZBPWnWk4VjPJcH4sqs7rtw0=
X-Received: by 2002:a05:620a:8388:b0:778:9ac2:5a9f with SMTP id
 pb8-20020a05620a838800b007789ac25a9fmr12609093qkn.11.1700564256669; Tue, 21
 Nov 2023 02:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20231115172723.1161679-1-dwmw2@infradead.org>
 <20231115172723.1161679-3-dwmw2@infradead.org>
In-Reply-To: <20231115172723.1161679-3-dwmw2@infradead.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Nov 2023 14:57:25 +0400
Message-ID: <CAJ+F1C+3UQoEEvFgg8ENjR0xv-LTiPckx4XkCjVqOe2Jnx1EeA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vl: disable default serial when xen-console is enabled
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x736.google.com
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

On Wed, Nov 15, 2023 at 9:28=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> If a Xen console is configured on the command line, do not add a default
> serial port.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  system/vl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/system/vl.c b/system/vl.c
> index 5af7ced2a1..8109231834 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -198,6 +198,7 @@ static const struct {
>      const char *driver;
>      int *flag;
>  } default_list[] =3D {
> +    { .driver =3D "xen-console",          .flag =3D &default_serial    }=
,
>      { .driver =3D "isa-serial",           .flag =3D &default_serial    }=
,
>      { .driver =3D "isa-parallel",         .flag =3D &default_parallel  }=
,
>      { .driver =3D "isa-fdc",              .flag =3D &default_floppy    }=
,

Consistent with the rest of the lines (no conditional compilation nor
driver #define..)
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

btw, while quickly testing this (do we have any test for xen-console?):

$ qemu --accel kvm,xen-version=3D0x40011,kernel-irqchip=3Dsplit -device
xen-console,chardev=3Dfoo -chardev stdio,id=3Dfoo
(and close gtk window)

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555c11695 in qemu_free_net_client (nc=3D0x0) at ../net/net.c:387
387        if (nc->incoming_queue) {
(gdb) bt
#0  0x0000555555c11695 in qemu_free_net_client (nc=3D0x0) at ../net/net.c:3=
87
#1  0x0000555555c11a14 in qemu_del_nic (nic=3D0x555558b6f930) at ../net/net=
.c:459
#2  0x00005555559e398b in xen_netdev_unrealize (xendev=3D0x555558b6b510)
at ../hw/net/xen_nic.c:550
#3  0x0000555555b6e22f in xen_device_unrealize (dev=3D0x555558b6b510) at
../hw/xen/xen-bus.c:973
#4  0x0000555555b6e351 in xen_device_exit (n=3D0x555558b6b5e0, data=3D0x0)
at ../hw/xen/xen-bus.c:1002
#5  0x00005555560bc3fc in notifier_list_notify (list=3D0x5555570b5fc0
<exit_notifiers>, data=3D0x0) at ../util/notify.c:39
#6  0x0000555555ba1d49 in qemu_run_exit_notifiers () at ../system/runstate.=
c:800



--
Marc-Andr=C3=A9 Lureau

