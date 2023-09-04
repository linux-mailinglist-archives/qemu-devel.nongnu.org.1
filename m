Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A43791BA8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCVN-0000kw-3H; Mon, 04 Sep 2023 12:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCVL-0000jb-0W
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:32:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCVH-0003Kq-04
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:32:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so2247547a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693845160; x=1694449960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NPNHy6NEshjFV43jeFrEa3Ef5CXI6N8BOgdWbuM8wA=;
 b=fwKV7yYFPit63AcQ+FaQw2fpxNsk9OiMAiDD5pbjf97QZ6iMIuELl5Fm73WHGcHioN
 FDhHh9M/eFCS26wm4OUmyObqcAUQQuIKp7jswaj1VQqXRPJXeUV7y3aavmYAzWgBMA1/
 4ZKY02qbiYF4PgfDd8Ua8ERbCaTi6r8VONU/B/BmGhnKDsupGAZFKysxZIOfEmrNk77g
 jEnz6OKsDy2vgBDXi7t4NIKUI21zovauz35P1x+vcM+yJ/m1OBeqNpg8bguCbFUoT33j
 bibnEoclb5CHaBN7DrlG5JnxeIqH8VasbuplUvVG7mBIZPeJm5vapwnKlj5VZvy2QctB
 PRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693845160; x=1694449960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NPNHy6NEshjFV43jeFrEa3Ef5CXI6N8BOgdWbuM8wA=;
 b=Unyf+k2tfWOxVk2v6aIscO8CprKTp0okU8XoSrx2oYNyXbw0tMJxpF/0vNJ/+1YG9U
 MgDtpAtHVIM0cRM3j3rz3JqLKVqDwL6plijMBrZU7QJmAo2YN+qkj9gLihuUW4tmsGtn
 m9KbOup7UM7NtY3Yk8ApdOHd87tnqmZWapJdiuCgTym48UksiRvZ7yN5/tKv0BJe4g/l
 YvPI2no2iQv3Mc2ZPCC2gv9MAF2S3P+viAtwQPlWqsLqmT4bu4vmgqvpNj4XTs1P3Vqs
 81PKEFGZHKMXCNR7sBzf2NoL5HdqLngOq4yxIBnZsPFtUGscQ7HbHp+1D2m5iRmS2SbX
 AZew==
X-Gm-Message-State: AOJu0YyNNq43u32RUUgh3M4nWmUtTgg8F5TGmO3OLfhaanlHufoUdogQ
 +TQB0rG8bROpdiUJ84x6VG27SMZDW45xQy7ZmqDWpA==
X-Google-Smtp-Source: AGHT+IEtS2RqUYpqTrzDTYSipAX273fnWlL3ItMaI8foPWGaqswOL2SvHpZhBMgPOcwc/67LhcPOS+jJKaI1fEGeAMc=
X-Received: by 2002:aa7:c1c6:0:b0:52a:1d54:2534 with SMTP id
 d6-20020aa7c1c6000000b0052a1d542534mr7568484edp.25.1693845159773; Mon, 04 Sep
 2023 09:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230904162824.85385-1-philmd@linaro.org>
 <20230904162824.85385-2-philmd@linaro.org>
In-Reply-To: <20230904162824.85385-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2023 17:32:28 +0100
Message-ID: <CAFEAcA9O3CuXNXc2_VT+v8E+okDwdsNbKa_kqqzsk4W6EmV=Rw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/core/machine: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 4 Sept 2023 at 17:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   hw/core/machine.c: In function =E2=80=98machine_initfn=E2=80=99:
>   hw/core/machine.c:1081:17: warning: declaration of =E2=80=98obj=E2=80=
=99 shadows a parameter [-Wshadow=3Dcompatible-local]
>    1081 |         Object *obj =3D OBJECT(ms);
>         |                 ^~~
>   hw/core/machine.c:1065:36: note: shadowed declaration is here
>    1065 | static void machine_initfn(Object *obj)
>         |                            ~~~~~~~~^~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

