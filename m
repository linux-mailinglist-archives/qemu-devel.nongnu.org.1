Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB818380A0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 03:00:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS657-0003o7-68; Mon, 22 Jan 2024 21:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rS654-0003nd-Rh; Mon, 22 Jan 2024 21:00:02 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rS653-0004OS-5j; Mon, 22 Jan 2024 21:00:02 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-361af86c7f7so8612105ab.3; 
 Mon, 22 Jan 2024 18:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705975199; x=1706579999; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WriUz2uije3DgAqgmD8Wgqr3sDlFkbiCgRZt0yNTdqA=;
 b=l96Wp+1SVHJuSYhwn0xNg94uKHBOBDjFRBlCz8oz/cjl9kFQPcmkwIwmpTaKuMPkG6
 9ua2VUP8djFEnF7mKafyLlm0DqoNlbTJmEuHViOu/7j0fngy7Y8DwmUzcJL6zQgKVEM3
 SCJHDJaXSy7DPQvnuAy2U3pzUvHCnpTY5hq4KPtUhWojllLe/WO7q73QLB+8WR842+AZ
 GZy4vM/klV/MaHWBzE2e9RefQYX2cUw334mJlEbj/SaCXD+rKy7jmByH3RUM5k7pPMSk
 kqJVrz6XcXLj9ZgbBopWUewkLJY8eWqWNIV5Ia5NzBOUNJyExFSpcEesoPP6COiVNb/+
 jfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705975199; x=1706579999;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WriUz2uije3DgAqgmD8Wgqr3sDlFkbiCgRZt0yNTdqA=;
 b=S85f8xcglgWy8uzLlerhDAb/79jfUcBfSKTHt6uIkfyt/RlSU/G0s6eFWRGTU2h2F2
 Mh6HDQ5K0/IF1c86NLojq8I1a2PGoz2uLMzs+PEQVca4C4Kln1hRV0oaqwpoO0Gni9tZ
 cxhRYEjd5mHcygXfrGxcXSZiONW/lMVeJ30RwyaexPnLemKSUn4vq2D0YxdQRxyUXd54
 m66o3k1bIumzToQfm6YzvfO6DnJ3J894fgMavlocprSJkO8ODcqLgxef2f6yYsfddTX/
 AQKwInHKosKn+QKORPVWWG23ablVfW88sTcUJ8tfyJxk00u8FHsQS88chatw7xciyv77
 lSvQ==
X-Gm-Message-State: AOJu0Yz2U+MKztKr6bHd7vwF1rQ3ZM8yg6cgqTF+GZyGXBQURTLTDl91
 +U971xnAiMorw02OQ3nCW9a0BXlfGQbHKw9k2dmQ2ITeryon1aGL
X-Google-Smtp-Source: AGHT+IGZkbqiRtfejTkdQo5/QK/atllfWsrmxVPHuig8PKIe/6CXNJhequkg502vOHxxJKKfXqZ7dQ==
X-Received: by 2002:a05:6e02:605:b0:360:6aeb:1068 with SMTP id
 t5-20020a056e02060500b003606aeb1068mr6382107ils.47.1705975199495; 
 Mon, 22 Jan 2024 17:59:59 -0800 (PST)
Received: from localhost (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a635208000000b005cfbef6657fsm5101121pgb.58.2024.01.22.17.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 17:59:59 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 11:59:51 +1000
Message-Id: <CYLPQFUAZ55G.1G5L7E9FXBP0C@wheely>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/2] target/ppc: Implement attn instruction on BookS
 64-bit processors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240118152523.178576-1-npiggin@gmail.com>
 <20240118152523.178576-3-npiggin@gmail.com>
 <f8d6fd3e-07c3-4f8f-a4b7-d3e08d94aec0@linaro.org>
In-Reply-To: <f8d6fd3e-07c3-4f8f-a4b7-d3e08d94aec0@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x129.google.com
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

On Fri Jan 19, 2024 at 8:09 AM AEST, Richard Henderson wrote:
> On 1/19/24 02:25, Nicholas Piggin wrote:
> > +/* attn enable check                                                  =
       */
> > +static inline int check_attn_none(CPUPPCState *env)
>
> Don't mark inline ...
>
> > @@ -2150,6 +2170,7 @@ POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
> >       dc->desc =3D "PowerPC 405";
> >       pcc->init_proc =3D init_proc_405;
> >       pcc->check_pow =3D check_pow_nocheck;
> > +    pcc->check_attn =3D check_attn_none;
>
> ... since it is never called directly.

True, I mindlessly followed check_pow_none(). Maybe all
those helpers could be uninlined and moved into cpu_init.c.

Thanks,
Nick

