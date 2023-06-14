Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A242F72F320
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HJH-0005Kq-PT; Tue, 13 Jun 2023 23:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HJE-0005KU-Pc; Tue, 13 Jun 2023 23:36:36 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HJD-00056D-Bo; Tue, 13 Jun 2023 23:36:36 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-75ec7e8e826so155767985a.0; 
 Tue, 13 Jun 2023 20:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686713794; x=1689305794;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPhhjMHycID3tnrsjbliirapVc9obEjwA+QTa1ob9NE=;
 b=EKQB0weef3bOxd0JQi9mmYMLk96cFV6ZEQhfb+zJQW+kPcg1UP6SR4hqzXie59LOpi
 qickCwoHk1fyyR0LEDk+cCB90dlsnQw+bzzIBtFmxDsLdIMjC7QDtb9eJAJmvLXc6zs9
 puAvNJbfDLG+OAOyqp/WKo1yfUFt2MA60Wze4+inJncrVl0dvWFqF9vkkL8nKNItxuBB
 +x0OEYNnLgZ63KP+lyo6e91W9YFv/e5ERPmGPcoum6GrHSREkWuH9UtXrZe8NIaRSMF+
 oCbLEgezRiet0isfku2Hp1668asXpZmuC5oxIrLVj9M9bpuuySWhD4kFTvJfmeLSj5G/
 iK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686713794; x=1689305794;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sPhhjMHycID3tnrsjbliirapVc9obEjwA+QTa1ob9NE=;
 b=CNPY/tcnGTX7Q57WnHitvvHsKZYqVCYCjdsT+tWO7I6GuMXgEJf9r8M2mx4CixhHy2
 rnnTg0bwvZjsx6IGywLDHGGwvzyoyyCHrnGv9sgPXBFq2T4PMo4RBgxLJpcex4gHWzOo
 l/fQyBx9xgOZ6vsEtH55Gon42Q1dZh1YJdRVxJY+GFcXUvkVvDoChGJRYlUKvUXPj+mE
 yTjzwVFB+u3jmD+DpxGWrThUffSTZmeTJhTiu8aEfUwJKWniRQWbBoorCL5fW7pMuymS
 e/4KbXVDwf4I5HKtqYT059ayIabV+J64tsKnThE13lYBOe+kYKI4AMv+RnUGYvjC1mSO
 Sw9Q==
X-Gm-Message-State: AC+VfDyRvCdpkTrkac91bhrbfbgRjJ0oxev5hgflXnk8Xl6V3bN/ZeNP
 br9R8A71gh3mf+HmIrks70g=
X-Google-Smtp-Source: ACHHUZ4BMRjBDD3OT/Wc6F8+1GKGt8/Mx9QJEbhGPBrpM+krMKbh0PpOkZttez77wCLF6HUXE6R5mQ==
X-Received: by 2002:a05:620a:8a8b:b0:75d:4630:4520 with SMTP id
 qu11-20020a05620a8a8b00b0075d46304520mr13593253qkn.47.1686713793866; 
 Tue, 13 Jun 2023 20:36:33 -0700 (PDT)
Received: from localhost ([1.146.66.73]) by smtp.gmail.com with ESMTPSA id
 t26-20020a65609a000000b0053fed3131e6sm9122633pgu.65.2023.06.13.20.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:36:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 13:36:25 +1000
Message-Id: <CTC24VY5AQCR.2VUJY58072BV9@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 04/10] target/ppc: Use env_cpu for cpu_abort in excp_helper
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <2323bc631817a134319fc1978531160986ecbe13.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <2323bc631817a134319fc1978531160986ecbe13.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=npiggin@gmail.com; helo=mail-qk1-x735.google.com
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

On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> Use the env_cpu function to get the CPUState for cpu_abort. These are
> only needed in case of fatal errors so this allows to avoid casting
> and storing CPUState in a local variable wnen not needed.

I don't entirely mind keeping cs around as a variable...

Thanks,
Nick

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 55 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index e4532f5088..51202f7028 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -422,7 +422,6 @@ static void powerpc_checkstop_state(CPUPPCState *env)
> =20
>  static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
>      int srr0, srr1;

[snip]

