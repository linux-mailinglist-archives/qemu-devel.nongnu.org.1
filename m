Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 447F373E5DB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDpU9-0007K4-6g; Mon, 26 Jun 2023 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qDpU7-0007Jf-GK
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:54:39 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qDpU5-0003Yk-Sp
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:54:39 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51d9124e1baso2823301a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687798476; x=1690390476;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PGewk6oFRCd9wb6nf6Zn3+P/Ru/5xZ+/jSUK5MxHbko=;
 b=DROc6YTLOqhmbtuEd8peNXSXj3XMIKTOIa2+szNWR/tAOoJ3AYuRM8+DVnnRGHOUbT
 EfpYKDArGKElj2FkPANDQeKZSR7gprBoZ5y3VLzzSSNeRtYV+HIO52Whch3x+aQ7YydZ
 e8ehiU0jks8rMn/OPn5qpBIWhZog0/cvrtKaE+cZhjM9k5G0AblPCHM030zs7986q1I+
 RD4fpz+veXysY1/0Ljdv2BuhCHOVoyQFnn3Mape1OuOBlPnHmQqJqfrXmFcvJycBOO+Q
 Zo87XJntNzKxDuASXM60xpndfeoUcNDkNcV6vDV11YBhkGsF28U2UFq8lAnmo2FzN9hg
 nWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687798476; x=1690390476;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PGewk6oFRCd9wb6nf6Zn3+P/Ru/5xZ+/jSUK5MxHbko=;
 b=les+EcoLifnet6TJOQH/lYWyD12LJBfK0VdOTPOBtt2l0mj8uH84mWvpsd4ZMHff5Q
 VM7pbGSEciv94IK9zwZLcXTyu2XRDcuAIG9ZoN7sJecr0cpUsAKfrQ2b/fKfPTdmMstB
 P9CFYj7/DpAFWBCqZRRx8j4KYUfZsMLrKAsFVKkEKuFoB8AUIyy0TjGs2Grd3aqKFBL0
 mcPsnChWL9hldjhT6Ra3RcvvYCyy1nJpMOGg6esfBGycE4S+Zh7CZyrZqxDpsynD5GS7
 gkhCDiip8HQ3G0YMLzMpfhNrEijvbCtjJSn53XK6d0VTupcp5ggLsbJLnDeIRSCmfnNK
 rAGg==
X-Gm-Message-State: AC+VfDx2ROfCjBbhi/ecS6cSsovhMxLmCwuQKiBMn0h2JWkIVFbsoRPb
 InvzuLyrmQKwN81Lz5tJj0yGAIk7JsF/0CkondblAoCw8c+oS3uh
X-Google-Smtp-Source: ACHHUZ6wG37/rRRy8gNfeTxKZtV6WDc0a9LIv04sHM7gS7FeVMn3K1mtV8BEHb6jLGFiD08lwOr/gnHIoO5aYcWMBLc=
X-Received: by 2002:aa7:cb45:0:b0:51b:fd29:b502 with SMTP id
 w5-20020aa7cb45000000b0051bfd29b502mr6110126edt.35.1687798476049; Mon, 26 Jun
 2023 09:54:36 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2023 17:54:25 +0100
Message-ID: <CAFEAcA-TNaJzMPGCMEN-erSc1bQ4myq6SyiRDHY7_7fKLdqyQg@mail.gmail.com>
Subject: which CPUs should call aarch64_add_{sve,pauth,sme}_properties() ?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

At the moment:
 * aarch64_a64fx_initfn() calls aarch64_add_sve_properties()
 * aarch64_max_tcg_initfn() calls all of
   aarch64_add_pauth_properties(), aarch64_add_sve_properties(),
   aarch64_add_sme_properties()

and it happens that (ignoring 'max') we only have a64fx implementing SVE
and no CPUs implementing Pauth or SME yet.

Is the idea that all CPUs (both ones trying to match real hardware
and ones which are QEMU-specific like 'max') should call these
functions to set up the properties if they exist? Or is the idea
that 'max' is special and match-real-hardware CPUs don't need the
user-facing configurability?

If the former, maybe it would be better to put these in
arm_cpu_post_init() so they're automatically called if the CPU
specific initfn set the ID register value that indicates the
presence of pauth/sve/sme.

If the latter, A64FX is an odd-one-out for creating the SVE props.

I ask because Neoverse-V1 has both SVE and Pauth, and I'm not
sure if its init fn should be calling these functions.

thanks
-- PMM

