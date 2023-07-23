Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B7375E291
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 16:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNZwr-0000WW-TV; Sun, 23 Jul 2023 10:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNZwp-0000Tu-VR
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 10:20:36 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNZwo-00022D-HW
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 10:20:35 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5222bc91838so293163a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690122033; x=1690726833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BfMfvWSPd8bJvptliyIBtJF0k1rDR+PLO5Og6EA38WU=;
 b=w9S6FqksTInbFeFKd6x4guyuB2ZABvbDoTmt+66Avu7ys912OkOU3m3CnmcrHk7FdN
 +XsLNc9YeC8RcR9WTfgWd5mPBsGKYQ4IABPoLKO2FlBO3soEnXjfig/A/Pv8cyj/NZlN
 cwqBrK0VLNJLGVL3L9j2w1UQpCINRTpj3YAF2TvfOeCfYutJHWEnJLblG3qwSkjhHMxi
 NlG4rMtCtWQYAuyd8PhlRLH3gZthHJBLlKv6GO2L+d8LUrrJgz9B9DpB5S+ET0l1n6ow
 +vs4Bvq4XpzsdKLqHvHG74n+C85oNKIBfxbTtOFj5RGCTp6XzNPUZSuJUEIbffRqX+k8
 CIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690122033; x=1690726833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BfMfvWSPd8bJvptliyIBtJF0k1rDR+PLO5Og6EA38WU=;
 b=ai4fAr27vu9BlpCbSPeFDWerKMGvCq3hAl4ND5NkvOLB+G/R9gsjYaDYUdWKvrdYgu
 dRGNDRJe8prYv8LAj2HNC29zqDyGl+cWrlJ6W5ht3AEWfJ09fQodlidMtUg1kOQ8+t1Q
 WGzjOQ18NXIAdmcyf1nhs0Q+QlsJXbt/Hqa9kpvzmRgLhvTNxl+NHf1U5ZgoPr6CuFRG
 Uy58yrOWbff2+JoQjTffpHm0TOTNVIaYrAjxLf9FlkiPwrhdyFHAYWBb5tGjgDkCO7ZK
 mioEof/4TalkgBKIwDgG791XrS0j50obz7MGU/wdzhP5fQwPMMET9shey7EPkAEyb1h9
 hz4w==
X-Gm-Message-State: ABy/qLbU1fLcMX3uMLg881Ly5B4nSWwrjo7QlNyZ1sca4vYu9XqAVD0i
 UX+9HABeiRw9hRHGZj0mC9be76glzACmgq5tGo3POg==
X-Google-Smtp-Source: APBJJlG+Wdcotoq47mg+5hJ5mNgsMWNlkfiYRBjRbcJQkpmSsJqYjPaX0yF+Ejj+UaFD7WdUGMXRzAITuQ3n8ZV57/U=
X-Received: by 2002:a05:6402:60c:b0:51e:1bf3:f4ac with SMTP id
 n12-20020a056402060c00b0051e1bf3f4acmr6713854edv.27.1690122032915; Sun, 23
 Jul 2023 07:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230722113507.78332-1-richard.henderson@linaro.org>
 <20230722113507.78332-3-richard.henderson@linaro.org>
In-Reply-To: <20230722113507.78332-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2023 15:20:22 +0100
Message-ID: <CAFEAcA9YxweE-_3nXBtLoumakvcwt59HtjFp-n+0ooD1XKEODA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] accel/tcg: Fix sense of read-only probes in
 ldst_atomicity
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Sat, 22 Jul 2023 at 12:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In the initial commit, cdfac37be0d, the sense of the test is incorrect,
> as the -1/0 return was confusing.  In bef6f008b981, we mechanically
> invert all callers while changing to false/true return, preserving the
> incorrectness of the test.
>
> Now that the return sense is sane, it's easy to see that if !write,
> then the page is not modifiable (i.e. most likely read-only, with
> PROT_NONE handled via SIGSEGV).
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

