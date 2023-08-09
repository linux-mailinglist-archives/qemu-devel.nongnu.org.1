Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B709775634
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfHj-0006RJ-8T; Wed, 09 Aug 2023 05:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTfHh-0006R3-Vp
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:15:18 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTfHg-0001Le-GQ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:15:17 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9bb097c1bso100705021fa.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691572514; x=1692177314;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8UBIxCcn3jhYFPdbmQhP4c67bHPjh/F9tN0g625FZw=;
 b=Eim9qHM7el67vdreyCuPE/tPfJb2Lv5ibxbNXIbn2zj1deZ0Ub7Nf0ASbiX34K5JXg
 Fjb9x/qFsfeTEXXIriKq27wNp4rDWZzqsVOTLzNcmHNJv+GqCjrePUj555VRfiB3YWVm
 dIWHlPkRN3qW/VOP9V8d12VBlMman6nAM03e+YrOh4XyDLNUm7tIZXRsWpDFGBRXQfqo
 uzw0ehSqFUI/q5COz7GvUzNMe6O4Z3W0u4akqwqTtIV84Zh7JlKa6WWRbo5luax64aQ4
 DCwBVgwdfpnrEiWsuzYeD+qRP1UqlUDD3MfRy5LJFh6kcsJq56T49VWa2qLhjknlRwPl
 oWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691572514; x=1692177314;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q8UBIxCcn3jhYFPdbmQhP4c67bHPjh/F9tN0g625FZw=;
 b=i8O4a+3YZJjndarun05HlZExX0+Wi9lTD7okzfiJ71KfMBEiq6fRKaBU9Hf6PC52k9
 46gQ7944/1WEYga+tU7Rn+m1PALA1MrgDVK3oHXuZiPylH8n+/UhCOxv51ie2DPcfOtX
 V10c1jKo0IZwnmRUbqOuc2x3IF6swrewGgZv2ri0jU4VzDtWTEBvqR6jjQ4lKazRYlEv
 BqW5s5/B6FKn3Fhd0a9UfaN4dzkQ2K/PP1MiVIeEVSxktCo3hbaAbfjFNsE62/NwvAcs
 gZ4RjND0nOCVpSkRuvQxqiaZiCpmq5xsg9aZy7yrmcpIQoxcNCacld2MyIF+1S5FNlp1
 2+gg==
X-Gm-Message-State: AOJu0YzDceamD1q3ncRfCGKtW2hSc2WE2zI0ELPqYrAH+J9N0v50kUxx
 UitehmXbeZYKlJAydIJ2tyHm4Q==
X-Google-Smtp-Source: AGHT+IGUznxscP9QwAgeovkka1PlWfZNpyYpUtya6+sqR2VJ0Kg7uHZuMxSwSc9AwN7PLPUFggZRyg==
X-Received: by 2002:a2e:884b:0:b0:2b8:3ac9:e201 with SMTP id
 z11-20020a2e884b000000b002b83ac9e201mr1342732ljj.40.1691572514361; 
 Wed, 09 Aug 2023 02:15:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a05600c2a5400b003fc01189b0dsm1352978wme.42.2023.08.09.02.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:15:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 832E61FFBB;
 Wed,  9 Aug 2023 10:15:13 +0100 (BST)
References: <20230808025542.50392-1-richard.henderson@linaro.org>
 <20230808025542.50392-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] linux-user: Split out do_mmap
Date: Wed, 09 Aug 2023 10:15:08 +0100
In-reply-to: <20230808025542.50392-2-richard.henderson@linaro.org>
Message-ID: <87a5v060gu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

> New function that rejects unsupported map types and flags.
> In 4b840f96 we should not have accepted MAP_SHARED_VALIDATE
> without actually validating the rest of the flags.
>
> Fixes: 4b840f96 ("linux-user: Populate more bits in mmap_flags_tbl")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

