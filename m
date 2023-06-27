Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4615973FA46
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE61B-00036X-65; Tue, 27 Jun 2023 06:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE619-00036A-J0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:33:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE618-0003U8-2W
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:33:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso15111525e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687862028; x=1690454028;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IvYq/eTwVhMM7BtqsALu/vlW2NkwCbzbDg+yL1EyQU=;
 b=a+vb60r5pL1LcD6iGtGQ0nKXeKMLS63M865ddGSqPgVAV/Uz0Rj0w/B3wkjC+svVC8
 9u6fLvKAFEubIScZg/Jp5tGxofsbqBFUe4FT4H+A4+RfjfITugJyFh3WM6fQbCQMfYEB
 LqJdHPclWHTIr9rgS13MLBaoMw6QGrqtPuRGdDcj7lTwJmZOnGtPiyep1ouZLXIFGM4x
 u9g372YlgU4/U3WNVE73x3rsHYunl0+ZNaDYVE9+r0H+ofHWppy7dI9J/8ZYpnUK9Kl0
 zCqlTVuOMBNvHm9A198d65w7gVIlsjMBJr4UO7G3n7MQx/LKHm7J1W4dRNEEzcL5DxdD
 C9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687862028; x=1690454028;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0IvYq/eTwVhMM7BtqsALu/vlW2NkwCbzbDg+yL1EyQU=;
 b=Hdujw+T/H3MXjgFRDK06KyrLdBJSODc7EPCELe2HFomt93DoUuev3PDBTOsafn1hBG
 eLRQ3J1VvPIYru+zXC2kIg3lxK3Qm3NgVEk5AM75ftDyzFmUug6MB6xJyuY0qclu9cb0
 2rWf8YR93+jEptZhZFVGpI8jVK6dLx7Y4ZX/bU1bHpwz7V3pFYAWHsq96L7ATXJ9qKoX
 3hlYO709xPbK3X74CrQE+dbR/B0nNfClVf5tM6SIww43tuSaHUakgFEI5DYzj+oXt/or
 MaXAw3lO5YxY9Z9xJOTv3VYlxk/WNfbvv33M76QwOSS0DNn41qkiiid1y1i7idI92hls
 CDdQ==
X-Gm-Message-State: AC+VfDxWj3QohoDypUM1J8d4ANyfGat4fUkZAQ7V55/fdMXzAn7woquM
 6MxoMUOQBxbN6oyrHrGwlnMC2A==
X-Google-Smtp-Source: ACHHUZ62451G7DW+nGq+wclHpzRvtK2qirCppt9ZUd3HU/0OOIS0LfGGZoTuB7CxUNWcoK0TkgOEpg==
X-Received: by 2002:a7b:c5d8:0:b0:3f1:789d:ad32 with SMTP id
 n24-20020a7bc5d8000000b003f1789dad32mr35429554wmk.11.1687862028607; 
 Tue, 27 Jun 2023 03:33:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003fa74bff02asm10247132wmb.26.2023.06.27.03.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 03:33:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E71611FFBB;
 Tue, 27 Jun 2023 11:33:47 +0100 (BST)
References: <20230623035304.279833-1-npiggin@gmail.com>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Matheus Tavares
 Bernardino <quic_mathbern@quicinc.com>, Taylor Simpson
 <tsimpson@quicinc.com>
Subject: Re: [PATCH] gdbstub: Permit reverse step/break to provide stop
 response
Date: Tue, 27 Jun 2023 11:33:42 +0100
In-reply-to: <20230623035304.279833-1-npiggin@gmail.com>
Message-ID: <875y7919f8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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


Nicholas Piggin <npiggin@gmail.com> writes:

> The final part of the reverse step and break handling is to bring
> the machine back to a debug stop state. gdb expects a response.
>
> A gdb 'rsi' command hangs forever because the gdbstub filters out
> the response (also observable with reverse_debugging.py avocado
> tests).
>
> Fix by setting allow_stop_reply for the gdb backward packets.
>
> Fixes: 758370052fb ("gdbstub: only send stop-reply packets when allowed t=
o")
> Cc: qemu-stable@nongnu.org
> Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Taylor Simpson <tsimpson@quicinc.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

