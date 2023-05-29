Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCFF7141C4
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 03:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3S2d-0003Y0-8I; Sun, 28 May 2023 21:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3S2a-0003VQ-Er; Sun, 28 May 2023 21:51:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3S2Y-000711-US; Sun, 28 May 2023 21:51:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso1854335b3a.2; 
 Sun, 28 May 2023 18:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685325077; x=1687917077;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x378eFKzhCZhygFHsf09z1MEwvx+WhaZLL1/t7NaUfA=;
 b=jCTJAV04v66RQov2GeA62T3Cg/uhceWIciyld7DoglX7B1jGMqmnPKmxms3YhcTgkw
 dcUrp/LhT1mrRWrR6BhnxNtQ920fvmkYlKyTNnl2gaZOnNvT1YEtsY4CMSurnVh4LRPm
 KO0+38myDU/cQexqBF99+x94TeS+3c4aK7vk+cRne6fow3RH1oHuCBu0BTQfjMBWgc6m
 1+KADbwpuynFkoNF6r7lqeJZXz7+DCsx6znx7aolLBfzlHfMoEZGGnhnudRKxnk2cewn
 zYw/28tgEvtCyYi69U9B4HDMGAIVWre7+DpBXwrmebySIzSEmQhkY+G872q1W0bq8jyT
 2OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685325077; x=1687917077;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x378eFKzhCZhygFHsf09z1MEwvx+WhaZLL1/t7NaUfA=;
 b=XENodUfKil5Xg69cC1CtkfnSh/r6CTNfnXyVbjjcJar+jmdIdlkwNn/m1BmQJjwsMf
 mQmCvAXRUDO6tkcwV/lcMC524hxbGo6w42OPMvEAXcgdrfF/kQtliP+QvoBSk1yZnAmQ
 RsO0cGAkJ5ktBWKI7EOevhBwjeNnjcJTr07Z3eCigxoYcuCpXmi/68C7kZFWALNwmZ1l
 IyyJWr7D2W2Bo4fFTcIhS3fXc8dCBvmVAV8TRQmULcsNJLk/prEaIEo6z+NTOGRvp3ti
 AT4mFgIncDnqE9L+4nyEwPAqdtYtXzS1h4oIf5b6Xm+vC1DBFs2SiiS5ZHn4PO0o2TaL
 bp4A==
X-Gm-Message-State: AC+VfDwFm0In66jhPrjkl6hfYPcWWQ4zC4fFCYaDJhol7P6DQkjKKt83
 k3R71VMN/EcZC7VmphwzuKH3mlfn8UY=
X-Google-Smtp-Source: ACHHUZ4yAmsalDvXpOBX8O9yGCT9Le7uJM9nKahu6nl89CoDqluTSuGU9OCxmmE0JlVqIkrsmdKKPQ==
X-Received: by 2002:a05:6a00:1489:b0:627:6328:79f1 with SMTP id
 v9-20020a056a00148900b00627632879f1mr13887347pfu.34.1685325076958; 
 Sun, 28 May 2023 18:51:16 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 y21-20020a62b515000000b0064fe06fe712sm583263pfe.129.2023.05.28.18.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 18:51:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 May 2023 11:51:11 +1000
Message-Id: <CSYDVLMGDZV3.1FTXBTBGZIQXK@wheely>
Cc: <qemu-devel@nongnu.org>, "Frederic Barrat" <frederic.barrat@fr.ibm.com>
Subject: Re: [PATCH] ppc/pnv: Add initial P9/10 SBE model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20220811075421.1431357-1-npiggin@gmail.com>
 <3b566ede-ec80-487f-3cb5-9f8d2c2071ad@kaod.org>
 <39307893-c28b-ece2-9403-322c2884e5f0@kaod.org>
In-Reply-To: <39307893-c28b-ece2-9403-322c2884e5f0@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

On Fri May 26, 2023 at 10:20 PM AEST, C=C3=A9dric Le Goater wrote:
> On 8/11/22 10:04, C=C3=A9dric Le Goater wrote:
> > On 8/11/22 09:54, Nicholas Piggin wrote:

[snip]

> >> +
> >> +#define sbe_cmd_dbg(fmt, ...) do { \
> >> +=C2=A0=C2=A0=C2=A0 if (DEBUG_SBE_CMD) { \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "SBE cmd: =
%s: " fmt, __func__, ## __VA_ARGS__); \
> >> +=C2=A0=C2=A0=C2=A0 } \
> >> +} while (0)
> >=20
> > Please use trace events instead, with a pnv_sbe_ prefix.
> >=20
> > Apart from that, LGTM !
> >=20
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
>
>
>
> This looked like an interesting extension to the baremetal models.
> Did you abandon the idea ? if not, it would be good material for
> QEMU 8.1. Could you resend please  ? (with the TOD patches)

Hey Cedric,

Yeah I kind of forgot about these for a while, sorry :( Too much
stuff going on... But by an amazing coincidence I have just started to
look at these again in the past few days, so I should try to get it
merged.

Thanks,
Nick

