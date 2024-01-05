Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E2825C4D
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 23:02:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLsGI-0001TR-UN; Fri, 05 Jan 2024 17:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLsGF-0001Su-Qx
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 17:01:51 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLsGE-0006is-4w
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 17:01:51 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5572291a5abso25072a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704492108; x=1705096908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2LlEfg0bBszyqL65Ck8sEp3J1IR6xB+xyaxAYp/yJhU=;
 b=Hmh8e3Njlw8SED/HzuiE/Iy8DfFHIgmDQZKmzI2wJLhVs1GhBKpN6MqAf9R01o4NT1
 9qNxWhZB+RTmUYDCD2SMQeOhPP5I9NUTYw/rsV9G9CkxCLeUpz57Yx1Ghtdi89pAJgtJ
 UWxw8TdR/uPJqxd9Dv0DIviphgVJBX9Lt1jzpPw68EFspLIsyFDieeKLuSd51cszFv/N
 kpTdpm0BN5mOnrYIzEwgwuBiWeNyUajD/k4x6vIh1pZdCs+MnoGmq00hjZKb/8TyqtmU
 ZwaT6O7X0Hr8sF/RcktAHOOCiE8vG20sxOegOs2Io0ThLLhrzX1055cjdiTo9x6mkPCm
 G5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704492108; x=1705096908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2LlEfg0bBszyqL65Ck8sEp3J1IR6xB+xyaxAYp/yJhU=;
 b=HLgoTccYztWgf6X36/XfHlzCzvhMesd4D2IJVULJMLGKu6rk6kRru9t+BWna6cFWPq
 sDTHrka77tfWBJ59UZjNAIQbxYGduIEiLicYxenFUDkqbfAPsuOSIeCHxRbLk8qRrM17
 YOR1X/FPjyzIucUFRcpAqQhVXB3OgM8gEdE0OdodFU7NTUPjo7qSEzEPQYK3EwcW8AO1
 yrGCxB//4JENTxixYlkq8ylRpS8R+W/n+F7FCI6roKh30SCNPyO+3pZgQ3Sdgj28Mayc
 JqSyFnWHSv7cC7ynXlos3HQ1SMsNNPQhOh4z5Pp67qU4PQ1fwA+6sNx8rykJXB8t9c+F
 SZ8Q==
X-Gm-Message-State: AOJu0YxJGbKjITxZFFsyTmZkyYyUfwkKhuBFGKW0+DungnJuOx4I3NcQ
 HAGRIaRmonJqsUf/xoU4OZesCp3mRJylVg==
X-Google-Smtp-Source: AGHT+IGCxwh6ZH5JH3L13YQsxCvezipyfyXlh7AlSQ4Kp/dUEubB1EKO6Z3o6/Irtg0mbGBuThgtTw==
X-Received: by 2002:a50:8d0b:0:b0:557:44ae:c5e4 with SMTP id
 s11-20020a508d0b000000b0055744aec5e4mr28472eds.77.1704492108542; 
 Fri, 05 Jan 2024 14:01:48 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 e23-20020aa7d7d7000000b005551b2f66f0sm1393674eds.43.2024.01.05.14.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 14:01:47 -0800 (PST)
Message-ID: <c8574a72-df49-44c9-992b-63b3b5f0057d@linaro.org>
Date: Fri, 5 Jan 2024 23:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/sb16: Do not migrate qdev properties
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20231124182615.94943-1-philmd@linaro.org>
 <48dcbec1-dceb-4bfe-8876-96b99c8ed6c7@linaro.org> <ZZdinF59FrEJDhhZ@x1n>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZZdinF59FrEJDhhZ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 5/1/24 02:59, Peter Xu wrote:
> On Thu, Jan 04, 2024 at 05:48:18PM +0100, Philippe Mathieu-Daudé wrote:
>> If there are no objections I'll queue this patch (fixing
>> the typo reported by Zoltan).
> 
> Yes feel free to.  Thanks,

Thanks, merged as commit fa293f8125.


