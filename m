Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B240282196A
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:07:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbgJ-0007UN-0S; Tue, 02 Jan 2024 05:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbgF-0007U8-9P
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:07:27 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbgD-0006Hb-Ny
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:07:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3368ac0f74dso7786070f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704190043; x=1704794843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6kSRNucXlnu1440jwJ2aYq2E1D8EYIuxrxckRHBVJo=;
 b=O9I4X42v3Kap8chu4Dpb6MjIM99DsbCl91jq4QJoOFQ6APGkim3FCto/jgrMDc5Ko7
 YQzy+eL85gI9vuihaDJz8LiEj8MlliC4+ZPKQu1OT13CMJ/qmwxaufkQOZJmuJwzEigu
 u7ey9/nlblEOT7Qsi+1wlOES6WTjzyV28C7LVdPIyFo8QOjvvr9LscJCzcciX2ZqGzvm
 HmwdFht8TVWWAmCsPYpf6G2/6zsuP/4mrfl5BxGoE4/RuhFtZ/EF5fbfCUKJNh7VJPg1
 I2ZOyQm23Sfg9MFUMtMlZAZme3a6Dk5mswKMjKGEEOWSscu2Oieo1klw4zCpKFkcXYm3
 eOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704190043; x=1704794843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6kSRNucXlnu1440jwJ2aYq2E1D8EYIuxrxckRHBVJo=;
 b=Nx+pZCPIUTg7+Umz28qHfnFr3veB6VsR1aWTN0nCz9hEvGhozURRDm+uoqSaGR255O
 gIT6ivbNJK9iMxTt2VwMSTc+BwbUlM1RoHb+9uiRJjzPHfZHGgL5laVN2R1efkJhf7+K
 su2ZSA1s8qb5pPsDqfs4r2DBky5+kkpam1xN1pTIo2hBQk4Fdnls+ewwFlI23fxlqcq6
 XM/5vhke1QaVq0dmh5RlnRdvSuro/QtltUofBBg7jl/Zh9kE74Os4xRUINZeU5HYW9vA
 7o4G6LUg9eh8jjwfGtHQMgXg07qz3WBFoGlM1Z/joCAJgC/VGho8uhRqQVjQ1n6u/qYJ
 2DXA==
X-Gm-Message-State: AOJu0YwO+VqxSVItp2riMVOBhJFzMdoctaV2/hFWeETcNYAaY3mKbErS
 85WdL91eKk/ajtVN6a1qclYQAY2jNawbnw==
X-Google-Smtp-Source: AGHT+IFMMCc0S4oFSSDDIwRWoYbghc8ILwxdt34VsGRUc5ySzZ7nNFO5TCsVvbZbg0196yA3ASWFmQ==
X-Received: by 2002:adf:f505:0:b0:336:7b50:1f31 with SMTP id
 q5-20020adff505000000b003367b501f31mr9732772wro.109.1704190043397; 
 Tue, 02 Jan 2024 02:07:23 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d6e90000000b0033667867a66sm27932048wrz.101.2024.01.02.02.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:07:23 -0800 (PST)
Message-ID: <7709ca9f-029f-40d1-b3e7-1a8374b2f0c9@linaro.org>
Date: Tue, 2 Jan 2024 11:07:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] migration/multifd: Remove unnecessary usage of
 local Error
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-12-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231231093016.14204-12-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 31/12/23 10:30, Avihai Horon wrote:
> According to Error API, usage of ERRP_GUARD() or a local Error instead
> of errp is needed if errp is passed to void functions, where it is later
> dereferenced to see if an error occurred.
> 
> There are several places in multifd.c that use local Error although it
> is not needed. Change these places to use errp directly.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/multifd.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


