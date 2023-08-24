Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A7787109
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZAxq-0001qd-6R; Thu, 24 Aug 2023 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qZAxn-0001of-CA
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:05:31 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qZAxl-00034J-2H
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:05:31 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5711f6dff8cso877928eaf.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692885925; x=1693490725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9TzXcsWXLqDk/WymJyiiY82ywS8U2nTO3Q3adXmtpJc=;
 b=J5dAGY3X3eE8Agy7Mhk0NZsAoLY2mGQALEvS5XJiVmt7ARcDLbg6QRIYoKsTIh+0FZ
 tI0QBUXRcoHcwKVBmPTRnnFnfacT2tVRJg+lME4Sen2G1BF27dCv1blP6SOMj5SsRbSD
 EIivSIDoQuLXtxjADLe6h/8M/6RnHYJ++Uis2JdLoq3DyaNz/wv3E7q0v47Hqi8ef7Dn
 N9q7XLchr70isFDzJMVkAu7ejCZpjXOmj08Xr/onLkGMB90FNBMo9vyKkkRBxvaThFyK
 CxHzm2WoCVyVaAu+4hx9sgjXsGbJlPJEDEgduaedO1MHfZB6ynU05Re6v1+Dyon118hB
 dHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692885925; x=1693490725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9TzXcsWXLqDk/WymJyiiY82ywS8U2nTO3Q3adXmtpJc=;
 b=ZuMrh0X1bjrO/M9SubNrgCStLJlOv9lrgfuTklgmcjGnL4dOqUgPFL/P/S3U/nzEcO
 GxQHQCQo6v/TMOFS8nDQnK9vLGy9Xd8fWc/QHLM9h0/aJBx8DysfCqCk1zt14wnTACVO
 IatwA6/3I309FpGz/PrxEZbLWt9PS5hebcpjfGOrvBRa16fDOuaYrxqCJ2AZyY8F6ymG
 BGaEmzOvDR4TMGPn5vZArhXMSLvP5Kn+zYZ+uzDe3/vEaI2FSs8mmRwkw7c8+DNGgaop
 9HPUYWTPzg26vuu5fF6ySjYF4AZvLym0v3PAsF3lMzf3f11vK82I0ozGzZFht5ehwOUR
 XiIw==
X-Gm-Message-State: AOJu0Yw9/15yL8d36nHXzGEtIOnVDjyyLtOns0LcUhMsRs0VzieKZziY
 D17qrpYRD4tHyQF2Yl/plGLlHOdeTvNg4ykHL3s=
X-Google-Smtp-Source: AGHT+IG/fKpkNGMZXk/mDIzxPSO5aKtBpsRENQSZsutgs+6k9yqSMSTF0B4L2lUj3aXrAtLLGm88UH3PZ4wKh3m6nBU=
X-Received: by 2002:a4a:919e:0:b0:571:1c44:c9bf with SMTP id
 d30-20020a4a919e000000b005711c44c9bfmr2361743ooh.4.1692885925238; Thu, 24 Aug
 2023 07:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 24 Aug 2023 10:05:11 -0400
Message-ID: <CAJSP0QVkeKKPDqNmE58pUjbK7dHRvFbPL6cAgK0hyhYSccb9VA@mail.gmail.com>
Subject: Re: [PULL 00/48] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 23 Aug 2023 at 16:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:
>
>   Open 8.2 development tree (2023-08-22 07:14:07 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230823
>
> for you to fetch changes up to 05e09d2a830a74d651ca6106e2002ec4f7b6997a:
>
>   tcg: spelling fixes (2023-08-23 13:20:47 -0700)
>
> ----------------------------------------------------------------
> accel/*: Widen pc/saved_insn for *_sw_breakpoint
> accel/tcg: Replace remaining target_ulong in system-mode accel
> tcg: spelling fixes
> tcg: Document bswap, hswap, wswap byte patterns
> tcg: Introduce negsetcond opcodes
> tcg: Fold deposit with zero to and
> tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
> tcg/i386: Drop BYTEH deposits for 64-bit
> tcg/i386: Allow immediate as input to deposit
> target/*: Use tcg_gen_negsetcond_*
>
> ----------------------------------------------------------------
> Anton Johansson via (9):

Hi Richard,
Please fix up the authorship information for Anton Johansson. The pull
request has "Anton Johansson via <qemu-devel@nongnu.org>". I think the
email address should be "Anton Johansson <anjo@rev.ng>".

Thanks!

Stefan

