Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A410373B6E3
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfZo-0003ED-8Q; Fri, 23 Jun 2023 08:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfZk-0003Do-Uo
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:07:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfZi-0003uJ-F8
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:07:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-311099fac92so681490f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522056; x=1690114056;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iorXlS8LHZdDIQFKq7cbqC1Drj4eqgJ051YcpBwHNU=;
 b=rljwzHnTODi4Rn5QypTx/Z+rG8+KXEZ5RMwnKmhMoeYe9W6l0HUaEp+bOzPlbsR5qE
 ZWObQT9C/IS6QLl7KorV1Dw6TWPksBCA3K6LnDYjAAY51DcQTA9gJzE5/310z8rsbSbR
 u4v2UGoeQDmqfBDSro5qro3ghLtejm4J+amvJMF9/utf9sHfYnKVeuwOzslueU2m8VEt
 m6nTe+LFcx5WJrr9XjsrdE18VMCrVzX/f1A8WqUDoJAqOzjYlduFmxXDYRM46G28KqIc
 iu/3rIuiLkIuv6HusB63sW95jNb4UF7AqqBZaZx3w2JCR/dRlW3Z0CrwxwSyWP844vAM
 B9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522056; x=1690114056;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2iorXlS8LHZdDIQFKq7cbqC1Drj4eqgJ051YcpBwHNU=;
 b=Usey4O9xV547Vkqo7Ha80SH61SpkDYxWopY/ZBmnmp3vQIDNzdR4qtAtCaPCYmqhlB
 xfXlAJrNg0Bq+f0jREp7nJavj0ynNZgunHg5Y53tli7aZbD+4ug06YcbkES+T0f81Y1i
 QJoF46J5a5OtzZPvCNOyK8Y+zlWm1UPtpkPHj/ycEeV+ko6+Rp0tJ6nFFLFTdIzI9vyb
 ro5yw2dQ7fG17U0D+EG4q73lnOzFZ3B1dxL/vvoja9HJssBL6bBSW9l8bdYsMb6orcmj
 vhzOUl4e7SzLS7RykVN3676CmH9EqHVgS0Rnj1ySkpsduG8bDHdY8sR1yX6U2irZBG8X
 7sjg==
X-Gm-Message-State: AC+VfDz/+jIPjLIH3SW63KeL/NcrYKxX9/aPCI5vRGB6W7ekd6trx808
 GjuQXDrpmDK0Zt9Cs76zzgcBpw==
X-Google-Smtp-Source: ACHHUZ46GwFKo4SRjUG+64Vai3p17JEd+6WiHg6vQsiyijh8CTXipFJiIymWkN78WXkcgOqOd/ENdA==
X-Received: by 2002:adf:ef8d:0:b0:30d:f75c:4a68 with SMTP id
 d13-20020adfef8d000000b0030df75c4a68mr17283137wro.34.1687522056534; 
 Fri, 23 Jun 2023 05:07:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y10-20020adff6ca000000b0030f9c3219aasm9343472wrp.47.2023.06.23.05.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:07:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C69701FFBB;
 Fri, 23 Jun 2023 13:07:35 +0100 (BST)
References: <20230622101717.70468-1-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-trivial@nongnu.org, BALATON Zoltan
 <balaton@eik.bme.hu>
Subject: Re: [PATCH] docs/devel/qom.rst: Correct code style
Date: Fri, 23 Jun 2023 13:07:28 +0100
In-reply-to: <20230622101717.70468-1-philmd@linaro.org>
Message-ID: <87bkh6fkl4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Per commit 067109a11c ("docs/devel: mention the spacing requirement
> for QOM"):
>
>   For a storage structure the first declaration should always be
>   called =E2=80=9Cparent_obj=E2=80=9D and for a class structure the first=
 member
>   should always be called =E2=80=9Cparent_class=E2=80=9D
>
> Adapt the QOM rST document accordingly.
>
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to docs/more-qom-docs, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

