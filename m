Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575482DB9E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:46:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOE8-0007TC-MA; Mon, 15 Jan 2024 09:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rPOE6-0007Rm-HK
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:46:10 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rPOE3-0005cD-Tl
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:46:09 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-559737bac29so306367a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705329966; x=1705934766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/4ySOoTk4TppXZjwZbNwuRPAqBVyqkp14luXtIwRzA=;
 b=NHREOUmLFGdn08py5AtOnvmAWxjH/txZyOH0n2BMbqZ7iL6TiuOvuWteM7FrklE9Bl
 48in28rqOOA02DMgZdo0kvl98nGmDkQd86qXNGzEU5fPNIiTKbrwfb65h2x91VTQKw5g
 gALU1ACjj1QjPwha22ibZHf0puKE+UjIbSE+H+LXDNdAHRGSMjGoN8svrdltHqPtFeW2
 M7PcpF0/oLvXkAiXqSG1ML2NNFf9smb9gabDjYQUY0Xhn8qxYz0Ba7Eia9HnlR5mkMXt
 W//1hQp6WXoG4a/dXMmMczMHpWFnh8kdXB9/3LG+YEXB6kdZdgOrUZ4t3hriqnEFT8uK
 Lvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705329966; x=1705934766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/4ySOoTk4TppXZjwZbNwuRPAqBVyqkp14luXtIwRzA=;
 b=uZ63ioH6ZNS2W/BzIltyiPfIJVbMN0kRzXXktyAIEnRwiNDI+QHfeM6YmRb4qdLMjs
 JGBUdiZOoRL0CBLGP8JCfmht+5VAkxBGHzrTfObeHw9dO+y3BiZpIj982NXlROBl0xzS
 OHQhh/vJqYPNyF6qBqZKmsIx1y3Hqympxh+1ScSvUEHsAkutI0OeTYFJ8qWzdpSITgVy
 LwrLzAO/mO9yH4ES3viItI3o1/Bj7TKddWao81LgQIBqwxF/GU3JaC0BxGqKUlL6kKnR
 Wq+fBNC9B2FOqyY1W1NLcjfczZ68A6UHiLE5/13oo8Lbjs071nQJnHXlnJVsc0r751SF
 99QQ==
X-Gm-Message-State: AOJu0YwfslJn9uCHAOq8Rh6tklsv4HLggYXOORR2w1S3+shw/z+eBVJ1
 Lc4ObXOzJaqrMWMQIZ3VykTRxZcli3GruP1wv4c=
X-Google-Smtp-Source: AGHT+IHzHQA6gp+7gFhnfWLKkMoHCFmAzDUdS/M5a/u48VV9ALOuyKdLcA5bmqyAquWhQFm3w7jclc4KHPCz3X+yoYk=
X-Received: by 2002:aa7:c993:0:b0:557:7764:b6ae with SMTP id
 c19-20020aa7c993000000b005577764b6aemr2740254edt.11.1705329965974; Mon, 15
 Jan 2024 06:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-4-bin.meng@windriver.com>
 <87le8qkepv.fsf@draig.linaro.org>
In-Reply-To: <87le8qkepv.fsf@draig.linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 15 Jan 2024 22:46:11 +0800
Message-ID: <CAEUhbmUoyNi=3uSwiFPGdb25_a-0zwQavbni4T+8jMJJFJH01g@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/acpi: Update virt/SSDT.memhp
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Laszlo Ersek <lersek@redhat.com>
Cc: Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ed1-x530.google.com
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

On Mon, Jan 15, 2024 at 7:40=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Bin Meng <bin.meng@windriver.com> writes:
>
> > The Arm dtb changes caused an address change:
> >
> >  DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
> >  {
> >      [ ... ]
> > -    Name (MEMA, 0x43C80000)
> > +    Name (MEMA, 0x43D80000)
> >  }
>
> I'm confused by why this changes. Isn't this declaring the size of a
> NVDIMM region of the memory map? Why does a DTB change affect an ACPI
> based boot?
>

I have no idea too. I suspect that's because the AllocateAlignedPages
call to allocate a 1 MiB aligned address in the BiosTableTest.c is
affected by the shrinked DTB now.

+ Laszlo who might know the root cause.

Regards,
Bin

