Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7374BB1B
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 03:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHwgJ-0002S3-0B; Fri, 07 Jul 2023 21:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHwgH-0002RZ-8Y; Fri, 07 Jul 2023 21:24:13 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHwgF-0006MZ-Ji; Fri, 07 Jul 2023 21:24:13 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-392116b8f31so2049355b6e.2; 
 Fri, 07 Jul 2023 18:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688779450; x=1691371450;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwLtWHsjA4aEYVtqcxXeib5Cr4Npsv65latHJuREzQ8=;
 b=W8BAoC4FSnCZL1i3jJouW7r0cAGIct84oXPf2dL13/2xRjklt0847uD97ge4p1AZmx
 YfXdH2HVz0kKk1jVKtFtfMsQFfwxN6PrL7vp4x9wstFAsTZgsLTmbr1EnVK9WiDUxmWW
 Y6hm70WPiWM/xi3paezRSfWZAC1OoznHNtBY3x3qAhrgyFCDzBVjnepqgoVYKtT4JKZK
 ipD8RIEZ2tAS1+0ZhXtLAApgqSy2asu1gJZWyE+ArG+s3Yb/9DuUWppLaBosFiYUfGu/
 HB25J9wU9GJVp+5KrBn+LW7lTGA01TmhPI/+1B4W1Lac31h6aInXYGBya7C5tlNYa7Aj
 FCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688779450; x=1691371450;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EwLtWHsjA4aEYVtqcxXeib5Cr4Npsv65latHJuREzQ8=;
 b=KwnwH0FgMPMwA/i0BzdO2GUqVhvixA+pJb2Tr+/TH/pqDEVp0CdXGwFZhubif3ShmI
 895PCaMn1Bfs7a+eyLGGYgp9NRG0Hyn3YGqbs+sCJJmZ+N4101/WwTUrQ3Jz3ctu59P2
 KUOhw9hCnPx2lu5oX8HVi75tNDP3nwN/N/TSNxY8EGxl3TgJf5G/jPi7vbHyaW0ox2wX
 LC7gIj5BkDp+l9sLtyOqtersY/tX2K5/KypzkcTWkVk5o6+/83qGrjGS/YjLr1+1hmhF
 QH1t/8q8p26/XwoawsAHqvnhauds+Vt/9SXhUF+q/X7ZdSY7cthbu+XGFgzl9ytjMM6U
 vSkg==
X-Gm-Message-State: ABy/qLaiY2O/uxo/FuRFKYHQg+zWHU1Mm5ffQqc370NaZ5inzg1hxYnn
 siohDBakcHig4KHZ119gwok=
X-Google-Smtp-Source: APBJJlFYiiKaYxM9TyIdSqyx8in0NAJ8zTjvfxAcXqgnRQCFfK7ffJz2EcplUN3X83KZn2gGRkPEpg==
X-Received: by 2002:a05:6808:10c6:b0:3a3:9337:4099 with SMTP id
 s6-20020a05680810c600b003a393374099mr7921215ois.56.1688779449705; 
 Fri, 07 Jul 2023 18:24:09 -0700 (PDT)
Received: from localhost ([61.68.2.145]) by smtp.gmail.com with ESMTPSA id
 bd1-20020a170902830100b001b9c5e0393csm1771874plb.225.2023.07.07.18.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 18:24:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Jul 2023 11:24:02 +1000
Message-Id: <CTWECLG9DWKS.2K25HI799MU70@wheely>
Cc: <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>,
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>, <ravi.bangoria@amd.com>
Subject: Re: [PATCH v6] ppc: Enable 2nd DAWR support on p10
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Greg Kurz"
 <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <168871963321.58984.15628382614621248470.stgit@ltcd89-lp2>
 <b0047746-5b36-c39b-c669-055d08ca3164@gmail.com>
 <20230707135909.1b1a89d5@bahia>
 <9c7ca859-f568-9487-0776-a6464edc69b4@kaod.org>
 <c93ce2b0-98ce-0d65-b799-9b0e2a4d9ce0@linux.ibm.com>
In-Reply-To: <c93ce2b0-98ce-0d65-b799-9b0e2a4d9ce0@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22a.google.com
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

On Sat Jul 8, 2023 at 2:10 AM AEST, Shivaprasad G Bhat wrote:
>
> On 7/7/23 19:54, C=C3=A9dric Le Goater wrote:
> > On 7/7/23 13:59, Greg Kurz wrote:
> >> Hi Daniel and Shiva !
> >>
> >> On Fri, 7 Jul 2023 08:09:47 -0300
> >> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> >>
> >>> This one was a buzzer shot.
> >>>
> >>
> >> Indeed ! :-) I would have appreciated some more time to re-assess
> >> my R-b tag on this 2 year old bug though ;-)
> >
> > We should drop that patch IMO and ask for a resend with more tests
> > but that's a lot of work to build a PR :/
> >
> Hi Cedric,
>
>
> I will be taking care of Greg's comment on avoiding failures in TCG mode =
for
>
> cap-dawr1=3Don.

I have done a patch for DAWR0 and CIABR for TCG and spapr, maybe that
could go first in a series then extend it for DAWR1 with your KVM stuff,
if that is of any help.

> I have already shared the "make test" results.
>
>
> Do you want me to try any other tests?

Do we have any tests that test DAWR0 or 1?

Thanks,
Nick

