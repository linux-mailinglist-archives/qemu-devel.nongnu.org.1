Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C987808D8F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 17:37:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBHLp-0002eX-V3; Thu, 07 Dec 2023 11:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBHLm-0002dv-Q2
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 11:35:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBHLl-0005oE-Ak
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 11:35:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c236624edso12144115e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701966943; x=1702571743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8na5YV2UKRJKrvZNqXW5ynfPFJo2Y7T/xB70HYZTi4Y=;
 b=o8COGIozica7bzqvmlOBfHnyv+wSW5HtDqVy+2ysWUSx8SHW+YfiYWgkvwUcXBquM3
 bUXMiIbdh8cQHfeExW/5er+XqjjNOojmArFlVeERfv+PCu0zbos7pnS32nZ2meeHKftZ
 oxDKPsP75hXomGxXdKdYNCc/BMhXAuMK4jvYUXiqJhFcnITcEY+I6XcaB99Gn0Ft4UO2
 P4X9oPFLysYiHIa/82Psi9j1J21/QdG7lpoBLC4G0K3E2LtAPIscjd+QCyzZ8Rw78bME
 bSHDZPeXfnrXXsygh4I33VGYeyrpj+AseoYC3Ef5c9OAZ2yuX+R5vnkLNoQ7IKWJz+N2
 Sf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701966943; x=1702571743;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8na5YV2UKRJKrvZNqXW5ynfPFJo2Y7T/xB70HYZTi4Y=;
 b=xE/urOHwzBTu/dkF7FXJFhI1BSkbpiO/ai6PMA7AuI50HPjwxV2a6dgM+AecO6BRRr
 gy6QHIyX6qP+KToNiowZUPC8nC7/R4YO4fO9Av6DQSU2kvP0BSx9kuxs51W3ZnyQO3V2
 8YH1DZCDmvALrRONxrtxad8RDdmu9rYSAlVKngg1OPz6p+LgJrHUfUItlU8DJTWZxqjP
 mM+Epd8HqdfcVSMsQxd/AbqUrFSHoDXR2YSXHgBNF/1lGWARA8R7ggAC9p+VuPQrm0hB
 +NuB3pbIKaNX171oAlb9h0fRGoTNWJT5tE8rjf+p096j+ZmkaGJYw00N2l46o1kSKfMW
 t+WA==
X-Gm-Message-State: AOJu0Yyee+APpeCmFdDcEroY3EzjUFoTPhEnTz3trG8YgI53y/HZOWmD
 Jocd0aCAA2Gd7laX3ShuZT8cK6BLDzwZAHyJhf0=
X-Google-Smtp-Source: AGHT+IEjnXBbGLUTJzBbEsoocZqBJcyb/TkLMb4OdS0gPQY+c7bOS5INH47KC32Uef9SrxFeRy6Ffg==
X-Received: by 2002:a05:600c:4688:b0:40b:4fa4:d59a with SMTP id
 p8-20020a05600c468800b0040b4fa4d59amr1709412wmo.10.1701966943029; 
 Thu, 07 Dec 2023 08:35:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ay41-20020a05600c1e2900b004063cd8105csm2498094wmb.22.2023.12.07.08.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 08:35:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11B265FBCC;
 Thu,  7 Dec 2023 16:35:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Talha Khan <talhak2111@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Build qemu without USB,network devices
In-Reply-To: <CAMnsxbAr3GyB6bpvrYMt-31Q+ZKuEoLm+i++CWs6thQmQUXtVw@mail.gmail.com>
 (Talha Khan's message of "Thu, 7 Dec 2023 13:27:07 +0530")
References: <CAMnsxbAr3GyB6bpvrYMt-31Q+ZKuEoLm+i++CWs6thQmQUXtVw@mail.gmail.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Thu, 07 Dec 2023 16:35:42 +0000
Message-ID: <877clqynq9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Talha Khan <talhak2111@gmail.com> writes:

> Hey all,
> I want to build qemu without network devices( nic ), usb and vga. So basi=
cally a very lightweight emulator without the things
> i need.

You can configure with --without-default-devices or alternatively
--with-devices-ARCH=3DNAME where name is an alt config in
configs/devices/ARCH/NAME. For example:

  ../../configure --with-devices-aarch64=3Dminimal --target-list=3Daarch64-=
softmmu

Should only build support for a minimal number of machines and devices.


> Any help and leads would be appreciated.
> Yours Truly
> Talha

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

