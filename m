Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D517828F0C
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:41:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJq1-0002Ip-9B; Tue, 09 Jan 2024 16:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNJpz-0002ID-AP
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:40:43 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNJpx-0007xY-Nx
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:40:43 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59879870ff3so628618eaf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704836440; x=1705441240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QQ9sqdUSpl1mccmrRssHU2tPBwKEfVyU7cwSvuD37aU=;
 b=yNgIDe7gqJ6MMJieGVE7f5d6AlYgdAULaPU+HPKhVZosvXF70OCXeynuEyfydlf3Lk
 vzi9deyfGwBjZQ8LJEDbuS0YrDChdf4D7cB2ymE0Wab0ynsoxceY8yupmMrHjDmrm6xz
 n5a12CKP3HilYXCOgC+lmxmLiucoRT9t9khhZQcPoi80qtgfqQZrYdMFIMOGULGz4Rij
 09Zg6vpI0cRKHwxiZ+5F9Tuu7HxcpwhCjqa4ifix68wUMI2HPchcOmwwv0zhZSNxYPsv
 FZJLLG6fc/W89PzlnkL36lrofuaUjX2e0/p1/o7GdMlue0FRKNHTpMQE2XBbwb5W3W1x
 Utzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704836440; x=1705441240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QQ9sqdUSpl1mccmrRssHU2tPBwKEfVyU7cwSvuD37aU=;
 b=Gr62rXIWFIoOzYqmYFeHo0sWKpYA4tv2fMthxIXWgRmJjlglSsNPIP3nwmhUvq/loA
 ed8FPDB44HkWo3I+6GW8JyPHTJn1Db/wRiJ1FCHvCdFIMM0jX+sqc7eIJqF4A0NTFZIJ
 /AHeGtLDY6yaVXIMkvNEumU5OhbklmRVtEbM8mTshyjxSLXinRo0EkJr4icJuehwx1mO
 D11ckPfk73ekMGq6a4RNh+O8y5wW1DVvs5uCrI6zdgMgSx6p7bMPGNKtJXIp/lISEh6e
 PXRvXDJaY3NEN5WGEqUEaKheo9yUN6yM/fvIDtXZxI6gM0xL18v1/u5h3Punzo9WLHSb
 CWEA==
X-Gm-Message-State: AOJu0YzHypfWZNZ0dL2HZKGRYp4+Y7xKQM/lQToKTc90gFNaYptB0wKM
 NYLKiIMcdo5doVJrUVhkEaqGMjIfjQI2nA==
X-Google-Smtp-Source: AGHT+IG7kqw0aAGVP2IRx/5rsWIvb9MP5Ji1Owlwne7sQ/RALD9zOkmeqHQYaEMvO5jlAPN8dJyNSA==
X-Received: by 2002:a4a:af4c:0:b0:591:4ee7:76ca with SMTP id
 x12-20020a4aaf4c000000b005914ee776camr49365oon.17.1704836440475; 
 Tue, 09 Jan 2024 13:40:40 -0800 (PST)
Received: from [192.168.44.231] ([172.58.109.85])
 by smtp.gmail.com with ESMTPSA id
 185-20020a4a17c2000000b0059870e7b02csm554867ooe.30.2024.01.09.13.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 13:40:40 -0800 (PST)
Message-ID: <6b45dc49-9eb9-4cfb-8b87-78fd51ddbd0e@linaro.org>
Date: Wed, 10 Jan 2024 08:40:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/pflash: implement update buffer for block writes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240108125342.48298-1-philmd@linaro.org>
 <20240108125342.48298-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240108125342.48298-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 1/8/24 23:53, Philippe Mathieu-Daudé wrote:
> @@ -818,6 +867,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>       pfl->cmd = 0x00;
>       pfl->status = 0x80; /* WSM ready */
>       pflash_cfi01_fill_cfi_table(pfl);
> +
> +    pfl->blk_bytes = g_malloc(pfl->writeblock_size);

Do you need an unrealize to free?


r~

