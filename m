Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB17FED94
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 12:13:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8exZ-00070J-5n; Thu, 30 Nov 2023 06:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8exV-0006zV-BB; Thu, 30 Nov 2023 06:11:53 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8exT-0002tZ-5D; Thu, 30 Nov 2023 06:11:52 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cdd13c586fso776567b3a.0; 
 Thu, 30 Nov 2023 03:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701342709; x=1701947509; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDh1/WK9u6sCAh+OxZwPWashhhvllPg5p2JzQqcS9PU=;
 b=Hb3oLTQah4Nra4lIhPlv/ggfomw18BJvpeYTY2umy6JXFFaWP8QILc6bdNLhaqBtb5
 zK/LL9E5dNlaPzDJw9dH0IGnHbylN3LVWqhbfUC/JcYBYrK2DmIYtyuchlUycav9zBGX
 vePW6+aOhs+XJtuAM/+5VOTaqULXZnOGCQcOxpuJQ+Z4mbY6+iwu7konwAz/PufMuBjO
 QP7prnfLt+f/JxjiX/LKrVsZw+sfNEBdsY14Cw5uG9PoHD2b0aBYbS1hGW16nbAk0CDQ
 CWOu+/1i8cTxPpcyKmta1PKjmsIrW8tGLyz/JyWVyA8vaes34ecYJyQHe6zn4lOJSXIv
 ixuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701342709; x=1701947509;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SDh1/WK9u6sCAh+OxZwPWashhhvllPg5p2JzQqcS9PU=;
 b=qzsZ4bdFvJ0K4pwcqEFcNMR9RKoT7dkYWKidnL5TyPumEtFK8RlM1YpggjUt/67Fj6
 FHLy4aKB379CBH1+rC+M1cgbHOOIh/PoomP5KLiW88LwjWgscW/WNBCz5DACpC+qWSfM
 N4n++uiq04B+ezq8kNiFZtUHFsd9yUXpALD2CqF4yWUeZ7KIgWsk+mzfkN9ZbIOZemZ8
 2clo7EajQXtFfXkEXGWAM7S0rfcjS9XyFqD6zbdNTwGkVeAKqcH0X1pRyAf+yunX6fAT
 BBKpzYgrzbR6848gfpbAlWXHMtw1trfr5uOBX8vXI+qU+Lk+HaYHy3Pa+0wi/qX0eVTo
 fW7A==
X-Gm-Message-State: AOJu0YwGWzccMhb08ucq9CuwOY58WrWB/9GNVM4Wh42NInam6k9blv5l
 5VqL6SBuzkXwqvBV8EJj0TI=
X-Google-Smtp-Source: AGHT+IGqVF0+VgFau29RvjdJe9rOJnBOUf/WyV5gyegKIq9fQQhlSPLK96goMLKBE/MH671iY+XerQ==
X-Received: by 2002:a05:6a00:35c7:b0:6cb:4c60:7398 with SMTP id
 dc7-20020a056a0035c700b006cb4c607398mr19989945pfb.13.1701342709403; 
 Thu, 30 Nov 2023 03:11:49 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 o25-20020a056a001b5900b006cdd38b72dbsm973456pfv.148.2023.11.30.03.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 03:11:48 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Nov 2023 21:11:42 +1000
Message-Id: <CXC3NJMX3IHH.LY7HE54F29I@wheely>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 04/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-5-harshpb@linux.ibm.com>
 <CXAZVME5KCFG.32WTQX49G8W7B@wheely>
 <614cb3f5-454a-c83b-47b1-a0387a8aa187@linux.ibm.com>
In-Reply-To: <614cb3f5-454a-c83b-47b1-a0387a8aa187@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

On Thu Nov 30, 2023 at 4:19 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 11/29/23 09:31, Nicholas Piggin wrote:
> > On Thu Oct 12, 2023 at 8:49 PM AEST, Harsh Prateek Bora wrote:
> >> Introduce a SPAPR capability cap-nested-papr which provides a nested
> >> HV facility to the guest. This is similar to cap-nested-hv, but uses
> >> a different (incompatible) API and so they are mutually exclusive.
> >> This new API is to enable support for KVM on PowerVM and recently the
> >> Linux kernel side patches have been accepted upstream as well [1].
> >> Support for related hcalls is being added in next set of patches.
> >=20
> > We do want to be able to support both APIs on a per-guest basis. It
> > doesn't look like the vmstate bits will be a problem, both could be
> > enabled if the logic permitted it and that wouldn't cause a
> > compatibility problem I think?
> >=20
>
> I am not sure if it makes sense to have both APIs working in parallel=20
> for a nested guest.

Not for the nested guest, but for the nested KVM host (i.e., the direct
pseries guest running QEMU). QEMU doesn't know ahead of time which API
might be used by the OS.

> Former uses h_enter_guest and expects L1 to store=20
> most of the regs, and has no concept like GSB where the communication=20
> between L1 and L0 takes place in a standard format which is used at=20
> nested guest exit also. Here, we have separate APIs for guest/vcpu=20
> create and then do a run_vcpu for a specific vcpu. So, we cant really=20
> use both APIs interchangeably while running a nested guest. BTW, L1=20
> kernel uses only either of the APIs at a time, preferably this one if=20
> supported.

Yeah not on the same guest. And it's less about running two different
APIs on different guests with the same L1 simultaneously (although we
could probably change KVM to support that fairly easily, and we might
want to for testing purposes), but more about compatibility. What if
we boot or exec into an old kernel that doesn't support the new API?
>
> > And it's a bit of a nitpick, but the capability should not be permitted
> > before the actual APIs are supported IMO. You could split this into
> > adding .api first, so the implementation can test it, and add the spapr
> > caps at the end.
> >=20
>
> Agree, I shall update as suggested.

Thanks,
Nick

