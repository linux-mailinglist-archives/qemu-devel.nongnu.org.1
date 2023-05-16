Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B6704B01
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:45:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysAM-0003Fy-3f; Tue, 16 May 2023 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pysAA-0003Ex-0G; Tue, 16 May 2023 06:44:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pysA8-0004f2-F8; Tue, 16 May 2023 06:44:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6439df6c268so9142106b3a.0; 
 Tue, 16 May 2023 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684233850; x=1686825850;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdFTZOZBeYUG7n5gh7osRECrBynopvDPpp5Mdm4vbOQ=;
 b=npQuPDsppQ8E0cup3A4OGB0qmL3OHTbG05V9f+hPqh9jUh+KtJ5lasbLKY7YGQrtvG
 882sF3jWQTxQoHPpLkr+xaz7iihIVjmdpL/l6D3ri/oJBvrNCYKqyMPzjM2xfnIEUYh9
 0SvDuCsS2nsiiHhEZAApESsB3T5utEmhpPwzVV3lWYUzCKFAmkfcZCpcEvlkZ1JNvLEY
 UfMAbn6SXfBFUi/ZDUt7CUjcCQ1hy7XQH7XHNfDmtiQ59aderlLdDZ6rNktvFyf82UOZ
 6h6TXw+9QBKxDjUAMP8XxLeh1iLU0CsNwY8fJuhK98aTvLqm+AHT06KloaeioqMfxIXt
 GBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684233850; x=1686825850;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qdFTZOZBeYUG7n5gh7osRECrBynopvDPpp5Mdm4vbOQ=;
 b=kDqvDAZe9fB3MN9/2HK/kpHUFPOAVupvfD+pu32SkVFB3U/yOBYeAN1pJ105Z+B5Ep
 oFb27mFpK4DEuk8x73ZNQMjvoPEQf9ulSBfF8gYmi16iemuBG91dryGfaxTS5Wegez+C
 Oyjayzj5WtXRd91o14XyRE/sWCzQ3gfP1TwBYjwGq5T3K9nmIPwBWCutvRDssiEUxoRC
 tH5FKr6DLDYL8UP2ntHl0fc97Dl3/1dJgumEEC7E6iaEHi10BphBDr9PJpYkorRZg/Y7
 8QumE+DXZIJUboitX35FjJ3xZ5ewWLPOTk20E4Wq5JC3qKq1BEsLwPcXEKZy/yhtIqqo
 ITmA==
X-Gm-Message-State: AC+VfDzEDn0vBXUbQdwOF6h1DJOW2eQPT2H4lEKtQTvBaQiwArT5LPoQ
 Lo7ESw+fUDPtlZks/aaIFBrahPm5X5w=
X-Google-Smtp-Source: ACHHUZ7JjL+AbPbdd4p+YQu6MkzG9DGom+0rnzikBsjiLea/vAI+9BB4HLaGYJVRtAvQ/Cx7nO+ObA==
X-Received: by 2002:a05:6a00:ac2:b0:63d:2f13:200 with SMTP id
 c2-20020a056a000ac200b0063d2f130200mr48052337pfl.16.1684233850661; 
 Tue, 16 May 2023 03:44:10 -0700 (PDT)
Received: from localhost (203-219-189-129.tpgi.com.au. [203.219.189.129])
 by smtp.gmail.com with ESMTPSA id
 c4-20020aa78804000000b006439ad979cbsm11640579pfo.152.2023.05.16.03.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 03:44:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 20:44:05 +1000
Message-Id: <CSNN2JCJ9ZUZ.3U1FM12NO5AIQ@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v3 2/9] target/ppc: Fix PMU MMCR0[PMCjCE] bit in hflags
 calculation
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230515092655.171206-1-npiggin@gmail.com>
 <20230515092655.171206-3-npiggin@gmail.com>
 <4b7c4c7b-d374-766b-48f1-c6769805f0bc@gmail.com>
In-Reply-To: <4b7c4c7b-d374-766b-48f1-c6769805f0bc@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

On Tue May 16, 2023 at 7:32 PM AEST, Daniel Henrique Barboza wrote:
>
>
> On 5/15/23 06:26, Nicholas Piggin wrote:
> > A store to MMCR0 with PMCjCE=3D1 fails to update hflags correctly and
> > results in hflags mismatch:
> >=20
> >    qemu: fatal: TCG hflags mismatch (current:0x2408003d rebuilt:0x240a0=
03d)
> >=20
> > This can be reproduced by running perf on a recent machine.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
>
> Fixes: c2eff582a32f ("target/ppc: PMU basic cycle count for pseries TCG")

Or is it this one? 0625c7760d54 ("target/ppc: do not call
hreg_compute_hflags() in helper_store_mmcr0()")

Ah, neither! It looks like 8b3d1c49a9f0 ("target/ppc: Add new PMC
HFLAGS"). But that shows I have probably missed HFLAGS_PMC_OTHER
here.

Let me do a bit more investigation and send an updated patch if
necessary.

Thanks,
Nick

>
> (not sure why I didn't hit this back in 2021)
>
>
> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

