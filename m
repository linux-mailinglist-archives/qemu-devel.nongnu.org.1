Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301973A127
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:47:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJhK-0002vD-AH; Thu, 22 Jun 2023 08:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCJhI-0002ug-Iu
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:46:00 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCJhG-0001qG-Ti
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:46:00 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51a3e6a952aso8360395a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687437957; x=1690029957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lEwB5Qxt8Jc5L249b/yUgqX817SyHViHn0bdjo0QeWg=;
 b=AsDcVeGXBacQDyXpQH2EvVp+cQ0BrxNHct3BJ9sRkOErLiBsk382bwcqV2vQdqzUTW
 iAKbEzLHl7K8JD9GfHydcqeZTlGVFUJhp2pbxmO4dybteryMIdOIOUmEo5u43MXpGVMz
 Y6ssut/3VOW+INHvCXV1zCLNJH25NPb7HUPXmrWhDhOF9uwRlfZO+goQLQ9om7xon2vc
 B7mBpBabhK2DSkXRSAtOYWqmeTofauK1cvDpjp22QDEiUx0O3vqJp9krITp9+80r1ybp
 5RcmKMbmqDzGchTIAmRVN0YewhnI4rhW5TfgmFTAbHbLWCnwvZV6GQ0xzepIaxLO36vz
 bK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687437957; x=1690029957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lEwB5Qxt8Jc5L249b/yUgqX817SyHViHn0bdjo0QeWg=;
 b=AGvKVPHA1Ef0UtbwVkwvc+EfBAgEMyXvHFAIs3r2Dlct14/B6h/FZcgHlVk9D42TYQ
 2D3JL2t29Ptx45nMBS5abvFFA3K1d3gNpBadKvwej4qVnfaWecN2rSGTlauD6Ei0pGPf
 jn1EsMpq1OuDBVds2YD3ynQAX+N4kjDqJkOCZv795PUbEyuQuqYbVcjo49XKIeswa73a
 8Y6BNViY65wFnGD3Ow56qkmiwNMYgcUE2f9ScQvFUJ0dB5WNc4XNpv90YjsAntvKjQOW
 VgKqczwsti8kmzj6B6ziyMHNhY771+GW7wfBK/LRKYz6Jqnrg6i0GMLW7Dwpo3xPsxT9
 Y4kg==
X-Gm-Message-State: AC+VfDyiHTW9UNJkRG/0xOxZ/PClrrBBg2ZQeWcCnSUVM8quEJXq+ZEO
 jJL3K2bEWYVhxJ99b+PQaBe5jbb81QmqgGp79TKMfA==
X-Google-Smtp-Source: ACHHUZ68D9tvNdrMWw+DdznwC0DBEzedlibC2POJVv53DbIWMMjQsN5bdHoA/9eh/PieUKKiQSaPhymyy/sXPnyKHJc=
X-Received: by 2002:a50:fc07:0:b0:51a:60be:7d5a with SMTP id
 i7-20020a50fc07000000b0051a60be7d5amr6526257edr.14.1687437956785; Thu, 22 Jun
 2023 05:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230620124418.805717-1-richard.henderson@linaro.org>
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2023 13:45:45 +0100
Message-ID: <CAFEAcA_mRP1=TrtF4dk12owguHTSCBKmjkMXfCb9YYFcOqqCPw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] target/arm: Implement FEAT_RME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 20 Jun 2023 at 13:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v5:
>   * Enabled only by cpu property x-rme=on, not -cpu max.
>   * Rebase vs SecEL2 fixes, now in master.
>
> This doesn't have the magic RMM memory, which previous patch sets
> included for booting Huawei's forked TF-A.  Upstream TF-A does not
> have sufficient code to build either PLAT={qemu,qemu_sbsa} with
> the RMM enabled, so that can't be tested either at the moment.
>
> All I can say is that this doesn't appear to break anything else
> with x-rme=on.  Which is less than satisfying.

I'm going to apply this to target-arm.next, since it's all
reviewed. I've added this to the patch 20 commit message:

# We're not currently completely sure whether FEAT_RME will
# be OK to enable purely as a CPU-level property, or if it will
# need board co-operation, so we're making these experimental
# x- properties, so that the people developing the system
# level software for RME can try to start using this and let
# us know how it goes. The command line syntax for enabling
# this will change in future, without backwards-compatibility.

If you can send an extra patch that does the documentation
changes that would be great; I figured we didn't need to
hold this up or apply only 1-19 and not 20 just for the
docs update.

thanks
-- PMM

