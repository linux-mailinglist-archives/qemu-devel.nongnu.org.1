Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E077D3E64
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:57:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzAf-0007iQ-Fk; Mon, 23 Oct 2023 13:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1quzAT-0007fZ-1K; Mon, 23 Oct 2023 13:56:46 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1quzAP-0004V9-VW; Mon, 23 Oct 2023 13:56:43 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27d23f1e3b8so3062803a91.1; 
 Mon, 23 Oct 2023 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698083798; x=1698688598; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z47QvoOgxRlrB3eUY29cxy9/SjOZ707KNumspmd08xA=;
 b=JROF5OVmbKwblGQ3GsX4dLDIEkhw0ymKiZk6FJr6yt+iO7uBa4zWruGEdc9uYOMMrT
 Dp3ohl62zr1LcaAmdTGcm34k3534E5+3Dn9KGnPoRiliA4n36ZQ1ATgXijJ3F/DngprO
 4p0z9K01WrkItLpgXe4LZjcECYRACwKycmUHS72gkUxoyK4ZtBYUm5zESmgn0lA/xg16
 +nnSE6Aq2Ke1647VeatfmIypCziHREsdzpksUtUbfOBzWi6eqjKNZ3inljZBarnFVkZ0
 UJ70P9oD9ryy3eBC9RlRXf1Zi28Y1tRsnnbdYJ3+lia+1kCHYZ0XuE6SXu7YrLQ5l0GT
 w39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698083798; x=1698688598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z47QvoOgxRlrB3eUY29cxy9/SjOZ707KNumspmd08xA=;
 b=tcGkggFDjx7q17QQD48QvTW7/kNM8xuumnmJfGsE9v6aXZikBHErJlGY2p8mNZPy0P
 gbNGaPejVo/OtTqY0sGfYJp6vN/FmrwXCMYnYyKqQVq0xq+kGE3yD9b0e1jv26iZUYNd
 8sNtzDYXb0dz/vX4vZK7l1u3ql33rP9Qp4dIdl3LVjg9QTLZQcYZBEOecPaEckb5ug1H
 Yo48Riou0/IelUocoSBQErpmWfn+e34LRWe3+M/SevnvjAWz1L5v+YpOauZLTl4OLPi2
 tIxl5lcEDTGx88dvaUTYbMXrVWzSDTbOKXJYSnyKXNGbNg2+c2OcoETyn8lYgpHQ7Bq7
 OuwA==
X-Gm-Message-State: AOJu0Yw8dARGqbPsyMCH3y+Zivve+bkZgosyrh40VQJqfwHZLe4lhW5f
 /4bvX+Ls8iIq2Fj54N8yRXHChAdwlMArCzIam8k=
X-Google-Smtp-Source: AGHT+IFMvQrPZuCv+VCWb9SJdSZQb5q/79jCHrk6IDA9f5Go22+pkflxG23dMChUvV3xDsqYR/J8i385R/JW1SXedug=
X-Received: by 2002:a17:90b:1d01:b0:27d:348:94a8 with SMTP id
 on1-20020a17090b1d0100b0027d034894a8mr9585504pjb.6.1698083798646; Mon, 23 Oct
 2023 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-7-philmd@linaro.org>
In-Reply-To: <20231023160944.10692-7-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 23 Oct 2023 10:56:27 -0700
Message-ID: <CAMo8BfL_ArK4BGRvkLuCvGZ5BAT1ViiX-8=_xuZcLyKbzbv9zg@mail.gmail.com>
Subject: Re: [PATCH 6/9] target/xtensa: Use tcg_gen_extract_i32
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1031.google.com
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

On Mon, Oct 23, 2023 at 9:10=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/translate.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

