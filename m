Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F397E21E6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 13:40:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzysT-0004Vm-DH; Mon, 06 Nov 2023 07:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qzysM-0004Ty-Uq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:38:45 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qzysA-0000Jg-KT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:38:38 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507b96095abso5544059e87.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 04:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699274307; x=1699879107; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QseeqxFQMkKzTjuxolDbun6eFvusMmaH3/5dQe0wdg8=;
 b=e0oS5ahFtOBMAo/nx6VO1fEOrtAtswgw1Bcd25cYpPanROTOtTc0X2w9LhV3Cwo53d
 IFy1C0kCVVnwxUYUu1eFph8gUBXI+6k5uI3N3TmisQT8SX0nN1srL3bT0E7H01PvJQsL
 9wOV7KuBQ/1xOnU1V8vocwX6+xWGpeCUVqP7kk3ryL6Bj/NdyPy4bisQd/AVKCZC2drx
 B5m3nP26VJOHe94qKc1uzlCT+WzF0zi/PEmOA+kdvY7IVpCT3fyugOPyUzoYic6xkx4v
 S+eFvA3nASwWSKCSPqW3gKfNM/2a37xj2wYGp1mFmMdkA0krb2VfRz9T0SdInguu1q+2
 z93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699274307; x=1699879107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QseeqxFQMkKzTjuxolDbun6eFvusMmaH3/5dQe0wdg8=;
 b=vMPGvGuKbHUkjqJ5kKxjsHIzS3FBaQ3djNtQchhxvCgICbrXsK2UzL+/KjihhuOjSH
 qUIS1nN4ekCH/dKr8FU3F4rem4P9Gz8+Z+TyqyNAeAnp0vmyoPUJi8Hyx9ycu45svSMM
 bizTdN1OG/zqAd7cyRfWJBamX52j3kM0OQ7VS7G7nL1IWTlR3B5YXxWAbFbTljfD0SBd
 kiyWonEFjh6TrZ2WJucFhqKmo5j/9IT5ugDMIzJIBF+NXPiBuqr4Rt7RvbSi9C4Rohn/
 2/Bz2J5sc0Qd20CdQLHwTlBMLknewhJfqjDBcI4IGCsYMRiebHwkW+ZrGFKqWgBJHvm+
 Uvaw==
X-Gm-Message-State: AOJu0Yw22fZu/QwSuq4aBNbg7kOeDooZbVwPIScLQbUGXhH/bDoiP+OY
 x5Oswe1bZcU9zovjhg9y1G5kHlkRGc3D7tYlh8ZwcQ==
X-Google-Smtp-Source: AGHT+IGvx/o+WFAQjLwZW/x15kNnShRuGhJjggYJNKZG2AmTRhagwB/k7PKX3NpyC/zdN6riyRdWWVNEFfs5dl5YEmc=
X-Received: by 2002:a05:6512:33cf:b0:509:4c8a:525d with SMTP id
 d15-20020a05651233cf00b005094c8a525dmr10760742lfg.35.1699274307474; Mon, 06
 Nov 2023 04:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20231017125941.810461-1-vsementsov@yandex-team.ru>
In-Reply-To: <20231017125941.810461-1-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2023 12:38:16 +0000
Message-ID: <CAFEAcA9LpNoaPjg7UVHTQ1qtJG=LYB4GHKy2wCTNNt4tGQ=PgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] coverity fixes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru, 
 davydov-max@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Tue, 17 Oct 2023 at 13:59, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> v3: rebase on master (two patches dropped, as already merged)
>     add r-b marks
>
> v2:
> 01: add explanations, new assert and avoid extra assignment
>     add CIDs [thx to Paolo]
> 02: add explanation, improve wording
> 04,07: s/{0}/{}
> 06,08: improve wording
>
> Hi! Here are some improvements to handle issues found by Coverity (not
> public Coverity site, so there are no CIDs).
>

Looks like nobody picked this up, and they all got reviewed,
so I'm going to apply it via the target-arm.next tree.

thanks
-- PMM

