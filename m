Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB887F19C8
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:26:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r581Y-0000Zy-TB; Mon, 20 Nov 2023 12:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r581R-0000Ys-7c
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:25:23 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r581O-0006tZ-6Q
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:25:20 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-548a2c20f50so2231656a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700501115; x=1701105915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rt6yvIhC3Ev+7ooito66m4fp8ulzbX39qgkqxP3R/Fg=;
 b=NSCdwAspkNBm+0y+NfhhAU/AeJ66rtbxqv52HO6B1ef4ump7AT8ty1gN+eIDmmO8+4
 8u6WEnOwWaZvS/XLHRocobjr3UpVL44IeVJQuE2DUHnlp90UcB5qZLxPxevfZsYst9PZ
 dApiPVZgRGBdkRaqdUaF9wHfUp1d9I83xwqV2EFjG7AOfUojzqLVUl7cUvuJ3nT9/1fO
 WfyeVdxqwvjXhZknyQ1n8vio88f5C+3WBj1HZN4lSJ7t3t6/TQrIhNHhT/lwvng7PUY2
 qdZuzMKbrLzBvS81+gLBVf3Bj34hxvuvnItIETuN0W5j/CR2oXJgEJ5mkSLux65MWo8k
 xtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700501115; x=1701105915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rt6yvIhC3Ev+7ooito66m4fp8ulzbX39qgkqxP3R/Fg=;
 b=Iex2pSuLiqqauD0IldtDERzYyJsE9Tgfdf04cb1+5o982HfKd2CeabX1ceU4eakdBf
 Rd3g/pWUGbqX3Od57Q6h7mFUfybBrTsVl5SR94OQBTPW7+TnjG6RaSFQsjwV225k3iyX
 c1jwhIvf0KsyTLTTvdp36Mwykvmnv4KairzndURnyox9EP03BuSo+f39DZ/SZ5TKPCmC
 jsgkitIAyLXBSo2/vWu1eoMK5TV7dcegacnLAlAC5P7xDp6CohPWyCsBez9voUOptwu9
 fT0jtyRL/+027baItO5m7B3rKz2mr3iMQEZk9FMLRQR410gI3jzyXydGJVRpbC+wJ0B1
 2Mjw==
X-Gm-Message-State: AOJu0YwfrvrublB+3gBd1Ko3kqr0s8Y0PNCzxEjx4tbIZdQs/xMWjQBI
 2bDhj+UwRJpLj6MeY0ucmTjEfElff/PQc5lAfZTuEg==
X-Google-Smtp-Source: AGHT+IHUPzvuL4D5bW87jvt9+3tI9CkZu1gwEXCUgdaVDL8WlhPbVavuyUvtrEYJRofrLc/NHtSqA3dIg0mB2JPZKzk=
X-Received: by 2002:a05:6402:688:b0:543:52be:e6ad with SMTP id
 f8-20020a056402068800b0054352bee6admr68352edy.5.1700501115673; Mon, 20 Nov
 2023 09:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
 <20231120150833.2552739-12-alex.bennee@linaro.org>
In-Reply-To: <20231120150833.2552739-12-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 17:25:04 +0000
Message-ID: <CAFEAcA_QP7QZb04Op-U_jYGpVckSkzgQrFnJghywLK1NgX6sxQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] tests/tcg: enable arm softmmu tests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org, devel@lists.libvirt.org, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, 
 Chris Wulff <crwulff@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 20 Nov 2023 at 15:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> To make it easier to test 32 bit Arm softmmu issues implement a basic
> boot.S so we can build the multiarch tests. Currently CHECK_UNALIGNED
> is disabled as I haven't got the right magic set for it to work.
>
> Message-Id: <20231115205542.3092038-10-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +# Running
> +QEMU_BASE_MACHINE=3D-M virt -cpu max -display none
> +QEMU_OPTS+=3D$(QEMU_BASE_MACHINE) -semihosting-config enable=3Don,target=
=3Dnative,chardev=3Doutput -kernel
> +

A minor thing, but I just ran into an awkwardness in the
equivalent set of variables in the aarch64 subdirectory:
if you ever want to define a different machine type then
there's no convenient way to say "give me the standard
options but a different machine", because the QEMU_OPTS
has the base machine in it and there's no variable with
just the semihosting etc options in it. For aarch64 I opted for:

+QEMU_BASE_ARGS=3D-semihosting-config enable=3Don,target=3Dnative,chardev=
=3Doutput
+QEMU_OPTS+=3D$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel

because then you can have a particular test do something like
+QEMU_EL2_MACHINE=3D-machine virt,virtualization=3Don,gic-version=3D2 -cpu
cortex-a57 -smp 4
+run-vtimer: QEMU_OPTS=3D$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel

You could argue about whether '-display none' should be in
QEMU_BASE_ARGS. I figure -kernel should not be because it
has the weird "must go last" property.

(These tweaks to the aarch64 makefile coming soon in a different
patch...)

thanks
-- PMM

