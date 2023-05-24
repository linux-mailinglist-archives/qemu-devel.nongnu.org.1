Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0470F444
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 12:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1lmT-0005Ul-Tf; Wed, 24 May 2023 06:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1lmD-0005UN-9h
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:31:29 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1lmB-0001oI-OV
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:31:29 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-513fd8cc029so1694403a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684924282; x=1687516282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ldZu5D1nrOy+8us2rh9980tv+QWYS1zaM5b3/sLyPLI=;
 b=nE+U1IECLBHx+1sNZ+OX5MrvX8WyfFpamN3sGtVMWlN2ewaKLx0ry/2HHcp8LdZNym
 txkrAu9Blb+hLAAwF/rDZODUVcpQiznmPEPQq/aUAeeknRPNrIEqGBW8HJNYZ3eEdh7R
 FIaiLlobsq19FvgBDYMUV7FVphBzEiyEh0VM8ej2CU5jQQopmbfZlcsREqooq3J4U5rn
 9AoqVRr+3kkq8bdnOUJZW7BRLcnuuvkVQYUBTDFTp94rydkqF3zQPlS4npCbWSpWq1/L
 NWyg/SUFfGm0mrvCaQUbsJBc2myNiFEZQGGUoOiJJQgn6Syq0gkC8P+Y+0SjEyBOGMa7
 oxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684924282; x=1687516282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ldZu5D1nrOy+8us2rh9980tv+QWYS1zaM5b3/sLyPLI=;
 b=QZ9r/VQkdrweFDP/I29tuooZPGd0jg6UJolEfsTuiLm+/kBijLXnOUjL4jxH6RadKq
 pIntWiN7zto8lbgh83vOqCdrhK0dTNaIvhtLeZFanVAEhUrwPxA+JgG+yRNwSGOLMX7/
 sK9W6QN4YnkWD/WsPpff6njo2O8IfbXkoKwhrrXwsAa1tNBKYZCYuIDUqGcRL+RJgJRW
 +4gIoGUmRjJULq5kdlLOQyfVNgmpGmKbXCXma+4CppQpQ+iOeIBzLNq8DxhSPw6EdVPd
 DuhLSOdpAfExKYRU1Iz6ENlv6dM2m6F9tYGT915CKgEgGwJXrIHFpStPPHNfPXagX8YC
 7JHQ==
X-Gm-Message-State: AC+VfDwM7un2lV1Dn16vt6nls889HLWRZPWVn8E5evvMwVFawvBkqhZN
 E241IMk0Yo+jrfN8hX//BdAVL223YP6k5JB9N0+XIw==
X-Google-Smtp-Source: ACHHUZ51nictspdE/zADeGFD2gbH+zZilIAtEWY+QIetMzNNz6+nIWELIAhTF4S+YxDSOqj9SuLIIvBICyaXwHE47mA=
X-Received: by 2002:a50:fe89:0:b0:50b:cadd:21e6 with SMTP id
 d9-20020a50fe89000000b0050bcadd21e6mr1647125edt.8.1684924282147; Wed, 24 May
 2023 03:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230523223844.719056-1-richard.henderson@linaro.org>
In-Reply-To: <20230523223844.719056-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 May 2023 11:30:56 +0100
Message-ID: <CAFEAcA89YToWdvwprxQgaMBpp4KVFqj8asXpBBcikg8zseSv0w@mail.gmail.com>
Subject: Re: [PATCH] meson: Adjust check for __int128_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 23 May 2023 at 23:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove the signed * signed check, leaving the signed * unsigned check.
> This link test runs foul of -fsanitize=undefined, where clang-11 has
> an undefined reference to __muloti4 to check for signed overflow.

If you can't do a signed * signed multiply then that sounds
to me like "int128_t doesn't work on this compiler". We
specifically added this check to catch "some clang with
-fsanitize=undefined don't actually correctly compile
int128_t * int128_t" in commit 464e3671f9.

-- PMM

