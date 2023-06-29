Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D004742143
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:45:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmLV-00049M-FD; Thu, 29 Jun 2023 03:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEmLS-00045x-8k; Thu, 29 Jun 2023 03:45:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEmLQ-0007ua-Gk; Thu, 29 Jun 2023 03:45:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-666eef03ebdso240986b3a.1; 
 Thu, 29 Jun 2023 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688024734; x=1690616734;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/Ky/MlulAuKz/w99TFJfrkDkiCShJIIQ4MJnryAWsc=;
 b=Wf/kvECmh0s//sJ8esFAi+7dUECrS85HPkdY4HPVRgRGF7b/cTKXHZC/2AJZrB2maT
 FNv2xCZoqC6o8PVgfNAeCX+AubicqUbXl4b5UCVhXmFWut66NpFiuRAxCvbbNzgsxUbI
 ORgCdAAW2XOAZtqYgDQV+CH1YQIfTvcqjjj9v1VMlWNy/nbmjLC3BkToXlDI3yWL+f5M
 IqrAK+Id3hJg+e5fdHRzLzntRjRka5Vcs9+mVuYXQoCM+uKAMKdn/1h8IvYHA0zYtCsX
 Ag+opuRsxE4ZozDi73k5t1aGLY0DA1VgmxVU4FejFdO5hoTol7Z+ishP6gFETNZEvczG
 9NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688024734; x=1690616734;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N/Ky/MlulAuKz/w99TFJfrkDkiCShJIIQ4MJnryAWsc=;
 b=cY52UFESARL3vC1Hk0KxAlAR6jgjIAdp5ZhQHj9WVEUfj4QFesnSGyL3alV8/xDOd8
 Ef5Numa/SelxdYtCCtYD4Qk/PQlpBjWhBMsjmEoVXiEspgHCL1km2A1iykhzIh+ycDnl
 znazwPmWSSqYnddSVa7y+1vFyIULTC5Qw0P/xWuGGHYcr6tTDz7okGve5ZXhMjCEylhQ
 Y7pFDQVkIZ7TEI+DokKhbn3hgztwA5mu0NxFKHPDF99gISz60VtYsIE7SGw9lbB7bszd
 f7NNzNpbi2NuVFq/3C565QgXF85x/w8djgkkkla/Xw/J9WOsXR3ZccxhfGPhYWm4lf0o
 0Jsw==
X-Gm-Message-State: AC+VfDyuLATOWevAozqMuNqHwEky1sRvVBunaJgNBcPLB0MmBOF9VYvi
 n+0rqlf4cULkx1e8WY7g4lQ=
X-Google-Smtp-Source: ACHHUZ6TqQFdVI+TUwaoOy6cMN7Ffq11UitVg2HEaRVH+JeiZ/QadoohZnO/aNhPduxvBVLQK8F63g==
X-Received: by 2002:a05:6a00:2d2a:b0:67e:a36e:f4db with SMTP id
 fa42-20020a056a002d2a00b0067ea36ef4dbmr5613594pfb.14.1688024734036; 
 Thu, 29 Jun 2023 00:45:34 -0700 (PDT)
Received: from localhost ([1.146.16.117]) by smtp.gmail.com with ESMTPSA id
 z19-20020aa785d3000000b00679efed4108sm5239397pfn.33.2023.06.29.00.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:45:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jun 2023 17:45:26 +1000
Message-Id: <CTOYTPZ8K6B4.3LV2HL1PAFWXH@wheely>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Greg Kurz" <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH] hw/ppc: Fix clock update drift
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Frederic Barrat"
 <fbarrat@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230629020713.327745-1-npiggin@gmail.com>
 <e793d122-91fd-41ad-7151-b97073ac9753@linux.ibm.com>
 <d3618712-b4e9-9405-c6c8-f80c120d06e4@kaod.org>
In-Reply-To: <d3618712-b4e9-9405-c6c8-f80c120d06e4@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

On Thu Jun 29, 2023 at 5:34 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/29/23 09:04, Frederic Barrat wrote:
> >=20
> >=20
> > On 29/06/2023 04:07, Nicholas Piggin wrote:
> >> The clock update logic reads the clock twice to compute the new clock
> >> value, with a value derived from the later time subtracted from a valu=
e
> >> derived from the earlier time. The delta causes time to be lost.
> >>
> >> This can ultimately result in time becoming unsynchronized between CPU=
s
> >> and that can cause OS lockups, timeouts, watchdogs, etc. This can be
> >> seen running a KVM guest (that causes lots of TB updates) on a powernv
> >> SMP machine.
> >>
> >> Fix this by reading the clock once.
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >=20
> >=20
> > Nice! It must have been a nightmare to debug.
> > Do you know where that ATB spr comes from? I can't relate it to the ISA=
.
>
> You should look at the e500 CPU (BookE) specs.

Yeah it's in 2.07 in the Book E. It doesn't look like Linux uses it
anywhere so I didn't actually test it, but the pattern looks the same
as the others so I think it's should be right.

Thanks,
Nick

