Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3AB7F9F59
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 13:15:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7aUn-0004dK-Bs; Mon, 27 Nov 2023 07:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r7aUj-0004cK-B4
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:13:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r7aUh-0004IU-7F
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:13:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b427507b7so10220715e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1701087218; x=1701692018; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xTe9bMxa4h/Uf0N80P0IzHktkuTrCSwCICYwFmCHt2I=;
 b=LerqQ7st+rJhdTLYHcBgIMqL2mEP9FJ7YDUGx9q/G4E0XX63cKQU0Q9uBk02MU14va
 4uWqausIwOqHzuCPpijEf7ChNtaI5LnqeCMc0KWvdWrpo+QWer8OcJWOZPSxUHk1FD3z
 wlAI7kR1DcCRq5lwZRcvRfpYthqjol291+eyUQ2FmMWexHhn3fsIYhCavcf5VUaELI8o
 eoWE6FO+eKj6L6Tqc9p1/i9cS38caCVgcgT6wj+ODotNPY66h5zIFlrcZDngv1hxaXoe
 ZbbAT9nchGwGw7CdHV+dioiZQVoHzGwRgMC6HOuRIu6KTWX+KuGGbbKy9kQRfU3ma2vu
 qj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701087218; x=1701692018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTe9bMxa4h/Uf0N80P0IzHktkuTrCSwCICYwFmCHt2I=;
 b=TeTPJGeQCrDKw5CElBGuo/43lvDZnDkvO49PYzH35o1KleEdByloZ7PtchIBRNQXpw
 27F9wkC/nH3WDQY+1kvVyDr0aN1SkvE8WcxogYyqB1wyXaLdh6Sh/CeJoYaanPx4DRiF
 hvJQu0cIUXJJR+vAG7QJyuvaT2c4f1ATXrc8GpAWJDAdsIccIPBipZ9vXGQwPsbbSiff
 Z0fsTZKWv/734jfD3rDG1laRCrR8FfJYqLsAC3cnMWTwyWef0uLLW5GZEi5MhRPa5/H5
 aT19EZE1x/+39ysb7JzfbhxXOqw9dkPkgq2A04pFvZ2wuq9hd1DXFkPdkllptb9NoyLg
 +yWg==
X-Gm-Message-State: AOJu0YzI11P+knLjYl9DNim1sFwY7sOYQuCkMuI0rWYS3LCrOJ2hUbHa
 GWWK+oS7EFv3SzyXszm/eJU8cQ==
X-Google-Smtp-Source: AGHT+IFV+qvmAhTS4KjtU0v4uwebMPhpnagIJX4iaVCv4nWR8LqSiTBZTDF6x4XO/z+R41DWt6uixA==
X-Received: by 2002:a05:600c:4e90:b0:40b:47c5:4be6 with SMTP id
 f16-20020a05600c4e9000b0040b47c54be6mr1085408wmq.23.1701087217804; 
 Mon, 27 Nov 2023 04:13:37 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a05600c3b1200b00405959469afsm13820410wms.3.2023.11.27.04.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 04:13:37 -0800 (PST)
Date: Mon, 27 Nov 2023 13:13:36 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-9.0 v2 2/8] target/riscv: add priv ver restriction to
 profiles
Message-ID: <20231127-15bc491c5f7eb99b4b356674@orel>
References: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
 <20231127113752.1290265-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127113752.1290265-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 27, 2023 at 08:37:46AM -0300, Daniel Henrique Barboza wrote:
> Some profiles, like RVA22S64, has a priv_spec requirement.
> 
> Make this requirement explicit for all profiles. We'll validate this
> requirement finalize() time and, in case the user chooses an
> incompatible priv_spec while activating a profile, a warning will be
> shown.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         |  1 +
>  target/riscv/cpu.h         |  2 ++
>  target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

