Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F37DA8E5
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwouj-0005Ii-VD; Sat, 28 Oct 2023 15:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwoui-0005Hn-5r
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:24:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwoug-0000Nz-6l
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:24:03 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so2852869b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521041; x=1699125841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oyJ9k1/PB8GZaB8IE3AlvR+iYEpDp+07SL1X0Jt8FXs=;
 b=GqNEkb+D9PpoIpQ4uyw5M3RzaOaHBd+nuBllXF6zYYZJ6kgkgxna2nY7zFTo3iVPYt
 2XJOJ7n4mlIWNVdBN3vCK1RpYUXfiqPJmBaqTHoXqNEFYbL9V5z7O6WmAhjikieJHt3p
 ac0EPUInyW2FGc3lcZfVPOspJ5x9FbqYetR/9w7v7TVKZ4lKw/y3+dH+mcJUp8yBu9ND
 Oe0aBE/b+u2tVBMUbp0T1ph7ew/YN+cxHRC81LUY6oONKgmufKPN0dgps5t9P7Zk41RJ
 GKWcGnusxyP73BC/NvZ7Q1l6hUx/TqLoBppXEVt6IonGidk3TxWnIA1LQ+X+qz6Gvs3u
 KUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521041; x=1699125841;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oyJ9k1/PB8GZaB8IE3AlvR+iYEpDp+07SL1X0Jt8FXs=;
 b=gIU0ab/QARvyJYtsYFVbxcRxDm5vkWDxDiw+fRdBB8GWru1zLh5BxASKEBMbzvFZgp
 9IBMA11qbe9sQ7BdrqtdHf2tDakauDhcaEqI0m8h+onVHFIAXO2ua1BH74bwSRTrYS+m
 +ZKlopcLYWuRPyy57lJAZJia76OcfgHbPQXDL8l0ehORx2MoAL843pd/3PbldOWjhgB1
 73iHdbT4mKPWioUNqsHf/IwwG1S+jUqoW9EuAGDHsU/68K3pgUAMbj1rLxbqANKE0dq7
 GeuDxY9MZeNcMk7IcQjsLIZDVSlaF/YzLsF0REEmt2X9JE28Y2KfoCCZ+k8V26V/lD3Y
 GkwA==
X-Gm-Message-State: AOJu0Yyk40seobCa9f1X/zCmsXoc9oUvhCKC6BHMeiiwYcEr0vV7lObr
 PjJyO1o2Bu5tyJksQIa8gz/Aicce4TkMIagk6lk=
X-Google-Smtp-Source: AGHT+IHnF4x6lEhgPqAGPQJ8/daMfbqB6tzfeHsrRmUdcRsd+H6d/fE+YtpJHFMLaKm/wUjhMfsntA==
X-Received: by 2002:a05:6a00:a0a:b0:6be:2ace:deb8 with SMTP id
 p10-20020a056a000a0a00b006be2acedeb8mr5841073pfh.20.1698521040712; 
 Sat, 28 Oct 2023 12:24:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:24:00 -0700 (PDT)
Message-ID: <91c1d19c-cea5-4582-88df-0d3d1a09940f@linaro.org>
Date: Sat, 28 Oct 2023 12:23:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] tests/docker: use debian-all-test-cross for hppa
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
>   configure                                     |  5 +++++
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  1 -
>   .../dockerfiles/debian-hppa-cross.docker      | 19 -------------------
>   4 files changed, 5 insertions(+), 26 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

