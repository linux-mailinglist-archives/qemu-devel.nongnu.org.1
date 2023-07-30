Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 266937684C0
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 12:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ2v3-0005ix-W7; Sun, 30 Jul 2023 05:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qQ2v1-0005iE-R0; Sun, 30 Jul 2023 05:40:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qQ2v0-0003dU-7Y; Sun, 30 Jul 2023 05:40:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bbc64f9a91so29775105ad.0; 
 Sun, 30 Jul 2023 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690710052; x=1691314852;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLNIFhfa5aiopLQcvSuj6cVdFcW3x0hnA5OZqItjz4c=;
 b=jrU+SXta/+FsN/uj/70x86x5PU9KbmGxbi1rqhS6XeArqdIyyZPGO0MNQoEhuaIHD/
 tXdErYWgnJnnH1FQl6VLcE7Sou9DlG57XL/P7DgNYExWEiUIwqntqvQlNdvgbA22xcxD
 C8CsarfnRx+MuCFUcnRtZ4MijYm4f2Kqx623X6rLLTHAUZQyP57lEc4h8YwEEI8fW2el
 W7PoNgy51hzj4G29X+heoBQ8BmBUrYnoPhW0F2ySQ5uo0DJXOv60A9NcKNDYrMb9eum3
 RoXoRxMm5MmLYACK+suivdc7YoUKpYAqZRqmxdPMha9ys49mRhN1DetlGjTF1afDDjSc
 U4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690710052; x=1691314852;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YLNIFhfa5aiopLQcvSuj6cVdFcW3x0hnA5OZqItjz4c=;
 b=exF6tgteW39+pdMQLOJar+ufdjbsfD1VgBsOlspwtUA/+xvzh5sVrbom8ufZiIvTfV
 O+OxNE+En4AiNyfZouaKJpfhhSm3mUnew6+NNgJCPKjDK/HBBN3pRF5GBEnjpyuJvjKd
 hzrQTMysYpQkMSvr5kKnfdaA8dmlnXcK1vDvH4sVVrFJ/L3MTazzIoS/MVOJ6xCXaoH6
 C/LnSKe/d+G0RmuY2qnVlgc8+DCa7LoBxZv08qANn+hgoet9aMAaEIQ18cHt3ZR8JOt1
 HNAF89if/FS3vhF1tT7Pn/kHk+hHUsOua2Y56aVZMOWP9Kw7iEKTF62xSzyS+gtcJx6a
 9OQg==
X-Gm-Message-State: ABy/qLZOx4rqtstnrOmysO0sPKbeTFXYqUYGeQy2wpYKUKzV/W6JFeb3
 tTkELoCtmHHI5T5QNETT5Ws=
X-Google-Smtp-Source: APBJJlEjdvX+SCRS4b/0qbUzcVe77tinKEjBJk4M2B5fIV0S0BgGuswxJXBO12IMfKn1xg/BAYsjvw==
X-Received: by 2002:a17:902:9b94:b0:1b8:b5f8:c485 with SMTP id
 y20-20020a1709029b9400b001b8b5f8c485mr6666290plp.50.1690710051634; 
 Sun, 30 Jul 2023 02:40:51 -0700 (PDT)
Received: from localhost (110-174-143-94.tpgi.com.au. [110.174.143.94])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001acae9734c0sm6387243plc.266.2023.07.30.02.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 02:40:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Jul 2023 19:40:45 +1000
Message-Id: <CUFEOWJA6156.NJED7GB1RF8Q@wheely>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Cc: "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 5/6] hw/ppc: Always store the decrementer value
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230726182230.433945-1-npiggin@gmail.com>
 <20230726182230.433945-6-npiggin@gmail.com>
 <8d485d17-2f96-8517-6607-7344d0aa178c@kaod.org>
In-Reply-To: <8d485d17-2f96-8517-6607-7344d0aa178c@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Jul 27, 2023 at 10:26 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello Nick,
>
> On 7/26/23 20:22, Nicholas Piggin wrote:
> > When writing a value to the decrementer that raises an exception, the
> > irq is raised, but the value is not stored so the store doesn't appear
> > to have changed the register when it is read again.
> >=20
> > Always store the write value to the register.
>
> This change has a serious performance impact when a guest is run under
> PowerNV. Could you please take a look ?

Yeah, the decrementer load doesn't sign-extend the value correctly as
it should for the large-decrementer option. It makes skiboot detect
the decrementer size as 64 bits instead of 56, and things go bad from
there. KVM seems more affected because it's saving and restoring DEC
frequently.

The fix seems simple but considering the compounding series of bugs
and issues coming up with this, I think it will be better to defer
the decrementer work until 8.2 unfortunately.

Thanks,
Nick

> Thanks,
>
> C.
>
> PS: We should really introduce avocado tests for nested.

Yeah agreed. Both for pseries and powernv, ideally.

Thanks,
Nick

