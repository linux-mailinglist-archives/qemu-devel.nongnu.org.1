Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D67529B6
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 19:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJzyD-0000RX-AP; Thu, 13 Jul 2023 13:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJzyB-0000RE-4C
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:19:11 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJzy8-0007e2-Ft
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:19:10 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fc8049fd8bso1629178e87.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689268746; x=1691860746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mrhJp7tgiras5q9Lx+eXgQee4fQCartEnaD60a2vQoc=;
 b=S+wY3400znzrcVqxSMBs7m13MVmiKvLLeNHX6UyPK2ALX75gVWWVZJIVPdXN9RBJUz
 5lCcwDREOfNZ7fR2AtG4mA6bJt2KybO85wfDS2v4wfoEUVxL11ctxNHPEaf8bneB3jpE
 C5DxUuLGKOitI8pTVGZfZLTqDLucXMMJWauEFJxdcGGIHA8eeMhBhfiC08qT96BbuB++
 ipd0RDVdO5vnRhzQoaLGsaM31K90OZlN/mgHlhb0vX3XyiD9H+A5sfMR81yA2ahMK5XK
 uj34+p6GkiwUmjPriWEMgob/eHwOAM0fV6bXC4CueoYuGSNtyiyeFgKO5TKPhkhp0zI5
 9NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689268746; x=1691860746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mrhJp7tgiras5q9Lx+eXgQee4fQCartEnaD60a2vQoc=;
 b=YyDqqpbZrXF6Rq9yF0WwVA/c/lYddRiiWCXt6Wk7/FbVL8OZ5b0q1Q0vX1XLGZ/p4i
 m4oB6/TsQpDAnh9bqhtz2vz8YwCNtI6agAEf+hR1fyu8Q8JqJGAoUDTDTIeLYYiCSVLn
 2FmpNgI3cR3DmQPO2Q+4TSZZZODaXmaRWOpbpSsYHVqZqIhbyj/7SABhx3rNVEdtsWXF
 qqHdaSczfht8d6kELxLUGNRN6sz/T2asbH328mnzagWgaaRWJbgXjp3dSFTMfPnZ2kWU
 L4Xl3zbJGZbTEdLWUO8Z0iNB1Nir0FBXP51YcR6/mwbVTjjpO/xoAfBy7Nld6aSPYBol
 a3bA==
X-Gm-Message-State: ABy/qLYK6CjC2/mfmEJdQeEhWhVXjIBGS6JdrBAe4DeBGLUmhckpw9kz
 NFz6j5bruqF9DiKXTplzC9Uv7bdM8w7zXjqg+2+Mng==
X-Google-Smtp-Source: APBJJlGQsEQ4SEO/qOxEkpH8YnE+3e4amF2jcJORc/4P7KZ8TmeTbvwpv1Yn1BpLh50mYpUzqSXui2NNUMz080/9YO0=
X-Received: by 2002:ac2:4f16:0:b0:4f8:4255:16ca with SMTP id
 k22-20020ac24f16000000b004f8425516camr3131393lfr.38.1689268746500; Thu, 13
 Jul 2023 10:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
 <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
 <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
 <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
 <c5b44af5-e737-d899-5ea1-3d7debe760a4@linux.ibm.com>
In-Reply-To: <c5b44af5-e737-d899-5ea1-3d7debe760a4@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 18:18:55 +0100
Message-ID: <CAFEAcA-igpEHJOxw8mCV=em6FRUT8BuNRPCiVMvQ7moaasSmLw@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Thu, 13 Jul 2023 at 18:16, Stefan Berger <stefanb@linux.ibm.com> wrote:
> I guess the first point would be to decide whether to support an i2c bus on the virt board and then whether we can use the aspeed bus that we know that the tpm_tis_i2c device model works with but we don't know how Windows may react to it.
>
> It seems sysbus is already supported there so ... we may have a 'match'?

You can use sysbus devices anywhere -- they're just
"this is a memory mapped device". The question is whether
we should, or whether an i2c controller is more like
what the real world uses (and if so, what i2c controller).

-- PMM

