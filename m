Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A3730D69
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dG2-0005OS-GQ; Wed, 14 Jun 2023 23:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dG0-0005Nt-6d; Wed, 14 Jun 2023 23:02:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dFy-00050X-ND; Wed, 14 Jun 2023 23:02:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b3cc77ccbfso26580715ad.1; 
 Wed, 14 Jun 2023 20:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686798160; x=1689390160;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6G4IXwGpoUdWL3Jj26QlGSDuiNxEjCjHlS4hHitS9FY=;
 b=GOg+ZPxRGBheX5NiFnwchnIk6F9ucBIBZkHECyciq1u+1Lbw73d3KXyMNOJ5K7EGsa
 DLKZNF6jBpC3ZnlkfQwAvDq7EjlkHz9J82xuBaIavB3mlD2Pi0bfyASTRcL7Joz1+9Pi
 Nch/MQnKGvYv5fT+9VUMYDZUwHGL3gg+YCzN4NoY0K0QrTX5ppT4+x9waNF+QDmVliJV
 YmCmrICVINR5cNM2tmXppwHAmwYspROGTazQG4swifGWdQE5UU1Lw9tMf2n3DMm70PDH
 MO+lReBH35ycVa9ao6mhLkOcWmJebpodOPTgpxYjZ21Mxdx0iak2X4OFZyLtHtIpa9oB
 CjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686798160; x=1689390160;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6G4IXwGpoUdWL3Jj26QlGSDuiNxEjCjHlS4hHitS9FY=;
 b=TjcUsWc7XL2P/VamF9A71611Hp3vQGhUTREh9KJFQOzWDsZbJw8pyE6UILwXQxsb7J
 Y2M0f19VIL3LJ4Uyi1fYI4tjN/gpCjLKPbsWFTy82vwpwRynLV30ihsZvxcx/HAGgui+
 PPiyNB7ciA5gyYSMwed7gQDqtplJc7fNEerz1o+pkOAyGTMV2er8Skezqj/6rQ1Y7oFH
 1WilAKQOskvcNYTZgMiI2BVHov2IdSZcW28eC23rfy/esOYgDpzPX5A8CE+yEfYKXIDw
 D3tP2VZ3W96tcCwkFPEajPI89UJOpCc42DzL/pCC6VSHoyoq+/SiD7GB6Vd1cbJ1qbiz
 iNcQ==
X-Gm-Message-State: AC+VfDwLFrazuFHm02qDoEt7AP4ipTTFTjyCly5eKbhu+eKrdjENpN//
 Am66dg7l2WQdGvgH5UF7JCM=
X-Google-Smtp-Source: ACHHUZ6lgjIPBI0Tymldtf6QR27S0ioLRgoC0GF43wVBjXefXq1as6jZvCfbw6Hn4lMDb5hFgodfSA==
X-Received: by 2002:a17:902:e314:b0:1af:fe12:4e18 with SMTP id
 q20-20020a170902e31400b001affe124e18mr11243125plc.20.1686798160453; 
 Wed, 14 Jun 2023 20:02:40 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d70500b001ac94b33ab1sm4164815ply.304.2023.06.14.20.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 20:02:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 13:02:34 +1000
Message-Id: <CTCW1ILCXTMA.24T7LU9PQBTDA@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>
Cc: <kvm@vger.kernel.org>, "Laurent Vivier" <lvivier@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>, <linuxppc-dev@lists.ozlabs.org>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [kvm-unit-tests v4 00/12] powerpc: updates, P10, PNV support
X-Mailer: aerc 0.14.0
References: <20230608075826.86217-1-npiggin@gmail.com>
 <CACPK8XdpAxjvP+bFNFJzQQzBYvEwsE69QkbNWRumZtUW2wOrrA@mail.gmail.com>
In-Reply-To: <CACPK8XdpAxjvP+bFNFJzQQzBYvEwsE69QkbNWRumZtUW2wOrrA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Wed Jun 14, 2023 at 11:09 AM AEST, Joel Stanley wrote:
> On Thu, 8 Jun 2023 at 07:58, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Posting again, a couple of patches were merged and accounted for review
> > comments from last time.
>
> I saw some failures in the spr tests running on a power9 powernv system:
>
> $ TESTNAME=3Dsprs TIMEOUT=3D90s ACCEL=3D ./powerpc/run powerpc/sprs.elf -=
smp
> 1 |grep FAIL
> FAIL: WORT      ( 895):    0x00000000c0deba80 <=3D=3D> 0x0000000000000000

This is just TCG machine? I'm not sure why WORT fails, AFAIKS it's the
same on POWER8 and doesn't do anything just a simple register. I think
on real hardware WORT may not have any bits implemented on POWER9
though.

> $ MIGRATION=3Dyes TESTNAME=3Dsprs-migration TIMEOUT=3D90s ACCEL=3D
> ./powerpc/run powerpc/sprs.elf -smp 1 -append '-w' | grep FAIL
> FAIL: SRR0      (  26):    0xcafefacec0debabc <=3D=3D> 0x0000000000402244
> FAIL: SRR1      (  27):    0xc0000006409ebab6 <=3D=3D> 0x8000000000001001
> FAIL: CTRL      ( 136):            0x00000000 <=3D=3D>         0x00008001
> FAIL: WORT      ( 895):    0x00000000c0deba80 <=3D=3D> 0x0000000000000000
> FAIL: PIR       (1023):            0x00000010 <=3D=3D>         0x00000049
>
> Linux 6.2.0-20-generic
> QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-5ubuntu2)
>
> On a power8 powernv:
>
> MIGRATION=3Dyes TESTNAME=3Dsprs-migration TIMEOUT=3D90s ACCEL=3D ./powerp=
c/run
> powerpc/sprs.elf -smp 1 -append '-w' |grep FAIL
> FAIL: SRR0      (  26):    0xcafefacec0debabc <=3D=3D> 0x0000000000402234
> FAIL: SRR1      (  27):    0xc0000006409ebab6 <=3D=3D> 0x8000000000001000
> FAIL: CTRL      ( 136):            0x00000000 <=3D=3D>         0x00008001
> FAIL: PIR       (1023):            0x00000060 <=3D=3D>         0x00000030

Hmm, seems we take some interrupt over migration test that is not
accounted for (could check the address in SRR0 to see where it is).
Either need to prevent that interrupt or avoid failing on SRR0/1 on
this test.

Interesting about CTRL, I wonder if that not migrating correctly.
PIR looks like a migration issue as well, it can't be changed so
destination CPU has got a different PIR. I would be inclined to
leave those as failing to remind us to look into them.

I'll take a look at the others though.

Thanks,
Nick

