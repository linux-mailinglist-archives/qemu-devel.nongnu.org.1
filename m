Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1782564D
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:06:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLlks-0001oA-Bq; Fri, 05 Jan 2024 10:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLlkl-0001ns-Ro
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:04:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLlkh-0000jr-Sw
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:04:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e3b3fb6f6so1409825e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704467088; x=1705071888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G+b+UhhWUTTADKOHH3dFD6R5H8/Kn+xlE1Fw01Bx6hI=;
 b=opWrk3RH0wKJjf7hH+d8k0vIGi5OWXbJglJUpQIE898DICijgXvu2on/wfwx8IlMms
 BmFLBjvCcrAli5X6T3WidhRbsoBG/gZZXL5p0v6ivfwDmeaPN0DnRkv9gWnfyTB7h5Db
 ohW3OpyEK4gkDPqjyG0X8+Oz2qsB9Vp0X2Q2hlviqAJBcJxLJXVu4bJK4nYgobMePGhK
 rPNEG9zFwr4aHV84IY8Ek2ROHb7q8bsxt++YtdeVagR2jy/ChG5N/rrqWIw/5TkOXmE3
 KYHN0bkW3k7iVzRHa73a3PHR/o11hkL6d9F1ciHz4ZtrQUs7nuliVt1TapYESqr3WTxb
 yWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704467088; x=1705071888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+b+UhhWUTTADKOHH3dFD6R5H8/Kn+xlE1Fw01Bx6hI=;
 b=w2vcaTyuce60Gj8jGBtsxbzKiSLRhVeh8qnS0ZM7mCCHop0ZOmyRUzrYvCRmrmxMRY
 iBZyrny0rK2tdlvnxChdc1Sq/QlT0xS9ITUFcVLUCRY7/JTfXdlf4Z8KMV2P9Q3+xgzi
 jSB99LPLaERn3h9UpKJ+wv+2LVbo2AMU6cK5wqb7yA2P4AeHv+B1pleHrjaqjG7CQqpA
 YXc7mj05W80aGWWoXobd+Stn4Or8Squ7luB/KvEZBu/5zSEO1+0GUaeUI2COUVZlSnrM
 laKiJWq8gdcGxnMlH4nW/TQJZQNmOrapbBQtdKm5iYDIMn9ZzOWc1NXaeWGZrPMCSk6w
 tCKw==
X-Gm-Message-State: AOJu0YwnqPlU7AsnMXfGvRePN/awj7Kdq4km1mBwJG/u2hqZtoUo4jFU
 /nzsCOgfWXtgTzJ844Mcb+pr1vrmF1JhQg==
X-Google-Smtp-Source: AGHT+IFuf8gNdzgdNKirXf+yYITyi6YI+NIG7GbRz2i8XBg7VLyhtIhXDEslgyko881TI9AmxXa39A==
X-Received: by 2002:a7b:cb97:0:b0:40d:8128:bc9e with SMTP id
 m23-20020a7bcb97000000b0040d8128bc9emr1441109wmi.163.1704467088670; 
 Fri, 05 Jan 2024 07:04:48 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 iv14-20020a05600c548e00b0040e3733a32bsm1822953wmb.41.2024.01.05.07.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 07:04:48 -0800 (PST)
Message-ID: <b103923e-1f89-4dc6-8cb3-95f77878bd82@linaro.org>
Date: Fri, 5 Jan 2024 16:04:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 19/25] misc: Simplify qemu_prealloc_mem() calls
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C_=C3=A9_dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-20-philmd@linaro.org> <4ild1.0v3gsvmc0lqe@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4ild1.0v3gsvmc0lqe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 22/11/23 08:38, Manos Pitsidianakis wrote:
> On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> 
> Commit message missing but indeed there's not much to say

I amended:

   Since qemu_prealloc_mem() returns whether or not an error
   occured, we don't need to check the @errp pointer. Remove
   local_err uses when we can return directly.

> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

