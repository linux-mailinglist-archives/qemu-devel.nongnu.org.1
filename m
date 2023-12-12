Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0E80F3CF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:58:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD63y-0001DL-Ew; Tue, 12 Dec 2023 11:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD63w-0001CR-88
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:56:52 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD63u-0001t1-Lp
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:56:51 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54c9116d05fso8088109a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702400209; x=1703005009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qR8gziIv2UNheMz0M1zhqTx/v25K8xFMMJfI4pJMb9A=;
 b=NYk37VLIPyd9EN7UzqA3l5SRRp7HyJ7vsrt4gKTPTWoKLZUGV0kTkA2UemvKJAARo7
 /r+ojW0H2Bw+K8wcLFnBtFks+LAjZo52z7fd0OafJ1lykqlHQPbQL+FhMRrwYpw8i/Bw
 IAao0GjvPGQZegn9erQnPQKLHP1Pvq54H/qXw1qopk1SHiLf3vDbAIpwEgibjAdkm3IN
 68QJsfy8PKKTiRAH5qVK1YBLZddns9qTI/FEM61cBPvHKVVD2oZ/c1vRnghA6l0Ar6MQ
 iRDVqSWp+Z6V0o0TP+OrKNr06BJvhLU5bRngnML3v/KxOJH93Z5EH3nbIphMpm5oiDZ3
 fYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702400209; x=1703005009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qR8gziIv2UNheMz0M1zhqTx/v25K8xFMMJfI4pJMb9A=;
 b=LbrAkUNuQQGfG6lF1mEA9rvypLkcdhAKTjKIUNtwnM2AeFpP5+dYVaqQ/c2cOZ3doh
 QoSzWeJVmjJQbrFl0GweHkL7N989uU310h5X10OilAy3dH8QxVy247JRBPC0ATkan3jH
 +mAIC7HsaMhKhLtan5ZReA54t/J+FwqguOpqkklC4r5P/xD+zDRWyWQa1diJtZ9U6C7o
 EKRXnvVe/4xRpYCyDiVjbk4J1kj+jPPbr/t/41xMj0jIWnfhfz4/4/XIqAaszbEsMe/m
 kw0L9gjyUBcqosiMKtz1wipe1cv5f3Vc6PYf7U9TdsFmjBBDA999oJ1ajnclsYWekCgi
 wg7A==
X-Gm-Message-State: AOJu0YwP0ukfbyb7X/5W4ugp1IzVku6G78tL/osYhMwpfDs6LfIaagTx
 /8i2MT/HqSAfGz73K6smgbrVZWDj/PrQ263+8/xsJg==
X-Google-Smtp-Source: AGHT+IHT5coyk8GGQxue/YNqyV1KrdbrfEamqHpHAPVhBIqIttA1C4FZsuNa+dE4XxXBkP2MOGw55OJh3TF26uxvL5E=
X-Received: by 2002:a50:9b5c:0:b0:551:8766:7296 with SMTP id
 a28-20020a509b5c000000b0055187667296mr414921edj.105.1702400209257; Tue, 12
 Dec 2023 08:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-7-philmd@linaro.org>
In-Reply-To: <20231123143813.42632-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 16:56:38 +0000
Message-ID: <CAFEAcA9tP+Opy0MHtHtpZa2q=ktY5vVaGZDFfMxatjT+-7E1xA@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 6/8] hw: Simplify uses of qdev_prop_set_bit(dev, 
 'start-powered-off')
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
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 23 Nov 2023 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Simplify few qdev_prop_set_bit("start-powered-off") and re-indent.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

