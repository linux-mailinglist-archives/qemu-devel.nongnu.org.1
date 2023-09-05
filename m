Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A581E792169
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSHG-0007UN-W1; Tue, 05 Sep 2023 05:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdSHE-0007UC-5y
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:23:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdSHB-0006Qr-OV
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:23:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so2003119f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693905792; x=1694510592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UeRMQChd6iwyQK9sBxY570Is2u17lLTGs0zoI0yITM=;
 b=kiqdbHbf8yEd6pJaV3TdEvOCpsFJX/h2IvUERrV+gE7F9H0raK9uBMSNPD+9xzQ/47
 gGTMcDaR2qahxxec9thmAr/ckdcnmF2BQ3kWTqeTKI/E5ovSGmdQ1FD+TgPNz3sQMIVX
 KzduY9GpaWjHUvwQroaA5iqcGT2DWciC3knhZeY3VcTVwbeEE+ijeFDvQl4Vgq4SE7NA
 NdiIojQ2szwQGo73qTgIl+39tVe+sECcTTWsV+ZoNr2sTIqFsD5EgdwpnvjIlmjpGbkG
 tHV3/3S2Cd8Q5FkCU0minj8VGsVDErL0ps8pV3DZ6p/iDJleT6k4zx4jY+Y0Z+31lcwW
 u2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693905792; x=1694510592;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3UeRMQChd6iwyQK9sBxY570Is2u17lLTGs0zoI0yITM=;
 b=JhdMs/Kw6I2Ccz9P647uWQmTCHF9xXhUnwlw0FzWkP3xerIa8GfAdRUU4FAdIq2tbm
 moZbzhpxySAO797256/O7bseQRlXXcelK1AsuKuoo1bRMfwJh3eKmJjJQ3ahgj8jELWW
 wW+4S/u5sTkvIqZLz63WTptd1hJWZMhQTtjRco2B8MfiPDYq36yV5OWrjcayMU978WW/
 PQlMPaIuLgXtYuuN11/u9tRpNDu5CU6Hkcjp8PG4EeM9iJHjY8U2etEzvSYt3NGQ+mkn
 wZ5OONXwbHlKiyUxzTzHCnj4eOtTvdWRBTGvfFrlE8qwpuemeCIbzeljmej7Lf5jZyN8
 +CTA==
X-Gm-Message-State: AOJu0YyUD02Ps8iceL31lEgApleKS3Rh/rwtqv1t9ZMR9BJn0mvnbLqp
 1xtU98F2ySdRuA1rpPCxeKioxkIEqdo6mCT6JPI=
X-Google-Smtp-Source: AGHT+IFpIB4sxex5fmznPLGohlUeco2Yeem258D7rvLQ7y6hCl7zy3UlbzPRzfouOTtOphfvIz22bw==
X-Received: by 2002:adf:ce04:0:b0:315:ad1a:5abc with SMTP id
 p4-20020adfce04000000b00315ad1a5abcmr8989533wrn.5.1693905791744; 
 Tue, 05 Sep 2023 02:23:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z12-20020adff1cc000000b0031ddf6cc89csm16764374wro.98.2023.09.05.02.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 02:23:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB7701FFBB;
 Tue,  5 Sep 2023 10:23:10 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v5 01/20] tests/docker: Update docker-loongarch-cross
 toolchain
Date: Tue, 05 Sep 2023 10:23:05 +0100
In-reply-to: <20230829220228.928506-2-richard.henderson@linaro.org>
Message-ID: <8734ztht35.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
> ---
>  tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tes=
ts/docker/dockerfiles/debian-loongarch-cross.docker
> index 9d957547b5..b4bf265717 100644
> --- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
> +++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
> @@ -20,7 +20,7 @@ RUN apt-get update && \
>          git \
>          python3-minimal
>=20=20
> -RUN curl -#SL https://github.com/loongson/build-tools/releases/download/=
2022.05.29/loongarch64-clfs-5.0-cross-tools-gcc-glibc.tar.xz \
> +RUN curl -#SL https://github.com/loongson/build-tools/releases/download/=
2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
>      | tar -xJC /opt
>=20=20
>  ENV PATH $PATH:/opt/cross-tools/bin

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

