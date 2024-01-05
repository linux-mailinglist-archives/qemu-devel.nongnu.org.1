Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B75825895
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:47:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLnLH-0003rl-V2; Fri, 05 Jan 2024 11:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLnLF-0003rS-Vi
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:46:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLnLE-0006ux-Bh
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:46:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d5d8a6730so15790275e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704473198; x=1705077998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+XesGPt6M8kow2hbHLuoiYwZT9fbHdGsS/st+N6yU4=;
 b=rPzcPeB1Q5WcGvRdsXUoa/SY7Ww9DzX4EzE8Lzzw2gucPua3WyCk58B/UoypCOHl7Z
 AIQnYD9jX8DWtvH31QEMzNbiFJBLvC0bKoVWlyIE3RaUAYI/l4wKulunegknc/nmct9/
 HiSvs/GS37VZ3oUdO89wXVHjL7LXw4zoCkX/IPskeHBjcmMUlY5ciPyiJq/yJFavrDA/
 FK7/GJ79rGWhfjHt4qj3cMaC3O8++eonVEujzWaRR3/UDP3MLIetqdJsTGZoYHt1DAAj
 rYrP40LFwaakDWAheqzDs53Up5MqMWoeR7x09Vw9RTnokNwyC89q5qJnNZSM5XFkOTZw
 +VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704473198; x=1705077998;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y+XesGPt6M8kow2hbHLuoiYwZT9fbHdGsS/st+N6yU4=;
 b=mD81KcIo3H0eCx1HOGWzV8wa9ps2NV7V7u+EuBlQK6a0BeFQdxeZWvSFEqs4qlqZor
 Ra2rJ/MvgTEI4M6r0pt/DLJRIVH/AS2GOlV2q0wIAtFc97JyAK6cWGavmjDmHIWAdhH2
 7wM4GEbvgbjXlur/P8EGfpOP7rYfJ57zjgTctU4SHY2SaUxt0rF0k1Bv+j/JTbdiQioM
 D7hgfRj5rjNzv6xq8/4WWkgonqvrzt8tZeo+os+D+wIUIRqiFDSf5O+/lg42T+ZWEm1i
 p9F+cXUS6G4rqoa5Xyn3mlkI/8NxYNnxArvHby0cHzWfVeoqp4P11QaH+TyeTy6jXzWL
 GCoQ==
X-Gm-Message-State: AOJu0YyoAh75W0rCuB/ylP7BEnhXQVsyPpoWIRKLqbR4T9EbN4r3dKlH
 3pPOqJBOogGwW05qCvYcbZSY/hFsSss8yCT77aYPgkKABAc=
X-Google-Smtp-Source: AGHT+IGfQ3Xtijrn9RSjx5/lkQi003txpkqHMJPrjO3j7ymH6H2sBW6JG409QE8qxnBxTKL1vsQOww==
X-Received: by 2002:a05:600c:a42:b0:40d:8780:2aff with SMTP id
 c2-20020a05600c0a4200b0040d87802affmr1276841wmq.131.1704473198281; 
 Fri, 05 Jan 2024 08:46:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h14-20020adfe98e000000b003367a51217csm1706264wrm.34.2024.01.05.08.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 08:46:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB8E75F933;
 Fri,  5 Jan 2024 16:46:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?5ZGo56ul?= <273415826@qq.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>,  "linux-cxl"
 <linux-cxl@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: Question about CXL emulation in QEMU
In-Reply-To: <tencent_7710D323F3DCBEF4BEAAF17BB3AF851D4707@qq.com>
 (=?utf-8?B?IuWRqOerpSIncw==?=
 message of "Fri, 5 Jan 2024 19:00:14 +0800")
References: <tencent_7710D323F3DCBEF4BEAAF17BB3AF851D4707@qq.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 16:46:37 +0000
Message-ID: <87r0iveniq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

"=E5=91=A8=E7=AB=A5" <273415826@qq.com> writes:

> Dear Experts,

(add maintainers to CC)

>
> I am writing to seek your assistance about CXL emulation in QEMU. I am Zh=
ou Tong and I am researching how to use QEMU
> to simulate CXL over Ethernet=E3=80=82
>
> I want to implement remote registration of CXL.mem devices based on the Q=
OM model. The general idea is: the CXL slave
> side notifies the master side of the size of the CXL memory and other con=
trol information through Ethernet, and the master
> side registers the CXL device locally based on the control information. W=
hen the master accesses the CXL device, KVM is
> responsible for intercepting the action of accessing the memory, and enca=
psulates the CXL message and forwards it to the
> slave through Ethernet=EF=BC=8Cultimately achieving remote CXL memory acc=
ess.. Ask the experts how to register the CXL device
> locally based on the control information without occupying the HVA resour=
ces of the master host (OR display the CXL
> device).
>
> Thank you in advance for your attention to this email, and I eagerly look=
 forward to any insights or advice you may be able to
> provide. If there is a more convenient time for us to discuss this matter=
 further, please let me know, and I will be more than
> happy to accommodate your schedule.
>
> Once again, thank you for your impactful contributions to the open-source=
 community, and I greatly appreciate your time and
> consideration.
>
> Regard,
>
> Zhou Tong.
>
> -------------------------------------------------------------------------=
------------------------------------------------
>
>  *  =E5=91=A8=E7=AB=A5=20=20
>    273415826@qq.com=20=20
> *=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

