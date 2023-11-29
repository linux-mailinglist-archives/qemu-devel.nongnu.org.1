Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342977FDBC0
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:43:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Mhp-0003Er-SJ; Wed, 29 Nov 2023 10:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8Mhl-0003Eb-Vn
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:42:26 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8MhX-0008Tm-0F
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:42:23 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso5039736a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701272528; x=1701877328; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3bMUMk32+sOchxveB6vtyBp52QuYuL8OdJA9GYAtSY=;
 b=lRRLqV0ycik30+fYYpyeqpNgUvvO6bJZ7qUFpp+syfM4lSAxpYZpc0B8tYWuSmR0EM
 6SymLf451dH6UnqIBLPRFGEmReOqRzFo/ePYOvrDaAUIG0Ayu4uUz4c+DXG0KswRhSNX
 /Vy3xjp4cBiPZsI3o2GKhqx0pcUNMCrC2+K3gJmcU1r2duDUWcpQrLDwqrkOdYdkDELS
 HHCcCyfg0eYnRIowHogsdCuwV4CeIeaGFv5FOku2dhHbOJZtx6k2Bec+1V4Bzsz64Ori
 gmOBszpgJi3+5DPy/zbgZ6uFcCjjv3J4izoWSJm2yfRxf/KyJKLcG43HvrzHFryPI5mR
 k39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701272528; x=1701877328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3bMUMk32+sOchxveB6vtyBp52QuYuL8OdJA9GYAtSY=;
 b=XlTpzmxl4mSKeNn21tK4aTfSlwvg8fur9Ycf4uch4sBOsgc/qPlXrnggUeQfFSkgd1
 IyoTB5xoGM7hUEyficJlirUMjLGcijWekJLC7yw7xX3SDL11FBGMQJ9H/b31FSESDyoA
 ZogobxoB8tRrKo6I6T8j/fIZDOt/ClpxOXigtdNm8QuCzUVFAWP8aQdrqd4Ntb+zB7El
 Wi2wiv1J138Mcd7kNW1Funeh/MBlSuA7y0yh428mcHqSkuXKD12Kvd1ysmCU4rmpzqKs
 BgOLeV6WCFRnQs6fPzvMR6CltJQbz8Kg+xAidTxH+SqPc89RK3++qqty8TCUyF4j7XtZ
 v6jQ==
X-Gm-Message-State: AOJu0Yyv533EYpsBFGd9VIzgjrD8QDn6HF5qL6ujCklDzXIQukwDbP/U
 4DOpLvbuTJar4duQfRi/0ejlrkoB/2O9cZwMpPk=
X-Google-Smtp-Source: AGHT+IGTAn7Pfl7XUa10/4iwAKNrAWIduL7rwT/jWsLiDnsC/uwPL0dbrvAqE73qqfrjvl2pX/kcgtaRPSivsJ7DpoU=
X-Received: by 2002:a17:90b:3b4e:b0:285:8cb1:7f52 with SMTP id
 ot14-20020a17090b3b4e00b002858cb17f52mr19615920pjb.18.1701272527820; Wed, 29
 Nov 2023 07:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20210720195439.626594-1-richard.henderson@linaro.org>
 <20210720195439.626594-15-richard.henderson@linaro.org>
 <7a6efb0c-62fb-4047-a20a-261ebb8c99ac@linaro.org>
 <d071f147-5d5b-457e-aeb6-9f77868245b9@linaro.org>
In-Reply-To: <d071f147-5d5b-457e-aeb6-9f77868245b9@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 29 Nov 2023 07:41:56 -0800
Message-ID: <CAMo8BfJxF9Jf_ddF-yim0d=h0oSXfm=Zm+m3nHT9iJ0noGRXSw@mail.gmail.com>
Subject: Re: [PATCH for-6.1 v6 14/17] accel/tcg: Move breakpoint recognition
 outside translation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org, 
 mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 28, 2023 at 10:06=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/28/23 05:08, Philippe Mathieu-Daud=C3=A9 wrote:
> > (In sysemu there is a single use in Xtensa tb_invalidate_virtual_addr).
>
> I suspect that should be migrated to use the common HW breakpoint support=
.

I'm taking a look.

--=20
Thanks.
-- Max

