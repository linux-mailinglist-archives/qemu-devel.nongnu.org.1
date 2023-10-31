Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9077DC7FA
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 09:15:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxjsZ-0003Zi-Mx; Tue, 31 Oct 2023 04:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxjsY-0003ZN-Dd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:13:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxjsW-0006JQ-Fj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:13:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso41943315e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698740015; x=1699344815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DYfXMBG7qLYXbrgOjacDKwXBzHNVF65J3hkuqZlLZ2E=;
 b=K1a/m48/6o2PGxDpw0Jy5dX3ZULETFPE0gbw3aX17bdPZS02bJK3aSBb0Ne2gBwLbe
 gDxon5te01oqvmHoPEU9dtcbNwc6BR2psCn+CbCslH3C268SeHDWA1fN2XSuUe/P8N6i
 pNXw/5kt5C1sVeRwOL5BtzIjY8hoC10ZKTVE8dybIIIsl76tyKYk6cGbzI6pRhJ4lXJk
 hxWLTWS69Xrd3yITohfeIU9qnbi+ETuPSW7B/7t6Cd5fzh6hX4IhZLr0jMdERdOEO1gY
 uz9cYRDoUNVcsrrr2mxCm2mqwBR8M7vNcKFYS7PAnwBdt1sazGbzOfewlgxca4AkNU5u
 VtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698740015; x=1699344815;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DYfXMBG7qLYXbrgOjacDKwXBzHNVF65J3hkuqZlLZ2E=;
 b=XcqDtq3eA7mx3LEJuDcnEJ2dB9TjUyEH1SAwGb5VpnXLyBCUJ/u3j1agi2KVMYrVLT
 YeqcfMtqMe2r7AOn6UgfZTi0QUlDh5WA+yPC+bHprxe4poSnIFfaftp2XjrO+13Ph1Nr
 z0rcGHsQpCH6CqGOWkd5m/mvUwIJ/+dLvIEZcOkwLTAd1yT2N5FcS0etfw63My1bGzTz
 GKZFRbB7qqIKNqxW9DjxHuVzYyjZOr6GLAb+0fgmWcTwM7kAW0qrfd71ulq4mLsDBUbL
 lPIBzlH8cCjpjGDEbVZRdxWPblWoKsP7EAhe2wFQTrOmhWKstc4cdfyQQCJnr1/Bg81F
 huwA==
X-Gm-Message-State: AOJu0YwZTtnKDemr+atkBnJh3PJkGiRX2HvEpYkwN0yBNR348YAl3ikN
 ogNPilOMegXZJTmdJf8//Dnrag==
X-Google-Smtp-Source: AGHT+IGEcTOmDD/LFkMzWEckJ3pLLbLxyZcFjYDs9xvv52iVIZ2Xb9hzlBQqhbjQ+wk2yGLzLU9QkQ==
X-Received: by 2002:a05:600c:4f0d:b0:403:7b2:6d8f with SMTP id
 l13-20020a05600c4f0d00b0040307b26d8fmr10195086wmq.2.1698740014821; 
 Tue, 31 Oct 2023 01:13:34 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c468f00b003fe1c332810sm1006464wmo.33.2023.10.31.01.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 01:13:34 -0700 (PDT)
Message-ID: <8ff4c5dc-884a-9190-ff0b-3a313b1597bf@linaro.org>
Date: Tue, 31 Oct 2023 09:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: =?UTF-8?B?UmU6IOadpeiHqkxlbyBIb3XnmoTpgq7ku7Y=?=
Content-Language: en-US
To: Leo Hou <leohou163@163.com>, qemu-devel <qemu-devel@nongnu.org>
References: <c295140.2281.18b83b65ec4.Coremail.leohou163@163.com>
Cc: qemu-discuss <qemu-discuss@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <c295140.2281.18b83b65ec4.Coremail.leohou163@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.441,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Leo,

On 31/10/23 04:10, Leo Hou wrote:
> hi , all
>        Does qemu plan to support CPU heterogeneity?

Short answer is yes. When will this be available is yet to
be determined, as a lot of work is required.

I'm going to talk about the challenges and possible roadmap
later today, feel free to join the call scheduled at 2pm CET
on https://meet.jit.si/kvmcallmeeting.
(See 
https://lore.kernel.org/qemu-devel/calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com/)

Regards,

Phil.

