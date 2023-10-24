Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D637D568C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:34:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJPm-0005xI-MH; Tue, 24 Oct 2023 11:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJPc-0005vr-2O
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:33:44 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJPW-0005cC-47
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:33:43 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507c50b7c36so6434559e87.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698161616; x=1698766416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgn7DZOjqiLKpDeJIAWXRIPQaKWXfmUlyU40rW5Vul0=;
 b=r4n66Lvt5GqG58Sxt+jbNWMX2w/ZSl8rTkYhrn3v3gKIVXY+QKHHfEnjRZrQmo71RB
 U0u+MOCdieM4s/GqNe6e+zoAPfPi5v5dQJz953IvD9c/VfF4l/kynESSsGU926thwBI/
 S+jJRhJG7D0XON5SWS2yFhVwsQVDpjrDI0iChDD2bggJafi6Ibir7cGaBuJNk7I2Kit5
 nj9WActjiraJ3SChQlFSJ3a0mBJJYueNx6zH4ms1wiLNxRzlTxyYMJjwsPltqSZJVSqO
 S24gb2Rx18ZgFsqYTRd0fJ6MkqEdwoGX6BPBLekBNQ4kplFDQz4UUC7ACE29cHbwsBLs
 uOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161616; x=1698766416;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pgn7DZOjqiLKpDeJIAWXRIPQaKWXfmUlyU40rW5Vul0=;
 b=SgPYvYb1DjDhdZe0IcXE2JKLcvHLokzyUzV43/d7lZT85QGVBGKC+kvddYmD2pZWZS
 aO14SrygW47i9xhBiu1VOt+miK1EPmEf051czw5nVvKIwpr9+8YjANGvcrmfgR215TpF
 mgE33qpfXQtlwEDP6DL/TtOlF5MvE+iHQr+vuPotfVB0r9hJhYl4KCamLPyNBnKA0N6d
 iyeB2H2s8x8u7Iwh3yokHUWVlPBviPgUbGQEfemSQhijl7u09cAIOoganiWfEpowG9n+
 WepgwpDTDC35p3ZWydjvvMsSesOIfcjky0uk+5vZqK8Uo2ZIkqXzTeuovwYQRzYOvLH+
 ojww==
X-Gm-Message-State: AOJu0Yxu8kCP/tkYDW/Uocc+JPtF/UYHydtyKYd+vPXBs6cqMjWWnDWI
 c4GkNJFhcn168lNdABGxObgvUg==
X-Google-Smtp-Source: AGHT+IERaAXJZu/NEaGGq5i9CuYFrG2wQ65+x8yTDScZaEY7DCl2PsKOOkex2LHV25CK2hUsLxDFYA==
X-Received: by 2002:a05:6512:3156:b0:507:a3ae:3252 with SMTP id
 s22-20020a056512315600b00507a3ae3252mr8565102lfi.27.1698161616310; 
 Tue, 24 Oct 2023 08:33:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s3-20020adfea83000000b0031980783d78sm10119502wrm.54.2023.10.24.08.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:33:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E4B91FFBB;
 Tue, 24 Oct 2023 16:33:35 +0100 (BST)
References: <20231016151909.22133-1-dwmw2@infradead.org>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony
 Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo
 Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/12] Get Xen PV shim running in qemu
Date: Tue, 24 Oct 2023 16:24:48 +0100
In-reply-to: <20231016151909.22133-1-dwmw2@infradead.org>
Message-ID: <877cnc2fxs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


David Woodhouse <dwmw2@infradead.org> writes:

> I hadn't got round to getting the PV shim running yet; I thought it would
> need work on the multiboot loader. Turns out it doesn't. I *did* need to
> fix a couple of brown-paper-bag bugs in the per-vCPU upcall vector suppor=
t,
> and implement Xen console support though. Now I can test PV guests:
>
>  $ qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kernel-irqchip=3D=
split \
>    -chardev stdio,mux=3Don,id=3Dchar0 -device xen-console,chardev=3Dchar0=
 \
>    -drive file=3D${GUEST_IMAGE},if=3Dxen -display none -m 1G \
>    -kernel ~/git/xen/xen/xen -initrd ~/git/linux/arch/x86/boot/bzImage
>  \

So this is a KVM guest running the Xen hypervisor (via -kernel) and a
Dom0 Linux guest (via -initrd)?

Should this work for any Xen architecture or is this x86 specific? Does
the -M machine model matter?

Would it be possible to have some sort of overview document in our
manual for how Xen guests are supported under KVM?

>    -append "loglvl=3Dall -- console=3Dhvc0 root=3D/dev/xvda1"
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

