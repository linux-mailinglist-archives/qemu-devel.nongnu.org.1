Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED2831668
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 11:06:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQPHg-0000R2-N3; Thu, 18 Jan 2024 05:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQPHe-0000QB-0k
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:06:02 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQPHY-0003OF-IP
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:06:01 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cca5d81826so155412751fa.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 02:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705572355; x=1706177155; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uTmgt5LKqekmL4R8cbSTdHv6RqEq83JLTfEj+9ciDjI=;
 b=q0Vql8kdaElAfE1WaC+a0dbafaWkPjIc+xztOblxktNWo74HLLZNJkt6ZjAvrKeJKl
 /0bWeyJCzsz7NDXjfYs8ebAQvtk+BmYDdQzarcJO1u2WTMWfYGRUBYMq1WQSNvh90jQo
 2W9EJt9j6QiS8uPGL2XXGWDuktBGpOEEfjI7mPQAyyDtxpjvH5oA0eyEZSfqhfahEgQD
 AKvq6RFHAmMnqgoRfju4pu+TGvncYnSPPJHzgPPYGqG+ByjaG1A6VcR5EZGEXL/msusW
 bbe2t5ScS1nv7IXoiyjM71xm/jHw2Nt0blDqMPXZso773Y67+gLwnUi1ZErWfuzmrC3S
 BBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705572355; x=1706177155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTmgt5LKqekmL4R8cbSTdHv6RqEq83JLTfEj+9ciDjI=;
 b=R7sENFws3F3YyJWbLaSIrgp6Sg3hnhedDhhxCuNBD8b/fQb9mOO+mCGf9Qc44rFrzh
 zaSflJeRmjscj4DVXvrH/v54iIGnVLvK5gEfZWT4vvcpes8nUWeKh6zGsnuKTFeY4NlB
 1Wzxy8dy8p0U0kzs/dLAGz6aev7ZeyosXIlANi4SLPwMJXH61Lwnm7fVHPhJlaLYGeRJ
 FhoBgBAaDIU54YMJJKI3qy5YR3waGRhkv0iRgfZZEvZYtPIeB9z4+vtYU8GKC7mbfLWt
 E//EOuLV/nrxJjJEnVPBzboX1T3pHUrf1h8wFNMnhEJQ3lb5rptXd6m55GS/p3PnEUBr
 O6qA==
X-Gm-Message-State: AOJu0YxgKY1PHpfcneVSiL20U/sgiv3ng8osiwfeeJTYcj/4W9SDQqmB
 d1qMqoKjpkkkMDOmDKyW/FGcgKc2ziQ1TMmZaUYKW6YyCJUjLBfC8Zk4I9i466lGSn4CzhlccZU
 AizbS/DzQ0mNsdf6Mi/NZILv66IBAUztgixcrDBuBNbpwWLtK
X-Google-Smtp-Source: AGHT+IF5HwDI4v6ShIliVfjGkF2zVZ7AnylD3r79HNhfRbYsGmkMcLF3O/yP24TUD6W+voQYz2UefQGkTrw6E3dRs/c=
X-Received: by 2002:a05:651c:21b:b0:2cc:e3b7:f7a3 with SMTP id
 y27-20020a05651c021b00b002cce3b7f7a3mr423416ljn.71.1705572354857; Thu, 18 Jan
 2024 02:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20240109092015.4136865-1-kai.kang@windriver.com>
 <CAFEAcA9LBXMxOzJwmXYEVj+q0hTzMQZrpZHOOKFYWZDKXFyHig@mail.gmail.com>
 <1db86e7c-9d4a-6c7d-9e6b-52054b2382cd@windriver.com>
In-Reply-To: <1db86e7c-9d4a-6c7d-9e6b-52054b2382cd@windriver.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 10:05:43 +0000
Message-ID: <CAFEAcA-UPK_Uo_6bvMVrGSR9ZPMuA4DiAbJOmehhYSKKpEuMWw@mail.gmail.com>
Subject: Re: [PATCH] qdev: not add devices to bus in reverse order
To: Kai <kai.kang@windriver.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Thu, 18 Jan 2024 at 06:49, Kai <kai.kang@windriver.com> wrote:
>
> On 1/18/24 01:31, Peter Maydell wrote:
> > (cc'd the people listed for this file in MAINTAINERS)
> >
> > On Tue, 9 Jan 2024 at 13:53, Kai Kang <kai.kang@windriver.com> wrote:
> >> When this section of source codes were added via commit:
> >>
> >> * 02e2da45c4 Add common BusState
> >>
> >> it added devices to bus with LIST_INSERT_HEAD() which operated on the
> >> single direction list. It didn't have something like LIST_INSERT_TAIL()
> >> at that time and kept that way when turned to QTAILQ.
> >>
> >> Then it causes the fist device in qemu command line inserted at the end
> >> of the bus child link list. And when realize them, the first device will
> >> be the last one to be realized.
> >>
> >> Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to make
> >> sure that devices are added to bus with the sequence in the command
> >> line.
> > What are the problems being caused by the the list items being added
> > in reverse order? Your commit message doesn't say what specific
> > bug or problem it's trying to fix.
>
> The problem I met was just as I asked for for help in the maillist on
> Dec 18, 2023.
>
> The indexes of serial isa devices changes with the commit dcdbfaafe90a
> since qemu 6.2.0.
> Before the commit, it creates devices literally with "1" & "2":
>
> @@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
>           aml_append(scope, build_fdc_device_aml(fdc));
>       }
>       aml_append(scope, build_lpt_device_aml());
> -    build_com_device_aml(scope, 1);
> -    build_com_device_aml(scope, 2);
>
> After apply the commit, it uses the 'aml builder' way and the devices
> are handled in reverse way.
> Then the indexes are reversed. It affects guest os such as freebsd. When
> run `pstat -t` on freebsd
> with qemu, the sequence of the output is not right.
>
> root@freebsd:~ # pstat -t
>        LINE   INQ  CAN  LIN  LOW  OUTQ  USE  LOW   COL  SESS  PGID STATE
>       ttyu2     0    0    0    0     0    0    0     0     0     0 IC
>       ttyu3     0    0    0    0     0    0    0     0     0     0 IC
>       ttyu1     0    0    0    0     0    0    0     0     0     0 IC
>       ttyu0  1920    0    0  192  1984    0  199     0   664   668 ICOi
>
> It is expected with ascend order which keeps the same behavior with
> older version qemu.

Thanks. This seems like something that should be fixed in
the AML related code, not here.

-- PMM

