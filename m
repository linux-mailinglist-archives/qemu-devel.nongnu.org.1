Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EED835B3A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRo6e-0000S8-4K; Mon, 22 Jan 2024 01:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRo6X-0000Rg-4o
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:48:22 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRo6V-0008Ls-Ms
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:48:20 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-467a7a376d5so395096137.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 22:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705906098; x=1706510898; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxkcK958nlAkpBJVXETcoJwO3Smq4kPUF6KlJSxmoDo=;
 b=On1jVakrzQqBQti+byxvLT8HY211QRe3H6xtsIWKAnGXYKwysmi7Id+60HsmkYaVCp
 5vQVEvNQIGFXl2C4j7XP42gJV3X+VSsmJqZsQh3S7MlRDGUO8Gpscjlev5SnsNbmnAZE
 J7Dva6VRKvHTzmR8D9I9WYNhHhwq/vbetMcZOojsYKveCEMevPLVk0yXjL4XlxfxrTFX
 JBuSISCfbfG8770MeTlwgMk2BskEo5TDzWzon+nWQqjZAJ6Y5jzNEDRxD5vH8F8gVSfD
 xVkbBfFkBEOBZf5STRUnIKBtyaf8vswqCbIEeqZPmc7cGoZMdBeFD5c9bEQuThCkCt2n
 TdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705906098; x=1706510898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxkcK958nlAkpBJVXETcoJwO3Smq4kPUF6KlJSxmoDo=;
 b=McO9mI/AkUx0AGzUQDgesnUU7O2DsKg8l7NHdRhHrnWhfg0GgmiQqOlGEHV1pUXnR4
 aRG3fvzsiUztnjSMQdswX4YAKM41Fm5uXNs2fHUmPYabxdnbxEge5I9FTeWiydoqHLWl
 GacOVrd99T53KY2lWD91X+Oy1xmAsE97+Vbb4S6SckX70OIAQTO4UdBc15G8naP5e+sS
 Ml4SEwFSVFpRge5O+DI9Ep8YAznmCcZxnilliMDkYOfnFHA44VIGPjxEnNvQDbKIrFJr
 sR/xARvcazm+eo8m4yJtsZOosQx3L7oQS/j4MsdcysAchK6GIQ8Wf0BfSQGgnEepadaI
 HVBA==
X-Gm-Message-State: AOJu0YzzEIXqhaP31WoeMImqsLB+AiieHarajmOnFGRsNRhwbfmQ5sc8
 rw8+fJ/OE4YN9ka/wp7OwvvgBlC1vnmkcj7JDvUF18UR2p6Xbo9OGZO/f9QZEu2NRJaj69zaDuz
 UWFa5Nw2+I/sd6bp8VQiOVamNcX8Njv0mM1k=
X-Google-Smtp-Source: AGHT+IH/DZCw52BYpqKHGFmSIdZ5FGdYcnc0KhSkB/fPD7oX6V12OmWBrNToNeOYK51cxHV8pkQO4C1Zv8XHo9SBPsc=
X-Received: by 2002:a05:6102:1886:b0:469:7690:eefc with SMTP id
 ji6-20020a056102188600b004697690eefcmr905519vsb.32.1705906098321; Sun, 21 Jan
 2024 22:48:18 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR07MB60808AC0A8A31AF17BE2EBC6C561A@MN2PR07MB6080.namprd07.prod.outlook.com>
In-Reply-To: <MN2PR07MB60808AC0A8A31AF17BE2EBC6C561A@MN2PR07MB6080.namprd07.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jan 2024 16:47:52 +1000
Message-ID: <CAKmqyKN71ff1-qMQ1GNbqQXym4=v1oR+r+Lohv8K-=j-Kq1jyw@mail.gmail.com>
Subject: Re: Adding custom CSR to riscv-qemu
To: Nati Rapaport <rapaport@cadence.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jan 2, 2024 at 7:22=E2=80=AFPM Nati Rapaport <rapaport@cadence.com>=
 wrote:
>
> Hello,
>
> I=E2=80=99m going to add some custom CSRs (Control & Status Registers) to=
 a new RiscV core in qemu.
>
> Could you please help me understanding if there is any method to do it?

Have a look at decode_opc() in target/riscv/translate.c.

We probably want something similar where we can iterate over the
vendor enabled CSRs.

>
> Should I do it in /target/riscv/cpu_bits.h where all CSRs are defined  (a=
nd other files, where all standard CSRs implementation reside?) and just pu=
t it under a compilation flag for our new core only?

The vendor CSRs should be in their own file. The idea is to keep as
much as possible separated from the general RISC-V code.

>
> I don=E2=80=99t think so.. as I don=E2=80=99t see any similar example for=
 that there.
>
> Should I add all the related code around these CSRs in dedicated source f=
iles and let them built only for our core?

Pretty much, although it will be built by default. We don't want
custom binaries for vendors or anything like that

Alistair

>
> Please explain..
>
>
>
> Thank you in advance.
>
> Nati Rapaport
>
> Cadence Design Systems

