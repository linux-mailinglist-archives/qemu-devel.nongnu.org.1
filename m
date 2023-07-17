Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D9756819
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 17:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQFM-00009K-89; Mon, 17 Jul 2023 11:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLQFE-000090-Qf
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:34:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLQFD-0006Cl-70
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:34:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso48903115e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689608077; x=1692200077;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GscuW2O/rqCjfj+OBE3YjdekwMxTZYC8z/BNio7awpc=;
 b=ejpFZ1fzoYu9J9boXNHzVvVuPHhaPfAs8uocq0cb67insP0EftBb1p86cfmTcmt9Hy
 CK3Ftw/ZWPouf2IBVUpE7FA/Iqq4HJ2WG2ReAK+X7O56f/3GZ/VcJDqZH2QzChMViznh
 ko7xKi4focKHjc3hRugeGSP4gEC9le18UuVjEVoIxb5JRmfMnO7SjIQrQHyLuZGlxqlB
 9YgNZOa2cb+Lvb7UOsFsF0a6l3xLes+ViedwY1oIkXqoZosiijvsWy+mtTdLrdVeVuUv
 DVsz1DFbaBMtk1d9M9uKwl6pmo8UMmidj+Wrl1hLK5vS6oQ7Zu7lmQPbVFKMGpQTooZu
 BZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689608077; x=1692200077;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GscuW2O/rqCjfj+OBE3YjdekwMxTZYC8z/BNio7awpc=;
 b=SqPF4dYdle5URg0EJzO0urv4obyPJRGJVC46Obv43XW6zUWaB+gpZRyx/OuXAzbAes
 1qPRPfzzDOSZO13s3UDkiICOnxpkjs2dV4FMZGXkqdiRwNODt3+lSyQBQqNfipw3ktH8
 +4w5KW91pHtOdCoEaD+19pZ/4hFfxLsgn5pkULcwFyCic7/xhRAVs448X4yokji9hL0X
 m8JsYd+Afuq81n2FGIj3SLSh7Y0CqNJJAW4z0xaklMZesHPPPVKum+hqvPDC04kSQ9Sr
 Joc4Sr4Y7qWX3JWfeUNyfSkaXlG+VSGWH23GlRE5jp8eFQwbaLQvYrSIoGBIRMMiRHZz
 +Bvw==
X-Gm-Message-State: ABy/qLZ827urzQfYiruDSczNRsI08mb8eCoUVJKeTcF3OzBMcayaw1BY
 Zl5BRtgfEKO5A7RO/XT2DW0Ueg==
X-Google-Smtp-Source: APBJJlE1cXbhxSd5z9VIqSkDOI8JZUKeNctXC5foHZE8k3ZY4D6BUwD09MN/k2O3PWLZP2PoGem1RQ==
X-Received: by 2002:a7b:cd97:0:b0:3fc:92:73d6 with SMTP id
 y23-20020a7bcd97000000b003fc009273d6mr11194797wmj.11.1689608076798; 
 Mon, 17 Jul 2023 08:34:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fbdd9c72aasm62957wmg.21.2023.07.17.08.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 08:34:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87F321FFBB;
 Mon, 17 Jul 2023 16:34:35 +0100 (BST)
References: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
 <874jm2ya3g.fsf@linaro.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org, Richard
 Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] plugins: Set final instruction count in
 plugin_gen_tb_end
Date: Mon, 17 Jul 2023 16:34:02 +0100
In-reply-to: <874jm2ya3g.fsf@linaro.org>
Message-ID: <87sf9mwnzo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Matt Borgerson <contact@mborgerson.com> writes:
>
>> Translation logic may partially decode an instruction, then abort and
>> remove the instruction from the TB. This can happen for example when an
>> instruction spans two pages. In this case, plugins may get an incorrect
>> result when calling qemu_plugin_tb_n_insns to query for the number of
>> instructions in the TB. This patch updates plugin_gen_tb_end to set the
>> final instruction count.
>
> For some reason this fails to apply cleanly:
>
>   git am ./v2_20230714_contact_plugins_set_final_instruction_count_in_plu=
gin_gen_tb_end.mbx
>   Applying: plugins: Set final instruction count in plugin_gen_tb_end
>   error: corrupt patch at line 31=20=20=20=20=20=20=20=20=20=20=20
>   Patch failed at 0001 plugins: Set final instruction count in
>   plugin_gen_tb_end

I think some newlines crept in, I was able to fix. Queued to
for-8.1/misc-fixes with the assert added.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

