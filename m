Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A78312D5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 07:44:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQM8F-00042s-R1; Thu, 18 Jan 2024 01:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rQM8B-00042j-Ra
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:44:03 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rQM89-00038v-RI
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:44:03 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a2bdc3a3c84so818314166b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 22:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1705560239; x=1706165039;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C+tVU2zjHsgesCy8uoXBOCz8/Fh480I1x5NbavwpaiM=;
 b=19BH31Tt5slR4+Dizemr7BlMNOusILo6ft2wrpNFsm/851ftWR10yIL356eJeXKO4F
 Obe1QaD0J+TKWm+ZHG9Z2/mS2FSZX0aK7c5nDIgdy77W0xV3eUtFqbC5nYdiv0zRUuW+
 aQL/4xWdfpe8dSk1aMGoZKBcQUc/DgJKDxPkjZ9xG9ftneBY67ojBiGaGVxTg1FcFXF5
 F4dcKOji4gxWh8GIVz1Z3ukOEMkCX4uJk5hwg5pIH1XBcv45MoUXRFM8UO0UW0sjxQKB
 fjY/XBuiTyvU2OnPQmoNMZixrKVjRCrtuybkGKwSE+PGm9RB5rA8GGfT+qfhlm8abqDc
 KWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705560239; x=1706165039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+tVU2zjHsgesCy8uoXBOCz8/Fh480I1x5NbavwpaiM=;
 b=VZDiDOLv/ZKRFGUnIMKvnpZ7bhqqRXpnleFWCT9ONS/4AaG30G0RHfhoLd6K0K4PNa
 jHDdzqDEUTdM6+rNC8HnjR3o8YzDJVV91RWiKXRNUnhvbzm2xBeFFur/PaAL1lr+aOfI
 dkA1BjbxuEWe2enn/fZ/zEQr9rpW0Zp/CNovFgvgk46g5gCPOo7GhWkvxkKW70g+niex
 C/NEJILPH9zlv69yMH5n4+L/ZthM35jFeJy7WHuo9wSN+313cAsYlmxtHQ7DpGKuRgM7
 EYxvaTbkHfWAzE3YK/9koCHz8VNXCIIvmibk/4y36XruIj/r3ohtY/rb1e7Sx+f/a8ic
 Y/8A==
X-Gm-Message-State: AOJu0Yzgmsk2CQvhuTZBSHPdO9C5IB1KdrFCeBSOwiDVmqFRyE+GuH87
 niEI3KGpY1qmbBq+ZWRbxS/1Nf3uh7UKqgekLYa6F6ekmMOLIXteViocN8cdrS8db03KSiX6yxZ
 chVBU/bCWi7x3fq++DaT2h41SFCEXiTqUVNg7cg==
X-Google-Smtp-Source: AGHT+IHXLSdwqzj98N1zUPE8JUoMV3VjUh/0d/Obtpd3lDonMcGhqCAt8L+RoEJXEgbvXw/yVX17oRtBEH6OWOSMMro=
X-Received: by 2002:a17:906:4c54:b0:a28:e7b8:c57e with SMTP id
 d20-20020a1709064c5400b00a28e7b8c57emr181368ejw.130.1705560238946; Wed, 17
 Jan 2024 22:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-2-tomoyuki.hirose@igel.co.jp>
 <CAFEAcA9Sp0fVBkAyKFwVwt6F+Bzt4X6UfqhyqFkn25Z14TjZSw@mail.gmail.com>
In-Reply-To: <CAFEAcA9Sp0fVBkAyKFwVwt6F+Bzt4X6UfqhyqFkn25Z14TjZSw@mail.gmail.com>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Thu, 18 Jan 2024 15:43:42 +0900
Message-ID: <CAFS=Ecmz3G17MSAcz6wuJn01soL8kEMbB62JEy0o6DGJP_vKvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] system/memory.c: support unaligned access
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ej1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

Thank you for reviewing my patches.
Examples of corner case you explained is very helpful.
I'm currently working on patches. I will submit v2 as soon
as it's completed, so please wait a little longer.

thanks,
Tomoyuki HIROSE

