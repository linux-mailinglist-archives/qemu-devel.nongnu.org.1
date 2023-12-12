Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166780F3F7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 18:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD6AX-00069t-F6; Tue, 12 Dec 2023 12:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD6AG-0005ld-Qi
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:03:26 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD6AE-0005w2-5q
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:03:23 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54f4b31494fso9036420a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702400601; x=1703005401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Phr6MYUzkA8BOaldnWrA90ueBDuHxuNyYy/7GkyshtY=;
 b=aPxKle1Lga156W3K1CDSuHxQFc+wodIYoaG9lznDHCPzYsaL4rE9hbHLUHQbd+qstp
 gUEWC2oJDwdnAWAcl/iAmrabzFG7wDHrHDSBAN16kZHQ9AWyMV1NG5CLcPr87NVPPAwu
 QN/fE7E94yh9zr10lszmeKD27TQV9oaC0Y3k8rEyjQuTgmK0Wx+5tFRLfZVsJxPVzCrV
 GStXWGRhORt3oxG/49Lh1EcUCr4OVCPBAOwf4W66DBevf7oE2YJ2Sm0jYGXnfWKkgr0L
 3s4t7VbuQ9g2qye+r3qNkIB1r+Kd8bhz5Pyh+qpYclNM0PFViuqy1VjSO9wmANOL3X7T
 Dxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702400601; x=1703005401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Phr6MYUzkA8BOaldnWrA90ueBDuHxuNyYy/7GkyshtY=;
 b=NtlwRygeQBzAJC6W+nMGOIqK4WS3dn11nelPS/J1ZUqETMuWS+F4+YmC2aTf77W71D
 ItJvQBXn29S5WqsyfwYzVSIvsOfqgyt2fmdeMUJorzUHWGncY55ZAFk2vjLyme7SgN23
 R041tHeFv1J1IY6mmUiG0pVNSBNj4dKT0xy5RMYUof5y+FBJzlCXE6HBPh2fYuLBdGqo
 9pC8xiz/LW23dPTpXunSF6AdYIuQxUBD/L68AkLiuKAb9VIqqXKLQqtDiuihxKTYRBt7
 5itPH12a+PQxRcM/zsVnARGWveLd7jwsLgo8hwMwhFohJX9tpCxEtP/ucGuNiHNW/rhm
 AZrQ==
X-Gm-Message-State: AOJu0Yyi4EPwGqi9TitZiSwGwZcnRr0Df8VmoQANL+Ft9LPvZmS6f57m
 l1eQy27JCnyUs2oxAWjK1WUxG0l8kOg2lroF2nwfXA==
X-Google-Smtp-Source: AGHT+IFAFP1QOH4zficg51TcgEIhM6kgnb8x6HZKVOufew8w7w0OilrhjxQkhONTFQ2YPWG7T1q8WqijqOBahSMVe0c=
X-Received: by 2002:a50:d541:0:b0:54c:73be:dd98 with SMTP id
 f1-20020a50d541000000b0054c73bedd98mr6936470edj.14.1702400600790; Tue, 12 Dec
 2023 09:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-9-philmd@linaro.org>
In-Reply-To: <20231123143813.42632-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 17:03:09 +0000
Message-ID: <CAFEAcA8EegdW0YFsCF1YhypuSMtfRKpJP1HbA6TTJ_OxoLrE=Q@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 8/8] hw/arm/bcm2836: Add local variable to
 remove various DEVICE() casts
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 23 Nov 2023 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Cast the CPU to DeviceState once.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

