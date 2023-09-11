Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66D979A722
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdtq-0005tA-RR; Mon, 11 Sep 2023 06:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qfdto-0005mX-G0
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:12:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qfdtj-0001Cu-9N
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:12:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so4190588f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694427119; x=1695031919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deWfsNYYceWrgp4CDST4cCra1hkSRfP6AgafYPSv7Ic=;
 b=gle2pp3cHczHPbizpvjW30nBInKV19lABFNes6COk8VAneoieh9IhgCs9co4aiHSBr
 PHMToGM5cQqj6uHv03wK93B0oENWB1fseeyY5Qzdh+bsoOseO8idIA+e3QQTjf11WtRX
 JEqnHuJjjem82pO9w+89uL9p+ysGx5/reswuhB7Z0ARw9m9ZOheLL5ymO05XfimfCsUH
 SfbbJK7AChnApSrXWyZ1GCuukj7GOSt6twdCmr1ZQEqSF9dl00c+ZIMhP0LOHIUKtos/
 a7EgmIRwtk8HYpgTDzJlcZzI+9ng8fCKILG1KArDgLPFnhdiIFDUeesudwRNR7Qv/MhW
 F6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694427119; x=1695031919;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=deWfsNYYceWrgp4CDST4cCra1hkSRfP6AgafYPSv7Ic=;
 b=u6eublyr50edAshd1EeDjCEbPjBNzWgs4OWo/lGgMSFmx4/kw7zH1gzmYOGrnRq5iM
 JGXCOlW+tz5RNCACRLd4GY0vq3qE2j1kP/nWIUYbhEEvZyT9jX7LvgiK+xWhhDHjJSso
 jzBU5EmI2MIoRchOAxdfTOEo2/IbMkmwuyiCW5w7BLHAOCpdd2M8SEiBLf10pSL54vGr
 ExFmtI+IuDxjie4ig/LWKAt3VoXXY7K9c4rg+aQgoe0HBTYyXd8RAVu/OLIpNI7Q/R0n
 t4rBRKg5qeF2GZFAgFoblpYDdDH1NinL5zDRKmHR46Pa/rejZeaayQlE2RIr7h1jBhnq
 p8kA==
X-Gm-Message-State: AOJu0Ywgi+gdF4bp5vVlUN9NEOkDKeseKdCAXDzjlV7Iy4IzLjivOfqt
 r5CYkzHr5apz+kMKCdgeuT0vnsC7ZNerfakak68=
X-Google-Smtp-Source: AGHT+IEQZ3rHfWSYplPFZMhiM8sa6OnGlReB/aDNmoOzF1bhF1Bnyh87lpf0laCZ5gWf61C+1sjHdA==
X-Received: by 2002:a5d:55cf:0:b0:313:ef24:6fe6 with SMTP id
 i15-20020a5d55cf000000b00313ef246fe6mr7895793wrw.1.1694427119443; 
 Mon, 11 Sep 2023 03:11:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c044e00b003feff926fc5sm9504750wmb.17.2023.09.11.03.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 03:11:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACC2A1FFBB;
 Mon, 11 Sep 2023 11:11:58 +0100 (BST)
References: <a1f2b1ac-3d88-8e46-5a3b-f6df740bd418@tls.msk.ru>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: linux-user vs system build options and libraries
Date: Mon, 11 Sep 2023 11:10:55 +0100
In-reply-to: <a1f2b1ac-3d88-8e46-5a3b-f6df740bd418@tls.msk.ru>
Message-ID: <877coxow7l.fsf@linaro.org>
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> Hi!
>
> I noticed that linux-user binaries, when built separately (with
> --enable-linux-user --disable-system) or when built as part of
> system build (--enable-linux-user --enable-system) differ in size
> and link with significantly more libraries which they shouldn't
> link with.  libnuma, liburing, libgnutls, - that's what gets linked,
> just to name a few.  zlib is also there which most likely shouldn't
> be.
<snip>
>
> Also, which might be a separate issue, --enable-plugins seems to
> be in effect for linux-user too, which result in libgmodule being
> linked with.

TCG plugins should work for both system and non-static *-user builds.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

