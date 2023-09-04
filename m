Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D88791955
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:03:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAA4-0007im-KS; Mon, 04 Sep 2023 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdA9v-0007Vg-CW
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:02:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdA9q-0008QQ-3V
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:02:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso15062005e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693836144; x=1694440944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4T7g4fym7DFHXHtphW05P/bbwA+qNUGucZ6Ib7wZVyE=;
 b=RzizSFO982ipsgfCGrT3QKfkk2ro+rCqurp/BIprHKaBPxk4fh5U1az9k2zNX7jw7n
 wihEifsIVhsOPSvXCRRftjbkIVOSTDYHF+yMhbRUMbHShlOf/UWCbWOURmsD/D5+CrDs
 6bGWt+Q5IF6feJKmOO93vqWEupWmZCe3gPjMHc+wPKhqsvApF86Wri71G5rVBFWJyqoK
 SwtQoUnD73Lj3830gi+Njq/GN/yrFXZjXqU2aQ2jXqqDOxQry9eqLNhNeOOMMA5RN9hK
 rq7onKn9BjLxF83wstnqsHjH/0gUUzj/1eTyxuiv1/HRm7cwQCiJQZ3YA339huvllBCX
 nmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693836144; x=1694440944;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4T7g4fym7DFHXHtphW05P/bbwA+qNUGucZ6Ib7wZVyE=;
 b=hdFEUUV57tB63DtFoNL2KrOKrfNOxg8sIjnswEY11sjARS6Afrn+mahGW3kEoNr5Mn
 +IwKmSqwIOc/GnSUse2Yq+ORGEDilWbj5nIf3ODmUdA87XsXyijZTpumyY/fxbZhoUqk
 mKCl8IOL15PkKQsLzYKRyqcGKe5mOGnc8JjHtTISOsWPyx1B/XC0QLMPS3n7elNL97U6
 PrRRpJiba2CWJZNmXJ+ia9iiqb0UI1LYrTrpuTASDOq4uqUdcX87suZ7M0OPtP1imWx6
 x8nMlN5gogkFbrwfJ4YSlEZpXPGBm0o4DNHNkC4tKbp7DXXfyoe/6FlY6PwLGuJH0dih
 1Bow==
X-Gm-Message-State: AOJu0YwxuS6kUx+TN6YVoAV9KgZC6yThqJid8VEPZy1MHczi9OlYHM18
 SfED8TItxCmKi8duJZSF9SFAhTXKKZE3/J+GbcA=
X-Google-Smtp-Source: AGHT+IFTuTlA3zquh8OgIzRxi5bvGGWayiR5NF5G3YyW+/FnqOrKP/REFdaoJ0JWM0b7Hv7WmdAjAA==
X-Received: by 2002:a7b:cbd1:0:b0:401:dc7c:2490 with SMTP id
 n17-20020a7bcbd1000000b00401dc7c2490mr7354143wmi.0.1693836144202; 
 Mon, 04 Sep 2023 07:02:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c025900b003fbca942499sm17418904wmj.14.2023.09.04.07.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:02:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 548001FFBB;
 Mon,  4 Sep 2023 15:02:23 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v5 01/20] tests/docker: Update docker-loongarch-cross
 toolchain
Date: Mon, 04 Sep 2023 15:02:08 +0100
In-reply-to: <20230829220228.928506-2-richard.henderson@linaro.org>
Message-ID: <87wmx6hw9c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

> Update from clfs 5.0 to clfs 8.1, which includes updates
> to binutils 2.41, gcc 13.2, and glibc 2.38.
>
> See https://github.com/loongson/build-tools
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Do you want this queued ahead of a vdso series?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

