Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE47E8B44
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 15:47:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pEu-0001Iw-Bs; Sat, 11 Nov 2023 09:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r1pEc-0001Bp-PA
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 09:45:20 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r1pEa-0007UF-VH
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 09:45:18 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5b8f68ba4e5so2142645a12.1
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699713915; x=1700318715;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+vhF1yv6s52ipiMsl04VwlS0cYZlLF9WsvegugSFe7E=;
 b=t+FHf6hB1m7P2dsNaGav6ox0lNNx2nPoeB6gTpWU13SGEfaOJKNsJu3se5JaSRWRcN
 PQTT7zGpKPsJ3vbn2YDx/Ks6g+r/bAGDBLRx9EbubLb10WdFNufOpS9GVPvhbVrbxz1o
 O9uQ8hURcDbdPqAvrFrMmp2k8LBbLNhw9LLns0ZTLyNSx30hGWRGAsw3ZIwsiIZc8NAd
 sThvXsVxj67JTbUk8yKGRbUSXfqBJxlom9Rb2YafXYpV3UpYm6sP/V09L2nGYxdDPDHh
 ZcUJl2syJGjQeWgLOmnpC8TG8eDv2iU9KqefdGomhqrVBEvhDDSO5UjQv3kzslvMwZma
 Jcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699713915; x=1700318715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+vhF1yv6s52ipiMsl04VwlS0cYZlLF9WsvegugSFe7E=;
 b=v9jxGVkYtPQDcmiXNrDQnN3Q/SrNUGjNYzULvnedaArWM/goSb+DPLOATpKNDXbK+J
 IRGCPnxmaRSrNcBY9iz+mdQ6gxmPMsIXkJ0safeRE0fa8jlnPKtYgAk8yAztjBvtipvg
 W5dnmjtVQ2qX8spfbUX3Rqio8jU1d+368ejzN43+0QITiV7hoeeaL4klEMId7JS311mM
 ZaQ9J3cLJvKda6oFiV2JDC/+p8h95V4DZHMPdvAzIZX4/PfCwSkAGhFQxDUvNqlBT5Mx
 MF8TLxgQdqoH7q1sz8Zfjcm9tONInREVEpa5tAOaRb2JysmOpY1CtNBAOHe/iaJlmViR
 lglA==
X-Gm-Message-State: AOJu0Yzh0UXFdzgsNEJkT+7RolHj+Cvy6mrBceMDqglamCgjQ9UU0mEe
 yy7S+DaEpyjlPE20dQZfOQ0fIn6sA+lpaWloUx0=
X-Google-Smtp-Source: AGHT+IFBR6mXQ3cyny0CzfMSGh3wAjwGPOKsyeDjn4n8jYzzf07E912mXejY1JGGR2/zVJO5g/s/pg==
X-Received: by 2002:a17:902:aa48:b0:1cc:31a7:88cf with SMTP id
 c8-20020a170902aa4800b001cc31a788cfmr1642701plr.40.1699713915144; 
 Sat, 11 Nov 2023 06:45:15 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902c1c500b001cc31dcec49sm1362257plc.146.2023.11.11.06.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 06:45:14 -0800 (PST)
Message-ID: <330090c6-3956-4f66-8407-513f5c6ad1c5@daynix.com>
Date: Sat, 11 Nov 2023 23:45:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ui/cocoa: add zoom-interpolation display option
Content-Language: en-US
To: carwynellis@gmail.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com
References: <20231110161729.36822-1-carwynellis@gmail.com>
 <20231110161729.36822-2-carwynellis@gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231110161729.36822-2-carwynellis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/11 1:17, carwynellis@gmail.com wrote:
> From: Carwyn Ellis <carwynellis@gmail.com>
> 
> Provides a new display option, zoom-interpolation, that enables
> interpolation of the scaled display when zoom-to-fit is enabled.
> 
> Also provides a corresponding view menu item to allow this to be toggled
> as required.
> 
> Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

