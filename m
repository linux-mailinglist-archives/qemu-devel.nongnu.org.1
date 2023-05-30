Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F65716326
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:07:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4006-0001CE-2h; Tue, 30 May 2023 10:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4000-0001BY-4n
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:06:56 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zzy-0005Jt-2u
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:06:55 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f3b9c88af8so5204145e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455612; x=1688047612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MwDG1dJ0R+ylczfpb9LgJSGMK+igr+ePmXxrtt0VspM=;
 b=x6wrvcT+Ic6Q1OwkrIeq+Evd7YCLcMMwoLiORT1vCJ65V44xLwBOll7W7Bn2GUERZd
 9uukfe1VjSZOAYnUiY8h4CmPKTcXp+niTrRC2eZu4F+Qr5iQxoGjMoyM1GwRAt5/g7Fh
 rTi0uzGQTboduhx9P+YHsrmu1RXdD/gpGgdnkMQYnDsFVy46MmEPYBMFoECQwupBV09S
 ZjBH8cyzZ4Cok338Jxa8rXv087VLvLbDAZWDUaxb2la+EUgssvE2ncr021vAnkrN4XBv
 kFUUkHt32Q0iLJLaeqnEqHJ3m0+ixaDctTtmRkUWox/vyn8LVyXfBKFcxr1FSeGL27eV
 bwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455612; x=1688047612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MwDG1dJ0R+ylczfpb9LgJSGMK+igr+ePmXxrtt0VspM=;
 b=A06B1r0cuWs0zMwQSqkaVtqtDc4X3QaQruFgHvFSmuPNZwpiEC+CknC87BAB30f2TQ
 qS7cWFLDy7rVwymOM3dCXUNl7N9hDEXV4b2A9SeWd91Md9QnqCLI+jDvDGA7T+tkLLET
 tDCdV+FX+jWgPGISVlS/wYcJzAyVQ6MH1D5SQ7N+ptPjEqICLnuA5Xr5TAZTV13gNd+I
 K172NkU+kLuqBgAVzjARjcAqKREXXQf7Be74KWx4BiFx/f08x5Hlvd6leskQ1nl5o4ar
 y7OGLUDxKRrhyemwXeuDx4JhclCNxMd6HJ0jRyG5E8eHpCv608TbQ5bQIIFAdlFCOHDR
 +PjA==
X-Gm-Message-State: AC+VfDyzDrvZjfzttiopZlX1qObaWAlwzr1UGtD07HJUpsVM8VMnh9zO
 E3Dm/W1jK3K1T7BPFaR/TDeVpA7so234/FeB9GN+Rf494bEIqndl
X-Google-Smtp-Source: ACHHUZ5N4nxc7lojLyMsaKuSPeyyLu+dTqwcjvOAKSoM1Q2Xg3XaGhbtxZj24G8+RydT512eimNhp7nZgfF4EvuEhtM=
X-Received: by 2002:a19:741a:0:b0:4f3:a0f0:7c4e with SMTP id
 v26-20020a19741a000000b004f3a0f07c4emr775418lfe.35.1685455612068; Tue, 30 May
 2023 07:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-3-richard.henderson@linaro.org>
 <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
 <5192c74b-38fb-7f2e-7b27-58d210c1b087@linaro.org>
In-Reply-To: <5192c74b-38fb-7f2e-7b27-58d210c1b087@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 15:06:41 +0100
Message-ID: <CAFEAcA8tPuFMz8BZ5P-SJS42q8E_TZ1_5DJL-0kOvzeT-Fymmw@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Tue, 30 May 2023 at 14:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/30/23 06:44, Peter Maydell wrote:
> > On Fri, 26 May 2023 at 01:24, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> PAGE_WRITE is current writability, as modified by TB protection;
> >> PAGE_WRITE_ORG is the original page writability.
> >>
> >> Fixes: cdfac37be0d ("accel/tcg: Honor atomicity of loads")
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   accel/tcg/ldst_atomicity.c.inc | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> >> index 0f6b3f8ab6..57163f5ca2 100644
> >> --- a/accel/tcg/ldst_atomicity.c.inc
> >> +++ b/accel/tcg/ldst_atomicity.c.inc
> >> @@ -191,7 +191,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
> >>        * another process, because the fallback start_exclusive solution
> >>        * provides no protection across processes.
> >>        */
> >> -    if (!page_check_range(h2g(p), 16, PAGE_WRITE)) {
> >> +    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
> >>           return *p;
> >>       }
> >>   #endif
> >> --
> >> 2.34.1
> >
> > load_atomic8_or_exit() has a similar condition, so
> > we should change either both or neither.
> >
> > So, if I understand this correctly, !PAGE_WRITE_ORG is a
> > stricter test than !PAGE_WRITE, so we're saying "don't
> > do a simple non-atomic load if the page was only read-only
> > because we've translated code out of it". Why is it
> > not OK to do the non-atomic load in that case? I guess
> > because we don't have the mmap lock, so some other thread
> > might nip in and do an access that causes us to invalidate
> > the TBs and move the page back to writeable?
>
> This is about falling through to the cmpxchg below: if !PAGE_WRITE_ORG, then the page is
> really not writable, we will SIGSEGV, and handle_sigsegv_accerr_write will kill the process.

Right, but if !PAGE_WRITE_ORG then that implies also !PAGE_WRITE,
so we do that even without this change ?

-- PMM

