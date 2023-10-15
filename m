Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 598527C990D
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 14:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs0h8-0001II-B3; Sun, 15 Oct 2023 08:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0h6-0001Hy-5R
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:58:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0h4-00058H-Nq
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:58:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40675f06f1fso28824215e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697374685; x=1697979485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0t3nExzlleSESMTcwq4nMAvM+u4j7Nu+fH59xqR8wo=;
 b=q2hhfeuNIXw5pIb6ZVQnHpmWMJFTaZXykBduArr2YFdsi+Z3ZHx0QWZAqYCHJZZyTO
 3rbMggPspKOg3MwHqEIGeu0RPpAVBzMRFH+F8sx1hPSEMQCY58t5fPob2lvgJ+dHNWtW
 Yz6SrDvn4Kj8cw5+jzfQkjH4SVtQyxxbalqIApTqaVPOsLUEEaOtY7yZCdIekjvv6UW/
 UhGfm7A7yoE6y0yZI5zNmI+SXWvEUOpyovnGYPxUk9WXC1afYPTp1TP+CH2IVQ5OkwyP
 TdDEo06DNTYDZGhqVPoYxrzsjD3PyTsQNqdrxjkBMyghVo0f4faVrMhYyGpPCUBPcuCI
 lZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697374685; x=1697979485;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K0t3nExzlleSESMTcwq4nMAvM+u4j7Nu+fH59xqR8wo=;
 b=KEapLYkuOV9XLem6j8YSJfPtqnUI/zfuvrXs7qjr9yaVU/v8XKWPcDJFbMzKlv4v0Q
 53vBaG3l6kZ7ECuyxFg+v+GMqH4HJ8IQrtD7O9zUKmcOCWMXuO3n6dlE+yPdL/jwAJSg
 C2U5GSQgyHc1t3Gg9IhxGo9WZOMTj3xj4USIN1pVyIji+ixuxEIRpVWCj3pgb/fYj8jG
 Ryypq8t27tk1hLq3NG2V/cBYHOzNJMi1P0UQYIxZ4iabzAOwaPVnZtt+QWiPkvzBXSCP
 CIjy3GIARG2j4mBQsV0sWLGj8DwoIhLRGHw3l+Re1h3iGLd0w/CuY4pbLTvbvIAfWB3x
 u0rw==
X-Gm-Message-State: AOJu0Yw/+ihg76wNwVPoFZJhD2P1Ag+FTrQ/LKBQ6JYefgAZgMm7ku8m
 9OkJUFrJmHqSnb/JzwbkaCwDHIs0e5iBwLrnllE=
X-Google-Smtp-Source: AGHT+IFYt03XA+vqb+GQ69hTGUzVKkCDfDbD+vb2hrCOC8ucJRikEioITR3FHbEyF0aR08ZCbv8kAw==
X-Received: by 2002:adf:e745:0:b0:32d:a2c2:bad with SMTP id
 c5-20020adfe745000000b0032da2c20badmr3542734wrn.2.1697374685004; 
 Sun, 15 Oct 2023 05:58:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a5d4482000000b0032d8eecf901sm8862238wrq.3.2023.10.15.05.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 05:58:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A2EB1FFBB;
 Sun, 15 Oct 2023 13:58:04 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v17 01/16] accel/tcg: Move HMP info jit and info opcount
 code
Date: Sun, 15 Oct 2023 13:58:00 +0100
In-reply-to: <20231003183058.1639121-2-richard.henderson@linaro.org>
Message-ID: <87jzroxctf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Move all of it into accel/tcg/monitor.c.  This puts everything
> about tcg that is only used by the monitor in the same place.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

