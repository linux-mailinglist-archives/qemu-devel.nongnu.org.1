Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F2175B3F0
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:13:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWGz-0003KC-Ld; Thu, 20 Jul 2023 12:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1qMWGv-0003Hg-E4
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:12:57 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1qMWGt-0000Hb-Lo
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:12:57 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1b06a46e1a9so751465fac.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689869572; x=1690474372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71eTAIWFlt63L66STGFEau4N/rm+L69jq4+JmG/ghK8=;
 b=np5BO3O0leTQthjp27yFRjQukgS5GDXt6q9vwFs/nVoAkXh9/Sf9J8zLSxwrOTZh8m
 iSHzTYog61RLdkmj+RpRrc1l5VBIcbTJ2EKKHLxnEa5lviXjV64qze9k2JqIPW76fjhQ
 d7cHFt5QUDskUvEh4Yjpj4MOy4+CsJCSCD1gPxyZgJt4dmlMwcfuE2Pz7lx4zbP7he7k
 bHMySzhscgx6I/WbZi3+OTIzajY1P3ZUFOo0Eki/nV8vVFFtnRynGXVQvK9yAK+KZl4f
 40Iayl7ODfcAmV09ZHs2nLdEzrGFkQ8L/YblYpDblz+tPGPJwOAco7w0PNQzYEF81RuS
 fUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689869572; x=1690474372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71eTAIWFlt63L66STGFEau4N/rm+L69jq4+JmG/ghK8=;
 b=QAbHq5sknn+DuaZI7TuADJfrZsEPefTKO0S1LwasuZZg0CJrq118Z/BmQx31TMpZPY
 vzKLNVScwncjUaJdj2SHnRVbX7KjRXGP89tvUp/HSmdXZXtf6MDpuWxu4Am59Dp3BaIq
 jFDWcTb2WB3isHZLK8FS3Z2tdQZrBXv4HxecMBfOqF3hWNI7v2zrsXAFelpiiiOKtOHD
 6v3oq3PlKRO38c3JfdduRsUDILXpoPV2o8TJqlXCrx4+F+OVBPCn+fK2afyu1DrTxWyo
 iY74BNKJzF7Vmojz8K1nm4mJDOUdXK9zaQBZu+nuQR9mC86QEqNmj71XJKG8bBQfDycG
 c8nw==
X-Gm-Message-State: ABy/qLaMVfpT7apfYODTay3majy39nHOzr5RkZ0gQN5T8q4H3fe23EKP
 5J/cwm+rzkh70aduv5mt/meI43ExBXHWNdmRS6lHtFJmSj8=
X-Google-Smtp-Source: APBJJlFwotSR+K3Sg14Xubr9TCX74aTQcVrs6pSIcPh4cGiRczMAt4+sZWzEDgmzn4aPqw2tXJ84YJTZ1wWDZnn85SE=
X-Received: by 2002:a05:6870:3053:b0:1b3:f010:87c2 with SMTP id
 u19-20020a056870305300b001b3f01087c2mr2272413oau.30.1689869572269; Thu, 20
 Jul 2023 09:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230608104222.1520143-1-lis8215@gmail.com>
 <781894e9-2565-b54f-8df3-9cbd1cf68e2a@linaro.org>
In-Reply-To: <781894e9-2565-b54f-8df3-9cbd1cf68e2a@linaro.org>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Thu, 20 Jul 2023 19:12:32 +0300
Message-ID: <CAKNVLfbdJ=bdLFYR-TUR8Tr+Gcqb-iB8PUCMUZYShTNB4CyhMQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] target/mips: Finalise the Ingenic MXU ASE support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=lis8215@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

=D0=BF=D0=BD, 10 =D0=B8=D1=8E=D0=BB. 2023=E2=80=AF=D0=B3. =D0=B2 22:28, Phi=
lippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:
>
> Hi Siarhei,
>
> On 8/6/23 12:41, Siarhei Volkau wrote:
> > This patch series is aimed to add complete support of the
> > Ingenic MXU extensions of version 1 revision 2.
> > The serie doesn't split revision 1 and revision 2 of the
> > MXU ASE as it ought to be, because I have no hardware which
> > supports revision 1 only. The MXU version 2 is not the subject
> > of the patch series either.
> >
> > All added/fixed instructions were tested on real hardware
> > via set of fuzz tests written for that purpose, although
> > the tests aren't subject of this patch series.
>
> Thank you very much for your contribution.
> This is a bit unfortunate that you did'nt implemented these
> opcode using decodetree.
> Also various opcodes are not well optimized, and would benefit
> from using the TCG gvec API.
> I imagine you have been rebasing that for some years now, so I'm
> queuing as is to mips-next.

Thanks so much for applying, Phil.
Unfortunately I have little expertise in the QEMU internals,
so, I just improved what was already here.

> I hope you can share the tests so your work doesn't bitrot
> with time (in particular when a good soul converts it to
> decodetree).

Here they are: https://github.com/SiarheiVolkau/mxu-tests.

BR,
Siarhei

