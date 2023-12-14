Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A5C8134E5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 16:36:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDnjf-0007Ma-TK; Thu, 14 Dec 2023 10:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDnje-0007Ld-1U
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:34:50 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDnjb-0005zs-Pm
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:34:49 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-550dd0e3304so7772362a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702568086; x=1703172886; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nv2TX1Ip2iaU3Gdt+lOUIp5X3QhzzFnX3LN7f4+v81w=;
 b=lbd5qCcdV/FjJkcifIgNYvGYjaGjAISKHRLYbGqA1om6VRVVA70eju8yxNx5GdYWQN
 wJGCCFT32BP5wYKDwtpX34uGZ+qr0wJFUptuH3KsDmn5QOIT3Sff8mAajVGZUg3zdkBd
 7z+Uro79pGzWrdlirMsg2NIKHppJMUNsvFJRuxPOnlxykKSXOGgk4lNGKpJxonyi6Ih2
 xg4hNJOdYvrGiSxowua1N5a6fDWpuNM+pZGphSYERtyCvLQBPaGqceEIJdwdQmnIfilT
 GS0/R917XqvMy4jB0tCwdQtBu64qrq48wT3lEPuD6wtsnTpxvsBtMSjUcedun4STvIc2
 uYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702568086; x=1703172886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nv2TX1Ip2iaU3Gdt+lOUIp5X3QhzzFnX3LN7f4+v81w=;
 b=kzp4rMMwXuWTx8Xsh9w1XI8f6We75EDgTi0fHyeaT509C+y8+Uo3dJthAsneKacYKO
 Aprq52M1bgcA9UXHZaYr5KXaZBDidM/ulD7Wjj5fpGkGmy/WXTBRO1Ae95BiM67eKuQW
 oJwi3XJh4p6kFP7YTa4r6lanZnCFk5edVBcATJcROhv0QYSlZHx+lTEY6Q2BabL2bC4I
 /z0ClrKouRPB/owd4AJz1Bbl+/pyQImc3LYWGZ3rf6qNXpoPLjjrBqKOoSdY3MpqgA6q
 F+C/WRsexKWHOsPVtLWJiOlYT18vo3CNmTbO92/0Cr2n730ccz7tCgjUuqWs4oZ86vAg
 QkOQ==
X-Gm-Message-State: AOJu0YwLPAx4iqf8fS73ZLAeORPvLTZ2VLUZYkl8VYWo724A6tJ21umt
 Uc3mMVpskXnr7jd6VIZb8bG2A1xILbonXvUU/9Ijjw==
X-Google-Smtp-Source: AGHT+IFcq6DemeL/YJ2XuTTh4jlsRgMuGMuDQEtXvj/bCvfTy5ls4pzl8QuwCb3aopkrNe2aCWakxkKBHdxMz7mxpTg=
X-Received: by 2002:a50:9514:0:b0:552:31c2:83b0 with SMTP id
 u20-20020a509514000000b0055231c283b0mr1088462eda.39.1702568086292; Thu, 14
 Dec 2023 07:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20231123183518.64569-1-philmd@linaro.org>
 <CAFEAcA8S7Ug8uFpvDO9FarLpLhTr_236H8gOK=dEOWQZe-3zgg@mail.gmail.com>
 <e4443aa8-1b36-41fd-b1a8-6ed7ddb2f130@linaro.org>
In-Reply-To: <e4443aa8-1b36-41fd-b1a8-6ed7ddb2f130@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 15:34:34 +0000
Message-ID: <CAFEAcA9v33h4EgfvFdH0EtVaf0jxtyAahUwEqoVDA39Z1izwTQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 00/16] target/arm/kvm: Unify kvm_arm_FOO() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 13 Dec 2023 at 09:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 11/12/23 15:36, Peter Maydell wrote:
> > On Thu, 23 Nov 2023 at 18:35, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> Half of the API takes CPUState, the other ARMCPU...
> >>
> >> $ git grep -F 'CPUState *' target/arm/kvm_arm.h | wc -l
> >>        16
> >> $ git grep -F 'ARMCPU *' target/arm/kvm_arm.h | wc -l
> >>        14
> >>
> >> Since this is ARM specific, have it always take ARMCPU, and
> >> call the generic KVM API casting with the CPU() macro.
> >
> >
> >
> > Applied to target-arm.next for 9.0, thanks.
>
> Thanks Peter, the only change I added from Gavin review is
> on top of patch #3:

OK, I've squashed that in.

-- PMM

