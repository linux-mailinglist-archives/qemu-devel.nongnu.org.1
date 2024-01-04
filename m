Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED618242A9
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:25:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNis-0000xs-SS; Thu, 04 Jan 2024 08:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rLNip-0000xQ-UE; Thu, 04 Jan 2024 08:25:19 -0500
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rLNin-0002vg-Vf; Thu, 04 Jan 2024 08:25:19 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 46B2EC070E;
 Thu,  4 Jan 2024 14:25:14 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id Ul4roXsSTEhP; Thu,  4 Jan 2024 14:25:14 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id D98A2C06FB;
 Thu,  4 Jan 2024 14:25:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr D98A2C06FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704374713;
 bh=3G4YasyhzU7LoeY+kXJmdETFxUkTsmT6DK5w6NvdoBA=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=4fPNd0zueaek93iDy7rzKFgR1hYFAmLlZYY6Hyib4ckzJOcJMrkWBFoAOpRQnvu7x
 /caOWQzxHvsDHpywnRXcJkNMsNeLHQWhbf3f3+UcjTZmT+RNQg8DxDya+Csa+EdFt7
 D25U3Uno26b+HGRvLopmqmNSPIHRcs6NnCl5E2bY=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id vr0ZwMqJSDAp; Thu,  4 Jan 2024 14:25:13 +0100 (CET)
Received: from buffy (unknown [IPv6:2a01:e34:ec63:e440:de99:aaf:30a9:1726])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 7422EC070E;
 Thu,  4 Jan 2024 14:25:13 +0100 (CET)
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-2-ines.varhol@telecom-paris.fr>
 <908650b4-3bb2-4cf2-8909-5bffc622950f@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?In=C3=A8s?= Varhol <ines.varhol@telecom-paris.fr>, Alistair
 Francis
 <alistair@alistair23.me>, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth
 <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/3] hw/misc: Implement STM32L4x5 EXTI
Date: Thu, 04 Jan 2024 14:23:12 +0100
In-reply-to: <908650b4-3bb2-4cf2-8909-5bffc622950f@linaro.org>
Message-ID: <877ckpgrie.fsf@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dc;
 envelope-from=samuel.tardieu@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> This doesn't build:
>
> ../../hw/misc/stm32l4x5_exti.c:172:9: error: expected expression
>         const uint32_t set1 =3D value & ~DIRECT_LINE_MASK1;
> [=E2=80=A6]
> I could build using:
> -    case EXTI_SWIER1:
> +    case EXTI_SWIER1: {

Out or curiosity, which C compiler or option do you use for=20
checking? I have no problem building this using "./configure=20
--target-list=3Darm-softmmu" with GCC 12.3.0.

  Sam
--=20
Samuel Tardieu
T=C3=A9l=C3=A9com Paris - Institut Polytechnique de Paris

