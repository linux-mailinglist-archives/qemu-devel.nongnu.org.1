Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802280F377
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:45:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5sM-0004CX-Q5; Tue, 12 Dec 2023 11:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5sJ-0004BH-CD
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:44:51 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5sH-0004n5-KR
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:44:51 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55193d5e8cdso932033a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702399488; x=1703004288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOeQ83EtJ3ms2HhHMlNaTSs4RpfIIzAok2S/UMoUDjE=;
 b=hh0CDesy+1vNoXsmS6Uaq02kd+JeqY23T7CDSWWBMteIqhFtp4JeNzXOJJKRHJySFf
 /kTeibyTv1EflNfiNjQ6deU/XL6tcPJ+QKIpuaiwADtqUQQMyDWcgICRklTQMoMfTwWr
 L2Os1QfoKp/T5yGhRo0H7032S8mefvGm+EwGzON0bD6Pxj2aGSo2C+GJh6nTcqq1rN7B
 qwOjLViQrH00GyGgjq/wZWpjAqUVp6RntHz7XAYnjva8d8UIseRLFk+ENd//XXn5fL9H
 qeGuHNf6oo7Aj5a8WINR1TmVtphOubJhhYS1VuB2tg+rwk5cPGZK0IOPXdUrK8NIjzds
 4BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702399488; x=1703004288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOeQ83EtJ3ms2HhHMlNaTSs4RpfIIzAok2S/UMoUDjE=;
 b=sRVyUNjYgy/1jV71i/hxzmbzZLLWLaDhc2gjysAN1NpYu/87z/Zmv+/NR83JNe5YrD
 2lvb744eykpuy9P4ppd9P+DsdqXEsUDhHBg4+Lbr66TitESrJDPYbVm4EqUjrwyvm/ay
 ap8SD2ZoxxnV00v32tcX6haW/UqCSX4R3x8eNQfq+9wxrk0EBwkJI5ukxVj9oyerwWoW
 ZZNEnUALWHycd/SVwaNIHJyVxU1xowtI4hhEPnZxZV5DliuPlX6h4xhVBXJM9vckMOAe
 FUP0jdVWCJaKekCJAon/skDSdD00+j3/sPEhLEhc7geakvdsn3DPqlxP1L1WiDt0REa0
 6k2g==
X-Gm-Message-State: AOJu0Yxg8LiwhU4yK4FFhJ9SUcJSbXv9stMX7sfWxfoo5L2OWVGEWfpl
 INHfckeRbVNORKvG6scRmNdeFrIr/mTDBM7qhM7MCg==
X-Google-Smtp-Source: AGHT+IH/OX91HcKzgIjNipQedBCkTigCwLbtBIsq/6mmfP8OGAmmaYiadrTUv9eTZTdLioWh1gfity9NGVUAFgNAzys=
X-Received: by 2002:a05:6402:2227:b0:547:9f26:e581 with SMTP id
 cr7-20020a056402222700b005479f26e581mr3153838edb.37.1702399487970; Tue, 12
 Dec 2023 08:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-4-philmd@linaro.org>
In-Reply-To: <20231123143813.42632-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 16:44:37 +0000
Message-ID: <CAFEAcA_wxzio-UDPLzEgMoZoBvQBqjUnHNsF+kYHiBSY-m3jOA@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 3/8] hw/arm/bcm2836: Use ARM_CPU 'mp-affinity'
 property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 23 Nov 2023 at 14:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The 'mp-affinity' property is present since commit 15a21fe028
> ("target-arm: Add mp-affinity property for ARM CPU class").
> Use it and remove a /* TODO */ comment. Since all ARM CPUs
> have this property, use &error_abort, because this call can
> not fail.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

