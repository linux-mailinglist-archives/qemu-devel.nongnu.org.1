Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B21B8254A1
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 14:48:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkXp-0002ky-Nn; Fri, 05 Jan 2024 08:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkXh-0002ka-KJ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:47:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkXf-0003FE-BI
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:47:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso13949075e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704462437; x=1705067237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8yANIo9XwSPsn23LEL+WCP1lA40BVvc4bUgRohLca0M=;
 b=qmTdMxB+2ro/IL5do+PtlfC7USDLObaZSEq1em/uqryETJRJ4r+nanHZPMXXnQp7FG
 HvlGTWztAzKRdcuf7cVPV/eS7nqI7szpB6e/WxTHlbkzRx3igaXxYQ4VaLEVHyovLvN1
 Tf1U6R580jColX+yCvMHrg3dzMcGnOrs1aCWnaFPM6E2wC5583N2xmh/ButhXT7w5ozE
 DT+FGDlBoawINpGMVDpnJW2D/asW/uUlBEF2jPp8OUWJuyaNb3llZWeNfgFVeNCiNApA
 8WDinibcJCG1Y+xfsW/zttWvz2NU4qmtjpQsLkTyCOe17mfwrjQqyPQMXjj0KAwKdKhm
 HtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704462437; x=1705067237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8yANIo9XwSPsn23LEL+WCP1lA40BVvc4bUgRohLca0M=;
 b=G4sJgJ0F86Az1ZGevznSCrccV4NDCoeQGaW7ZMVirsFdDt85nwV1dtYgsoZBNPtg6A
 j3Ijd1BUEELQ98OGlBcQmJcZjGTn2q1OYpimomt+MqS8Seis0RXAZMysempUA5fPVybM
 aKUWsC2AnuMSMEyi5WEDboAU5SO5O217G+SiHd6xoX7207ZWrXWY8Mtz6p87uhcgBwT4
 ylETSAlQY3GThTZ8ZyXzd+TnWFoDr/A2eiMsvGqpXO6FScgRzV8iDcXsqkv2IeOQuMDi
 FZPySDxzaYGSHpquzZpxCJf+RYTJUyKTDpJpX9lCaYCCNAcNeAubCLG3Ol/sQ2aQUaVD
 JOCw==
X-Gm-Message-State: AOJu0Yy9OVD3fIvP9IeAEdbl6zgekdDxRZfha9vhc/xj5eeEvhnozaj4
 I8sNzXCOV3mph9K0PHYojW7JkhYiYJE/Cg==
X-Google-Smtp-Source: AGHT+IEBRiVDnwP6+wMxjVwrjlno8s/tp73MeyskcGEiLwMo0PgoRsc7cIsGuKg9bg49MFv8+CEtGg==
X-Received: by 2002:a7b:cb90:0:b0:40d:1a5f:8abd with SMTP id
 m16-20020a7bcb90000000b0040d1a5f8abdmr600416wmi.291.1704462437429; 
 Fri, 05 Jan 2024 05:47:17 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c4ecb00b0040d2d33312csm1654165wmq.2.2024.01.05.05.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 05:47:16 -0800 (PST)
Message-ID: <5492018d-8b72-4aea-b33c-bb9f4f6b4f48@linaro.org>
Date: Fri, 5 Jan 2024 14:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga-win: Fix guest-get-fsinfo multi-disks collection
Content-Language: en-US
To: peng.ji@smartx.com, qemu-devel <qemu-devel@nongnu.org>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
References: <20231227071540.4035803-1-peng.ji@smartx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231227071540.4035803-1-peng.ji@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 27/12/23 08:15, peng.ji@smartx.com wrote:
> From: Peng Ji <peng.ji@smartx.com>
> 
> When a volume has more than one disk, all disks cannot be
> returned correctly because there is not enough malloced memory
> for disk extents, so before executing DeviceIoControl for the
> second time, get the correct size of the required memory space
> to store all disk extents.
> 
> Signed-off-by: Peng Ji <peng.ji@smartx.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2075

> ---
>   qga/commands-win32.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 697c65507c..a1015757d8 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -935,6 +935,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
>           DWORD last_err = GetLastError();
>           if (last_err == ERROR_MORE_DATA) {
>               /* Try once more with big enough buffer */
> +            size = sizeof(VOLUME_DISK_EXTENTS) +
> +               (sizeof(DISK_EXTENT) * (extents->NumberOfDiskExtents - 1));
>               g_free(extents);
>               extents = g_malloc0(size);
>               if (!DeviceIoControl(


