Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9D77FB12
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWfAj-00018u-9X; Thu, 17 Aug 2023 11:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWfAf-00018i-Vt
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:44:26 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWfAd-0006fC-S0
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:44:25 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5234f2c6c1dso10611095a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692287062; x=1692891862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NiUH52F5EeY0Ajo9FtsRaEEjgRTg6lrGy+J62EXjw6o=;
 b=XEvyR0i8yKrJFZIHsi092SO84pCVqXq24vYEgW5I5rtp2GyP3bEe4c6RGduqdZ3vv2
 bNUa5qwdKig0xtkkTu8imDD8xAXZQkX7HBBvjvHwEdcnI1Dv/fs5RSYJ9bk7xwL0hILe
 bDI147xKMJXgVVA8Hca3jLdDoKZHira3wMlByRvvXH7GNxJBh7QU8oKB60mRuZ5bhYf5
 35kZh1uuIu3FFMazzMheLH1x9CKTMnL5JpVtGGWnmmxvuAklaEWFwllq+TVmOZ7Hx/DL
 lF2jLVV1hz9lqCz4fnAHADHOqYdukHrWuI2oA/hDA6aygSTFejd9e5/a5yBW41KiVDng
 JAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692287062; x=1692891862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NiUH52F5EeY0Ajo9FtsRaEEjgRTg6lrGy+J62EXjw6o=;
 b=cQQv2e+NkuSnEDRQxTCkNuEe4i07qNlE4JjwUpKgw5wRCZe3kKvYq6JGVyi3GjxpBh
 azipmBDeuNVLj3P3A9kfBtzlcTUFwKSFG6uyr6CRqU40uko+wVwpQ0DvFQZJUaoOFf9a
 auI/X9PcZ12+gZXCbZSQUTm1NJ7t5lw6ylgAx005peu2cuy9a8Z+7zupPJA5C6Ays4g8
 pmd1dI07j3kEDUOzz+560kuqs4ZdjQResko9MArR7Y+dMLm1BxbZFafQem8h1FfIAZ+O
 vIQW63NmhVjPFENcyq0INxeemryf7CglMaTZBQrNwfmGN9eeWOtlL6reI+1z6/OVfsIR
 GRbQ==
X-Gm-Message-State: AOJu0YxvvLvq72V9t2M6+rjVw3SNiZ6CGUAVSV4/oQk2TkMLCmWWWce9
 94VoD/QtA0sB0vvrWx+1fVuDnZsj6SHD87bHQ1mzQw==
X-Google-Smtp-Source: AGHT+IGo0fkOPoty4Zit8ni7uPzV/NrOUgDJgT0zuYNuv2mynAyO3sRtFhCoittu+6z0a3bnVx4PDz6q6O39Md7GgMQ=
X-Received: by 2002:aa7:cf0f:0:b0:525:63f9:a268 with SMTP id
 a15-20020aa7cf0f000000b0052563f9a268mr64874edy.42.1692287062169; Thu, 17 Aug
 2023 08:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230816145547.477974-1-richard.henderson@linaro.org>
 <20230816145547.477974-2-richard.henderson@linaro.org>
In-Reply-To: <20230816145547.477974-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2023 16:44:10 +0100
Message-ID: <CAFEAcA94YWgNRi_6Z8Ww5b6O2GncB-cqF-X8yr31UzFJEwJQXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tcg/i386: Drop BYTEH deposits for 64-bit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 16 Aug 2023 at 16:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> It is more useful to allow low-part deposits into all registers
> than to restrict allocation for high-byte deposits.

>  #define TCG_TARGET_deposit_i32_valid(ofs, len) \
> -    (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
> -     ((ofs) == 0 && (len) == 16))
> +    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
> +     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
>  #define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid


> @@ -2752,7 +2751,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>          if (args[3] == 0 && args[4] == 8) {
>              /* load bits 0..7 */
>              tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
> -        } else if (args[3] == 8 && args[4] == 8) {
> +        } else if (TCG_TARGET_REG_BITS == 32 && args[3] == 8 && args[4] == 8) {

Should we assert(TCG_TARGET_REG_BITS == 32) rather than making it part of the
condition? If I understand the change to the deposit_i32_valid macro above, we
should never get here with 8, 8 if TCG_TARGET_REG_BITS is 64.

>              /* load bits 8..15 */
>              tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
>          } else if (args[3] == 0 && args[4] == 16) {

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

