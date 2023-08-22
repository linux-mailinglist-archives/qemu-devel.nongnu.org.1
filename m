Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5C784794
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:28:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUDW-0008Kn-FR; Tue, 22 Aug 2023 12:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYUDP-0008Jw-S6
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:26:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYUDL-0002dA-CA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:26:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso860544a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692721601; x=1693326401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQbt1N+xe74ITT69tg5yWz1GrQEUZduKDftwx0/q1QM=;
 b=EyfH2JBKCLAXa7NMqp/rf0izdawHW2d98fZ+OnQzHT+VgAhzlMvFFFLH9oQeOzRs+0
 /DZZVRlWZ1Yg5yiaGTk3JGFxXf9uqLJuQt2WhnA7I2uKoAKqGTEe3K+m4RAkkTdVs/Ha
 ibxKLdyhdy7sZ/0NOi8DifQx4vhB4/O4sIm9T/ScPNp79qSy3BoC6Q6cxOt9Ridhxz7L
 DQdTRSR4ubG7cRzj9r3Y5SPPBnvQMrhtx3z/Fy5+OFGrcLyC7bEg25Cxx8MuNHwZsz/2
 7rrnpOxUAmgvssWZXg+QwiIjSou6bN8cLw2n6zqEGjTBTIYLm3l3ZDs9fm46kmHSpiq7
 N+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721601; x=1693326401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQbt1N+xe74ITT69tg5yWz1GrQEUZduKDftwx0/q1QM=;
 b=E4Ui9RxO8ZSLyK6ZgKYoxsB+01M+Yl05AYWaGU7Nw4gqz7j5yU8lJSrkUTyBvjQlYu
 WWdvBKVz1PRzmqn2V+ogN+FM6D6OVQ249KFNb9VBak4i0F4oPOkq2ySW+3opkMux8orp
 GI3xRiONKRHRagva6h9GB6RkzS3opmkTK6EDYLAZFQkgJJUUlHnJYMWMtsakUtXXPz2W
 WZS4LTz6bnsOUl8kdO8BnAuS/skBhT7NnQ3PGgZygQElrCAgoNHmyL3iYp5e6mwT2aRi
 0BTpNpbp5K7Y4yMX9H9ApkKYfUo1X4N8wyMyU2Mzv5lXT1IPeE0mbCGRkTjaw3AfwjRK
 23mg==
X-Gm-Message-State: AOJu0YwKZz+fD+7SFMulVW6YXXvrKlYC2tN0jYlqrOST3dxX0bCRYx9h
 jz5IiF8JuckfmRICU1WIDiZTKytu2n9mYYjt6mvFasIOQRNFqysn
X-Google-Smtp-Source: AGHT+IGXKEkCmEVO4dzUb3gYsvfF/MpV6gVng7b9OXk22uo1L/WGt8isOeRnpJo4cv/v1cRhk/T6MUtsDJ3NBgzCA/8=
X-Received: by 2002:a05:6402:3447:b0:523:1004:1ca0 with SMTP id
 l7-20020a056402344700b0052310041ca0mr9283237edc.5.1692721601490; Tue, 22 Aug
 2023 09:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230822161755.1225779-1-matti.schulze@fau.de>
In-Reply-To: <20230822161755.1225779-1-matti.schulze@fau.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 17:26:30 +0100
Message-ID: <CAFEAcA_j+2LHnmkLARcSuDJ4i0rRV0TdVkCDTY-22WUWLB4HZA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix bug in memory translation for executable
 Realm memory pages
To: Matti Schulze <matti.schulze@fau.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 22 Aug 2023 at 17:18, Matti Schulze <matti.schulze@fau.de> wrote:
>
> This patch fixes a bug in the memory translation for target/arm.
> If in realm space, e.g., R-EL2 executing code from an executable
> memory page currently results in a level 3 permission fault.
> As we cannot access secure memory from an insecure space,
> QEMU checks on each memory translation if the in_space is secure va
> !ptw->in_secure.
> If this is the case we always set the NS bit in the memory attributes
> to prevent ever reading secure memory from an insecure space.
> This collides with FEAT_RME, since if the system is in realm space,
> !ptw->in_secure also applies, and thus QEMU sets the NS bit,
> meaning that the memory will be translated into insecure space.

In the patch series
https://patchew.org/QEMU/20230714154648.327466-1-peter.maydell@linaro.org/
(which is just waiting for 8.1 to formally be released before
it gets applied) the ptw->in_secure field is removed entirely
in favour of only ever looking at ptw->in_space (among other
reasons, because it fixes this kind of bug).

There are also some other realm-related bugs which we noticed
but which again are pending 8.1 release before they go into
the tree. If you're playing with the realm support, I would
suggest you start with this branch for the moment:
 https://git.linaro.org/people/peter.maydell/qemu-arm.git/log/?h=target-arm-for-8.2
and see whether the bugs you're trying to fix are still
present there. (Don't use that branch indefinitely, though --
by next week I expect it to have merged into upstream and
then it will just be stale.)

thanks
-- PMM

