Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69E80D211
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 17:38:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjHL-0005o0-PD; Mon, 11 Dec 2023 11:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjHC-0005nj-4Q
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:37:02 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjHA-0001vQ-FX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:37:01 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54c7744a93fso6634722a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 08:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702312619; x=1702917419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rchDbv41LmtjjKEGa4Aos/UEX+s2aj5wfo2X55D4PBs=;
 b=VjnE6Al2eeQgnuK28HKh6+9Qlm0Y2VQ+1uULwN5Vwe9GmWjkml9UaFI6/ZlVhd4YYS
 iy6KF3XfvzmF9YU/PLPekwC2IV53oP0Psgsg0w9GmgLQVJ9rtqXaL/LrNDykR8punRGW
 Qh62TydGrVMVOy/0k0OJe8vDqX5VUX5xjOTS23PPAVh2XXqSTQd8lnheqEcOhrUTMwLU
 kqZy/ozdUpKmdKDdaZkKJLrsH06IBdvdu40fNjkzSDGe6p3dByysbI9aBdVKJQsMEE0v
 zwDJJ9EGP/nckV1TGS/DwNXMBBHJJBcZI3H02nvTekrW5+WBAkWnSfwpBB9V1HQNjI3P
 fclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702312619; x=1702917419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rchDbv41LmtjjKEGa4Aos/UEX+s2aj5wfo2X55D4PBs=;
 b=MRgagB9MjaYBo2thbOZHy8QWQeyE73xjIgHAkIh6dqG0xtnx5X1hPfCPCYU4YFjJxR
 91A5XI3EAsepIxjz0E5omkBF0GoZ9JeKvtEHjJVyrUr2EcmP30CrQElr7R0Nf2epeDN3
 X71hR8+uXjjOgYPL0TyG7FG84c3/8es1A86cqL4OqlFY4pL/R5yVKoNGkpQz2B4mYFie
 A8lztRxx/tpuWn2np3ItK/d4OR3UPVKXV+OUYYdq46wgO88TDuzwCW3AhewX3vAkNm4b
 99DDFY5mL91Zv6+4FR688q7iIG/nHt73m9Yany+iVAlQ8k/lbZsMtykQkTI4GRoN4Xew
 MUwg==
X-Gm-Message-State: AOJu0YzkSrpLPnVkrQyjC+0Vl8iFY/dXaITCJ0YIi6rWuz8g9Bm8wSxd
 2P32mtmFAkKcjBeJnDXXjNfgRA==
X-Google-Smtp-Source: AGHT+IGRSB4xvIcdsnqjQZqKP0M8XN4p5GuuQ1IOBXp8idoQn+ocFfXv4zbe60b/rATCpyHNiOS/1g==
X-Received: by 2002:a17:906:b0c9:b0:a1f:6433:798c with SMTP id
 bk9-20020a170906b0c900b00a1f6433798cmr2034910ejb.106.1702312618978; 
 Mon, 11 Dec 2023 08:36:58 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 rd12-20020a170907a28c00b00a097c5162b0sm4995159ejc.87.2023.12.11.08.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:36:58 -0800 (PST)
Message-ID: <5377419a-88dd-4e5c-8be4-1345f6c2115b@linaro.org>
Date: Mon, 11 Dec 2023 17:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] testa/avocado: test_arm_emcraft_sf2: handle RW
 requirements for asset
Content-Language: en-US
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-8-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208190911.102879-8-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 8/12/23 20:09, Cleber Rosa wrote:
> The asset used in the mentioned test gets truncated before it's used
> in the test.  This means that the file gets modified, and thus the
> asset's expected hash doesn't match anymore.  This causes cache misses
> and re-downloads every time the test is re-run.
> 
> Let's make a copy of the asset so that the one in the cache is
> preserved and the cache sees a hit on re-runs.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index f5c5d647a4..e2e928e703 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -414,14 +414,16 @@ def test_arm_emcraft_sf2(self):
>                      'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
>           spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
>           spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
> +        spi_path_rw = os.path.join(self.workdir, os.path.basename(spi_path))
> +        shutil.copy(spi_path, spi_path_rw)

This is an implementation detail. By default fetch_asset() should return
a path to a read-only artifact. We should extend it to optionally return
a writable file path, with the possibility to provide a dir/path.

