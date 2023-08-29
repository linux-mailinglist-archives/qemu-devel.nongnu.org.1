Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D4978C54E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:29:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaym6-00043I-8d; Tue, 29 Aug 2023 09:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qaym3-0003vb-2x
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:28:51 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qaym0-00064b-6j
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:28:50 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so5729718a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693315727; x=1693920527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sx/bM7QdDkhgmgSr5gZET7B5Nu9MmQxxvRD9Yyke+5w=;
 b=yAIwLpfqN5VZ6cI6B80Cjbk6a4GfB0KHGKLb2HnL/FsDaJHxMzBLM8n+brZ+ixwzfP
 JJ/xY0DrpwNLkY3KtleFDkNhMVJnt7i4kTS6fAmMm2fFPFSVX1PXCxUgABoP14XABYOi
 PZUyJGMTKFsK43EMdu2h5BGdcWA8eQErIOG1vs9eb2jzl7oukE0HZqrNJOVPdeic2odX
 KsKYogL5a3okm1KfQLt4S0yo6ftfyTjotvtXLD6YK3su+wQPI2rvvV4CGMSX4FS0ysxh
 0MEitVPAZvAadKJKm0ubNW9z2Efr20gOe5qPv4HnlSn5haK17u57MATGl8Wf8mzkxKBZ
 7tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315727; x=1693920527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sx/bM7QdDkhgmgSr5gZET7B5Nu9MmQxxvRD9Yyke+5w=;
 b=XoI6WRoM2Ybrr2ut65f0oXR86MaUctEOfleQw8fFTiQ3qf/6WXuex/unY0HfcmzeSj
 cBT2NSh7mrCOphP2Wg1v6sCSFQ+2xWp/9sN/F4/3B32sZ2fYR9K+FEoWLsJykcU7Pgoh
 3HNl1hdVFdChHTW3f26l04LE31aWMNW7mBQIRE8heUI8xjiWkmm+oK2gYqu77zbwkj3I
 Y6xfg0B0L4lLR3cRyYRlh2HIkQYNPl9LYdJxokd/GWmB5GTPYdv3rqmqomk8/jEXPUv/
 cQBsXHSzkm+Bx8G1KtMahpnFRY4mcGNTfVtMCje3lDsC5fSQHhZLrNDKaNR1ekty1+yr
 c2fw==
X-Gm-Message-State: AOJu0YxoplRYdktNn0bkN/rdDsxdphU4eLFBoK2AScVvt1mbz5rvM5GN
 nIMsehEnMv3dxxLsDHW8tHuEgXhc+SLq+cnfJfnsegEuhTXFBzxO
X-Google-Smtp-Source: AGHT+IFE2/XaFACj8pHDieqIBhEfpgtUsTz9IcFFUvuGMleCcjXxFfE4uL2xccsrjVlN2tb4ZDZ2WO8qhSu8/onug68=
X-Received: by 2002:a05:6402:31ee:b0:523:4acb:7f41 with SMTP id
 dy14-20020a05640231ee00b005234acb7f41mr20490615edb.14.1693315726997; Tue, 29
 Aug 2023 06:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692964891.git.jcd@tribudubois.net>
 <59e195d33e4d486a8d131392acd46633c8c10ed7.1692964892.git.jcd@tribudubois.net>
In-Reply-To: <59e195d33e4d486a8d131392acd46633c8c10ed7.1692964892.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:28:36 +0100
Message-ID: <CAFEAcA8LF3zzne9PuvV3H0j-w7BtfEG8B7pp8bkgEWi7aTZ_SQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] Refactor i.MX7 processor code
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 25 Aug 2023 at 13:22, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> * Add Addr and size definition for all i.MX7 devices in i.MX7 header file.
> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>   - SAI
>   - PWM
>   - CAN
> * Add/rework few comments
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

