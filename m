Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BA72F32F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HPL-0008Be-Ir; Tue, 13 Jun 2023 23:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HPD-00087i-Th; Tue, 13 Jun 2023 23:42:50 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HPB-0006h9-JY; Tue, 13 Jun 2023 23:42:47 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1a6d9d673f1so265981fac.0; 
 Tue, 13 Jun 2023 20:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686714164; x=1689306164;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhWiz+Fb19yBM5ociID4BqDdRNRJjJqIACh+wSjZHgE=;
 b=BT3oFuG1SBfcIT27aaiqAL2PlTAXbZuzJFY9ez9LpNEsEEa90v4MLjEYxIRJI21iPK
 dCrJPnPlkyyXmUG38I3nIaeLpTjA9T4WkWfZAP+wo3v/nn6lLloPbbHcRyLQ++YHy2/K
 7dc6SfM8ynnLhyV/DDibfLhjoYDdk1LfYbxFYbs+xHt4mGGDWGKNh0dHYWr0nC+FO+Q+
 XJsykbe7TvKCGDhchTTFgabwlJbWuMhjQYJcW1uwxe6VGFJckfTwkgMn8yD35gRLwGK4
 WRY3zip54PWtXeVb+VlS8e5IRQW3KL5E+qt6/k8C1PIq6Mvg2jTztCadvCJY5jcP6oL2
 hM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686714164; x=1689306164;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DhWiz+Fb19yBM5ociID4BqDdRNRJjJqIACh+wSjZHgE=;
 b=ZSsMezjeXh0OF/ixSFZv9/Y+0utmIiWcg/zxADw7o+9bO1gvLfYQb5yZ1MZrCjwsSg
 ycfk5w9JrAEgEbBXrBc+Wvk7FNmI+NB+cjKvJhaCQF6HFxhsQ+u/RpMXPJN7QABgK9ex
 2m3nEyWHrC/x3pbNe0W1Guh5Js4Pi1nXglgxx3PvWlCPnNZSEC9mmfpOJLM26vVlAhuY
 o1m4914KX6i7+ikbiB0WE+Y2mjkiOJ2/GNaOgJXVjc2ZHF6nP2SamH3qVgsEbApEWxDe
 QyTcfSWaM/uBEY2cyGJE2KUyobdTZtIWwHMqFpPm9BGBP8k6hiJwH0aXCEjA26oIka5t
 0Mdw==
X-Gm-Message-State: AC+VfDztsmeTaQIULQEqhmXygy4KJUVn0aTctlINc1o+oMkW3PiE7ZDS
 iuWiCSCSyVqLIct2lxwd6EfEUziWJxkNPg==
X-Google-Smtp-Source: ACHHUZ45gYhso0tudWOaLV/MOFhm3v0BmWW6CFaFH+jqh0NAcbzYJrkwLAWmJuEvhdZJXBr0bvicoQ==
X-Received: by 2002:a05:6870:8645:b0:1a6:4c71:8dd with SMTP id
 i5-20020a056870864500b001a64c7108ddmr8682017oal.37.1686714163830; 
 Tue, 13 Jun 2023 20:42:43 -0700 (PDT)
Received: from localhost ([1.146.66.73]) by smtp.gmail.com with ESMTPSA id
 z3-20020a17090a398300b0025e2b703adesm147476pjb.41.2023.06.13.20.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:42:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 13:42:37 +1000
Message-Id: <CTC29MMOY1BX.L0JG4T0TAX1J@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 07/10] target/ppd: Remove unused define
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <13f743d961c10d03c5b4f745a1b26ece3a7e1494.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <13f743d961c10d03c5b4f745a1b26ece3a7e1494.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> Commit 7a3fe174b12d removed usage of POWERPC_SYSCALL_VECTORED, drop
> the unused define as well.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/translate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b591f2e496..a32a9b8a5f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4416,7 +4416,6 @@ static void gen_hrfid(DisasContext *ctx)
>  #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
>  #else
>  #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
> -#define POWERPC_SYSCALL_VECTORED POWERPC_EXCP_SYSCALL_VECTORED
>  #endif
>  static void gen_sc(DisasContext *ctx)
>  {
> --=20
> 2.30.9


