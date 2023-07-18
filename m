Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7596757933
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:21:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLhp7-0003Lm-8t; Tue, 18 Jul 2023 06:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhp5-0003KP-L7
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:20:51 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhp4-0004H2-5C
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:20:51 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51f7fb9a944so7779761a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689675647; x=1692267647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoJRYC3MfcZ18P4KVffL2lD9O71DJkppni4a/To86g8=;
 b=azh+Y0DP9GH0QC+odHtuWAN7AoQWELZTVuybHwTLcWntiaHzSLg7QQJ5DbP4dOynP6
 pZX2mFkDPMi2neb1iAG6JArqzdQABSFdjjWeTY+oOINLBBX8B4M6mdJvrA2Q3GSKlt7+
 X58Qibco9tIbRKrVSOy4cJJx2VhgfiTXpSoeqBKv0eZ+E6qgR5wiYD/+5I5bYtqV8WlM
 BoSdzLtvjCGuRczrzNuvQEdDZZVn3GtA4eGIXLeYA6YM7fzrRoM/mF3gLc9wHvPCQibz
 /kI7qGM00vp5T4g61lLXIJbrM5y+5X7vDamuG96EBQGFG5QSgaeoHuYS6P6uMLMDySlK
 vThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689675647; x=1692267647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoJRYC3MfcZ18P4KVffL2lD9O71DJkppni4a/To86g8=;
 b=cp90VhzBimdGED4wCXoJ5ZCW9B1Vi/HFUpt2ga+B9wP+WQbkr0coQvmxKvA279LN1e
 AVOA8CEZpfjepmKQ9lihn5auIln57unjT5HqCsTHThwp2/2nHY8RJQU0Bkn+PoZ0tYY8
 4hPo5FXRlqiexznfvOuz4B2AgOthGgkl/JrYctpV3iqYltwq2PyCTffGAHZRwDncFZUu
 acO0BkECIzgZD6DeDjqahC/vou0I03ABoMFK1vHaQzH9aVavn3be1khruAdfUQoGMBSa
 3ptbTx4qDi5EmGu83oCOswvIRXG+FOmLx/Jb44/gFsKdcQp/mdFu6eTN6Rf0Q7m8JGHx
 AMyA==
X-Gm-Message-State: ABy/qLbXpJADLmq9o4qPjUoF+yM7w+nwtS3j6mAdrvFLO8KmnRNxDGGj
 tm47Cx+Mbr0YTBIcNBqtp/97v+lnP6J9s8NThZL/iw==
X-Google-Smtp-Source: APBJJlEG0Ej504yYOBHl2kUovQ4qSFTgvuQuGI6qOgxsg6osnVH1w5HJZGvLEXYx6s26bdw7N8hvFQHFkRZgUr8sjys=
X-Received: by 2002:aa7:c58c:0:b0:51e:f83:6de3 with SMTP id
 g12-20020aa7c58c000000b0051e0f836de3mr10726453edq.17.1689675647141; Tue, 18
 Jul 2023 03:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230717213504.24777-1-philmd@linaro.org>
 <20230717213504.24777-2-philmd@linaro.org>
In-Reply-To: <20230717213504.24777-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2023 11:20:36 +0100
Message-ID: <CAFEAcA-NGLFtoso_J3hUpZhLx=g4PxR3D7-j_Foa_kDntSuqUA@mail.gmail.com>
Subject: Re: [PATCH for-8.1 v2 1/2] target/mips: Pass directory/leaf shift
 values to walk_directory()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 17 Jul 2023 at 22:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We already evaluated directory_shift and leaf_shift in
> page_table_walk_refill(), no need to do that again: pass
> as argument.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/mips/tcg/sysemu/tlb_helper.c | 18 ++++++++----------

Yeah, this is definitely better.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

