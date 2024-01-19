Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA28328B4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:25:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmzP-0006uF-0T; Fri, 19 Jan 2024 06:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQmzM-0006td-6K
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:24:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQmzK-0001KV-LS
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:24:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso7337885e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705663481; x=1706268281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ceRoHLSpu6njO5KXwFRSZTbsHghvaqyS8HbxepJdf/s=;
 b=vmPooluPjBGMfveZiZabRCTyLc2XC31O7wlpZXc9IEoNZAPl1sSQQI+s8Rk70mlXKa
 rJIa7idpOwPmAkvuJd+LMKAzNaNktrWdeuABqA8darG2fUAMkz2LjEdtKvUPcw2jr0yU
 icUp91EBKGL0lB8ddT4+Gb+ZGPNqQ6emQKAM0duqn8pscYU1wppayqFMyKeNsO6nnGf4
 4MlyfC+PgRfij8rutK3NTBrel+OR3IGzpZDVsoJVhxSDlc+v5uBRdgKbNmpdxqlsUKhE
 KOcoLBnmxAXHEM+6/kW4kSLzlz/JLNTq9mvxZWbMvNTt8gLeMSIuMWQNg9wxyg754vu+
 ONEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705663481; x=1706268281;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ceRoHLSpu6njO5KXwFRSZTbsHghvaqyS8HbxepJdf/s=;
 b=e0e2l/YjFpPR00U4aeWnpxyDYSYHIWg7pLIgyYZwP2OZQF9oSLbgAn5TjrdsstRbEF
 yy7B+dxvwc2S/4rmp3NbtrY4pzgqhW/Xr+I0M4DS+OWaUVoGxRWbAA6eBl7dedU40DuU
 lQQyirj88SyM5dieF2F2GmU1aI9WLvEY4xSeE5mxWJqDVrHEfzU1snirP7DfV6p5gHSP
 LGZVdYQFhfFN/npz42rVzcrFxUwE3gI7mf/HbiGCUdv9qrKtifwKp8rAYV1Am6q1o5bj
 xzPrsdn4TgCeoga4EoLaZbF3mG4OlRLzhT19W4FSPLmxtITo6EpwNov55c1b4G+xph8Q
 Ukng==
X-Gm-Message-State: AOJu0Yw41id32kZTYcmX+CwdZ8LdPgbg78PXvnRlrDLJ6TezEOO9PvlV
 nmawSijXFnvVWKhz002ZllK6LqcKz+VI5Ak2qa5QhhvpYenVbkqlbsJ5AQB7orHO8mx/hnKShyg
 V
X-Google-Smtp-Source: AGHT+IEk5QFTiccLnyb3mBfY1SGPwPuztQn40/Ulht9/53dxQanYE9fUg20LwhHzaUip3ckK/3CGcQ==
X-Received: by 2002:a7b:ce96:0:b0:40e:864e:48a2 with SMTP id
 q22-20020a7bce96000000b0040e864e48a2mr718890wmj.23.1705663480652; 
 Fri, 19 Jan 2024 03:24:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g21-20020a05600c311500b0040d30af488asm32646679wmo.40.2024.01.19.03.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:24:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D04B85F8C8;
 Fri, 19 Jan 2024 11:24:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Jan Kiszka
 <jan.kiszka@web.de>
Subject: Re: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
In-Reply-To: <20231103182750.855577-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 3 Nov 2023 18:27:50 +0000")
References: <20231103182750.855577-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 19 Jan 2024 11:24:39 +0000
Message-ID: <871qadh8g8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Convert the musicpal key input device to use
> qemu_add_kbd_event_handler().  This lets us simplify it because we no
> longer need to track whether we're in the middle of a PS/2 multibyte
> key sequence.
>
> In the conversion we move the keyboard handler registration from init
> to realize, because devices shouldn't disturb the state of the
> simulation by doing things like registering input handlers until
> they're realized, so that device objects can be introspected
> safely.
>
> The behaviour where key-repeat is permitted for the arrow-keys only
> is intentional (added in commit 7c6ce4baedfcd0c), so we retain it,
> and add a comment to that effect.

Well the key input all works as intended and looks good to me. I'm a
little disappointed I couldn't get audio working on the musicpal machine
but that is not a problem for this patch.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

