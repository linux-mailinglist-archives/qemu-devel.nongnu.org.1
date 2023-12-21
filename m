Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D181AD74
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:26:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9a5-0000yU-TZ; Wed, 20 Dec 2023 22:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rG9a3-0000jn-34
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:39 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rG9Zz-0003wc-8Z
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:38 -0500
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35fcd6f8aa6so1377285ab.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703128713; x=1703733513; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LjzbahiJf7iWMjSutJrYkVwOwcQyuDyYDzO8iBq8Ycc=;
 b=HFddhCF4UopS+jYtxIh29i2pA/GnDtIUlXhwuRrvPlyVXC7iX8vlnrdnBAFlGB38SG
 dGbCIDmzOkVCkTYVa+gn1UGx0FNwmNIHdXbaB9qDJ0iG4SaDjgMRJWByi/rjajIDjJdU
 jvMYZ0dsrozkzWHivnEZwcdMvIpL8qSEvJKdOHYjDbKa5JxU7wBZ0HdwojWhd3nnmxTw
 WT730xHxI4pXcU1z2iV6Q2eFgq9p2TR/X/UMna22kMsu0iIsD+FkIumnW6h3TCHhX9WO
 5oCZ6SCqZ4qdepT9qgIayT/J+ekSPee2ypnCG1mJSp+nptEBAyWtahbssCxaB5jqUdT+
 v6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128713; x=1703733513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjzbahiJf7iWMjSutJrYkVwOwcQyuDyYDzO8iBq8Ycc=;
 b=assHiOoi3kfXAXs1iseDo0ulDBi306b7pfRUsuhgbtGfa0xhiNtm1eTAVe/kVslG8n
 NVrA6QfCWmK7/Xqo6pYUyM2I4/ePGnnonI+mcmIF/6cU2dbjKsd6Kp8JyWhjGu9k5k1B
 29L795h+uhtWzppG8xi4DjFfGMTgQS/dUKqLGrcwaMoFvlTTXBo8EPOnn/YxnLtSpYRW
 QdIVIloVbiAyvjyjUMWqYS+kBCw5/bWpglpPDBNzCkVc3+fy7ZQi+e/Y/8LeqwIgB7ss
 zUETZpvY8v3LOYrKmhSgHlRZ7k5yc+b78NlRPYh5ZBX8GnJqhtFCBQL7oGmYVhoW2l0b
 1I+g==
X-Gm-Message-State: AOJu0YzUxG4SmkR/dNh3k9wisFhBkaT39j0KKxlA1670ArR/nqjJE7Kp
 8wdOOXVmgBznKYqASLqrm/6VdA==
X-Google-Smtp-Source: AGHT+IHI50EaXJjfCdGOnNqYFVaDO876F6ey1LOQKPnkMaOk0ZKLSHL3Rf/8jP5L62ONwvsDhC0jAQ==
X-Received: by 2002:a05:6e02:1c46:b0:35d:7687:1def with SMTP id
 d6-20020a056e021c4600b0035d76871defmr29675972ilg.9.1703128713460; 
 Wed, 20 Dec 2023 19:18:33 -0800 (PST)
Received: from sunil-laptop ([106.51.83.242]) by smtp.gmail.com with ESMTPSA id
 i7-20020a92c947000000b0035fb0d46fbfsm253713ilq.50.2023.12.20.19.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:33 -0800 (PST)
Date: Thu, 21 Dec 2023 08:48:14 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] docs/system/riscv: document acpi parameter of
 virt machine
Message-ID: <ZYOudvqiDBbV0PC6@sunil-laptop>
References: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 20, 2023 at 08:34:36PM +0100, Heinrich Schuchardt wrote:
> Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
> table generation. Add it to the documentation.
> 
> Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	mention that acpi=on is the default
> ---
>  docs/system/riscv/virt.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil

