Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A07577B6
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgqS-00052e-RP; Tue, 18 Jul 2023 05:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLgqP-000527-6Q
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:18:09 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLgqN-0007rs-LU
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:18:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e566b1774so7192085a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689671886; x=1692263886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TIVxhHPGSR5fPDKW9AlCFiTlFMUvN1yxHTDMTpeE4k0=;
 b=n5QAPxBJXC7WAAuE19bVO0hVIUcuptk2+d/aDueXKRySu7NRw59310wy2VeBny+uux
 /reamw4XhVssG2ofYWkYXxzon2ibg85RO884Nbh4q75PzBx7l/tOarzRjg6L2boOxvlw
 FO/yRxzrIO3uUaVazTwN3EBpyYdAdQuYvb+6/a3csnbAUCiBy+j24ciF17jdojhOSORv
 NWof1g335UUJd3rYrmiS9Hie2qDink5EdfgC7lS+A6yiFcHuKh/yUjKUsBqoAodDp7Yp
 T3PgWd6SOHc9G1EmQ3HKbLUIEaTLYS9XZpxJx+YxA7v4hfxb8htACGKbCtMgWcQoSo2o
 lD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689671886; x=1692263886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TIVxhHPGSR5fPDKW9AlCFiTlFMUvN1yxHTDMTpeE4k0=;
 b=K7gCnKUFWTvaIzsT+NnMGhWl4CzmSIxmFRkXdmZWLfXwR0l5m85bI+jVx09D808cLE
 VIeQHSrIrLPIt87AQRIaN+FM/5o79VuN/pulQExbSwm9N8VVtdMkRhd5BjoBJgJww9CD
 DZX/y70aFn9kyQZ14JPw45tfHNpbGnRgvIaefCFj9xKbmNRB6RskpyQJyy6IzbxR6c/w
 o5+CgNvS7tlyOWxmWvzwt+ccPpdKum4tXnsCp6lLAhGtmWohRWKOcwzvlVORQ4hZXPTv
 Jyt7ywCfyFkuiDk6ypqpXVC1iLJ2A2HskQpwD2JF5JNp5mXv7am/7vauWDRv2qSEGTrl
 jgNA==
X-Gm-Message-State: ABy/qLakNYJxsrPEEUbx9xFwP4Fd8GXhi+6zAABWTCSwm/8VFg8nXVLy
 mNfO6Ry7grKrhTxjUs31zrP96lsSKwFPMqBRKCi4VERz8YIzkcXW
X-Google-Smtp-Source: APBJJlELXetQwWk5liy9wPit51+uWbfxPCBy1O9qlJWVnK0BeYej+WITBE6rt9eTb/hpb/YUitRauoB7ppUKoDKAvus=
X-Received: by 2002:a05:6402:8d0:b0:51e:1c18:dd99 with SMTP id
 d16-20020a05640208d000b0051e1c18dd99mr12300232edz.38.1689671885773; Tue, 18
 Jul 2023 02:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230717162940.814078-1-peter.maydell@linaro.org>
In-Reply-To: <20230717162940.814078-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2023 10:17:54 +0100
Message-ID: <CAFEAcA_=O6A36AuXKQOF17-j8Lgek8iQM5gP7yrX1ODtOMKhuA@mail.gmail.com>
Subject: Re: [PATCH for-8.1] target/mips: Avoid shift by negative number in
 page_table_walk_refill()
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 17 Jul 2023 at 17:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Coverity points out that in page_table_walk_refill() we can shift by
> a negative number, which is undefined behaviour (CID 1452918,
> 1452920, 1452922).  We already catch the negative directory_shift and
> leaf_shift as being a "bail out early" case, but not until we've
> already used them to calculated some offset values.
>
> Move the calculation of the offset values to after we've done the
> "return early if directory_shift or leaf_shift are -1" check.
>
> Since walk_directory() re-calculates these shift values, add an
> assert() to tell Coverity that the caller has already ensured they
> won't be negative.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/mips/tcg/sysemu/tlb_helper.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
> index e5e1e9dd3ff..c67c2b09026 100644
> --- a/target/mips/tcg/sysemu/tlb_helper.c
> +++ b/target/mips/tcg/sysemu/tlb_helper.c
> @@ -643,6 +643,9 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
>      uint64_t lsb = 0;
>      uint64_t w = 0;
>
> +    /* The caller should have checked this */
> +    assert(directory_shift > 0 && leaf_shift > 0);

Whoops, this should be >= 0 && ... >= 0.

-- PMM

