Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8271FA81
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:01:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ymf-0003CU-Gq; Fri, 02 Jun 2023 03:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4ymd-0003BY-Gh; Fri, 02 Jun 2023 03:01:11 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4ymb-0005o3-T6; Fri, 02 Jun 2023 03:01:11 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6af873d1d8bso1405130a34.3; 
 Fri, 02 Jun 2023 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685689268; x=1688281268;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAXL1s/3a9BraSRSJRdD0e3CEMGB7Z17L6dMEyvSrzc=;
 b=gZZEGZYRX3wvgGktdFobkRjcqVtPyFw3xPtNeXDSPoak2IU7lnuOEXK1JJSdGBDlxh
 ZMeC6NnWDHD7Vt46RMEKwZ09e+71rS7e7wKtNtFVW6mKRhG0YygmuEzQ6dq0zGJeGYbM
 C7fC4HRAC0pMosnm3EjTYwx/TuKrQiIkKDsEi1UrJiig4L2esSLPLvt1DBGqrhqyiTtO
 0A49sRnVeFWjCAxGwHMDSSsJG8Tt+JlYDVOb5vUjor2Oxljc8Lq7uysIu8x9+pctPPb4
 HWdPWfFraLw7rSP//VylXM0xM5UpCUiGesorpJVVNdzbjS3CKkoGHCpTSPos+6Z46yxZ
 HZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685689268; x=1688281268;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pAXL1s/3a9BraSRSJRdD0e3CEMGB7Z17L6dMEyvSrzc=;
 b=jxF7afXCa7lnRT5EdO0M2NhLswZzfgg5fiSO3jLNCBzChAqCmqpBw8NsOu5gYtu2He
 TFtIwnZO/L5A6xc1Ffquu3f3CBTXlHFLT6TUuhgMqtEIuyLB8IMJVJWvC28MCB6zctJR
 gyuR/PNlFfxPwe7Vvs2gzfv05Y7eE+1G/s4fpY9xp6UpWU1uA58+xl7r1RfnXgPxJgBb
 xY+D6pYEfhD/4hHjTEYz6z0Vu+Bpy5BQvgMS1tI4CNP9XGxjBT4NzCi6oCjjA33rzcN6
 +mQnseDPH1XpqJITjnnJKXWTlkGA3eA6VzRxWgOjlGGWZr63/qi4rJHxnLm1TQQhkBB2
 Oy4A==
X-Gm-Message-State: AC+VfDxjxLLixXy2zIoKWryKMS4CyOlT4aqaEV2iY/nyHSPMXXls5qpz
 a6RGjAL1/DHLD9vAHn3PMj8=
X-Google-Smtp-Source: ACHHUZ7LyN/B5VbdByaH0JqEoLNoFhRjJj6qXkaYX4beO4vKuT4gn3owR0gp2UFIpBcf+jqmqrgSfw==
X-Received: by 2002:a05:6830:1356:b0:6af:7491:d6e5 with SMTP id
 r22-20020a056830135600b006af7491d6e5mr1444082otq.17.1685689268302; 
 Fri, 02 Jun 2023 00:01:08 -0700 (PDT)
Received: from localhost ([1.146.22.171]) by smtp.gmail.com with ESMTPSA id
 c13-20020a62e80d000000b0063d3fbf4783sm372397pfi.80.2023.06.02.00.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 00:01:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Jun 2023 17:01:01 +1000
Message-Id: <CT1YZ02RYMRT.1LL84FLYLC3DO@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [RFC PATCH 0/5] target/ppc: initial SMT support in TCG
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230531012313.19891-1-npiggin@gmail.com>
 <bad4b347-e129-ff7d-3b9b-23d964c68350@kaod.org>
In-Reply-To: <bad4b347-e129-ff7d-3b9b-23d964c68350@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32b.google.com
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

On Thu Jun 1, 2023 at 5:56 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello Nick,
>
> On 5/31/23 03:23, Nicholas Piggin wrote:
> > Hi,
> >=20
> > I'm posting this now just to get some first thoughts. I wouldn't say
> > it's ready but it does actually work with some basic tests including
> > pseries booting a Linux distro. I have powernv booting too, it just
> > requires some more SPRs converted, nothing fundamentally different so
> > for the purpose of this RFC I leave it out.
> >=20
> > A couple of things, I don't know the object model well enough to do
> > something nice with topology. Iterating siblings I would have thought
> > should be going to parent core then iterating its children CPUs. Should
> > that be done with the object model, or is it better to add direct
> > pointers in CPUs to core and core to CPUs? It is (semi) important for> =
performance so maybe that is better than object iterators. If we go that
> > way, the PnvCore and SpaprCore have pointers to the SMT threads already=
,
> > should those be abstracted go in the CPUCore?
>
> You should be able to move the thread array into the CPUCore. If you do
> that, please check that migration compat is not impacted by the state
> change. However, I am not sure you can use the CPUCore model under the
> insn modeling. Something to check.

Okay.

> Anyhow, the way you implemented the loop on the siblings is sufficiently
> fast for a small numbers of CPU and safe, w.r.t to CPU hotplug. So
> I would leave that part for now, if it runs decently with 4*4 vCPUs in
> TCG it should be fine.

Yeah you're right I'm overly paranoid about it but we don't do hundreds
of CPUs in TCG so it should be fine. Maybe I will defer it for now
then and just do the CPU iteration.

Thanks,
Nick

