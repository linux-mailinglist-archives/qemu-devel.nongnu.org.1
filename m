Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CADC731756
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 13:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9lLJ-0006HK-W8; Thu, 15 Jun 2023 07:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9lLG-0006Gw-T5; Thu, 15 Jun 2023 07:40:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9lLF-0000Qw-6Q; Thu, 15 Jun 2023 07:40:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b505665e2fso5152695ad.0; 
 Thu, 15 Jun 2023 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686829239; x=1689421239;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RPA8bWL6WNp1sn0O6jKOeQzokwEhqOb9JKTwJbhvhE=;
 b=M1+4OJgQxUQw0eOA/9t9Winsz8/r9UymIi01+WT5KeyW/lq2/3z4NisE2j65Z1l+rf
 9vynHBdgE8GV4AeA5DmvTw8uDGXUAlI81WnL3mPe9x6e+aOhQLit+xWAlv2b4/ouCOnn
 ZybV7K2YIqIfFxU9AhxRnBL9Fq9+qIglbOoXERqm/Z7oIhoehbGgjOCNMQCr6tsU9ba3
 KZaiw8hBYp29/sgh7dTKyN6+35Yb/j3H3/PEYNxTIAvcnZIJ8TT1KZiQ+UBu8nouth1e
 Wtptt2aRxQ0Ri9cz7+U23bNgNKsqPu8QERYXsip2WfP/kj/dbxg4ejv9A59kCPT4/SzJ
 JJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686829239; x=1689421239;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/RPA8bWL6WNp1sn0O6jKOeQzokwEhqOb9JKTwJbhvhE=;
 b=Qh0bLM+VxCLXGtwQRFMPJ/KOZa3KAdyApvYt1x/CydM93q/Xqwb+oZUhjmAIsDY+SQ
 FZVrGNBGCFeZCj7r6opFesQKzJmsOQwnID0lFl7b/OfCfYJ6ZA9azGh5EZxv1wWMVoXI
 ayBV+RxRuPf29XmOrViIUzSxl2D6IUyGLQxYzsYV0Q4ocuHD2hSCTiBDve5DoTVE1WcL
 BqwdtDvT6l4qN8Vqxmrsz65UzZpkzd9ObV2ipdJgyiNxH1liOYQJnKFlO9vQ+JoFx/gf
 aw2lxGtOFdp5c762NvaHgy7B64v9KxBfsa+jq4jeRIr2sdh+wCxl5ckeT6C3AAdWrUMW
 GmUg==
X-Gm-Message-State: AC+VfDyQZoZnQi032lVlC6Uja0NWDD8nLrMnx96BaZv3AobUhzuz3F34
 BdV3o3Xdp+VB7elarQNBShU=
X-Google-Smtp-Source: ACHHUZ4pjRa6K8iJYxI21IxXmAQ1nxXKlvscoaZH6BySBI42MsaTky2KGaG+zgG3T52Etue3Kq4ngA==
X-Received: by 2002:a17:902:ecc6:b0:1ae:8fa:cd4c with SMTP id
 a6-20020a170902ecc600b001ae08facd4cmr6974774plh.7.1686829238788; 
 Thu, 15 Jun 2023 04:40:38 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a170902a3c900b001ae5d21f760sm5315599plb.146.2023.06.15.04.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 04:40:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 21:40:33 +1000
Message-Id: <CTD723ZCV2NQ.2GYK12U9AFQ2J@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 05/10] target/ppc: Change parameter of
 cpu_interrupt_exittb() to an env pointer
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.14.0
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <78ecd505a8b523e236cbeab335aa0621f7834cc5.1686776990.git.balaton@eik.bme.hu>
 <CTCWOA3I3X48.2RZG2THERVO2@wheely>
 <33d841e7-38ab-07d3-4914-a055b029605c@eik.bme.hu>
In-Reply-To: <33d841e7-38ab-07d3-4914-a055b029605c@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

On Thu Jun 15, 2023 at 7:19 PM AEST, BALATON Zoltan wrote:
> On Thu, 15 Jun 2023, Nicholas Piggin wrote:
> > On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
> >> Changing the parameter of cpu_interrupt_exittb() from CPUState to env
> >> allows removing some more local CPUState variables in callers.
> >
> > I think it's more consistent to keep cs, which is same as
> > cpu_interrupt().
>
> But with this patch it's more consistent with the other functions devlare=
d=20
> in helper_regs.h and gets rid of the #ifdef in hreg_store_msr() so I'd=20
> still like to keep this patch. Callers already have env so it should not=
=20
> matter.

Being consistent with functions of the same file is not important or
really makes sense. It's important to be consistent with functions
of similar type. cpu_interrupt_exittb() is a helper to call
cpu_interrupt() so makes sense to be similar. At best it seems like
pointless churn.

Thanks,
Nick

