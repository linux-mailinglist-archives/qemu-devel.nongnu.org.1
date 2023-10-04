Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181317B7EF4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0tC-0000ZH-Pk; Wed, 04 Oct 2023 08:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qo0sx-0000YA-0p
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:21:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qo0sn-0003KX-CM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:21:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4054f790190so20762515e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696422100; x=1697026900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Q1Hjyqm/By4i5FfidetUailPz2ky3ORUxQp5Qs6yPQ=;
 b=bLlCKou8VGX28v1usX4fbUSwoEu9uljl/ycEzePGpvcgWAGGclHd/5wK8iYgWY4q+A
 puwUN3Jsa279YXuJwEktgPrnp3oCx/M8h5OyWRRPHHsZaBMZz6TCF1uM92QtDZ58IWzT
 sLfoQDmcjeH7fUVlLd7CmXqxEeCtmsXiWj5SjsIIO8QVwZMaDUk1W66HvsxlulrHt7qJ
 wbw+IbE8d46ZDzJq7kd4/1c7CFNM5FRifx9OyyEyewO5NVx6LHk6PUgWScNhVNl4lXpB
 2Eq02IH2p+Ix9gNiH1GwYc7BVng7Nan4XZu/LBVpGqaIZtCeE+QMEHgYul3hHuOX9QJ9
 Ryeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696422100; x=1697026900;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Q1Hjyqm/By4i5FfidetUailPz2ky3ORUxQp5Qs6yPQ=;
 b=peaMXym+fsemwLTqdoe8pR1+iPwq/msg2/YNn6j3WPg59RcYW1Fq33JhQD+Fu0YJPx
 cAd5TXqZJXm166lG0gyHdLOSyb7hk71lc5I541wiyQVMy8C2yYwNBEQ7SwOzHwl0e53q
 q5+s0ArOUFcu64OgTG+5gs+jgg08n17IKB3JLkLEX8lzCNmXJgrL/PEH+bEgAS84blgv
 5RxlO2ov0Jk2HWoLOW8dZAtbqCTQQTkv3PyyQUqUKvbGZQ7496xEOJMHtV5wAmwHnqlX
 6GczzYquWw7b272B3r7J9Ygt/NRsyTp9HyE4owaKrwUnbaHMAr3OzWOFvEQouOhEw7fM
 wo0A==
X-Gm-Message-State: AOJu0YxszbY+xaVp7eX1JniFC5l2UNPfKf6YLOZ4IiVIQpaoKQRBRzZj
 N6+/5KvE9a8jxAZIXDSdpR3R9g==
X-Google-Smtp-Source: AGHT+IE+6FusxhF4cceNOLIuMnKP6kH0ypFI3C39L9JZPKyk2h82YunOiCowZHVqM/p4GTr3RM5erw==
X-Received: by 2002:a05:600c:acd:b0:405:3e92:76e3 with SMTP id
 c13-20020a05600c0acd00b004053e9276e3mr2058088wmr.22.1696422100037; 
 Wed, 04 Oct 2023 05:21:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a7bc84b000000b0040648217f4fsm1393994wml.39.2023.10.04.05.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 05:21:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2AF6F1FFBB;
 Wed,  4 Oct 2023 13:21:39 +0100 (BST)
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-6-philmd@linaro.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH v3 05/16] plugins/loader: Clean up global variable
 shadowing
Date: Wed, 04 Oct 2023 13:21:14 +0100
In-reply-to: <20231004120019.93101-6-philmd@linaro.org>
Message-ID: <87cyxuh92k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

> Fix:
>
>   include/qemu/plugin.h:245:54: error: declaration shadows a variable in =
the global scope [-Werror,-Wshadow]
>   static inline void qemu_plugin_opt_parse(const char *optarg,
>                                                        ^
>   /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.=
h:77:14: note: previous declaration is here
>   extern char *optarg;                    /* getopt(3) external
>   variables */

My same raised eyebrows are how exactly getopt.h is getting included but
anyway:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

