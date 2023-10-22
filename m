Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147097D20C1
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:26:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quO9f-0000PJ-5V; Sat, 21 Oct 2023 22:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1quO9a-0000Oy-7u; Sat, 21 Oct 2023 22:25:22 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1quO9Y-0004Px-PG; Sat, 21 Oct 2023 22:25:21 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-578b407045bso1601388a12.0; 
 Sat, 21 Oct 2023 19:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697941517; x=1698546317; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EnvQcTit6Z3SECuwhi7grFC3nAR3AHsH8AZxsNdtoI=;
 b=fi8wS3n1k2USHCvqxg1wQnnZWqXlGCH0mih/v8xMRNI0h6T8ouG3KI1XjXTuj21vhP
 fJORdoDf3SZFToXdXMCmLA3vERJsaut0dEa7PpZEu1tWcVZSuVy/pQtLahX4wLKClv7M
 dfMskvyqjwa/8diuCWnmmpXG394SkpvKcqq+Bh4xPYLKottg6M/ffiiZPifj5+hnrwSX
 SY7m6AiVzqvdmY30Cwa3+LtErG1xK9XW6hc+oK5pAFgyGWAQSaIxSuMeKB3tjZgbLio5
 nzzzqgNCAy5a3A4LVxA+ZtLAdwjjTEIEJw+5x+gkMXTlmQKfZSquehB8eW2TUQRyklsi
 5Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697941517; x=1698546317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EnvQcTit6Z3SECuwhi7grFC3nAR3AHsH8AZxsNdtoI=;
 b=Cp2VbS+6zKAJbleNK9ckZevgphuU7+AAgcCWIWTY2Zi9qI5wdgnCFLP2t8B4bp/NyL
 tQur3D9vocqx8R75dTG+2fgVNo1ER26mFqVrcHT3/Wc2+PQNqCKVunJhi6xoQXGD6521
 GubdDc17ePP1QMbopyZCqIAkHw7B2F64qiqOEZcGf2hTmCjIK85nopzadHevLdPghi8z
 pKgQpZrGDItpNwYVnOFLLDrV6MT8FUUUTmhuA/NahwwCPpwfz5oI8rrWnq4yhUM47/cb
 9OldaCnepKBcBF6lGDzYWE/PIj/nJyy2DuwT5v/uf90QT8Eg7uAm8UqhTIYGrUNYiX0K
 +idQ==
X-Gm-Message-State: AOJu0Yy7BGKvbOJ67GkkRajnseo8948wnhuIoUuTo4YnfOvMjIesoT4F
 KwTUxsPpuozaz1NVpzoDw4xpmYX9Zvyq+BS4oLQ=
X-Google-Smtp-Source: AGHT+IE/6XHDVchiIyLdX2aSGSEtIMA8I2iqclhJ0OytrWD6lOMZhsYxl0Xr8/pNLRq3cUWO2v1jnLtDcthwjMuHmjI=
X-Received: by 2002:a05:6a20:261b:b0:17a:e32d:242d with SMTP id
 i27-20020a056a20261b00b0017ae32d242dmr4798327pze.35.1697941517424; Sat, 21
 Oct 2023 19:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-8-richard.henderson@linaro.org>
In-Reply-To: <20231019182921.1772928-8-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 21 Oct 2023 19:25:06 -0700
Message-ID: <CAMo8BfKZ+dYBWuDAOY1n415VMDeNpwsGN5AymR76btT6aK7uUA@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/xtensa: Use tcg_gen_sextract_i32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-arm@nongnu.org, 
 laurent@vivier.eu, ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 19, 2023 at 11:29=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

