Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B4716654
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q410l-0001wE-EM; Tue, 30 May 2023 11:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q410Q-0001kd-Jc
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:11:26 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q410M-0005Gg-Md
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:11:26 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51458187be1so8077041a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685459481; x=1688051481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgqSrsE6WKBGhIyN31uqtjp1Dlf7zxgJ52vhXZmBtsY=;
 b=xODxqIyg0seQVT4nv1pMsiqN6j5/WK+Y0wNXor9cDC+6HKNzLcSLNt+o8CXRpIBedY
 b5DEwfp0KGQh8jqhyEEJhz5jfB2XfpMwF1nbbSOAz5IBFpCm7Spe0McvC0vff2+ypDoS
 km4z2eBS/MmzuLlwYnPbQAo8AicazAHa6ah/yEbO+2MR02fj/moCdH21CUm5hMSNMZp2
 q+7VK0wnWS46bkKavY+NdTTVZKy5TaLD+CFDFoUPUb/NjMbm7Ss0tcWy7FkFwKnlHkOw
 TuV/HOSRi7aCEdipAHNr7b9Bibi5q1L3VfGsYQU1B3XLYGgcm3EIalKmfXLcPcGU5ZFT
 hqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685459481; x=1688051481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgqSrsE6WKBGhIyN31uqtjp1Dlf7zxgJ52vhXZmBtsY=;
 b=H3lGJLPmVooMNvbgv3fMNxEJB2jN5XmaDrFimeA8ZY9c9HhvLrFYk1ltV9aPQuR7hX
 N0xT10juMGRWPZP8tsQFHLSDrJp7PMhQGEElIpg6gj+xLw7ERSVoAiphPDACVe75szmg
 ZPTl0Ov7rEyO2UPikv2qkeH5kv8g13eNfVNtgYjJYDHnczJlGqGQTqy44jblECL+OEFs
 t7M7HRk2w7qGkobSKKoLGEZVUIkIzXADiLsFqAPZl/gSEm7oHtEFGH9fvHFs7BUe2Z2w
 i6AkoyEgHhIYXFcnyBOh4rlO2XxprkKOjBDDv7HbrGynAb3iezBYxAyLyobwLKkW+osp
 z2ew==
X-Gm-Message-State: AC+VfDwYyCGSnMtZINe/uMUNeL2vXBfnYPo+PNMvx64U9ARju6GnPo/C
 Z5c2mRUyN+9/TZWITrxbmgsF9mUZ89gwqCIZlBO40Q==
X-Google-Smtp-Source: ACHHUZ4ZYySM1dor+T/6PgIX+iqV/c34lN3Kp1KxuNuvqaTAqPEkcI/u6tx5PNfhQBefaBY1aAcsZE3DPp1VjnhBpjs=
X-Received: by 2002:aa7:cfd8:0:b0:510:f8d7:1f4e with SMTP id
 r24-20020aa7cfd8000000b00510f8d71f4emr1899162edy.3.1685459480851; Tue, 30 May
 2023 08:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-2-richard.henderson@linaro.org>
 <dbb368d0-839c-ad09-01de-09b1a62416af@linaro.org>
 <87zg5r1kxx.fsf@secure.mitica>
 <8f315f7c-2778-855a-0879-f928f9ca8054@linaro.org>
In-Reply-To: <8f315f7c-2778-855a-0879-f928f9ca8054@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:11:09 +0100
Message-ID: <CAFEAcA8XnaEjh+BhfnfOEqXtEHXGxF-9iC83o8jNH65vhg5R6A@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] target/arm: Add commentary for
 CPUARMState.exclusive_high
To: Richard Henderson <richard.henderson@linaro.org>
Cc: quintela@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 26 May 2023 at 15:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/26/23 02:49, Juan Quintela wrote:
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >> Hi,
> >>
> >> On 26/5/23 01:25, Richard Henderson wrote:
> >>> Document the meaning of exclusive_high in a big-endian context,
> >>> and why we can't change it now.
> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>> ---
> >>>    target/arm/cpu.h | 7 +++++++
> >>>    1 file changed, 7 insertions(+)
> >>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> >>> index d469a2637b..4e16eab82e 100644
> >>> --- a/target/arm/cpu.h
> >>> +++ b/target/arm/cpu.h
> >>> @@ -677,8 +677,15 @@ typedef struct CPUArchState {
> >>>            uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
> >>>            uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
> >>>        } vfp;
> >>> +
> >>>        uint64_t exclusive_addr;
> >>>        uint64_t exclusive_val;
> >>> +    /*
> >>> +     * Contains the 'val' for the second 64-bit register of LDXP, wh=
ich comes
> >>> +     * from the higher address, not the high part of a complete 128-=
bit value.
> >>> +     * This is perhaps confusingly named, but the name is now baked =
into the
> >>> +     * migration format.
> >>> +     */
> >>>        uint64_t exclusive_high;
> >>
> >> Can't we rename the field if we add the old name to check_fields_match=
()
> >> in scripts/vmstate-static-checker.py?

> It's not worth any effort to rename.  Just needed documentation.

Yeah; the important point here is "we can't trivially switch
to recording the exclusive value as 'high:low' of a guest
128 bit value" -- it has to remain "value from low address,
value from high address". Really what is baked into the
migration format is that the semantics of the two fields
are from-low-addr and from-high-addr.

If you replace this:

> >>> +     * This is perhaps confusingly named, but the name is now baked =
into the
> >>> +     * migration format.

with:
 * In some ways it might be more convenient to record the
 * exclusive value as the low and high halves of a 128 bit
 * data value, but the current semantics of these fields are
 * baked into the migration format.

then:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

