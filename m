Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E117228C1
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:24:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6B7t-0006LB-4H; Mon, 05 Jun 2023 10:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q6B7a-0006Hl-87
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:23:47 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q6B7T-00011J-Rs
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:23:44 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f3b5881734so6166221e87.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685975017; x=1688567017; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zw3iz6Edi9TAPeU2tlXpO5biCnMLhrpMI7RUjAIFv5M=;
 b=TzXMiMUddRTLlZmCY4vvpi6wwuxGNwfcDiH2qJSC4fpQP/azJTNp9USUo3ml6L0V1V
 IhQKOeyv5EGUg1dwVxj3ZH6N8za+XNl0oVGJkd/KEIZJ76VYH923GHsM9s2u+JPYvJJa
 QsWlfjX6ZPQixAaw0W0EX1juK8DgkAwJ6EJv6s7CzzTy6IcVIyCFnNKmDZLHV3vexnlL
 TeQDViivewhZc2idi775tMPeXQhwE2vS4LS9E/9kpmXZ4FL+TKDKZdoTZQXC1kX3SeNj
 ZJ2cr+HenE2V718StPKDVFCxKVXfYnJmv3Ds9NMshvrkI+P8mDITCdy2U6aMlrJqqGEA
 4IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685975017; x=1688567017;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zw3iz6Edi9TAPeU2tlXpO5biCnMLhrpMI7RUjAIFv5M=;
 b=YFJNsUw24y8UULu9MED+1HjhfjkMQJYXtA+TXMJsiKCn+m7sfrhWJRQ0n816O+ipOy
 K8iRDBNYTsThwv9i/CH1NcACYGlGd66SCyI2ElDt0iuM8i5ofljLVtvi0tU0drcRwmig
 UDFkW6oiDOrxFjCV9TZPc8pFREq4tKJ7TezU0XH5CDMta+xoF78GRXwQBDfDMtx3hu8Y
 7VYFnMgZUXf5Oaatrq/Esb0y87VGBffroHTgvnso1WAEPzzeCLhrufbYHL0Tp7A0Pmmk
 F/fjqj1aduospJ71x8ua57PblXIM7qxR9/YbsnKL3YV44uxwm50iYie/VloAbLzK4VqY
 NzPA==
X-Gm-Message-State: AC+VfDzt9AUrMoJGTeXc5cCOj3WClHqKQw+AeYpmrM9kyGkmmKrrcUg4
 1TsCQ6vD4Hi2dMaI+fKaXUz6wQ==
X-Google-Smtp-Source: ACHHUZ6y3jW/CXLM+o54hvIrulJzc6iQhmU1DHCGU8GyLXK5AyBUXp8Xgt7W0AoEq8MlHxnOhjFSVw==
X-Received: by 2002:a19:ac0b:0:b0:4f3:a49b:121f with SMTP id
 g11-20020a19ac0b000000b004f3a49b121fmr5623207lfc.40.1685975016779; 
 Mon, 05 Jun 2023 07:23:36 -0700 (PDT)
Received: from [192.168.50.45] (h-155-4-92-80.A980.priv.bahnhof.se.
 [155.4.92.80]) by smtp.gmail.com with ESMTPSA id
 u11-20020ac248ab000000b004e90dee5469sm1145068lfg.157.2023.06.05.07.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 07:23:36 -0700 (PDT)
Message-ID: <b983c9568a8b2ab3834d6f25f9b920889a1a5662.camel@rivosinc.com>
Subject: Re: [RFC v2] linux-user/riscv: Add syscall riscv_hwprobe
From: Robbin Ehn <rehn@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-riscv@nongnu.org
Date: Mon, 05 Jun 2023 16:23:34 +0200
In-Reply-To: <85f76944-5657-4680-4e24-fd69c37c3b67@linaro.org>
References: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
 <85f76944-5657-4680-4e24-fd69c37c3b67@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=rehn@rivosinc.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 2023-06-02 at 19:57 -0700, Richard Henderson wrote:

>=20
> > +        case RISCV_HWPROBE_KEY_CPUPERF_0:
> > +            pair->value =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>=20
> Is that really what you want to expose here?  FAST is always going to be =
true, in that=20
> handling the unaligned access in the host is going to be faster than in t=
he emulated guest.

The plan was to add this in the cpu cfg in a later patch.
This setting e.g. changes jitted code and therefore it's helpful if such ge=
nerated code
is the same in the emulated guest as it would be on that actual cpu.

I'll change to FAST as the hardcoded value until then.

>=20
>=20
> Where does CPU_ALLOC_SIZE and CPU_COUNT_S come from?
>=20
> > +                unlock_user(host_cpus, arg4, cpu_setsize);
> > +                /* no selected cpu */
> > +                if (ccpu =3D=3D 0) {
> > +                    return -TARGET_EINVAL;
> > +                }
>=20
> I suppose you're just looking to see that the set is not empty?

Yes, exactly.

Thanks again! I'll send out an update.

/Robbin


>=20
>=20
> r~


