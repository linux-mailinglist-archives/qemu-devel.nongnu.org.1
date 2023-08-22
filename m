Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC58C7841CB
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:17:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRFf-0000JK-1m; Tue, 22 Aug 2023 09:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYRFI-00008o-Rg; Tue, 22 Aug 2023 09:16:42 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYRFG-0000TI-HK; Tue, 22 Aug 2023 09:16:32 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-570b6e1a413so1715359eaf.3; 
 Tue, 22 Aug 2023 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692710188; x=1693314988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMx8PhyPKpZUd/+PfW7Ab9VKVAtMFXTkGEB+x/bifeg=;
 b=lVJT6cVbigfU2Z4fpWz5EvW+gkwWi2fqM7zIoFGhcnVzhwEEZlLm8ZhnTACrxpRInD
 WQIPch569glXUF9+//xEhcYaYIBO64tURB+fMkYm+qtQX4M7ldvJjEA+Nyn83Yc/X6Z0
 mkRbOVdUF4QBYZXxi5QEJ3yUsU2Urg85DPZPW9XYJUDNJC0bOwR9VpgcVLkAOe4FoiNi
 ywSut6PHg6io3y5SjfljGDJ/OzGqF/bDdhALTMP+tsi7bUtg5XRyYj92tIk8Xx1ZCtf1
 +13XyB1bXYlCJQHlxRZX8JcK0kV7yn66ev/5dg+wp3REgA1RBK6hJZyFowJMTP1BcHkt
 Y7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710188; x=1693314988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMx8PhyPKpZUd/+PfW7Ab9VKVAtMFXTkGEB+x/bifeg=;
 b=FHEY+pJdX0py7RgOC6AK6YbQHptdCK+GLHsAt/aDlRNSt0TQKfRFmV58bnpOkK0eyk
 kuDFUSCqb5h12/EJfUtwFD8i0ktXsBP2tDvVfp5mj0p85hkJtCbzT80OEoZ4okbvFbQW
 QhCxPW8uUzVxiHgFIk+wG3zT6j+WuCRLVeZQ1qD0yEueugUVtJO3/+zbSLOVN/FWWe/2
 kK1+tt1B8PjNez9aMb98iULbO3BduN0rdUVfQz4uwOjZvFzndoCIQfpwmmTSagWBrTDd
 RaoHM4JIHyKjb17ZXL1b3w3K1SiaQgZbmfXrOAU9cm4Zbu/Z7wPI+gGI9nBwxm2MJVoB
 /dlw==
X-Gm-Message-State: AOJu0YyD9WBWvOVOegpEkfAxEoD83OGxpAoDWpV1C2jSdsEmSjj8rOES
 Rja0wHVLJKJIDfw1YwCWfb1JkUuiXlf3F1iM7Kc=
X-Google-Smtp-Source: AGHT+IFapqjb5K/AJSL9eAvoOtvowy6/5Spt/EN36SvbYdd3pY+seTCrwfponVr0IgZUtljbJWg+mxMW/PpevLKZhHg=
X-Received: by 2002:a4a:301e:0:b0:56c:7c3b:1c21 with SMTP id
 q30-20020a4a301e000000b0056c7c3b1c21mr8335407oof.0.1692710188071; Tue, 22 Aug
 2023 06:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230822125716.55295-1-philmd@linaro.org>
In-Reply-To: <20230822125716.55295-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 22 Aug 2023 09:16:16 -0400
Message-ID: <CAJSP0QUKO9WsiZY8OYD-httbcrxPsR6qsH63pAzFNrXCa4TE+g@mail.gmail.com>
Subject: Re: [PATCH v2] docs/about/license: Update LICENSE URL
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 22 Aug 2023 at 08:57, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In early 2021 (see commit 2ad784339e "docs: update README to use
> GitLab repo URLs") almost all of the code base was converted to
> point to GitLab instead of git.qemu.org. During 2023, git.qemu.org
> switched from a git mirror to a http redirect to GitLab (see [1]).
>
> Update the LICENSE URL to match its previous content, displaying
> the file raw content similarly to gitweb 'blob_plain' format ([2]).
>
> [1] https://lore.kernel.org/qemu-devel/CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZ=
N4sKDarSeu7DYoRbA@mail.gmail.com/
> [2] https://git-scm.com/docs/gitweb#Documentation/gitweb.txt-blobplain
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> v2: Drop '&ref_type=3Dheads' (danpb)
> ---
>  docs/about/license.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

