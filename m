Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E373FEFF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEA3W-0003pm-3v; Tue, 27 Jun 2023 10:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qEA3Q-0003pD-90
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:52:28 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qEA3O-00080Q-EW
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:52:28 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51da8a744c4so1150468a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687877544; x=1690469544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLnUJF5Bzfslc48dcgvh1zImH+cIPeOi8OhebaRALSs=;
 b=Up7JK2pAWfl5vhPnsWIN038BMYKar32wsExKOPYbJQ6kj2s1Y+MWUlA+FXE7ryyqH4
 hQIA3Oq5rTRYBq+/4hKrKKPhUAYdv1e5NUwiIIpqsb3V3hbxIZA8qNoF4bvnpXGV1z1H
 j8mI/qJSLma7uw5Z7to3ekA7IDqACGQx2YxpFuOr8PCgkEuArpKxmFgZYEeIiDmZCP1q
 H5SYP/l7+kQ5slf9wvEdF5DWGtVnLd4gpJ0LsLFKu3UDMwdi+KQsk9zLkFYHium4M3H6
 RC0hkw69TGxnOZVZ9zOROXvzn09SZG4II2wfx9kYBnOBGX44hrt1u/RbT4PSVe1hLtUb
 hRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687877544; x=1690469544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLnUJF5Bzfslc48dcgvh1zImH+cIPeOi8OhebaRALSs=;
 b=ROV/+39szqzhXEBEKGador3byZtS0ASIOF9piMOkfxOhTdeqOYU8MXyb0YmnSsoVVq
 hkptWQXSy/xEaRLqPea+AisFJ6l43tIltdNAb78CiQCNvoak4ke+N9fcyC50jq8R1Ah+
 LA/FJMHQX7jDoxltRCY+VE8jdluDV5UGlgu8PU6vjSWDkPLRqV+1JOZCeb/QNGlidzFt
 OEbieMXTMrzpf8ofzQuNW9r25/jgTDbW6SupUXibuhpZ4edYiFH5/vm+07hlDmncgAwc
 fPxHN2CEwI0B3F8KR0fTaA1faIhv0Xy49C9KIFJx19FUvUS5+6buPhSxB6UfMcYNZWI5
 X5hQ==
X-Gm-Message-State: AC+VfDwc1O9XC2023JoPOGqt+sDXXJegtlxJqgl/AuUSNkc3xwfsT9W9
 BSbEGWJYn3EZp9DDJDqRxhzMYDMIsc9OINsi8hxFdCFJ80cz40mu
X-Google-Smtp-Source: ACHHUZ5UwPpMMaP7px8nOrWGC7a2ulaI7IWSIitUhKPryIcspXlOl0XDdi4bcOzORwDYoWvvyphPoHnhWd3Xi1mwXTg=
X-Received: by 2002:aa7:d396:0:b0:51d:aa00:bdd4 with SMTP id
 x22-20020aa7d396000000b0051daa00bdd4mr1700936edq.24.1687877544615; Tue, 27
 Jun 2023 07:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <168778890374.24232.3402138851538068785-0@git.sr.ht>
 <168778890374.24232.3402138851538068785-2@git.sr.ht>
In-Reply-To: <168778890374.24232.3402138851538068785-2@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 15:52:13 +0100
Message-ID: <CAFEAcA_72SVs=YJmEbrai+KRopdkema9ubUEpc_sSEQUW_Zo3A@mail.gmail.com>
Subject: Re: [PATCH qemu v4 2/2] tests/tcg/aarch64: Add testcases for IC IVAU
 and dual-mapped code
To: "~jhogberg" <john.hogberg@ericsson.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 26 Jun 2023 at 15:15, ~jhogberg <jhogberg@git.sr.ht> wrote:
>
> From: John H=C3=B6gberg <john.hogberg@ericsson.com>
>
> https://gitlab.com/qemu-project/qemu/-/issues/1034
>
> Signed-off-by: John H=C3=B6gberg <john.hogberg@ericsson.com>


> +static int self_modification_test(uint32_t *rw_data, const uint32_t *exe=
c_data)
> +{
> +    /*
> +     * This test is self-modifying in an attempt to cover an edge case w=
here
> +     * the IC IVAU instruction invalidates itself.
> +     *
> +     * Note that the IC IVAU instruction is 16 bytes into the function, =
in what
> +     * will be the same cache line as the modifed instruction on machine=
s with

typo: "modified".

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

