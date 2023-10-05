Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8177B9D57
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOTM-0004Zt-25; Thu, 05 Oct 2023 09:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qoOTI-0004Pc-6d
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:32:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qoOTG-0002yo-Cs
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:32:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so1316940f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696512770; x=1697117570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O0DPIUsshgMzg56U5gjGAa98HBP+wpMN6ZdMzffRyk=;
 b=smQmQa6uo1bkGAH6XyzKutFvkeR5xLvwZ0sfWjNdNH5KTSuTFLabqpviHxioNDzzWr
 C5/bw5WOv63L0dqHo3Tx2JU3spPq9nqrQRYxoG3C70KALfd4G1bXhibOR+/migbZnhie
 4bwf/6ihuaoaZPaBa8m6aia74Llv4KklyeHt6gfdOpvuMJjwL0yjDOijUAXamRZFDuIq
 Mo89+KAxE46gZiVjLcdC/pscTXE0L+0GQBDQ7ertPZrKZrkdRYRJ66TE/cwDS7XdPTi3
 koe2Tb/sa8r/SmmCikvHPgOsDy6uvteu98VxxdXnbabH6X84P1Vz8PSA4+/QoAfaGFI1
 aL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696512770; x=1697117570;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7O0DPIUsshgMzg56U5gjGAa98HBP+wpMN6ZdMzffRyk=;
 b=a4qokev02f7WiUZdg5043AcG823sNAtacuZ+vtNYaoaR1zBKrvnlXax9A4d6lE//rs
 r94GCkov6OcSSXCgNl8Ih2VUy3+4bR4kyjQNWuBtqGx7POxEOC3XNjDDJvLIsaZ6X9Q2
 M7+QqU5r/hW0w5pBw5OzUqITkDQHKZu4LV80L+ZSS4Rr90DMgDpOJWnhigtRaHlonuG2
 dZmzNyh705EG23YMVL9OXoqfSmVsrYaGiMd3/XhCh9V0ZNUXbQTt+fj8BqR7MUjSr4XO
 ljWEgOTOBJphrHpdWwKY4U9IQvh9KOX56t7TKWG1eZzx624SmkPRXu69AGaJcvrFUsHg
 kHkg==
X-Gm-Message-State: AOJu0YyXG7MjA4uE7Z0+mNhWhak+T21X4Yxn7y8aLsgRG98+oKZ4yJPU
 zn2fU7MWyyKPNe5MQ1l2GHmAxQ==
X-Google-Smtp-Source: AGHT+IFA57HOw8cwPiEHEpJ1fbr3f0uT0A6PQ1yZEAhj8Xcp5z4wpyNt3MmPrb5aRmnHbTLzr7xhtQ==
X-Received: by 2002:a05:6000:1c6:b0:320:67:1887 with SMTP id
 t6-20020a05600001c600b0032000671887mr1319925wrx.28.1696512770679; 
 Thu, 05 Oct 2023 06:32:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a05600010cf00b0031912c0ffebsm1820437wrx.23.2023.10.05.06.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 06:32:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 378E31FFBB;
 Thu,  5 Oct 2023 14:32:49 +0100 (BST)
References: <20231005062610.57351-1-philmd@linaro.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] semihosting/arm-compat: Have TARGET_SYS_EXIT[_EXTENDED]
 return signed
Date: Thu, 05 Oct 2023 14:32:44 +0100
In-reply-to: <20231005062610.57351-1-philmd@linaro.org>
Message-ID: <87v8blfb3y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Per the "Semihosting for AArch32 and AArch64" spec. v2 (2023Q3) [*]:
>
>   6.5   SYS_EXIT (0x18)
>   6.5.2   Entry (64-bit)
>
>     On entry, the PARAMETER REGISTER contains a pointer to
>     a two-field argument block:
>
>     . field 1
>       The exception type, which is one of the set of reason
>       codes in the above tables.
>
>     . field 2
>       A subcode, whose meaning depends on the reason code in
>       field 1.
>
>     In particular, if field 1 is ADP_Stopped_ApplicationExit
>     then field 2 is an exit status code, as passed to the C
>     standard library exit() function. [...]
>
> Having libc exit() is declared as:
>
>   LIBRARY
>        Standard C Library (libc, -lc)
>
>   SYNOPSIS
>
>        void
>        exit(int status);
>
> the status is expected to be signed.
>
> [*] https://github.com/ARM-software/abi-aa/blob/2023q3-release/semihostin=
g/semihosting.rst#652entry-64-bit
>
> Fixes: 7446d35e1d ("target-arm/arm-semi.c: SYS_EXIT on A64 takes a parame=
ter block")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

