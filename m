Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD379090E
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 20:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcV6A-0002l9-Ba; Sat, 02 Sep 2023 14:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1qcV65-0002if-Jc
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 14:11:49 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1qcV61-0004zl-Ok
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 14:11:48 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so1258161fa.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1693678303; x=1694283103;
 darn=nongnu.org; 
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=harrS9fT99VacEDc+dyIb00pnN3mybrcONM9bSm8Tdw=;
 b=CVr1FwyDYqIBAYiu2TkpFJobSilOtX60iCIa8TOO5run/G0H+TtgRMuaZOolsvXgWW
 ETmUcDuCLtpiMCrGgcoFl9kl0WsjgFUkGXCsuZ4CSDAm62ZMltggwmZIfimWv/RlHOku
 OLaMePekp05DIJIH4qBH340gkFxQ9pLsUk19pbvcbVkYn4GDuO/8LpKJ9DWHR/u7Ee4y
 oKTs/7+IcKxH/WB6sr+5WgJnh1C2seLZ8OnVJJBp+yjJd2XSxN/uaB1N8IopIPRjjSHT
 5nNjSkLxuYPY+Rdr1YOdtv1O55qzRlOikmbuQHooi11yJsE6yegyYGcb3ytbAbLD7tIr
 jIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693678303; x=1694283103;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=harrS9fT99VacEDc+dyIb00pnN3mybrcONM9bSm8Tdw=;
 b=hRcFH+Yi17WWcqfxgmaGcnmjDlzMoxWyS4nZbCfvzlpUXqKLOcBPJ/V2HB4b8aiitc
 P9yQRsJLWV3UZY7nj8apsWd8vZsqjTpPKOLnNOyo0tdIWxrRi+OLRQTiEMD+vMAw/UsF
 lK/9AbjOp04npddqwaX+GNaZP0Rv7qSsDHPVj49anwyHHDbO96+e1p/YPA0H3z6TWQaq
 Cr14L1xaOEb6LtpyElQS3pmOCYBIENs2vZOT4gAbHR7xOVV7xcyjdVDAOn71DxcrsP+V
 eKnKqimbF71KxjL381Pw2QVgHWeWKenKnzjsFEfREqM0RkIwVRE/8+D/MYpcBoMN44hx
 Y8CQ==
X-Gm-Message-State: AOJu0YyHYokq2sklCSB+0tEjhGsf5IwIZdujaH1vX0BdDJzbM9xAisYg
 H63ZnzYm5FBTf/2hjD6vAe8H7FQMW2MaTkv+LT0t2w==
X-Google-Smtp-Source: AGHT+IGwz8kav5m5fhLdbHPXjVhC36zENSqz0jlTAvocT/xiYYEIdhR8/CXJUw4xf0w3vHnkWmhhOA==
X-Received: by 2002:a2e:300c:0:b0:2b6:d137:b61c with SMTP id
 w12-20020a2e300c000000b002b6d137b61cmr3877268ljw.39.1693678302873; 
 Sat, 02 Sep 2023 11:11:42 -0700 (PDT)
Received: from smtpclient.apple ([86.121.135.50])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170906824300b0099b921de301sm3669043ejx.159.2023.09.02.11.11.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Sep 2023 11:11:42 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
Message-Id: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
Date: Sat, 2 Sep 2023 21:11:41 +0300
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=ilg@livius.net; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When trying to build 8.1.0 on an Ubuntu 18.04 aarch64, I get the above =
error.

The offending code in `/util/cpuinfo-aarch64.c` is:

```c
#ifdef CONFIG_LINUX
    unsigned long hwcap =3D qemu_getauxval(AT_HWCAP);
    info |=3D (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
    info |=3D (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
    info |=3D (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
#endif
```

The reason is that on this distribution the <bits/hwcap.h> header file =
does not define HWCAP_USCAT:

```
root@9c7ad90af4f8:/# cat /usr/include/aarch64-linux-gnu/bits/hwcap.h
/* Defines for bits in AT_HWCAP.  AArch64 Linux version.
   Copyright (C) 2016-2018 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#if !defined (_SYS_AUXV_H)
# error "Never include <bits/hwcap.h> directly; use <sys/auxv.h> =
instead."
#endif

/* The following must match the kernel's <asm/hwcap.h>.  */
#define HWCAP_FP		(1 << 0)
#define HWCAP_ASIMD		(1 << 1)
#define HWCAP_EVTSTRM		(1 << 2)
#define HWCAP_AES		(1 << 3)
#define HWCAP_PMULL		(1 << 4)
#define HWCAP_SHA1		(1 << 5)
#define HWCAP_SHA2		(1 << 6)
#define HWCAP_CRC32		(1 << 7)
#define HWCAP_ATOMICS		(1 << 8)
#define HWCAP_FPHP		(1 << 9)
#define HWCAP_ASIMDHP		(1 << 10)
#define HWCAP_CPUID		(1 << 11)
#define HWCAP_ASIMDRDM		(1 << 12)
#define HWCAP_JSCVT		(1 << 13)
#define HWCAP_FCMA		(1 << 14)
#define HWCAP_LRCPC		(1 << 15)
#define HWCAP_DCPOP		(1 << 16)
#define HWCAP_SHA3		(1 << 17)
#define HWCAP_SM3		(1 << 18)
#define HWCAP_SM4		(1 << 19)
#define HWCAP_ASIMDDP		(1 << 20)
#define HWCAP_SHA512		(1 << 21)
#define HWCAP_SVE		(1 << 22)
root@9c7ad90af4f8:/#=20
```

The full list of definitions should include:

```
#define HWCAP_ASIMDFHM		(1 << 23)
#define HWCAP_DIT		(1 << 24)
#define HWCAP_USCAT		(1 << 25)
#define HWCAP_ILRCPC		(1 << 26)
#define HWCAP_FLAGM		(1 << 27)
#define HWCAP_SSBS		(1 << 28)
```

I don't know the meaning behind these bits, and how important is for =
QEMU to correctly identify them all.

Since I know my build environment, my quick and dirty workaround was to =
pass the definition via the preprocessor options:

```
CPPFLAGS+=3D" -DHWCAP_USCAT=3D(1<<25)"
```

However, for QEMU this is not a solution.

A possible solution would be to compile the code conditionally:

```
#ifdef CONFIG_LINUX
    unsigned long hwcap =3D qemu_getauxval(AT_HWCAP);
    info |=3D (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
#ifdef HWCAP_USCAT
    info |=3D (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
#endif
    info |=3D (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
#endif
```

I don't know if other distributions are also affected, my build platform =
for all xPack standalone binaries is Ubuntu 18.04 LTS.

I know that 18.04 is an old version, but I use the xPack QEMU mainly to =
run unit tests, and in some enterprise environments the machines used =
for testing are sometimes pretty outdated, thus 18.04 will remain the =
base build platform for a while.

It would be very nice if QEMU would still compile on Ubuntu 18.04, as it =
did before 8.1.0.



Regards,

Liviu


