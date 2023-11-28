Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7837FAFE0
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 03:06:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7nUK-000593-J4; Mon, 27 Nov 2023 21:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nUH-00058L-TP; Mon, 27 Nov 2023 21:06:09 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nUG-0000lz-7x; Mon, 27 Nov 2023 21:06:09 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so4202402b3a.3; 
 Mon, 27 Nov 2023 18:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701137166; x=1701741966; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5DF7g0v4NaTn+9wJLAgxFj2IuPQaBC4ZmhMBNiXAwI=;
 b=OoEXFVBh/ccM7HDw8wiO8C1fJcFSxHhtJNeGMt61ikixGQNH8pVVYYWrZ/8wDvXvmD
 WU27kFciVVli2vQ34hOlU2Knea7IEWtGdElnpMy6tv/pqhvveKzz0k2a9bGOn+dfCXSm
 FWAntO1ba7g7eNSMiN3TZ3fFAAbSy3Ywax0woem79AitS5IOrABCvBZQRySCG0y6TbQU
 aWDs9tTAFI+Wl1OvuoG+WvNAUY36uAfo4DxWHpfjWy9mmD4SbLlXD0qrGpe/fSsjwBAL
 +Qn5t0dBmR5aTL3NMMGqwKqWEKLs19awJivHbZzOxsNhxQwD5LKV6W/b8V2Y5TcH4WzB
 dB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701137166; x=1701741966;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z5DF7g0v4NaTn+9wJLAgxFj2IuPQaBC4ZmhMBNiXAwI=;
 b=wKFnJ2aGmzmIkS73f4iSAldRWCL/Q+DlXh3P7o/0pYhdHhGak21dJY4VSH021Fh/+G
 BnYGDuUJR6FGh9Jgud0/RMftrkUiGV9WsIDk7rcyJisb1RDIcf8AU6Ln9VtlUk1/rGf0
 aRG8bBC+J4QlFhH2NcRYMv/xeQ++nPT/dMvkqciqkbQK2SZfOmA+1q/Mo13LY8idQ3ZY
 hv41TqkXMYGs/Inz6lBihhjdtXh46IwmKhwWskzCFk//lrvEdzS4JdmGxACvPzSxc0E2
 jKAtaSnxkKML07nVCJ63GuY0S9npUBCHeODGciEAA974VDpmFg/EvK8GDozGTC+o2qLM
 DWRA==
X-Gm-Message-State: AOJu0Yy/TojY6e9XKIkiHqccV/OwgdjG64xiSO5Hh8H02w9pSj3i2NWn
 ZmpR68Vv4DgVCN/ew7pfEYVD7Lsnunk=
X-Google-Smtp-Source: AGHT+IGY+gmShNBvH3kIkhTFbG4sRJtLcv/ul3UZ4OfgWTnt9jdbBUKDMMS8SqkI9IjyUeU3B8D8ag==
X-Received: by 2002:a05:6a00:244c:b0:6b7:18c1:c09a with SMTP id
 d12-20020a056a00244c00b006b718c1c09amr12981999pfj.5.1701137166231; 
 Mon, 27 Nov 2023 18:06:06 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 y42-20020a056a0003aa00b006baa1cf561dsm7776309pfs.0.2023.11.27.18.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 18:06:05 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Nov 2023 12:05:59 +1000
Message-Id: <CXA2SMDK57YS.1BACSN5MDTSNI@wheely>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@us.ibm.com>, <chalapathi.v@ibm.com>,
 <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 2/3] hw/ppc: Add N1 chiplet model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231127171307.5237-1-chalapathi.v@linux.ibm.com>
 <20231127171307.5237-3-chalapathi.v@linux.ibm.com>
In-Reply-To: <20231127171307.5237-3-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

On Tue Nov 28, 2023 at 3:13 AM AEST, Chalapathi V wrote:
> The N1 chiplet handle the high speed i/o traffic over PCIe and others.
> The N1 chiplet consists of PowerBus Fabric controller,
> nest Memory Management Unit, chiplet control unit and more.
>
> This commit creates a N1 chiplet model and initialize and realize the
> pervasive chiplet model where chiplet control registers are implemented.
>
> This commit also implement the read/write method for the powerbus scom
> registers
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ppc/pnv_n1_chiplet.h |  35 +++++++
>  include/hw/ppc/pnv_xscom.h      |   6 ++
>  hw/ppc/pnv_n1_chiplet.c         | 171 ++++++++++++++++++++++++++++++++
>  hw/ppc/meson.build              |   1 +
>  4 files changed, 213 insertions(+)
>  create mode 100644 include/hw/ppc/pnv_n1_chiplet.h
>  create mode 100644 hw/ppc/pnv_n1_chiplet.c
>
> diff --git a/include/hw/ppc/pnv_n1_chiplet.h b/include/hw/ppc/pnv_n1_chip=
let.h
> new file mode 100644
> index 0000000000..3c42ada7f4
> --- /dev/null
> +++ b/include/hw/ppc/pnv_n1_chiplet.h
> @@ -0,0 +1,35 @@
> +/*
> + * QEMU PowerPC N1 chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.

Same question about tag here in in the .c. Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

