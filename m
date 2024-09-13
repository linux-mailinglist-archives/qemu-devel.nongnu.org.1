Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B03978994
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 22:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spCfP-0003qW-9C; Fri, 13 Sep 2024 16:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCfM-0003pe-7n
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:13:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCfK-0007dU-GY
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:13:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso24394825e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726258392; x=1726863192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sjPXZnAhyVIdy1pixglaPdBsecsXc+B/JuBecnd6QLc=;
 b=iVQGpZm3V6GXx0PUUEe6P8vQNoWVOPo+PdhiAEkurVtSdiX2vFAnd0AD4bl4f3JZna
 ROkeYj5qx74xvc/nasp+LVf0g1ILGiL/mgWoNnvhsnGokN/ZcIIZIYHViWJu+a2J24bG
 YvTvmgh/1fkCXqiCVWbZTVTI75AJYA3U24aO8Lnt36bsv/n8dnduzmrmzYh0I22hveEm
 tlOxteJ4MAMVRs9Dc46eY5sRwx2zmgDryu5TgYGvhI0ziCFLGLAhmnxyp54VG1njb1el
 teOUxHk8aM9PgqxvDv9fYXidotvDXL1sy/CSXBJgUnJHiIJsKppwhHYm+4wNUHS3Bmxx
 VFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726258392; x=1726863192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sjPXZnAhyVIdy1pixglaPdBsecsXc+B/JuBecnd6QLc=;
 b=d57CcUT1Jy3yfXS9qvs1YJtwfnXg+UzFPoUWKTKO5cmwpLhJc7zvJvDYbXc00dlIeH
 D0imF9t6OKLL01gfrSvGCfTJ17J7H4YpW4HjZ3AoMHKcdhjfqrp7L6NdRRIYKpV1/eV/
 VLwovGxOp9LfvehzxQLodohPzk/qdtb4r3UMjjV488eRiHZV13QeeEaE8KxldfS238rV
 2v4p6TpwSYm3qcRGqVTs6LBBDnLkdsNQGQRGbqIOKCi4QC/F0gfxleFVDYxZ1n6lQNwM
 2MM4qzdNK7oEoPw3n2QF+ENKSoIfUZVwng8fbmwTcw4ya/3jZJgIlPuca6Aoia8x9rD5
 eYKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTK+jd5RouPqOcAr9e22iFr0+eBn8V787Ovfi0KVhehNyVY4pBr1HPCA/n4Cz+MhWrYWpWD3AiWq4w@nongnu.org
X-Gm-Message-State: AOJu0YzyF63iM8xICBSPgN5yHyOh7vLN39SU5Yq39ztFSwtGzr8GX5Py
 Lsxco6KzeovU5unwcjCkKFNRFU6LiXSf5J+kNoxOpiJNOezTY3i2jFfDdTVnPPw=
X-Google-Smtp-Source: AGHT+IHXotzioIh8ge2jW1inaTcRSugoTBfliy+9jM7/l45vUifCqIaB7QTfEMqYeXpmPtgMIPJYTw==
X-Received: by 2002:a05:600c:5125:b0:42c:cd88:d0f4 with SMTP id
 5b1f17b1804b1-42cdb56aea6mr68477975e9.22.1726258391734; 
 Fri, 13 Sep 2024 13:13:11 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22e7330sm1370005e9.24.2024.09.13.13.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 13:13:10 -0700 (PDT)
Message-ID: <6496355c-bc11-42c9-a516-b30a15c37e88@linaro.org>
Date: Fri, 13 Sep 2024 22:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Move the mips64el fuloong2e test into
 the thorough category
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240913175140.3329083-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240913175140.3329083-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/9/24 19:51, Thomas Huth wrote:
> Commit d2fce37597c2 added a test that downloads an asset from the
> internet, so this test should not be run by default anymore and be
> put into the thorough category instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Hmm unfortunate but I can live with it (not worth splitting that
file again).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



