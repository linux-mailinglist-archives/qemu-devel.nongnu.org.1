Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B279D6C7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6bV-0004K8-IL; Tue, 12 Sep 2023 12:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg6bT-0004Jv-Ng
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:51:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg6bR-0000Mw-EB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:51:07 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso5783145f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694537464; x=1695142264; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KWP+oQLBWQrgtWy4H1v3FWKOpWPXfvGrZEeJ0+m2YCQ=;
 b=KmnFm1L3nipAOXgNly4BMBcOEh6GsH6zmZi+QMigP4IDrlKeAU9DgPS2I/NPEl5NUn
 Nv4MF8kmpS0GePnqfTXFpMiMV7KuCV+XWwUcD08M2ndtDwUviv/4RAHJye06VZJgE/ju
 v8hr9BqCo7vwRZHD2Hw7nIDsJ7aNPEJG3wm+5cW4adijIffEvWkq2jN38ZbT1wwEgFmf
 wZev51QVF3den3rX0kKj74bK8xpUmlgKcA98YZS3+MkCcKF2NuQvBT+wCcFa0GXn0qZI
 9u9S5q/2C5/vwz+TRg1QquMRq0UROwSmk4VDLCp+qkwmZXgUL86Y+1mRhp8jNbIVU9n0
 8MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694537464; x=1695142264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KWP+oQLBWQrgtWy4H1v3FWKOpWPXfvGrZEeJ0+m2YCQ=;
 b=rFQZJ35VKqoB3h+dAc05LhZMWwBAw4+qACmUehUE8x0djJyR+Q+ibjBgFFwW6jHr/n
 Jh76Io6V3lbb8CUckmky6bn2F3y4YsLNkPfH6Zk6I3XC/L9d3F+QMHACuyKCcYe+RPqT
 1t6TsAPg2wXVoWBGm0avUooJDahaecJAqzIitGGlsnxQeyrL+S+5d2h3ADnZ1QZ+Sc+H
 iPljdlIAblrYFyt50nLoP64msVbvgFx6gruPe7EgC4vu1fSa8hYZ16GotWp6P3U7snLR
 zufguUtpizVbfwR5eh8lSzk5BV7KZyletpdIItyGBzvZWHE0jIPSBHL3LCF6NbbBe4Ng
 pUyw==
X-Gm-Message-State: AOJu0Yxg1vVek1hSG0OWUBm9tHHcP88mglf1aHCbdEYA14a06BOslbRP
 83g92cdl6zOCNbJ5Yb5P/hrj9h8ykbCJuSRZIhFxaA==
X-Google-Smtp-Source: AGHT+IFMgz6Rkf604cPJxnndn4nnjp469wOdux3NB9beIj5UIYZ2AnjNcUkp1fbkiV1rDLPpcbM4iFCsMmGbPPb/sMk=
X-Received: by 2002:a5d:6704:0:b0:317:e1a2:dccf with SMTP id
 o4-20020a5d6704000000b00317e1a2dccfmr50695wru.62.1694537463641; Tue, 12 Sep
 2023 09:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230905115000.53587-1-thuth@redhat.com>
 <20230905115000.53587-2-thuth@redhat.com>
In-Reply-To: <20230905115000.53587-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 17:50:52 +0100
Message-ID: <CAFEAcA8pKuFso_boUxzAsAktegT4DJ9U2q26RmiqYK5TWKTinw@mail.gmail.com>
Subject: Re: [risu PATCH v2 1/4] s390x: Add basic s390x support to the C code
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

On Tue, 5 Sept 2023 at 12:50, Thomas Huth <thuth@redhat.com> wrote:
>
> With these changes, it is now possible to compile the "risu" binary
> for s390x hosts.
>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



> +/* reginfo_init: initialize with a ucontext */
> +void reginfo_init(struct reginfo *ri, ucontext_t *uc)
> +{
> +    int i;
> +
> +    memset(ri, 0, sizeof(*ri));
> +
> +    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.psw.addr);

Here we extract the faulting instruction, assuming it to
be a 32-bit insn starting at uc_mcontext.psw.addr...

> +    ri->psw_mask = uc->uc_mcontext.psw.mask;
> +    ri->psw_addr = uc->uc_mcontext.psw.addr - image_start_address;
> +
> +    for (i = 0; i < 16; i++) {
> +        ri->gregs[i] = uc->uc_mcontext.gregs[i];
> +    }
> +
> +    memcpy(&ri->fpregs, &uc->uc_mcontext.fpregs, sizeof(fpregset_t));
> +}

> +void advance_pc(void *vuc)
> +{
> +    /*
> +     * Note: The PSW address already points to the next instruction
> +     * after we get a SIGILL, so we must not advance it here!
> +     */
> +    // ucontext_t *uc = (ucontext_t *) vuc;
> +    // uc->uc_mcontext.psw.addr += 4;

...but here we say that psw.addr points to the instruction
*after* the faulting one.

These don't seem like they can both be correct?

> +}

thanks
-- PMM

