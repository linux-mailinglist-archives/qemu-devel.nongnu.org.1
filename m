Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C1A80F381
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:47:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5ul-0005Wy-JZ; Tue, 12 Dec 2023 11:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5uR-0005WM-Kx
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:47:04 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5uP-0005Zv-LI
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:47:03 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54cde11d0f4so8242475a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702399619; x=1703004419; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFzyQFyEoKLJOk8HnGBv3xF46rshezAwR/jjNtDoTVc=;
 b=VC59p/c2qZ0qqIHEhnmzDEzQ+BT3+S4AG7utsBl1FB+J31+VYiRuc1Df5jlcMQqB88
 V21wI+qyhcVczvGUanSUnZjrqo3zEntLBvy05o6Oo5D1087Yj/Dlzq9wBgR5iA0uG4SF
 PfcQbpfkh8StHHpig7mWq/YmYWD4L/YWmMpTqgh0r03L9cHoH53aiUYI8J3s3JRgT4aQ
 oJ2k/z82gm0R474ixJG1ymH6ejNrjFdOCh8wEvU2IPmIMOKgGGTHow4uoWZfPWrJ30vX
 Frvbll2i+96CGHs47w3Fd1ijh2lR/7YKxEYZkvSfLqc4lIiLb7rPwLqK5inpQZUtIVx4
 qRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702399619; x=1703004419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFzyQFyEoKLJOk8HnGBv3xF46rshezAwR/jjNtDoTVc=;
 b=wmxuXPlp2NRtCXDV0z9ZNXxx1/OnDmo22L/mLAfRuqZxVPMjaGhEhIBmn7UOvjGYoX
 /vSP0D2DEs6swuyNWxQoOlYdaK0PeqplN8Oe3QSdGX3sbSlkGBPBvFb5q3mskib/qnDA
 uHdqF4GlCdHl3nzYfPZhqPLYola716UxHFXigIPAhQC+cmXw0h3hqjf8aim7VTYSBeKP
 2fPrQ6Yy7ITRNkt3E+ZNX7Qg9Vc3XCqwQ3nu4ewraZp30kwoQGazV3x6OwUBOLLKv1zG
 Hz2zRQk6Uad4HtAL5GGX4LBqaAejWhZd0ILuPq/cadzNQAX9V2Ei35KdORquuiXRNv6M
 MBiA==
X-Gm-Message-State: AOJu0YweCzNwYev+18zGpxcer2MGntk5O639HAzVfjAUFTf3nn6Uz7Qj
 GAqpL7umn2NskNmj5GlSKchBKV4+APjaPQMTuLi7EQ==
X-Google-Smtp-Source: AGHT+IEObm5uvR3WtY3ZgyCLjDZ0qjwTJXXyqpV9XJ+bYZhYB2gS3u3kMCAeCImR173Shvj7XAAr7fG8DTEcV9veC3M=
X-Received: by 2002:a50:cc49:0:b0:54c:87a1:34fe with SMTP id
 n9-20020a50cc49000000b0054c87a134femr3896078edi.10.1702399619570; Tue, 12 Dec
 2023 08:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-5-philmd@linaro.org>
In-Reply-To: <20231123143813.42632-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 16:46:48 +0000
Message-ID: <CAFEAcA9s31674uBNiSN0tV0geyWdscH-5oT=buWuKmJk3QWLSg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 4/8] hw: Simplify accesses to the
 CPUState::'start-powered-off' property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>,
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

On Thu, 23 Nov 2023 at 14:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The 'start-powered-off' property has been added to ARM CPUs in
> commit 5de164304a ("arm: Allow secondary KVM CPUs to be booted
> via PSCI"), then eventually got generalized to all CPUs in commit
> c1b701587e ("target/arm: Move start-powered-off property to generic
> CPUState"). Since all CPUs have it, no need to check whether it is
> available. Updating this property can't fail, so use &error_abort.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/armsse.c  | 6 ++----

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

