Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BD7370A7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdQx-0008EF-A9; Tue, 20 Jun 2023 11:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdQr-00087K-0o
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:38:15 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdQo-0007rY-0X
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:38:12 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-519f6e1a16cso5749223a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687275487; x=1689867487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MoGjPgk/uRWlVcWLSh1TXKixNJ0OTYRcu7/yn7yeKEU=;
 b=wg/qrnfOyXMhQ3PoKqOxz4GOk1oFPe5eFIc8AEaRPPDsu4mY7yV/MYEodDFGeEKmew
 DmWJOVomXdg6/TeC+nSbL3NjQX8zcUtn5xFMbUbQlQX1eTrADqiuaRxsDT7j1z5FKavS
 t6Cijnr1zm7aXFvT9aXP7cBzLQ7vNGfQ8/ulP5pbDA8mJzjKhPr71vbu3LTDeK/UP2Tw
 A5JcFYZuWE3RuYs/FM1RBQLZH5YyNsBYP0OJONs3ZxjFYibD+VARXaQNL1wBJElT2HO6
 sGOiU8rIP0pmPRl/d8Hu9DJAHGgmUCbuZYoDFOLP8GK8pjc2957NyrktnGzhGTMdlowq
 RaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275487; x=1689867487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoGjPgk/uRWlVcWLSh1TXKixNJ0OTYRcu7/yn7yeKEU=;
 b=IPTOPlvOmB3SbybqED8rk54XA4Om2BTd/xZg5sdhwN5pP0GPKwy19rGxvn4KvfokMo
 ks+MVHAA/j7CT92f4i792OhsmiABSr4zeEIecRfV9cJrWjQP5I4S0sxTOORD0wwO04h0
 q25FssCroQzvNiSrdqE9DuIPeRtROhdN/XITBVCBWm47NveT4XHvUNgoMaO0GJf804I+
 cl4lgg/0Jydd0bpFkP/Hileo5IL+mVw1r/3kCnEOKu/+tzPfFuHhsfXUOYSXzuCY+lAB
 yI2ESkbevTLjDLBsQE7kpgKp1W5kbn8f4iSihWhKh2UUqVM9rzJSQwtoYdOeWXiGbAw+
 Sp0w==
X-Gm-Message-State: AC+VfDySb637KGWMfp6H5YDh4KhyTKL3vHxdoLeHsd759KIx9ngxbPaw
 64idh0dr2Ju1mp0IwPkWrgGpga3K5ZrDP9oPOHbFLw==
X-Google-Smtp-Source: ACHHUZ5RQu/KrtxTKBcZw4tLQ2esizgg5gbEutgXh6FzGL2dOjgcuK9LfJXy4crj1Rl6CixOtLDnYNLu9Yt72Z0E/LY=
X-Received: by 2002:aa7:d7c4:0:b0:51b:c626:7d71 with SMTP id
 e4-20020aa7d7c4000000b0051bc6267d71mr2546886eds.14.1687275487599; Tue, 20 Jun
 2023 08:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-2-alex.bennee@linaro.org>
In-Reply-To: <20230619171437.357374-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 16:37:56 +0100
Message-ID: <CAFEAcA8jVCMn+CmOWOA5a2HWu5NQtN96qES2-BMtf6PNnNqgtA@mail.gmail.com>
Subject: Re: [PATCH 1/5] docs/devel: add some front matter to the devel index
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Juan Quintela <quintela@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>
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

On Mon, 19 Jun 2023 at 18:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Give an overview of the most useful bits of the devel documentation to
> read depending on what the developer wants to do.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

