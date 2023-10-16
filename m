Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 103247CAE86
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQ8w-00009D-GM; Mon, 16 Oct 2023 12:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQ8u-000094-2E
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:08:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQ8s-0004TR-BR
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:08:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53db3811d8fso9722060a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697472508; x=1698077308; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B64LMSSe9T+t4aLv0xTa8ZKx3EyvHd4zsJH0F4FMPkg=;
 b=jBHzIZIEC5xH9os3FNRS0nnH6ueUVQ09ZJ9sN8XAzCMExfr/B/McN0l3WnsgII4TFe
 aNgO/OchnTUMQxa077DCb8R/yYxVc9VLh7Zmq7nSfpKaq/WU6PcRshOK6ae4Dhitx2qg
 vEE4mA14kzHAvcbQyl/jpK9PlD3fIq1EYdea7j+2SuIyDpZswLn6PsKlkN4csQ4YrXsn
 CigOvYdUccW1LaUkU1ucx1xvzkRozdNepxS1yMaHUEo05eH1BZjFcNrOr0g/Od/c6/tK
 sfibDZiiBB3vhi22mrXAyUEBc0GkftJs9K08JevN4XqHqc8/Ayb8TC7QV5ybO7zpeQAj
 RR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697472508; x=1698077308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B64LMSSe9T+t4aLv0xTa8ZKx3EyvHd4zsJH0F4FMPkg=;
 b=HUDNeKmymj608UyB7DsGRom/JePQmTb33CvPEFQFv6z2O+WsDk9Tl3Hdf9lNk68ZdD
 KasrdtzFZQqxXBwZTQ9addx2ZqW4ZMB1SrLrwg5Fh6nVBh+yGbhCNoamhXyePJtWe6Nd
 70obyHNVr1JlpihqzWgY0XXiyW+c6auLtzM5jCYaPj1xx7UgCKlnDggazvSpGjq0spZk
 fqgwkjYkkRbxUZJyZX3tFZ6EzzZwwU1eMiBi8pZ5X7kn2f5rGuBhu5bIh05lIqc7lejF
 oTx+cJ4HQ6whrhms/G4U84jg4ytnpjk76kWjwAr8CGVAW2bqBCs49meNfAOwDrHaDgOA
 35/w==
X-Gm-Message-State: AOJu0YzKebcfaTyW26d5aA8etYQ4LzicbNAZrVMUcDjghCXrJsx8A7/x
 m8ggZ05U0f6mo8xOeRnwh/ZQfivbfBYI0QeoFYSpgA==
X-Google-Smtp-Source: AGHT+IFJu7QeUuOaTTZyMxiYAxzjO08Co+E2Fo3eJKPuLLIBLRaSwURyIiFDgdZlyV2s3aXY8M/Y+cTOpWk91BTMqXk=
X-Received: by 2002:a05:6402:5207:b0:53d:fc49:49e9 with SMTP id
 s7-20020a056402520700b0053dfc4949e9mr8085691edd.6.1697472508625; Mon, 16 Oct
 2023 09:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231005062610.57351-1-philmd@linaro.org>
In-Reply-To: <20231005062610.57351-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:08:17 +0100
Message-ID: <CAFEAcA_P3s07PpNeDVvy8xB7HLM5+Uvnv=NDycVWW3LR7iT_vg@mail.gmail.com>
Subject: Re: [PATCH] semihosting/arm-compat: Have TARGET_SYS_EXIT[_EXTENDED]
 return signed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 5 Oct 2023 at 07:27, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
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

Is this actually a visible change in behaviour? It makes
more sense to use 'int', I agree, but unless I'm confused
about C type conversions then I don't think it actually
changes the result in any case, does it?  Given we start with a
guest 64 or 32 bit signed integer value and put it into a
'target_ulong' (arg1), it doesn't seem to me to make a
difference whether we put it into a 'uint32_t' or an
'int' (ret) before passing it to either exit() or
gdb_exit() (which both take 'int')...

-- PMM

