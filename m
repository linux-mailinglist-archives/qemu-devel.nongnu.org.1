Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9395777E7A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8hs-0001Mj-2B; Thu, 10 Aug 2023 12:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU8hq-0001KB-2M
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:40:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU8ho-0008UN-Ig
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:40:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe5695b180so9474045e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685611; x=1692290411;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FPnM/+IRhsE1TVP5M8Qd8UpUL+EWAB2Ie1AtKfDOqI=;
 b=xuSkFTIzJcYbLWsb3RYX/GMATVIrY7Zzp70ou1yiXfFvM2qDdHiCbi+wlSjs/s/pRR
 /bmSq4M5Z38qeVwVHgNvYauct7PJji+iZ3K521jhOODosQ9EHZh7H3VAqmtarFEsJ3tW
 wn61LzoKEHlUWAKeHOYIetzRdJiCQMWnZMcP6aEICnjkKi8forZ2wOU8/7mlDO/QL47N
 /J6V/Kr8RWxYyRmTll4+Gkx4KM8RWZ4FLtMbK0LW4gE1FHgJLmdAoiGAksvl7MD+/HY6
 WopekCaLhX4WClHLdNKBCkq4Csocxn86AFdrJczDLdoi/nHIB2RbptZlP/hk+uRJcM9H
 GaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685611; x=1692290411;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0FPnM/+IRhsE1TVP5M8Qd8UpUL+EWAB2Ie1AtKfDOqI=;
 b=EBuBAtgqcsH6r0syVBxkXe/5vpOir3OxeQ0fruoovfXzeW/Q4VNsVCtIeGX58B4UJs
 nGDmlO3xMG2dgdWyZj5uXk+q6fI7Dh053fmBXdHhwo/sEMMXjqq4TQeCMwzrokHGtg4Z
 Mc59PVyzHBUIXu5EU6YnkA4j2upVJ+P7FPJY/LZwZQ4OipxiL2vy27RbxmGjT0pGSiTt
 xBpdmnZDpJ7JPjpQfMA2sMU4JFPDaG8FuPH+vGIcrAnuTun0reHJL+M2xtVTyx+/583b
 2S9Zye+vtRJpYowwxO/i1PNG0nRnLSLPzs4QDiVWej/H59bbqg78adtgh36zcuVfAVJ9
 jHGw==
X-Gm-Message-State: AOJu0YyzjqZKqGcJxePGtcbj0Y3U9UroD1xaKggCclEzAYk3AxCSRSFu
 erSwSYM5gkM25igq7wedR6ml1w==
X-Google-Smtp-Source: AGHT+IF7T/yY1NIJSTJECi56nGHO/CFfCLTTJpz+reX1g5mWEycxuTef3RhK3kjNtmUjVS8+0L/UdQ==
X-Received: by 2002:a05:600c:259:b0:3fe:3b8e:1cba with SMTP id
 25-20020a05600c025900b003fe3b8e1cbamr2336574wmj.6.1691685610962; 
 Thu, 10 Aug 2023 09:40:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a1ced04000000b003fe61c33df5sm5579922wmh.3.2023.08.10.09.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 09:40:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 013151FFBB;
 Thu, 10 Aug 2023 17:40:10 +0100 (BST)
References: <20230810161329.7453-1-philmd@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH-for-8.2] target/arm/cpu: Allow logging disabled CPU
 features at UNIMP level
Date: Thu, 10 Aug 2023 17:39:27 +0100
In-reply-to: <20230810161329.7453-1-philmd@linaro.org>
Message-ID: <87edka3l7a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Some CPU features aren't strictly required to run guest code (such
> debugging features), so we don't model them. To prevent the guest
> to access non-existent system registers, we disable the feature bit
> in the ID registers (see commit 7d8c283e10 "target/arm: Suppress more
> TCG unimplemented features in ID registers").
>
> Since it might be useful to know when a CPU supposed to implement a
> feature has it disabled in QEMU, provide the ability to log disabled
> features at the UNIMP level:
>
>   $ qemu-system-aarch64 -M virt -d unimp -S -cpu neoverse-v1
>   QEMU 8.0.92 monitor - type 'help' for more information
>   CPU#0: Disabling unimplemented feature 'FEAT_SPE (Statistical Profiling=
 Extension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_TRF (Self-hosted Trace Ext=
ension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_TRF (Self-hosted Trace Ext=
ension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'Trace Macrocell system register=
 access' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'Trace Macrocell system register=
 access' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'Memory-mapped Trace' for
>   neoverse-v1

Don't these also depend on FEAT_?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

