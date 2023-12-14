Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A14458135AB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 17:05:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDoCL-0002hz-SX; Thu, 14 Dec 2023 11:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDoCJ-0002ha-9r
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 11:04:27 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDoCH-0001f0-FI
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 11:04:27 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-550dd0e3304so7822247a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 08:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702569863; x=1703174663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3UoNFJsBZ+wZXqHEBRWOUDEHY1QQulHFGyu9V+T8Ubg=;
 b=AQPdWAKTrG8/+8k4vtVKJXU8mt7pFdLgYDEal3Brknuk/aVS0zkEb2oQtsk741DNTN
 KtxUPmXvRezlrfMPVEpk7iAJXXz+rhfTZudNDfaT6cF5wSCMCUqnOLaM+PxSlPC+mdZZ
 MMpUWd3n/PqrvVTjJYaIZP6Dz6jB7JqUcxKHtXltmVrYhAB9tNTLq73HrPxgcIKxGlgn
 idh+NZxj1J1Hu0bnHVh3IHetKWl26R15T+1I7KX4jlD+1lErbDyLw6LVuOryn86l6jCq
 x6cp8KA+xvETKA+7iJLFibDQ4rFo9c0cUdgU4+A0pYLOz1LuR2g1zDQn5RA86n4nx2fq
 qwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702569863; x=1703174663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3UoNFJsBZ+wZXqHEBRWOUDEHY1QQulHFGyu9V+T8Ubg=;
 b=YLOk2fsXkWKhdZXFZxVwyERutfWFC1Gm8vhEHPVEWM1eCrJIj3CwJemFdTbLy1E7/H
 LB1I4Nx+nqypnS7+abMEL9ztlP8EdjBEqXyo33pKOmqk37k0UHUWN2h9NVaDwG+qeBs3
 I0+rh9J7p0V8uj/2tUNZ+1Sxg7R4BmQdbxTIA4weCRck1XwFJXjkxFtujuojIgshvjx0
 maemPxTBML1I5Bsd2qSoZhbZMVRfTaI61h470WHUhIcsib+UMZkPkebafYYcF572HIyl
 NpYIpOHhiWBhQizA3l1IW/lzwguznuXuklLB00Vw/5+UoIGPoi3hEaAM5m18Cg/mvXfb
 xqMw==
X-Gm-Message-State: AOJu0YyblxIqtW2ulutKVmNHRLfhENfO9BuqecQJpZhMEXBxyh/zvN9o
 UmscdGB872h/qj7FTEZbCfRTuNDE5EZ6cYAYJDjZ1Q==
X-Google-Smtp-Source: AGHT+IFfCl7WPPVDpStZxdvyzF60F730pYjfQOZl8Qo06K9albFWWTSpuVgd1kjOWQ2/+f+bPOY72QhoJNaF77rxb+E=
X-Received: by 2002:a50:d081:0:b0:552:6e4f:3d31 with SMTP id
 v1-20020a50d081000000b005526e4f3d31mr754854edd.40.1702569863243; Thu, 14 Dec
 2023 08:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20231213081839.4176614-1-gaosong@loongson.cn>
In-Reply-To: <20231213081839.4176614-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 16:04:11 +0000
Message-ID: <CAFEAcA96XrsnSNBZwR-71EAhDDMwmzvzvZ987ZKLRk__ZvVQfA@mail.gmail.com>
Subject: Re: [risu PATCH v2 0/6] Add LoongArch LSX/LASX instructions
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, philmd@linaro.org, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 13 Dec 2023 at 08:31, Song Gao <gaosong@loongson.cn> wrote:
>
> Hi, Peter!
>
> This series adds LSX/LASX instructions.
>
> We tested 10 million instructions with no problems.
>
> client:
> QEMU master + patch [1]
>
> server:
> 3A5000 host.
>
> [1]: https://patchew.org/QEMU/20220917075950.1412309-1-gaosong@loongson.cn/20220917075950.1412309-6-gaosong@loongson.cn/
>
> V2:
>   - Rename block type 'safefloat' to 'post'.
>   - Add the clean_lsx_result() function before adding the LSX
>     instructions.

Thanks; applied to the upstream risu git repo.

-- PMM

