Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E77141BE
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 03:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Ryw-0002Lu-Ks; Sun, 28 May 2023 21:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3Ryo-0002LC-OU; Sun, 28 May 2023 21:47:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3Ryn-0005W4-2A; Sun, 28 May 2023 21:47:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d2c865e4eso2096171b3a.0; 
 Sun, 28 May 2023 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685324842; x=1687916842;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L49D+cNuK2RKsmzSPg6AfKLED501Rt2FyNK8bADkyxk=;
 b=Gjd1r6N1jyo/OmkBW9EIOE6mCy3DfCGXn98tMjPzctKU2JZ1O1uK2OVjJDSY/dce9l
 YkRtAzG0glbtv6chfDaHYBelvKUWb74yuGhJn7gzbU356HtUtTE+2r9mfM/mZod3xGyZ
 UnkxAdE8630xVFwHJVve85GgZIx8y40o3i2nOqrN09czb7EUTXdVsjzwUbibNLCvxyjk
 Wo4llKz9bCS9/6Li4bP4Wzi07JGSi4ETFzrxa3DofIK6FDgKWy4AoY3Mjktc74uRJE5H
 tBvm+tmV59GDUn/U27w8wZR8S1iDVahECYxgD/Qhe/Cc5BVDfr3TCHaZgbZxXF8QlQhE
 dbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685324842; x=1687916842;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L49D+cNuK2RKsmzSPg6AfKLED501Rt2FyNK8bADkyxk=;
 b=SV9gTXl7rphmjExBvKO28fZIMzlBZjFKoou4j4aop2VsBa9ZslGbsjuQULkcwlx/we
 giNx9XjytXhIpcKL5K9Nvf1mNfU7ITaHslubsY2ODEQic7bWCVbFbSeUKDkVMoae5Qfs
 osubNEW99L/hxJzumMMZ0s6AAYSMFnMN3ho109I1mkAYV6fkqKEZa83cgVQ48PM7+QI/
 d9LbsiLl7H3DpfSivU47MhQB+hhxBI+FLfg3f/Db8WJjkFVy5NLvdHWyhWA8OV9hqvvC
 hTZbLNY2fQC9H+vcpeN5qHGqL2Q24ACNgeXRZjkQWpfpRBKC6kr/Rbnit3k4K4hIoK0D
 iWSA==
X-Gm-Message-State: AC+VfDyMOgM7sBQfZknB3uRX1Oh/Zq5o1fA/XI3WZRr9hMItLzO7PNyo
 mSvGxUxuID9LYhCd0L6dqWk=
X-Google-Smtp-Source: ACHHUZ7J+m7AhaWVP65KgmEsq9NV5IFwiLkkOZUEXgX6gIvU5UrGvivdtp94BaG1DtLsuzvvd1OFsQ==
X-Received: by 2002:a17:903:1105:b0:1ac:a28e:4b29 with SMTP id
 n5-20020a170903110500b001aca28e4b29mr11633341plh.26.1685324842333; 
 Sun, 28 May 2023 18:47:22 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 u2-20020a170902e5c200b001a9bcedd598sm6868720plf.11.2023.05.28.18.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 18:47:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 May 2023 11:47:17 +1000
Message-Id: <CSYDSM05U50R.2WZMPI0PMKU2J@wheely>
To: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v3 0/9] target/ppc: Assorted ppc target fixes
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230515092655.171206-1-npiggin@gmail.com>
 <dee25aee-5d4f-fb49-250d-b752e64cd9da@gmail.com>
In-Reply-To: <dee25aee-5d4f-fb49-250d-b752e64cd9da@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Sun May 28, 2023 at 4:05 AM AEST, Daniel Henrique Barboza wrote:
>
>
> On 5/15/23 06:26, Nicholas Piggin wrote:
> > Hopefully these are getting close to ready now. There is still the
> > question about doing better with adding test cases for all this, I
> > haven't exactly got a good answer yet but I do have kvm-unit-tests
> > for most at least.
>
> Patches 1 and 4 queued to ppc-next. Thanks,

Thanks Daniel, been taking a bit of time fixing up your your and
other comments for the other patches sorry. Much appreciate the help
so far.

Thanks,
Nick

