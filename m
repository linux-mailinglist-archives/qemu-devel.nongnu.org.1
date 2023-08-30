Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC478DC3E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 20:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbQE7-0007AJ-Jf; Wed, 30 Aug 2023 14:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbQE5-0007A8-B7
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:47:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbQE3-0003uT-1B
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:47:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401f503b529so7607685e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693421253; x=1694026053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKgRQjGfK/Lvr1ErIvKvIN9NWsheNqh1zF3x6I2Usoo=;
 b=yNQ3Y9wGtOJCwGykIMDW9w7SgZdUns+6v492X4NmpDSJ14zsic6UeZj97ZMgyxhd4V
 2khKHthntHhKTe0ErUIR+KxqVAizIA+xIrPrQhbp7o3HYgm08ghEBzwxc7AoibAnj/VK
 9zIMEpSIAT6chWXNQwRSIIDt/yuGoP7DyEo2TFUZiSMYqox8Dccg6Oaz9v0D4+2VvyjK
 LC/icpCkJ7xjH8QRX2Uqvc+jrOAGWswPNxqBzSL5gOwhS2OsukA2FMP7rnZfh5AF6EjY
 pv4MdyA4mOwLZcUXJxUbXnOImMqXgxDoeKh3n/2BQfHa1UHdj75LcA+reKglIS3EeRVv
 CKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693421253; x=1694026053;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NKgRQjGfK/Lvr1ErIvKvIN9NWsheNqh1zF3x6I2Usoo=;
 b=ERmOzEnlBTAox3WaKXEQg4zPWa0g3thlWSUglIhTdg4pOxCWSoHhAAAzPmqr2Yygck
 SmdC2ergcb8c+u+P5gcDXs8G94Op8vzy6nbUnnmTqQYzZkukiZjaJUIUqbxPHfUibGUz
 /fVKcmSCMBMzy2nBd9+wqX519WclD1tz0ZkEesmMSlqmmPyIZ9MtyWcgBYriZ62yIcqv
 WpmBSA8+mxKbTO4ykpzKfmIVyxN+8ZZZUogHKBrGBn+vHyw0L1vapdtH8yuRWImSzOju
 kecU7lfF/MOxzKY4m+7Nz5fBUk5JPN9AWq5ZzRDsLpb9iwP6sfXgsyxx8FjrN+Dlx9wG
 z/PA==
X-Gm-Message-State: AOJu0Yws48/O4RLM8vOBDMy6fWfc4PRhYajBN7XOHseDkocgEl7BhqWd
 xp3+KsyGv4xHMm3GNtb3yq2ZSg==
X-Google-Smtp-Source: AGHT+IENvBS6c8I0c1olo+AqqKxnWwJBLpOirPw+8B49nYXptSK5oBLnqj1fh4xOAC+sa4jcMh7JHg==
X-Received: by 2002:a1c:6a17:0:b0:401:b701:5424 with SMTP id
 f23-20020a1c6a17000000b00401b7015424mr2417633wmc.9.1693421252829; 
 Wed, 30 Aug 2023 11:47:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a5d64ed000000b003177f57e79esm17593761wri.88.2023.08.30.11.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:47:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D12561FFBB;
 Wed, 30 Aug 2023 19:47:31 +0100 (BST)
References: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matt Borgerson <contact@mborgerson.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] plugins: Set final instruction count in
 plugin_gen_tb_end
Date: Wed, 30 Aug 2023 19:47:10 +0100
In-reply-to: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
Message-ID: <87ledspdto.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Matt Borgerson <contact@mborgerson.com> writes:

> Translation logic may partially decode an instruction, then abort and
> remove the instruction from the TB. This can happen for example when an
> instruction spans two pages. In this case, plugins may get an incorrect
> result when calling qemu_plugin_tb_n_insns to query for the number of
> instructions in the TB. This patch updates plugin_gen_tb_end to set the
> final instruction count.

re-queued to plugins/next now I have rth's gusa patches.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

