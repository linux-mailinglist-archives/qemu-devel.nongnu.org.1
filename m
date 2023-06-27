Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B0573FF38
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:04:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEADi-0007TK-Cx; Tue, 27 Jun 2023 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qEADg-0007Sh-1B
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:03:04 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qEADe-0002HL-Bt
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:03:03 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51d7f4c1cfeso4748454a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687878180; x=1690470180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7acVeO8Fk/hj9I/KUIKvuKxa7Qgfhd6zOw3GILR2Wag=;
 b=AEOLIuFpdbKWjyYfbRoJKUzn7NYsbCkVTtDEkPW8yiG/5G+kZUu+N9udW2Gz7Vj74r
 Fp12c4xvEyoSj2SSIyKQO6wVLb+v8Sco9VF+cXDmPWZBL2F4l+O4jx3p2JTXQzD4EmxK
 dA+FZ2qQNVtbzu+lxwRVUwRPubmk11jeJ97qBx5oSBmpIiZW1sw2r+z+DIGvTMpj4/Cq
 MRTFr3En0/BpWjnr2Za//Qy3pvmN7v/l/NbVmgz362mfQA+/uHafGbyJRXNuVqdV1/cM
 tYprc43NZvHGdZNFWBL18t9MebruaFNodeFN0HFqh0fJMPr6ugKsA69l1wXSzhBgeDG4
 yD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687878180; x=1690470180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7acVeO8Fk/hj9I/KUIKvuKxa7Qgfhd6zOw3GILR2Wag=;
 b=ZtP1EQw+HJgOpf6gKTIWb9ZB03bagYvhFkLE6FkL3ofFrHtKD3sImIuex1PdwimaxE
 fTJYJlkWUcZk8bd8zZJhIFceK8UGLsabe7vguvsaHxO0DJM2iidIXzcTK9guqXCc+7ci
 /j1UunVhNz7EmDjjGZUPYYyObyELzwJGB+5cXhh5/GI1P+YWRgPz9kAOi0/ndXQb+OhO
 5rIN2uVEs0qdVqtHVNP7Yf9tkAFTt7hac0QDz23KynTm7soTaCfhj57+WsstlaRz61E/
 Zs64VScM77MHj872c7dLqoV3c0AtRTNDc3NDX+0Ayufow3rdPuCR8W2KFT+nYk6HlwDS
 0kPw==
X-Gm-Message-State: AC+VfDy8Oz0H53FB881eJHG+KscYSg2P7kylAwp7l/CTEzz4zqSb8ovx
 eTFxmXTIHylQoN5HrgqKzUo2JnwpmMItyxp8IGzdFg==
X-Google-Smtp-Source: ACHHUZ7oEzbOJeW9Jz86Ac2/SwvsubfXHsIbmdHwg4lSuD9X/x/vf94f1udUnS13oEfRXHE2AgCmS2UZUXr+lwpNCnE=
X-Received: by 2002:aa7:c38a:0:b0:51d:9dd1:29d0 with SMTP id
 k10-20020aa7c38a000000b0051d9dd129d0mr4086292edq.23.1687878180310; Tue, 27
 Jun 2023 08:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <168778890374.24232.3402138851538068785-0@git.sr.ht>
In-Reply-To: <168778890374.24232.3402138851538068785-0@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 16:02:49 +0100
Message-ID: <CAFEAcA9zpLBbTSnhvQ9+1o3n4FEnjkDAYm5ZF9NZ0JOJ05MDEw@mail.gmail.com>
Subject: Re: [PATCH qemu v4 0/2] target/arm: Improve user-mode compatibility
 with JITs
To: "~jhogberg" <john.hogberg@ericsson.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 26 Jun 2023 at 15:15, ~jhogberg <jhogberg@git.sr.ht> wrote:
>
> Changes since v3:
>
> 1) Reworded the first commit comment to note that the need to clear
>    cache is implementation-dependent.
> 2) CTR_EL0.DIC is now cleared in user mode to indicate that IC IVAU
>    must be used.
> 3) The test case now only uses DC CVAU / IC IVAU when this is
>    required, as indicated by CTR_EL0.{DIC,IDC}. There have been no
>    changes outside of the function `mark_code_modified`

Since there were only a couple of minor nits in this version
of the patchset I'm going to apply it to target-arm.next
and make those fixups in my tree. Thanks for this bug fix!

thanks
-- PMM

