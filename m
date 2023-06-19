Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A879735BA7
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHEo-0006kE-4j; Mon, 19 Jun 2023 11:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBHEK-0006eD-08
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:55:48 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBHEH-0004p6-4w
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:55:47 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51a20138617so5198848a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190143; x=1689782143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wZPBsvYOojFWwJdEHHf2LCFoqUu9gslOakc5Jllrq74=;
 b=rWY5G80xR1VAwv1il6466Hz5R8gYaUIFmC5CagV79JrSjq8KJWJqlxSZVhaaHD4MY8
 shPfiMKekQwJWkMcXkVl7jktO0DuMgdZkm9981ValbqEfJFKKjsqWy0R/nixouT4Q4JO
 VZdI/pxGpv3xSSvkhTR2VnpxzvEMKFChyljntoUu2V6uMyZdEkjvOQE3KwjRwNTj7JrP
 Yv4srnMsoncs1K7m7CZFRPNqdQOfqYhaLO1wB5ed+deJ8suQNfl7kPnjiEvUkZTvefPW
 azW8bpqoTac2k7dC4kWf2Cr2rhDRVeVBEfqnWxbJExjfjjQpyY9qfQgbI9TlD7zpAsJk
 6+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190143; x=1689782143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZPBsvYOojFWwJdEHHf2LCFoqUu9gslOakc5Jllrq74=;
 b=ePtPaekev8lL2Qb0MGwEndnJ4J4jYvr8WZT+tUsasur7VmtAbrc5TLpjlcy4YJNVZo
 WvRzPNOCOW03aonZKEAceSrKFKTDzGz0TqzhRTU3OPz799rhx6BR8wct6yJEXoAVWjHM
 64KeNR5AjkFIYirGoBHZ29OiGAC1OwItq0koE1Vptc0otMrjhnIdYMUk/mivMpPhwOCx
 RLM387044l4U5Iiggby417WKl0YljQyl2Uge7jkkT+cAjv0nbqupsI7zyQN1NgdQLFT7
 QPL6mnwtQbr0tCBiy3A+JLvei6wfaA544i+fU8J90nRVBjvclughc6NexEgg4DgB8kHz
 Lcig==
X-Gm-Message-State: AC+VfDyrc1Q0GuhZHp0nVaVdRfHYV4IKCVgu19FzsE8OOJDLUYbegqTB
 AACtQSNgjS+Xsh4J/yyywgeH9608fDJi2030eEjTJg==
X-Google-Smtp-Source: ACHHUZ748fAtSKjRCxCvLkuUG1tMb3QXD/lI1zmkoYgIjMgM0l4z/4FOcG6oA4ob1FDNzvxYIGiElUOa2OVj76nMVRw=
X-Received: by 2002:a05:6402:1a37:b0:51a:4042:6b0a with SMTP id
 be23-20020a0564021a3700b0051a40426b0amr5594901edb.4.1687190143538; Mon, 19
 Jun 2023 08:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-2-npiggin@gmail.com>
 <CT4I52C30RXG.AESIFCY16U6T@wheely>
 <94a453bc-cfd5-5fb0-289d-dbb321c8b172@linaro.org>
In-Reply-To: <94a453bc-cfd5-5fb0-289d-dbb321c8b172@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 16:55:32 +0100
Message-ID: <CAFEAcA_hirbGc_iZUhsD22Ksjj_2OBevDJq-r1mvnVqKoTqCvA@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Jun 2023 at 16:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/5/23 08:27, Nicholas Piggin wrote:
> > On Sun Jun 4, 2023 at 8:28 PM AEST, Nicholas Piggin wrote:
> >> Differently-sized larx/stcx. pairs can succeed if the starting address
> >> matches. Add a size check to require stcx. exactly match the larx that
> >> established the reservation.
> >
> > Hmm, question: reserve_addr is a VMSTATE field, but reserve_val is not
> > (nor reserve_size after this patch).
> >
> > Blue Swirl added that with commit a456d59c20f ("VM load/save support for
> > PPC CPU"), and when reserve_val was added in commit 18b21a2f83a
> > ("target-ppc: retain l{w,d}arx loaded value") it did not get migrated.
> >
> > Could we end up with reserve_addr != -1, but with a bogus reserve_val,
> > which could then permit a stcx. incorrectly? Not entirely outlandish if
> > reserve_val starts out initialised to zero.
> >
> > Could we just clear the reserve in cpu_post_load? It is permitted to be
> > lost for an implementation-specific reason. Doesn't seem necessary to
> > try keep it alive over a migration.
>
> It's not a bad idea to flush the reservation over migrate.

Is there any particular reason to do so? The default simple
thing is "if this is state that persists across instructions
then migrate it"; we usually reserve "do something special in
post-load" for oddball cases where "just copy the data" doesn't
work.

target/arm migrates both the exclusive addr and value.

target/mips migrates lladdr but has forgotten llval
(and perhaps llval_wp and llnewval_wp, depending on what
those fields do).

thanks
-- PMM

