Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F667369B7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:46:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYrf-0005SC-LB; Tue, 20 Jun 2023 06:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBYrT-0005NB-KN; Tue, 20 Jun 2023 06:45:24 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBYrR-00065n-Oi; Tue, 20 Jun 2023 06:45:23 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-25eb777c7f2so1759770a91.0; 
 Tue, 20 Jun 2023 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687257920; x=1689849920;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2+PWYWu67kOtcO1/lpBoUmVw2CnwyGnQa1s2+g/LgM=;
 b=HkASxJZcRjiMU5OdqNZgM0NOUXHYdY1+1tKO0qn5lfX2jO1HHe9P0aIYeJfTzOptjg
 jlo8I7ni+RWhnJG02ESuxPoiGGt+GKb8o74fY1m5JONwHF9qGQ8UtTkZ8s9vtvn+KZz8
 O5K9xCLm++pSgehZ/eE84HrrIgVuuOs7uiWcFFxKLztT1A1lOKijCi08ehD0ep3VL4/t
 F4PuXfjJPsxMhM/6JAFTpnXXfhqXURG+wuGHyb5CvOfRmDP5FDKbOsPc0SV3Ot7ZQgh3
 Hj0LYWtT27VSgPPU3bk/+UDPkn+oj8a+D05RLfneX+xh/pL8O9Tocd821U7yQXBSU5N3
 pslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257920; x=1689849920;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z2+PWYWu67kOtcO1/lpBoUmVw2CnwyGnQa1s2+g/LgM=;
 b=NEbKM8j50Fk10N8BMMPpbDa8Z9/eOdbyxlGYuz028QC8rjbb6vUCHkr1CpduIEkJDn
 3epo5YMjrxg1UdJEpKV6VAWAYswzHDMqWDAq2DMxSLaVazMaaIuEw8iHqylCMWY5kp+U
 6BzgE6WpCG/OCHJi4uKYnkpgV7hIo865edYE8mlQWC7BcVyZIUX4z69tvzAa9vAMd4RQ
 +/OI4wT/JjlirQtA++ogRNZHWNaec1+040W1VVZnFWxGGAct/upfOeaf1Q3hiOYo6Vnl
 2QDYXQcYOO7AuuNnNnA4Vb9Xmpwi1rdi57d3cZ5Qrply+KqHoOcNjIxbUY8FkMX2KTsF
 bAyw==
X-Gm-Message-State: AC+VfDzja+FJ48PzKH+Gy0CQB4ssuTiipJ8loOC3P8UPz7C1U0wHoVJc
 HNtF3Rqfd3p4DErd+LhMEs0=
X-Google-Smtp-Source: ACHHUZ7Q2gSZx3nGOOy8Gc/zg/4X2KGDHJq+QdYWLeep25+lkcTY4MzJuL2Bp5gII+hxxONnhvA/IA==
X-Received: by 2002:a17:90a:fe06:b0:25b:ba34:c4b4 with SMTP id
 ck6-20020a17090afe0600b0025bba34c4b4mr6946683pjb.32.1687257919626; 
 Tue, 20 Jun 2023 03:45:19 -0700 (PDT)
Received: from localhost ([124.170.190.103]) by smtp.gmail.com with ESMTPSA id
 gz24-20020a17090b0ed800b0025695b06decsm1254519pjb.31.2023.06.20.03.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:45:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 20:45:13 +1000
Message-Id: <CTHF0GSBVRD5.3FZQQ8143ZVWB@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Thomas Huth" <thuth@redhat.com>, "Harsh Prateek
 Bora" <harshpb@linux.ibm.com>, "Kautuk Consul" <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] target/ppc: TCG SMT support for spapr
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230605112323.179259-1-npiggin@gmail.com>
 <43ca9ac8-d383-42fd-ca29-f7cdd18d701d@kaod.org>
 <CTHEBROKN9FJ.33DEPNNJ89JEQ@wheely>
 <2756fa81-9ab8-0b15-a69e-726b47a43d41@kaod.org>
In-Reply-To: <2756fa81-9ab8-0b15-a69e-726b47a43d41@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

On Tue Jun 20, 2023 at 8:27 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/20/23 12:12, Nicholas Piggin wrote:
> > On Wed Jun 7, 2023 at 12:09 AM AEST, C=C3=A9dric Le Goater wrote:
> >> On 6/5/23 13:23, Nicholas Piggin wrote:
> >>> Previous RFC here
> >>>
> >>> https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00453.html
> >>>
> >>> This series drops patch 1 from the previous, which is more of
> >>> a standalone bugfix.
> >>>
> >>> Also accounted for Cedric's comments, except a nicer way to
> >>> set cpu_index vs PIR/TIR SPRs, which is not quite trivial.
> >>>
> >>> This limits support for SMT to POWER8 and newer. It is also
> >>> incompatible with nested-HV so that is checked for too.
> >>>
> >>> Iterating CPUs to find siblings for now I kept because similar
> >>> loops exist in a few places, and it is not conceptually
> >>> difficult for SMT, just fiddly code to improve. For now it
> >>> should not be much performane concern.
> >>>
> >>> I removed hypervisor msgsnd support from patch 3, which is not
> >>> required for spapr and added significantly to the patch.
> >>>
> >>> For now nobody has objected to the way shared SPR access is
> >>> handled (serialised with TCG atomics support) so we'll keep
> >>> going with it.
> >>
> >> Cc:ing more people for possible feedback.
> >=20
> > Not much feedback so I'll plan to go with this.
> >=20
> > A more performant implementation might try to synchronize
> > threads at the register level rather than serialize everything,
> > but SMT shared registers are not too performance critical so
> > this should do for now.
>
> yes. Could you please rebase this series on upstream ?

Oh yeah I should have said, I will rebase and resend.

> It would be good to add tests for SMT. May be we could extend :
>
>    tests/avocado/ppc_pseries.py
>
> with a couple of extra QEMU configs adding 'threads=3D' (if possible) and
> check :
>
>    "CPU maps initialized for Y threads per core"
>
> and
>
>    "smp: Brought up 1 node, X*Y CPUs"
>
> ?

Yeah that could be a good idea, I'll try it.

Thanks,
Nick

