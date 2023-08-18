Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A0781018
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 18:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX296-0007k6-1F; Fri, 18 Aug 2023 12:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX293-0007jx-8S
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:16:17 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX291-00018F-23
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:16:17 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9cdba1228so17294021fa.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692375373; x=1692980173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CRlaHQU0o+4VqTQPB8WprOoKTi5VAUM1Szxbq8PZwUQ=;
 b=OO8MN0RTjBgIeDIPbXGyCn39xblfGbFY5zg6uCjJBIajUUuIhfyGRcpHIgPbhklhxB
 FAziLCKp51MW5j+o5yPbTwQWDKLH6yxA0MQ02JFHq5gT8bjnRpLr5lcIozCASzOpebtO
 LhU3uKapK+BXa1pr2oW1cNLSc/lczzzrak9+xpKQiKrEZ714nwdhU3BGYc1Fm7Cxaamc
 8Ndh9fsGlCgrCJj4YyPdoF+6l8O0t5BBJImVV/0aC33akmW4vUR9X3c7xE1L0F3nk9/H
 vaKZOx0X5Wtw/IGeF2+kxQmHOfiUzpk3PmdHw43jbfj/3iZj0oFqaT+bVy4sDMu5Egld
 qRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692375373; x=1692980173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CRlaHQU0o+4VqTQPB8WprOoKTi5VAUM1Szxbq8PZwUQ=;
 b=IHRdK/a2O9mS/wDJIL+YFaIFOhpk+j89oYaMJJ529KfTYJsOOtBAcRj0hP/pGsvvt/
 HzdG+Zr/7hbxHOnUBMV1MPo4MxVyQVGu1yA2n9+ep2jEoBo1+eIHVU7uz2Ady8/be4XZ
 fKvQGCCvTEOJ8YcoRbNea496cAHdg/1LD2ct58PvBceiIhjgkUKapwAJI6yaVhFPUPzb
 Krl5K2GHyMCVZZEKTqjojmRxt8fO7xby41XP2hKBClhPehKB51/qiT4HPcr0uZIZTR2K
 gtXI9folp+Odz7bZovHlnrblW1DdPv1+wPfR9JHfhjlth57Nz5IlUfFKcTKqt0kVWe9a
 Zcpg==
X-Gm-Message-State: AOJu0YyJfc2qfkw6EyjZ08n/7xNYRT1+lxTuny7NuODulOyaH/NykIiD
 k/RFPHNa/9etjqlIg7Rdh8V8rQ==
X-Google-Smtp-Source: AGHT+IGgPaRdFE280K0vaffCx3PJr7h61I5qCGHNggVAvGaL7YRxjPLNGrdfEimisyUT8fYJNef3Xw==
X-Received: by 2002:a2e:7314:0:b0:2b9:5695:d10d with SMTP id
 o20-20020a2e7314000000b002b95695d10dmr2055272ljc.36.1692375373086; 
 Fri, 18 Aug 2023 09:16:13 -0700 (PDT)
Received: from [192.168.69.115] (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 p5-20020a17090635c500b00988be3c1d87sm1337257ejb.116.2023.08.18.09.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 09:16:12 -0700 (PDT)
Message-ID: <4ce4b0b3-aba2-bbea-6175-e1d39f411640@linaro.org>
Date: Fri, 18 Aug 2023 18:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] ui/vnc-enc-hextile: Use static rather than dynamic
 length stack array
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230818151057.1541189-1-peter.maydell@linaro.org>
 <20230818151057.1541189-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818151057.1541189-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 18/8/23 17:10, Peter Maydell wrote:
> In the send_hextile_tile_* function we create a variable length array
> data[].  In fact we know that the client_pf.bytes_per_pixel is at
> most 4 (enforced by set_pixel_format()), so we can make the array a
> compile-time fixed length of 1536 bytes.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   ui/vnc-enc-hextile-template.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


