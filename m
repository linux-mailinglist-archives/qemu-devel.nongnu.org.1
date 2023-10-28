Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A57DA8ED
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwoxy-0008Lu-6m; Sat, 28 Oct 2023 15:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwoxw-0008Lm-Rq
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:27:24 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwoxv-00019J-Gu
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:27:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso2801851b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521241; x=1699126041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1FS2eZ/eoGsR5DmuMZzR8Z7sNTnREgk+MGfuuIdeHA=;
 b=KavMtcxHs8M5IwFNTD89dg72R7+zP85GR16UFrzZzWmZxc3KhEm4hzycKi/NT+CJOo
 wo5XLuLPB+e74G4ZEUbyt0YN7jig11vQeKpRb2VzmLL+2AxNyT3vzMFvTWf11Uug3BQd
 V2j385kyvjSL6/DD2LvcRNurTF5lVI9eDV9BiwXv6859w3kFQCmRYPV3jcQFw/2s9gQU
 HG9dF8qtgJrMVvIvmFtw8DtaQPr3U5GBl/P1rByfcNwqTWWkbkvseZIn1fSiv9UPUniJ
 o8R6BPbVlHxOo+KVFV/ZDagZNXgQtqK58s8WRywm472N7WcQDpeCYebAtGTPAApCZjmI
 IzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521241; x=1699126041;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1FS2eZ/eoGsR5DmuMZzR8Z7sNTnREgk+MGfuuIdeHA=;
 b=ciSpXX/YCzY2Eg0R3ZFNvYL3jWPCwPhrII8T1EsOLO6354rNiAA37ftC0/ad12gSr1
 pqbzQhGa57DF4+MZ4XpO02FaeRuw4kGBBn5+7kofH+/ew6SxHcA8McNMZxhDmTNMrdG4
 BDDVIEptlcaAhQ0ifqHI3pl48Zp6SRvSX2ka4LrYLPQpYVlFjwSxKAgWFjzSxDgFs0pQ
 hGMkf3kv0/+JIXSknsVK0VrhAd4v9eE1bXO4wX3jARkJnCotNaM8Ew5NE4MOPt5BGFKT
 EtaNXXkaYYAmYbvF4LAuuF/zfyeP6j4szgop2eV0jJAoN8gvE7om/Y+2VzYkGuOSBmU5
 /pXA==
X-Gm-Message-State: AOJu0Yw4Di6evXOPoIhJfs3bnVSvjCplawdVs2Yyezbs95H4QOVV6QVA
 yI7ztuyGWcYiCCRPe4ozG6BMVsKPPFRfOvOykM4=
X-Google-Smtp-Source: AGHT+IH4WG9FM8+34w8Cqf/gFCCORw7OeLcMIrmq+uIwXuNNqmsRXbVIaVrMvmlegjuBIph8e/VQ0A==
X-Received: by 2002:a05:6a00:1911:b0:6bd:7cbd:15a2 with SMTP id
 y17-20020a056a00191100b006bd7cbd15a2mr5378433pfi.26.1698521241438; 
 Sat, 28 Oct 2023 12:27:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:27:20 -0700 (PDT)
Message-ID: <84736a0e-f1b8-487a-bf80-cd58efa55a60@linaro.org>
Date: Sat, 28 Oct 2023 12:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] tests/docker: use debian-all-test-cross for sparc64
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/28/23 03:33, Alex Bennée wrote:
> Maintaining two sets of containers for test building is silly. While
> it makes sense for the QEMU cross-compile targets to have their own
> fat containers built by lcitool we might as well merge the other
> random debian based compilers into the same one used on gitlab.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure                                     |  4 ++++
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  1 -
>   .../dockerfiles/debian-sparc64-cross.docker   | 19 -------------------
>   4 files changed, 4 insertions(+), 26 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker
> 
> diff --git a/configure b/configure
> index 20247bc149..7854451913 100755
> --- a/configure
> +++ b/configure
> @@ -1356,6 +1356,10 @@ probe_target_compiler() {
>           container_image=debian-legacy-test-cross
>           container_cross_prefix=sh4-linux-gnu-
>           ;;
> +      sparc64)
> +        container_image=debian-test-cross

debian-all-test-cross


r~

