Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD32873DD6D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkMN-00033E-NU; Mon, 26 Jun 2023 07:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDkMB-00030L-6J; Mon, 26 Jun 2023 07:26:09 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDkM8-00045a-Ed; Mon, 26 Jun 2023 07:26:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b801e6ce85so6080105ad.1; 
 Mon, 26 Jun 2023 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687778761; x=1690370761;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8a+GUObzzQA6zvOYQslJrAi4a5LSEQXB58+VRJofzW0=;
 b=fxtcH7X+QTxFdtf7eRCLKP6c7iC3wncAQynn1QuI1BJVZP9oLcFfjn5WCWJqiDK8/N
 T5JRW9dOgsEcmGAzooUUEo1605RkUE/ege4c8qqiQoJErh4WuHCcgzcPIJ0SokfSidha
 ZQZFPJOcbOD0gTft452nQLl1uot7HnYei2+r3/uhZBpXyO95k04fRW/Z989c1S97EGtd
 c/2bBrcTR3x8wtJ5/swzCm2kA72S/Z7qmMjc2EtYVUWsfVrERuiurh6B8cknhGa/OkbH
 Mfnn041RTuXAfrI0LRpB7Ne/X6j3O9ccKVmIdb01Aq/h/ititGGPxro21yCjK/pTXB7R
 cXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778761; x=1690370761;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8a+GUObzzQA6zvOYQslJrAi4a5LSEQXB58+VRJofzW0=;
 b=W/XTYkeMqE0fCIeiDSQqg8DywrjOyk0DximGh5uux8B5fjHPvxZJCf/0OwtooXkhNC
 wdvpGgPiyfnd/oIZUVA/poFNX2s9YxRNEUOimu4g0dd+bNjZgN2wcjQXwua1pNmZa8QI
 2pUKBhrlFfU4Cf6C3QnCaOiY8kaRrMmBnjohtMV8+200ca5zhCjpD02OCzmdMgx6EH6A
 h4VZ9/fuzaQFfc0/WLfoA6/K1LNVRJspszSGdjAjG8pH37ndPontJ1Zb80rlOoX6HROL
 eovCX+zZCjNOk9OqSIYqNTvdzvjDpEzvhhI4K15MWiRGMpyNesly2xWmPZh59UsH2eB7
 NbVw==
X-Gm-Message-State: AC+VfDwn4YppR3lWMHo+3lgdDVh8cdi3wR3XHPCip+e3ooQEoe68uHsh
 2QUS13uld5VecudSJ5LfN5w=
X-Google-Smtp-Source: ACHHUZ6z+JjIxme93EIQkXRLoLJaYlh/5Be3keirI02YOE8+P9M9l0PWLovWetG05gvV0E61uLAvdA==
X-Received: by 2002:a17:902:f545:b0:1b8:c63:4b79 with SMTP id
 h5-20020a170902f54500b001b80c634b79mr1854907plf.19.1687778760927; 
 Mon, 26 Jun 2023 04:26:00 -0700 (PDT)
Received: from localhost (14-200-238-131.tpgi.com.au. [14.200.238.131])
 by smtp.gmail.com with ESMTPSA id
 jm24-20020a17090304d800b001aaecc15d66sm3956318plb.289.2023.06.26.04.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 04:26:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jun 2023 21:25:55 +1000
Message-Id: <CTMJMWCPZQX7.LVCEBEI5KXOE@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/14] target/ppc: Move patching nip from exception
 handler to helper_scv
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.15.2
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
 <CTH6LN434MCH.2IK0QCFPCBW6F@wheely>
 <cd15856c-a664-66e6-cd27-65247784b3fe@eik.bme.hu>
In-Reply-To: <cd15856c-a664-66e6-cd27-65247784b3fe@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Tue Jun 20, 2023 at 8:47 PM AEST, BALATON Zoltan wrote:
> On Tue, 20 Jun 2023, Nicholas Piggin wrote:
> > On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >>
> >> Unlike sc, for scv a facility unavailable interrupt must be generated
> >> if FSCR[SCV]=3D0 so we can't raise the exception with nip set to next
> >> instruction but we can move advancing nip if the FSCR check passes to
> >> helper_scv so the exception handler does not need to change it.
> >>
> >> [balaton: added commit message]
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >
> > Ah you sent it, fine, thank you. But actually now I look again,
> > now we're off by one in the other direction for the dumps.
>
> This is mentioned in the commit message for the patch changing sc. I thin=
k=20
> we should not patch nip in the dump so we actually dump what the CPU=20
> should have and match the ISA docs.
>
> > So... probably your way is still better because it matches the
> > interrupt semantics of the ISA when executing the instruction,
> > but it needs this patch:
>
> OK so then I'm confused why we need nip - 4 in dumps?

Sorry I missed your reply here. We want nip - 4 in dumps so the
address of the syscall is the sc instruction itself, not the
random one after it.

Thanks,
Nick

