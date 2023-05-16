Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F6704A33
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:13:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrfz-00080c-5u; Tue, 16 May 2023 06:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrfr-0007zs-IZ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:12:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrfp-0005Pk-48
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:12:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-50bc1612940so25016859a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684231971; x=1686823971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DQizkdnZsAOG6QlIDBtEu548HfkhlFmfojjKz3BfyMk=;
 b=cUmC6SiXzqyfRqX408w9CnGqH69Vnpc22OQlDMKNBdyVn5EswMXVVi8ivpR9bArJPq
 /HygJQz3U4+WyPKXSn0I5zPDIO2ipDoCzx3zeHLQD4lSEGUVw/gZ2DyvtC0EjKE1FU7A
 Jaw9oHnGjWVJ42qbkfo+KjJmKq7ReGoWaYymM77VakZqUjc+JjfVFTEBZcEsxOsyL4KV
 PcF6kdUyehuVUDfCmohBtNwBIA5uhef/Y/MvuCHGgXIA0z5NJepLGXsqnraQMgmyCXl9
 tllgbJUgCFdr6bYaIkzeUtSnRnyzX54+Y8aFGcA14V8PMTbdLPVBMjOmIwLOswomU0Km
 L7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231971; x=1686823971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DQizkdnZsAOG6QlIDBtEu548HfkhlFmfojjKz3BfyMk=;
 b=URss7JBCHCLl4X6CftidpXofb+W8VonuRONDQ1ru8BY0QzA9z5rr8lLvF8pMVxoxn9
 B2wNeKjIoga1KPLot0shOx9+FmUanlfDLAAnJ0ckiaRu3EtGfCW6LbZ425FEUx1naVeY
 39UUB2YRmi8UfitgP8lzUk8wAUI27StvqduDppLgV3/IMxKpXuVk0bAolIHvpYVET9pr
 9eFgZaQuSy+VinqbUHu2VU1Cjz9VugiDqQSRE7T6HFd3ywsUctPf9Z3TplGIV1inNmf+
 /UxxXpjZCK04kRpXc53W+Vasv5sKQh2MIw7Zqb2V/sDLMhlJlxKZXijzmj7iK2Af3U4L
 7R/w==
X-Gm-Message-State: AC+VfDwkqqFtyrx67BjpIuGMsVdZJkLVO6L3HtKdKUU3lcMS4pJTfdhY
 6IHDmI6R0QYEh1A6QjUO7QmcN1VlHc9/tia35T44NA==
X-Google-Smtp-Source: ACHHUZ5Ytd63/P7enz1FX56361Eyo31SZ4aX8ZYtqrQZbWL8h02YOBCbbZ0geVg8wFoD94243LAI52/HLpHcG+Lnvak=
X-Received: by 2002:a05:6402:216:b0:50b:bfee:ea26 with SMTP id
 t22-20020a056402021600b0050bbfeeea26mr25642561edv.35.1684231971295; Tue, 16
 May 2023 03:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-46-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 11:12:40 +0100
Message-ID: <CAFEAcA-MuLtne125bOSRonnM29kwYxbYi0yjEcD92HXm1O6JTw@mail.gmail.com>
Subject: Re: [PATCH v5 45/54] tcg/ppc: Use atom_and_align_for_opc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 15 May 2023 at 15:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

