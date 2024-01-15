Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82AB82D87E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:40:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLJk-0002Cd-3E; Mon, 15 Jan 2024 06:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLJh-0002C9-1t
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:39:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLJf-0000FS-Kn
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:39:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e76109cdeso10710045e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705318781; x=1705923581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsnrcHzxPHk0pBK0xpSwFzf8njBQ6nWFNbsX9MFadKM=;
 b=O5fbkAMsQTAH2cnz5JXmRR/aR74sy7c3t6VW4lqphPKvz5JcB3t2M+dmypDSbQwwgx
 uTBU2Hz+e67YWl8nIdcMPFqkVwqTnmzBEufBfizhsqZTtPXCU8rDqfn3pqI8MpezZPwS
 FDQy+pxhVsExvPndpfI+cgOgyaXawhdw5+hE8m2MlOMgUtHxmPqyk7HSsZq+SRwJ9v45
 6awlEReNqkemoonSWx2POWt17RV4cHLj+XI2Qbn112yp7IGHUMGutikgClo7BG2gsZms
 cN5Qjkh4UXNmu6ovIm2xj2aGWgdhiQGakfa4FJmP4CjhH5LOZ9PBHcBMkgMupNYqof3N
 8OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705318781; x=1705923581;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PsnrcHzxPHk0pBK0xpSwFzf8njBQ6nWFNbsX9MFadKM=;
 b=m/0ciGnhnNvt3Rmg0Tmvodi76uTgJrN2JwL29uyozw461SAv8EjE1JxDd+GiRCH68O
 llvGyC23r+pv74tX+TnCzgip8d8E8jKHxaZDJCZo2TMdNTWRgtKDklaEevvNWJJ75o+J
 +yTz0uvrODlIKMyoXlLkRQDj/3uxWdnUSU26rhCeaM36KJjDK5YZ2oMYWI9BzncqWLxG
 USbXGq/vXLXkw4u8iASBbHCgyZYixV7wUG8KLc+aBN0BQz2JD4XClOnupQ7Qb0niU+5E
 DnaF4U3Nu0Tc9RjQnTx5DaRmd4zoBPDuiBbiGP9zv/fW22LSoTrV/QQDaeFmSebcN3sE
 UfQw==
X-Gm-Message-State: AOJu0YzhRL04Bs0phxtHazrWs6tM1hgVAoYcWVrLOyVNnlLz86NMjjS/
 reK2e5JF/zPSAmsRRENLMoOso93MLE4xvAcLniZvursVhzY=
X-Google-Smtp-Source: AGHT+IGGl/Fx02E8E6KJorfRtnwnGhUyf6cgnb22RV/K9lJUkMAdHcQrg32FbUgMnBG9WKQBYQeOSQ==
X-Received: by 2002:a05:600c:6987:b0:40e:743c:5e2d with SMTP id
 fp7-20020a05600c698700b0040e743c5e2dmr1131147wmb.172.1705318781409; 
 Mon, 15 Jan 2024 03:39:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b0040e3733a32bsm19455688wmb.41.2024.01.15.03.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 03:39:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C24BB5F78A;
 Mon, 15 Jan 2024 11:39:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bin Meng <bin.meng@windriver.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/acpi: Update virt/SSDT.memhp
In-Reply-To: <20240115043431.3900922-4-bin.meng@windriver.com> (Bin Meng's
 message of "Mon, 15 Jan 2024 12:34:30 +0800")
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-4-bin.meng@windriver.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 15 Jan 2024 11:39:40 +0000
Message-ID: <87le8qkepv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Bin Meng <bin.meng@windriver.com> writes:

> The Arm dtb changes caused an address change:
>
>  DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
>  {
>      [ ... ]
> -    Name (MEMA, 0x43C80000)
> +    Name (MEMA, 0x43D80000)
>  }

I'm confused by why this changes. Isn't this declaring the size of a
NVDIMM region of the memory map? Why does a DTB change affect an ACPI
based boot?

>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---
>
>  tests/data/acpi/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.=
memhp
> index fb3dcde5a10936667ad75a759b8bd444a7b19fc2..4d3ef733276bf5992da5b0bb9=
67f6d60e243417d 100644
> GIT binary patch
> delta 22
> dcmbQqH<OPmIM^jblAVEpao$EQUUsG%&Hz1D1wsG-
>
> delta 22
> dcmbQqH<OPmIM^jblAVEpaot8PUUsGv&Hz2O1wsG-

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

