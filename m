Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482C7829B1
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4UB-0007Md-Mi; Mon, 21 Aug 2023 08:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY4U9-0007MB-KD
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:58:21 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY4U7-0000lJ-83
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:58:21 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so1916657e87.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622697; x=1693227497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9AXhkJc4wnoaXIkJWcdWtTmLAonQ/5Ep2biAFuEjr0M=;
 b=Ww0wPj89ceO4dgoxAKvXdETo7mCkocZxaNk74AEuGv73rAOodygyxBQghE6oWD056H
 ZC5gZl+qpQYY4mbi57eXIVAc7B6P086V9n3IioLCLSBAqGQoDi8/6d3x9pciimgYk8i4
 6YlBjL4HEyw24CLS2OsVP+jI8D308pOhYrfmNThBNmalb1UfBB2KXnLJJtE+f3Q8vBxF
 di2K6CfwZa51DJ9EbRJA4clfKqn6J0CLikjq3yHwpQIZLc71sFtKnMDmU4OXTPA8/U9e
 EKIM3wqL3oSC2KwSNgiDiDHcD3a+0zQ7gO5TJ1Lb+mEShg0+42b/OqndKHpvsva9HfiM
 +4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622697; x=1693227497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9AXhkJc4wnoaXIkJWcdWtTmLAonQ/5Ep2biAFuEjr0M=;
 b=et/qNGV43hVti7P2hy4KuP0AFqgBZTjPkPzzZi3F5A6qR3Rd7bypkRPf3HkMpk99Y8
 7p247oE4acLJMLUhZkEZ4nR80KFuEbzciZM0R0EZuvT6es3Ez6G+Nyd5j1lZsXf28OKO
 iN2hNt4Bgt82hz4gSmuQH613FhlJakcIL2F6oj3G+baS8xvR4kAOmw+tDWm6Run7DhRK
 rUBbJ36ruD0t73ixd07Hm54XcJVgkyt5oX6jJiYZddedfsAYDfzef3A+hGRcnKlHQqw6
 l0FtABSDGD93mvXIse9T44PHW/tOMAsevLfX884/aqgf+2FCXAn3/c13/Q4B2PRGDEFM
 JjvQ==
X-Gm-Message-State: AOJu0YznAspBatCvbxhe4Bclv7P9GD8VsCKU6HxT9dg/lhMA8aMY9HDI
 O5QOErzrw5xWmcjrTjuBMrAYbJh9iaf5aZt0r+qcow==
X-Google-Smtp-Source: AGHT+IHC+ESplssJVH1l0CjOLWTh/P2mDbgifOapXBFkJHXz5wpYBkxjGaqlBaDs2CPXQXJvcJVxtqr7aP1cElscuGs=
X-Received: by 2002:a05:6512:1192:b0:4fd:f85d:f67a with SMTP id
 g18-20020a056512119200b004fdf85df67amr5732197lfr.61.1692622697236; Mon, 21
 Aug 2023 05:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
 <20230810191626.81084-9-francisco.iglesias@amd.com>
In-Reply-To: <20230810191626.81084-9-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 13:58:06 +0100
Message-ID: <CAFEAcA_o=W4jw929dAV+PNGL9zdhVEOWkBE0fFtx-J50cXQ3xA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] hw/arm/versal: Connect the CFRAME_REG and
 CFRAME_BCAST_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Thu, 10 Aug 2023 at 20:16, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Connect the Configuration Frame controller (CFRAME_REG) and the
> Configuration Frame broadcast controller (CFRAME_BCAST_REG) to the
> Versal machine.
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

