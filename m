Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35096747276
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfsg-0006JO-N7; Tue, 04 Jul 2023 09:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfsc-0006B2-34
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:15:44 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfsZ-0006Eu-Gg
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:15:41 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51d9695ec29so5385024a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476538; x=1691068538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duSIobqmJ+6xDh9LXiA95cPbM3Ke85YlO7/s8EEKSn8=;
 b=JeKvD9omZveW6guUMQ09RNC/lqx62bG80WzBpLm3l5hdJ0YVu+FPX9FDqrUGvVZFZX
 Y+R5jzPYUmrcpSp1RTCaOPOOgZhNjhMtx5qHrWjI4ZcZQDpGnkbfSjxwAd4VfHygCChW
 enKpZeUcloDHDR02Pn06Lw3A0TV+8uZbzn9/DPKoAdO/5B4eH5tMz3lufUUpGLMkUlRp
 rzBElOUqxdShNvN6LU2/91Ls1XDVDR6RxAklLeHzdaakdEKh5i3D1rZGKpEZzcepUgOU
 EG0veGBaiuX9miN4QWRF2DG24/x2RJvGYsq9n5DLVWGQFGzGf9h3oNrp010AWvMrZSXY
 HjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476538; x=1691068538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=duSIobqmJ+6xDh9LXiA95cPbM3Ke85YlO7/s8EEKSn8=;
 b=SMBBTTNCsa0B6eDWw3Abz1+jb9S1yLnoMpUzAjfewFC07FhSo8eUDdQ6o++hMSzb2f
 G4HZgdn/q48BmzTVG+EerYfdD61CrSYYwr2g00Q+iGjuggQk+DcaRxwXbZpXi0Ty7Zw3
 lRXyLj2A13m8xgwQVB6SruTJFuuE0gwTGLDETwduNzJM6U1HO3cY0XqqgJ4JPecNr/tK
 G4mK3V/5vMHvz3qoftH4DesB8XUgMvdA1o9Fc5e5YvNss3642Mxiy3iuJ/h9u8brsaqq
 X0PFA2OspU6k4rWAFHcVG4I9HMS0r7p3NiJiIXf8gg2p9YCAOIAOddNz0JwHw+d6vf1b
 +Zdg==
X-Gm-Message-State: ABy/qLaYC+nqskHSsPVRubQuY9HVoFOMrSCsyv3uGe0wN8BpNxsoEIlz
 obA0ovSy0tpmET/vOvxnLb48qHgmPJztYLEurHfonw==
X-Google-Smtp-Source: APBJJlG7XHLTyfESv72d6EJ4F4Xt0d/ZJwMdX539lpG0kc+M6u5/Fh7q/9roRbyFrcrcJ1m05t1FIk5d6mtHCfnUUa8=
X-Received: by 2002:a05:6402:b2d:b0:51e:1a3c:e72e with SMTP id
 bo13-20020a0564020b2d00b0051e1a3ce72emr2163270edb.19.1688476537808; Tue, 04
 Jul 2023 06:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230628164821.16771-1-farosas@suse.de>
In-Reply-To: <20230628164821.16771-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:15:26 +0100
Message-ID: <CAFEAcA-Z+ThrYO7ycQxc7eVZzF5f+OinL7R=_Cm-SfQ3U8P6_Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 28 Jun 2023 at 17:48, Fabiano Rosas <farosas@suse.de> wrote:
>
> This code is only relevant when TCG is present in the build. Building
> with --disable-tcg --enable-xen on an x86 host we get:
>
> $ ../configure --target-list=x86_64-softmmu,aarch64-softmmu --disable-tcg --enable-xen
> $ make -j$(nproc)
> ...
> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `m_sysreg_ptr':
>  ../target/arm/gdbstub.c:358: undefined reference to `arm_v7m_get_sp_ptr'
>  ../target/arm/gdbstub.c:361: undefined reference to `arm_v7m_get_sp_ptr'
>
> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `arm_gdb_get_m_systemreg':
> ../target/arm/gdbstub.c:405: undefined reference to `arm_v7m_mrs_control'
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>



Applied to target-arm.next, thanks.

-- PMM

