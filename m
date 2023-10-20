Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A91367D0CA8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmNP-0005Co-1n; Fri, 20 Oct 2023 06:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtmNE-00057b-Gq
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:04:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtmMx-0006OG-MV
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:04:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso10311985e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697796275; x=1698401075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FuXVKI/L2uGHl3E8LwcUCfAYOXQ/87vheSiGRI+GPPo=;
 b=zk1/2W4C84goAmVkL9RcZP/S9xmJUKXvMMI9W5evPR5mhuHilMc3ZvYZ9NqKI7S4/H
 RcHFZdyJJBQD/6ITM+IJZuaoVPZyunSZiOQDtVzYR+7MCFVXJsKeo8NS8noaf49tixqp
 I2OLa61SHkwrDAaE1IHDa6mfFPW/DZ9hZqdiUqKeZNc19pzbQtvvk/WtLcdK0qyk47UG
 Cat1B6/m52sUeJ11a9nXTK4r+/QNEOkWpWULgPgc/cz65adghuWgzlJKcSiI/Q2FE7j1
 9S9MJtBAlsehxfgMuoA33x+CLHuyQmBDxm5Y71eL3k8/LPLFfSX5fmvfqVN+2zPnE54J
 7aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697796275; x=1698401075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FuXVKI/L2uGHl3E8LwcUCfAYOXQ/87vheSiGRI+GPPo=;
 b=SN1XBBaxNI8T/oHpq+5sthjxi587VYKSfxmzUnOmzE60WRMiZSZdSGFGDPLWVRfW/b
 GGQDC/osHwz3khDd3r95C/xoHLv3JG84TaR+CVjbgwaOCfb0wtflrr40rZ1wWwL+JNf6
 qoequrAndxyjIsPZR9OuhEU7PSsnKpthZifAhv16cDaGt7ljM1/AusPEB8RVjt6PppNo
 KTFFgeseYoHhimjakxcnWXUZ1GIJ8kCZdSoimmW6qBMTLurlZe+k4p+V0Zd+fsIIVDR0
 KA663vvVIRbKYt0Iq5fb9+B0VWHq+0iC3StfoWhTG10uffrhTJNcGaQMeGno5KevvB5A
 Httw==
X-Gm-Message-State: AOJu0YzmokFnod7PDRCoh0NdrQYkTyl7o+WxhVmRgnfgSjmiJx8MPCXU
 LKn6HJFkNPHQIkunQKUbeGxTErYZaI4lInRLLts=
X-Google-Smtp-Source: AGHT+IHbEixS2IgPt98WzLNnbmsbV4UipOOypmhaer9SiTc0nOGYWDy/0QQt0HcVEhC896LcBQp4sg==
X-Received: by 2002:a05:600c:298:b0:405:3be0:c78d with SMTP id
 24-20020a05600c029800b004053be0c78dmr4203309wmk.3.1697796275135; 
 Fri, 20 Oct 2023 03:04:35 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 x5-20020adfdd85000000b0032dba85ea1bsm1338801wrl.75.2023.10.20.03.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 03:04:34 -0700 (PDT)
Message-ID: <3a05d669-fbd7-6fc7-451d-edbbed20d7d5@linaro.org>
Date: Fri, 20 Oct 2023 12:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL 00/46] Misc HW/UI patches for 2023-10-19
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org
References: <20231019211814.30576-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=unavailable autolearn_force=no
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

On 19/10/23 23:17, Philippe Mathieu-Daudé wrote:
> The following changes since commit 0d239e513e0117e66fa739fb71a43b9383a108ff:

> ----------------------------------------------------------------
> Misc hardware patch queue
> 
> - MAINTAINERS updates (Zoltan, Thomas)
> - Fix cutils::get_relocated_path on Windows host (Akihiko)
> - Housekeeping in Memory APIs (Marc-André)
> - SDHCI fix for SDMA transfer (Lu, Jianxian)
> - Various QOM/QDev/SysBus cleanups (Philippe)
> - Constify QemuInputHandler structure (Philippe)
> 
> ----------------------------------------------------------------

Stefan, a change has been requested for #30 "hw/audio/pcspk: Inline
pcspk_init()", so please drop this pull request.

Regards,

Phil.

