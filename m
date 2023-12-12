Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687AC80F36F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:44:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5rW-0003Kk-3v; Tue, 12 Dec 2023 11:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5rK-0003Jz-6m
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:43:50 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5rI-0004d4-IQ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:43:49 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-551d5cd1c5fso654940a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702399426; x=1703004226; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80mMrq9q6tWkSoQQCypb8VG9fAJ9L8n8T1QsxloxpqA=;
 b=lOFzVAeZ0OV8Wdbw+3ZnUyjhOF+WXNsyyvfpbfJiwmlVx/HlibcHLHWEROElQju6wj
 r6XxpBm4lqtson4yolY/Cb+7kBPO2kNrdFWnkFUv8Zm/4l41pQpHh/nQnIjzG+Ow0gwW
 fiJuHkxd0TeJx9TDWaLnOcoGe59noPtzbB/Tb3XRCb6xPK5rzVdRzVipzOfgwAz4IIkf
 tZRjQfq/r9+HpVkCzFhfpXC4yESJV2oStznJQqKDkxIFI7K05IQVXbPsTqE130/crCu2
 E6ybvoYy4WGQx957eHergWGUGpM8ZRsfDHx2CYY7UuWL2wbsjGlF43LvnEadZ9G7PkTp
 Rv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702399426; x=1703004226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80mMrq9q6tWkSoQQCypb8VG9fAJ9L8n8T1QsxloxpqA=;
 b=lyrA6XoXT4kvxh2fi99ZQy8XGy+osmC/bkPXqkJJZK6A5wgnf8Q0sktKE5IJKP+N91
 n54NKdkWh8oYFSoKOEhUxSL/WRCZ/WXzc2vanaU2lZ2Puq9xp605iEu3lMpFIS61S4g7
 dEJWG6rqEcAJUDZCVf20q+ht9ZDt0uOJo+8ikv4DfwqY++9p1e/gb9g7oJO8UKmJlnw3
 0ot23xrU63Rsqh2w7EvJ2CFapV7vsQ26j47TRcCflU94gq8LtPuAVcpD3qt3lxEf2AW7
 hgBLO5+d6ZGU7N3DyUMSU//ibM1VgUj2ngvBN8KzyvC3hqbeBxMr9RKPyQdLJ9Z6PCjR
 11xQ==
X-Gm-Message-State: AOJu0Yz/fHeVZkO0I2DSWFbJs/enpfQWe8eN5bk8ASv3FADuSgSjpRn4
 Xvk8qvYdn/YtzucXtpSySmlpf4K8ALMSsG7gCXM+AQ==
X-Google-Smtp-Source: AGHT+IFL0SNs/udt9ka79UgYlvT4OPMxRFdTEsoyoehQUKhoxM8x2KUsssnJFL8xVPgeflAv6bWoUt12kJIhna93/uU=
X-Received: by 2002:aa7:c484:0:b0:551:e56b:6e9 with SMTP id
 m4-20020aa7c484000000b00551e56b06e9mr184050edq.19.1702399425960; Tue, 12 Dec
 2023 08:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-3-philmd@linaro.org>
In-Reply-To: <20231123143813.42632-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 16:43:35 +0000
Message-ID: <CAFEAcA8Y30eetSWcQmrEiDS81cGOg3nLqh0DDXXcrjgTrUs8Lg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 2/8] hw/arm/bcm2836: Simplify use of
 'reset-cbar' property
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 23 Nov 2023 at 14:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> bcm2836_realize() is called by
>
>  - bcm2836_class_init() which sets:
>
>     bc->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7")
>
>  - bcm2837_class_init() which sets:
>
>     bc->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53")
>
> Both Cortex-A7 / A53 have the ARM_FEATURE_CBAR set. If it isn't,
> then this is a programming error: use &error_abort.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

