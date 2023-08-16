Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99877E1C2
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFmE-0002qp-Bk; Wed, 16 Aug 2023 08:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFmC-0002pK-MW
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:37:28 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFmA-0001Ir-7L
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:37:28 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so10455586e87.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692189444; x=1692794244;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMHwUYjNR0vqB2wpvM0iXRsu25ZDgjYQIwVxWMliJhw=;
 b=bq1GznbPkAK0Sbt47ckpY5E7VGrG5uZl5aO0i94vv3XBX5tFSCsK/Smw/EVA2Lg8EA
 zCJPsfhDrCEU9zcdpwzhHNnl1KAtHyXZNlrk2HCz3NW+H1oshBC900TPb7xfeN2QPZVH
 sZDqdUGCC9ocdJoknz8f8Oi2nRj9JPU8vkXV/GwD9ccdVxlgzcruUty2JHMxMkUep6Ni
 QSZi3uBusOl3hQArtOtLb6DI7tm7Ma2vMNgHukWVKX7IgaJUycG+0OlWO05w8AlncXt8
 VBoDrawvDJIeW//rjWti7xgtBC9HVPODS/Rt+Z5P475Pg6NBDg04V/TJP8waUg+5JyjS
 AJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692189444; x=1692794244;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMHwUYjNR0vqB2wpvM0iXRsu25ZDgjYQIwVxWMliJhw=;
 b=OZW9bRF7NN2sSthj+O9zLZbiVxpT502TwumVxKHmGrWad6EyWiJ6I+bKSiBtW3EtTA
 4wKouXK2ja+37oSKCzDfiRpItD6p/jlBfIZB5eQq9DRcMFMyPENo4jNaJBatYBCZ9NO0
 AiZP1n53c/HijeiN8yrzG04MHy46pHwDlINQweCRWp/JrwiT2Qsdz1i0Be2osO8o2n/D
 412alHvnm5KgUu9krfzvBDuLv1sxa/RhgHxiyRs1IyeHCPvqLf5KiCEpIPpGu8rCv/LH
 S9ARCHu76KnaHxpaG6RAbp1CKAk5gexe/mGHh4I/U0IKaYHGTPaNFKGsQZFx3Dxk5HeP
 THlg==
X-Gm-Message-State: AOJu0YzNDJxFPk+XCwhh0JhVRkACU0yIZwXZon05hf0jQmVn+KBfqea1
 aymvFdrq2o3BRin/2m5iZoEXsA==
X-Google-Smtp-Source: AGHT+IHNdhAV29aPK0FLFxBoJqQH2Rk4KzTpxBioxz3ZrSPCBil6V4H9TsEu52iQIFNDBEhCFu3Lvw==
X-Received: by 2002:a19:8c01:0:b0:4fb:9105:58b0 with SMTP id
 o1-20020a198c01000000b004fb910558b0mr1317814lfd.20.1692189444315; 
 Wed, 16 Aug 2023 05:37:24 -0700 (PDT)
Received: from [192.168.1.102] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 g22-20020a056402181600b00523a43f9b1dsm7959051edy.22.2023.08.16.05.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 05:37:23 -0700 (PDT)
Message-ID: <10b32eab-a19a-a656-b8bd-4aef1f00bf11@linaro.org>
Date: Wed, 16 Aug 2023 14:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: qemu-system-x86 dependencies
Content-Language: en-US
To: Fourhundred Thecat <400thecat@gmx.ch>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <ed59d5cc-587e-ae8a-f367-96e4e58b67ce@gmx.ch>
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ed59d5cc-587e-ae8a-f367-96e4e58b67ce@gmx.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

Cc'ing Michael

On 16/8/23 13:52, Fourhundred Thecat wrote:
> Hello,
> 
> I am trying to install qemu-system-x86 on Debian 12.
> 
> But through the dependency cascade, it wants to install sound
> infrastructure with gstreamer libraries. Which leads to absurd
> dependencies, such as:
> 
>    libasound2
>    libgstreamer-plugins-base1.0-0
>    libopus0
>    libwayland-server0
>    libusb-1.0-0
> 
> Does this madness come from Debian distribution, or from upstream?
> 
> I am just trying to set up kvm/qemu to run virtual machines on a server.
> 
> thank you,
> 
> 
> 
> 
> 


