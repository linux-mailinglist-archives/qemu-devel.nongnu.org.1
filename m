Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3A7368EB
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:13:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYMG-0002UU-UW; Tue, 20 Jun 2023 06:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBYME-0002UE-U0; Tue, 20 Jun 2023 06:13:06 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBYMD-0006fL-7K; Tue, 20 Jun 2023 06:13:06 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-54fbcfe65caso3673787a12.1; 
 Tue, 20 Jun 2023 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687255983; x=1689847983;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2ET9aNrfsRLdNp/DMnqrDeB4EceBt3i3n6JlHvi8zQ=;
 b=imRowmo9pX1nzKrz1WHeG7uKB2VN/FK5+uHr8eeryYNRSR4Gn/G1X3zEwqXGCfFHtK
 of2OHMAqU+cf1CGkaqGQxDcGQZkipbVeAa+yWG6FlYuiho5KmHU1d65jH0VQyySMTGCz
 LJPaj1V+85Z19vkgRNy0fDUsw8dof72LSvdCx3pE1UBGdtq8KWvCy2J0/TXTKN0V8kxq
 4wZeHGVlDV6sXXp2ijQp5qd0njcS8Y+0msjOAoT1pPATLKc69jfkTbPBAs5ByzGB8hYR
 M5Rlv1EDjbqYG09abBafsaH+rKLlbdLEb7iHA2DVscFp3fkZKNSneA8VN50RquW2GykB
 4LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687255983; x=1689847983;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m2ET9aNrfsRLdNp/DMnqrDeB4EceBt3i3n6JlHvi8zQ=;
 b=AVU7NGQPVx9n3ZLN1pf8H4R/JJkiZY61fPrUFewIg8LQvuB4ul54O+iRCyTp22UF+z
 POaCpeCHzCYaTQtq4khABtfaAiA2lKesK5MoezzfXuqXiB0/LibabSEq3Xir9D243Gd7
 hCLw4Syqo0G32O/bqjaKNsF01DlWhzU9HeA6b+oxwuAzDH2CzqCKTOtj6h5nQCkPdwoB
 6+ebdfr329DlNwqZ7ch4j9I2FMeM0fjaJGJEFCEdqIkZBSqYConARVVVxKMHz7rDMLeg
 IFjhv/GJpe94WV9TUGfQw7At2F77ngCoBjjJHt6/Nn+bqdyZXPyACn96FUQlT18N9ahp
 iMtA==
X-Gm-Message-State: AC+VfDxIEP8oliBpHsY14gC7c7yS11GLNjSW7D34SjU2YB8hnmHN3MQW
 slQh5WlPDrB+oqSbwgGAmDA=
X-Google-Smtp-Source: ACHHUZ6ug1tF4vlEfzViKPU/UV+NnBMO4hT5hHAhzxKGqpC9QdZ03u7cK+puZ70Uo7+czTWYS9vHOA==
X-Received: by 2002:a17:902:cf46:b0:1ac:820e:c34a with SMTP id
 e6-20020a170902cf4600b001ac820ec34amr16366858plg.0.1687255983005; 
 Tue, 20 Jun 2023 03:13:03 -0700 (PDT)
Received: from localhost ([124.170.190.103]) by smtp.gmail.com with ESMTPSA id
 q7-20020a170902b10700b001b24857d1f2sm1269180plr.188.2023.06.20.03.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:13:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 20:12:57 +1000
Message-Id: <CTHEBROKN9FJ.33DEPNNJ89JEQ@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/4] target/ppc: TCG SMT support for spapr
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230605112323.179259-1-npiggin@gmail.com>
 <43ca9ac8-d383-42fd-ca29-f7cdd18d701d@kaod.org>
In-Reply-To: <43ca9ac8-d383-42fd-ca29-f7cdd18d701d@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

On Wed Jun 7, 2023 at 12:09 AM AEST, C=C3=A9dric Le Goater wrote:
> On 6/5/23 13:23, Nicholas Piggin wrote:
> > Previous RFC here
> >=20
> > https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00453.html
> >=20
> > This series drops patch 1 from the previous, which is more of
> > a standalone bugfix.
> >=20
> > Also accounted for Cedric's comments, except a nicer way to
> > set cpu_index vs PIR/TIR SPRs, which is not quite trivial.
> >=20
> > This limits support for SMT to POWER8 and newer. It is also
> > incompatible with nested-HV so that is checked for too.
> >=20
> > Iterating CPUs to find siblings for now I kept because similar
> > loops exist in a few places, and it is not conceptually
> > difficult for SMT, just fiddly code to improve. For now it
> > should not be much performane concern.
> >=20
> > I removed hypervisor msgsnd support from patch 3, which is not
> > required for spapr and added significantly to the patch.
> >=20
> > For now nobody has objected to the way shared SPR access is
> > handled (serialised with TCG atomics support) so we'll keep
> > going with it.
>
> Cc:ing more people for possible feedback.

Not much feedback so I'll plan to go with this.

A more performant implementation might try to synchronize
threads at the register level rather than serialize everything,
but SMT shared registers are not too performance critical so
this should do for now.

Thanks,
Nick

