Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EFD7A597A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 07:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiTWK-0000V8-M5; Tue, 19 Sep 2023 01:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1qiTWB-0000Ur-8V
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:43:27 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1qiTVy-0008Ix-VC
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:43:23 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-273d9b1908eso1329331a91.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 22:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695102193; x=1695706993; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33rqio0PxVCsM2uq5rA5VQxFk1GY+Dse3zQWNdimRFs=;
 b=VX0dlKYvMMvSerHYn0qOfsJHYKB7bNa90AhequDKldCGYvk6gvMCuxtUx4IVsCsbgZ
 ing9+s9YA0L1obogP+Dh8S3cQI7/0zD+7vVATxJFUPRRLBLKkhcMGg/4H/QNZ9GVfVEr
 YMDeY7hMj2xzuXD6L9KZDKV3fC/tcDRjwlGWpml7B4Aq2SO/M2LFq44R2w75b0HsPZlI
 Jk8XKtbebmI2vqZEuhm8pq40iBfmEAdpgiEA90UzHpORslIyjGA87xZfazUPR265ws7U
 Ckgo309YrR8X4pnidhasbX3LRR7DgLbbP1sEocw4RHmk0XRMW5uyMeQb9Qh4mVGqn3/P
 Hk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695102193; x=1695706993;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33rqio0PxVCsM2uq5rA5VQxFk1GY+Dse3zQWNdimRFs=;
 b=s8sDIqJjp5vpgWejX7w+tNNbXOEca5O/hF+CSijI78aCaslYyHNaZihZ3H09w+x0db
 wOZzawr7lBqz0tJ5ixPH2c4POdN0Zw8NvT8u1tdxAC+mjjyuB6X0JLQovDKRj3epK2m8
 IVQ8/5pY46V2m/inEf24FOw/DhAPbTAck4iUNyi4vxAp/7LJ7GRUa4M2GgxfTI4h8MdP
 FUsYXbaPC8V7dKwsRVYbG0cIH6UtkACbYQYBl5VOEYnTpYA3DCHljyIFxvQsp4rzuRKY
 7d7UzKXaC6iPKuurJVwpHRIDACiuSJoyQ436NGJRPOnds3pDxDXVsRicWo82FbdrcCJQ
 VstQ==
X-Gm-Message-State: AOJu0YzWUVQT5XSZno1C7Qbqt5YggWQYkFwwvunZ2B8JntO67xgMPsAo
 lZFJUYJqCtFkO8yS62nWsdrOFQ==
X-Google-Smtp-Source: AGHT+IFVCweDuz7GXk75AEl/kDj/DIJRduaJ99OdYHqFDxjm+B92qPxs1YmsEeS3JDRKh3+qcLaRwA==
X-Received: by 2002:a17:902:dad2:b0:1b8:9fc4:2733 with SMTP id
 q18-20020a170902dad200b001b89fc42733mr12862912plx.3.1695102193005; 
 Mon, 18 Sep 2023 22:43:13 -0700 (PDT)
Received: from smtpclient.apple ([2405:201:d019:cbd3:19d7:fceb:a55b:9320])
 by smtp.gmail.com with ESMTPSA id
 ja2-20020a170902efc200b001c444106bcasm6179144plb.46.2023.09.18.22.43.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Sep 2023 22:43:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] target/riscv: update checks on writing pmpcfg for
 Smepmp
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
In-Reply-To: <CAKmqyKN_z7Q=mmsp41ycFbgW+N4PRmv4UB4sUrs=i6ziuHywmg@mail.gmail.com>
Date: Tue, 19 Sep 2023 11:12:48 +0530
Cc: Chang Alvin <vivahavey@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Andrew Jones <ajones@ventanamicro.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9FFB2CE-0F2D-4CFA-B4F8-CCBE33D44339@ventanamicro.com>
References: <CAEV2DRqFS+UvqvgrW=6R=ahj+akKcmvH3MtAarJ70RphARMNdQ@mail.gmail.com>
 <CAKmqyKN_z7Q=mmsp41ycFbgW+N4PRmv4UB4sUrs=i6ziuHywmg@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 19-Sep-2023, at 10:51 AM, Alistair Francis <alistair23@gmail.com> =
wrote:
>=20
> On Tue, Sep 19, 2023 at 3:08=E2=80=AFPM Chang Alvin =
<vivahavey@gmail.com> wrote:
>>=20
>>> -----Original Message-----
>>=20
>>> From: Alistair Francis <alistair23@gmail.com>
>>=20
>>> Sent: Tuesday, September 19, 2023 12:42 PM
>>=20
>>> To: Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) =
<alvinga@andestech.com>
>>=20
>>> Cc: qemu-riscv@nongnu.org; qemu-devel@nongnu.org;
>>=20
>>> alistair.francis@wdc.com; ajones@ventanamicro.com
>>=20
>>> Subject: Re: [PATCH v3] target/riscv: update checks on writing =
pmpcfg for
>>=20
>>> Smepmp to version 1.0
>>=20
>>>=20
>>=20
>>> On Fri, Sep 15, 2023 at 6:32=E2=80=AFPM Alvin Chang =
<alvinga@andestech.com> wrote:
>>=20
>>>>=20
>>=20
>>>> Current checks on writing pmpcfg for Smepmp follows Smepmp version
>>=20
>>>> 0.9.1. However, Smepmp specification has already been ratified, and
>>=20
>>>> there are some differences between version 0.9.1 and 1.0. In this
>>=20
>>>> commit we update the checks of writing pmpcfg to follow Smepmp =
version
>>=20
>>>> 1.0.
>>=20
>>>>=20
>>=20
>>>> When mseccfg.MML is set, the constraints to modify PMP rules are:
>>=20
>>>> 1. Locked rules cannot be removed or modified until a PMP reset, =
unless
>>=20
>>>>   mseccfg.RLB is set.
>>=20
>>>> 2. =46rom Smepmp specification version 1.0, chapter 2 section 4b:
>>=20
>>>>   Adding a rule with executable privileges that either is =
M-mode-only
>>=20
>>>>   or a locked Shared-Region is not possible and such pmpcfg writes =
are
>>=20
>>>>   ignored, leaving pmpcfg unchanged.
>>=20
>>>>=20
>>=20
>>>> The commit transfers the value of pmpcfg into the index of the =
Smepmp
>>=20
>>>> truth table, and checks the rules by aforementioned specification
>>=20
>>>> changes.
>>=20
>>>>=20
>>=20
>>>> Signed-off-by: Alvin Chang <alvinga@andestech.com>
>>=20
>>>> ---
>>=20
>>>> Changes from v2: Adopt switch case ranges and numerical order.
>>=20
>>>>=20
>>=20
>>>> Changes from v1: Convert ePMP over to Smepmp.
>>=20
>>>=20
>>=20
>>> Did this part get lost?
>>=20
>>>=20
>>=20
>>> Alistair
>>=20
>>>=20
>>=20
>>=20
>> Sorry, do you mean that the term "ePMP" should be changed to "Smepmp" =
in source code?
>=20
> We still call it epmp to users and it's still marked as experimental.
>=20
> See this line in the QEMU source:
>=20
> MULTI_EXT_CFG_BOOL("x-epmp", epmp, false),
>=20
> Alistair

I had sent a patch to rename epmp to Smepmp
https://www.mail-archive.com/qemu-devel@nongnu.org/msg967676.html


Regards
Himanshu



