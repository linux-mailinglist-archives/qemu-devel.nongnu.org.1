Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C3704A41
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrhk-0000Ua-Br; Tue, 16 May 2023 06:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrhh-0000Tb-MM
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:14:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrhg-0005uC-1e
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:14:49 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-50bc570b4a3so25027265a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684232086; x=1686824086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+xm7O14yXqB3fFYKPOCxA9C2ebkIifXYGTARhrCGXuU=;
 b=rgY6xLrhe3ahS5auvheSJ5GkcGJI3mI7E9JN4XMu+eXPhm1LDzNORfwP4YnsNIsG85
 JIajR89yCHYMPh9io5YvMj6M5GprrY+4loctGA7ulMfmjX1ucUP/ekYlpSk07ef8jiWg
 iuXVDyXo2Hn4Z7SIYyAvzK+b+JgwJJdeA2UWbcKL5gB86GlDozMchMnvStKs88QKikd2
 DU7RNx1WT6DqhY96INqC1x5exKkWCBe2f3Fen56edzTfDr/cHYcx5925MAOE9h1pfDe2
 NcYlT7i0YKtSydqirEomSpmLO+v4RIBfYcZlyhnJUDHpN5XOaI80wTT2UFaMgOiy67y7
 nTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684232086; x=1686824086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+xm7O14yXqB3fFYKPOCxA9C2ebkIifXYGTARhrCGXuU=;
 b=PX2dhGBJ1CaOV2PFuJDhN7Zr8vxiql1Jervv6J1mYmlC/ytXF/dhdjWMz/bXJ81qip
 WiXzdu+2Ek1J0ttr/TOhuZBcBYRh1eSRfMt4m6774Wax7wj9/qFYPwa3HxLUDt/No5Ha
 yAs1MGhQHR833iD3HUbunU/wtiL9wwRJQzy6C/nHYE270RQcPAR4Z6WQH0iNNe24HVgr
 Ojft8Q9u1Wpmie5Vag3Qyf49eo5zLPdn5XMTkSj9Nok7TdNL3jKFfdD941YnibBSyvWc
 9cSVeqqv+1eEm1VQ+UA/pDE6qE64ECz7bS5tVZCWtFpW8Vy7XVI8YQfqOWskAkuCyu+H
 +9Gw==
X-Gm-Message-State: AC+VfDxriX3ys5/+EiExD+pw9d4JotrsMG0DEWGYMuWm8YcdjsnqF+dV
 fvdTq0K5XH4+i1emCl5ZlzQ5BbUM2TvYoRYfWwIy4g==
X-Google-Smtp-Source: ACHHUZ7tucMt3Md3LwTi04gR1xpDAtqd6ijtb8TXkx4l3aiw4qmOgG4RrqCdUePjGIJNDF8Il/sIO6hPez7Ycd5p6DA=
X-Received: by 2002:aa7:d31a:0:b0:50b:d23c:deb4 with SMTP id
 p26-20020aa7d31a000000b0050bd23cdeb4mr26417452edq.42.1684232086483; Tue, 16
 May 2023 03:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-47-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 11:14:35 +0100
Message-ID: <CAFEAcA-zBEEJJoV1MiZbBOYi+8O1=i_JNTfBQXVuFsnPeNjyKA@mail.gmail.com>
Subject: Re: [PATCH v5 46/54] tcg/riscv: Use atom_and_align_for_opc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 15 May 2023 at 15:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv/tcg-target.c.inc | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

