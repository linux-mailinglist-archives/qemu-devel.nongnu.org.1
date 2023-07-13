Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4728751FF3
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJuYf-0000C9-Hk; Thu, 13 Jul 2023 07:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJuYd-0000BO-Ay
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:32:27 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJuYb-0002eA-Io
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:32:27 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so1057134e87.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689247943; x=1691839943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1JvQH0jsRRrSnPGXsjhfeKJOEoDuP2fkcHuSR0OBFDw=;
 b=gh0+0aw1dje0octJkNYrmXj8moQBfpKUR7Q2/7ezlqYW3cFJWKn9cXeBgvSbHz+GVn
 YL2TZNt1Dk4iwk9esF9pOvmGkui93DO1r6zagkwQnUWWATVs+n0W3ZBdeBJUYpFLecdS
 31qIO5asbGQY222zPu0h0+EIDHK4wDlY52Ih0kLudwfdcZup4W5++76do4ByW/+ZUYLh
 9v0Z62PfOGbwGbyZ65yXC6y46uQY3rI9h10lFXIfRcueWyl4vqH3Kl+7nn2/BFuXtqTc
 5fIWKsxBlCtpiZJrpnFN9RRvOlidti0VZABw4VV0nraEDAU6717J8NE9SgkHK5iRKK4z
 +v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689247943; x=1691839943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1JvQH0jsRRrSnPGXsjhfeKJOEoDuP2fkcHuSR0OBFDw=;
 b=SGxJ8yaVpvGkMngWBlzI2+qEhcFJ6tdnPmata3r4QLdgWw8bzHRobSPufFT7G/0Z0k
 BWyBbh/vAF/f5DepnsnYEnA/2zS+0cywIpNKYyzv4ukrcTXx2xANmzHC8wa+5Qn6TCLQ
 5yGmvJ+XtdXOcBKKSq1Ao7LFFjqdHUsQaaUr3zaBtaTNErDm8wXPuFMXaAPP5cHS5RPp
 jNgPkX6fnPkAWumZpGJwF23gpCEdBFksM4vfAqRzIziqefXiQ28i6Nj0rozDiE/0q4X0
 +c3DD0I1cM65DZW0Q4gf7JMY7CNWMDBwmEQDL7mMBcs8jBUUrV89knVYM/UpFk8bKiVf
 QABQ==
X-Gm-Message-State: ABy/qLaZEfAs+gZ6d1x28w1VhSbb6liBkZC4gr3iBJ97JsZ16z8ReNfS
 UQvnrM6Qhxuj7rTWMJwnZNhWzkK528hiMYtlJbKwBQ==
X-Google-Smtp-Source: APBJJlFlSn3guaEHA1XcI8SgXSWY5/UEigToQOrzcMA272rdaxDZ9L7QTLtpbVqeCNo1Q5re4khB7aVCoETYZahmU7M=
X-Received: by 2002:a05:6512:2249:b0:4f6:3677:553 with SMTP id
 i9-20020a056512224900b004f636770553mr1342535lfu.38.1689247942724; Thu, 13 Jul
 2023 04:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230707103036.5647-1-richard.henderson@linaro.org>
In-Reply-To: <20230707103036.5647-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 12:32:11 +0100
Message-ID: <CAFEAcA9LF_7RKSut0=XrLOnWx9ag7b7R0vWongxBb1dUiHjM0g@mail.gmail.com>
Subject: Re: [PATCH] util/interval-tree: Avoid race conditions without
 optimization
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Fri, 7 Jul 2023 at 11:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Read the left and right trees once, so that the gating
> tests are meaningful.  This was only a problem at -O0,
> where the compiler didn't CSE the two reads.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

If this data structure is intended to support operations
being done on it while it's being mutated, shouldn't it
be using the atomic accessors, though? That would make
it clearer that you can't just undo the transformation
made by this patch.

thanks
-- PMM

