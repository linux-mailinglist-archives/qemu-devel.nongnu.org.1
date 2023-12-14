Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF0B812F0A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 12:44:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDk7z-0005RU-MK; Thu, 14 Dec 2023 06:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDk7x-0005R3-Tx
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:43:41 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDk7w-0004Xr-3a
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:43:41 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ca1e6a94a4so104819501fa.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 03:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702554218; x=1703159018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ns/b12vs3meiT2AKsFvlgoRG58Wje041FbFxnxJs0eQ=;
 b=Iuc8sgSo+N3D52BymWJou56AQgg17uBJ2/y7OrhJYmXavNxPby4jVKFgt4d4kLJn63
 HAz/ZMD7sfPsLRPXcVVylqYCWWxahcbw7I1JK9YxQhp9cYGDXH6WnYb4EsEXPSh42ejG
 ceYDQ2Fcga6kovaBUmuQg1xSgAYbbYxg5spDaBn9qCRqqUJ+vMjECCBx9/uYbXTswnKZ
 nEcu3QRMJfpjOYQCjG51U9cvUTWcOM45ngKLA/gQjjatUJ/nL3AIQJCMPCH4A22yDFq2
 lwE8nL9ylgLPpjgWNgiTV+Pszi+UW/na/nOVYXPTWjXkCj5D841z3vro8tG7XqjOQ3iU
 MVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702554218; x=1703159018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ns/b12vs3meiT2AKsFvlgoRG58Wje041FbFxnxJs0eQ=;
 b=D51BU5Nzagv88wdnC8KJjR4iohkzxvIr3dlBu1O7SIQJVWpcVCiaY32C3Qq/XvFQXn
 N1ZGaPSs5OtDvcDTa0l9donuKwDxSrppTY08gKqWwQCSEShS3/kUHv31XPIDt6Y//lE+
 riOJXd1Eo04WdWeieIYNO5E3rHxeMwnFah2KeEmL8/5b04HhnadRVqXu7fanU7SaF50f
 cHfP3+hgBSo1vY8AMTalmha06eGQSjTESIvTjzIrRg8CmFxj7KgqGeGwNWIO2fr82WA3
 9KYZTO9qXjsSh5m1n/1q5sZofcdssy0L7Eh1D7CyFI5r6T3lfj2GQI9f4LW4JwBX1/V+
 +Xcw==
X-Gm-Message-State: AOJu0YwVW3Ovmr7+2+CQVYKGdAPw5lGLI8WhB6klZBs8W3FKiQQIbmdF
 6RsErIiUeYXnGh7pVwsDquTXS4zRlZDDrhPXV+cGlw==
X-Google-Smtp-Source: AGHT+IHuNrC683VlQ8lLAfm8Kj8cOOEwwA816fIYuv6rCXgNUgzaqnNpAWF9hiGX3Xi/O3hTuAeFGYvQlsBPALAtnWg=
X-Received: by 2002:a2e:154a:0:b0:2cc:1d28:edd with SMTP id
 10-20020a2e154a000000b002cc1d280eddmr3027338ljv.3.1702554217931; Thu, 14 Dec
 2023 03:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20231211175215.3216667-1-nabihestefan@google.com>
In-Reply-To: <20231211175215.3216667-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 11:43:26 +0000
Message-ID: <CAFEAcA_j21Vbr6viZtNuCymR1eM1J-dn3KxO1qPiQzuVmY4ibg@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Implementation of NPI Mailbox and GMAC
 Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Mon, 11 Dec 2023 at 17:52, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> [Changes since v6]
> Remove the Change-Ids from the commit messages.
>

This doesn't compile:

../../hw/net/npcm_gmac.c:889:43: error: too few arguments to function
call, expected 6, have 5
                             dev->id, gmac);
                                          ^
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/net/net.h:159:11:
note: 'qemu_new_nic' declared here
NICState *qemu_new_nic(NetClientInfo *info,
          ^
1 error generated.

Please make sure you've rebased the series on the most
recent head-of-git. (In this case you are missing the
necessary changes to cope with commit 7d0fefdf81f5
which added an extra argument to this function.)

thanks
-- PMM

