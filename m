Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA418826412
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 13:43:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMSTN-0006tm-Cq; Sun, 07 Jan 2024 07:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rMSTF-0006te-29
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 07:41:41 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rMSTD-0003AW-Gl
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 07:41:40 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-204c9c002e0so577519fac.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 04:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704631297; x=1705236097; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WXrEqOiwyXtxonKlT8UbYcrtZqfd9b5ivG0uOZXkOmk=;
 b=Fwy2/rZ++sni/q59/7vo86U0aDGZSr7up1UizxILRn/TZh/0K0DfjPMV/08AhZqUf6
 LEg7dPoZI/PJT+A53hU0fXp2mHD96V4ukB8r/+kYY3uVZhlZXCaKoRHi7HJRUHXmOYyn
 MerP9KIVCP5ojkAXvUVIRr7Zj6R3be5hVsES5DQEqae7BdDqwiBt0yKt5YEE1Ykrjb+E
 6ADDkYCet4x7SPUl8867EixLs5Hc+LNTvwRhq8ynscvtdZh/JaN8SNeDxbDBbMBt0NRG
 kJ3rWPZ176QWU8SaPqW3Oy8YbPKmNjSO1+nNMwBq8QnjAXhNd6LEJ0cFPohvc6Ddx4G7
 n6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704631297; x=1705236097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WXrEqOiwyXtxonKlT8UbYcrtZqfd9b5ivG0uOZXkOmk=;
 b=exgFgsF0TTPgFIqmAuH7JQ+McAspM/j+CfnrgLhwMubFuT+d4pzsWFxOkii1anPMt4
 2ASFFHU+4xd5gCoWMlJq+Sp/X+SCkSmdE9xqfgkb6MiyctZSzzVbLbqPvOSu5l67N7KT
 CoPX99qENvMtkBhWKND3e8NYHH7K0d/IbdnwraK11y0R4sJ3M5gDlRumxjcjpR11zjeh
 oMDGT31sBQS1HnA2l0UecCUWaLskgfu44uUMVumTIkWvRitZbjfzVyGon/ZrW/1M7ZCT
 jon69rGa9kkWyR85ugC6It7pMtntyLrpxwkPAriTLtYrwgWdGIyTHWrWHEvKkyDb9lvL
 VVAg==
X-Gm-Message-State: AOJu0Yx8LTO2D/QQlCThaGEC1MKY5OXIypVcQBlMIlc6IEjdBoS/Ryas
 0Wkm0gkkMxW34q4ojS7sXXcBsIQ3rT8aG8PsQDc=
X-Google-Smtp-Source: AGHT+IGurRtzMtLiVMrnCXscZDGru8Jub/zC0Uolxa0Oeu8eTer1zjtTL+/nbriA66c5AQR3ref4JuUkd8tF9NAVhu4=
X-Received: by 2002:a05:6870:7e06:b0:203:69b1:2882 with SMTP id
 wx6-20020a0568707e0600b0020369b12882mr2608035oab.97.1704631297472; Sun, 07
 Jan 2024 04:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20240104043213.431566-1-peterx@redhat.com>
 <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
 <ZZqaGf6nt0wkZgbS@x1n>
In-Reply-To: <ZZqaGf6nt0wkZgbS@x1n>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 7 Jan 2024 07:41:25 -0500
Message-ID: <CAJSP0QVA3USmat7EodQ7eBk+sf0FCT7oYBen_251ZMeeZHJ5dg@mail.gmail.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Steve Sistare <steven.sistare@oracle.com>, Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2e.google.com
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

On Sun, 7 Jan 2024 at 07:34, Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jan 05, 2024 at 04:08:40PM +0000, Peter Maydell wrote:
> > I notice that your gpg key doesn't seem to be signed by anybody
> > else; you might look at whether it's easy to get it signed
> > by somebody else (eg some of your redhat colleagues).
>
> Hmm, I think I have signed with at least Juan and Stefan.  Which is the key
> server we normally use?  Maybe I missed some steps there?

Yes, Peter's key is signed by me:

$ gpg --list-signatures 3B5FCCCDF3ABD706
pub   ed25519/0x3B5FCCCDF3ABD706 2023-10-03 [SC]
      Key fingerprint = B918 4DC2 0CC4 57DA CF7D  D1A9 3B5F CCCD F3AB D706
uid                   [  full  ] Peter Xu <xzpeter@gmail.com>
sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
<stefanha@redhat.com>
uid                   [  full  ] Peter Xu <peterx@redhat.com>
sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
<stefanha@redhat.com>
sub   cv25519/0xD5261EB1CB0C6E45 2023-10-03 [E]
sig          0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]

I have pushed to the keyservers again in case I forget.

Stefan

