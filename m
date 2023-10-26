Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D092C7D81D3
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 13:32:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvyad-0003OC-Qg; Thu, 26 Oct 2023 07:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvyaB-0003KB-HS
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 07:31:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvya5-0004SJ-R4
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 07:31:21 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so127563266b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698319875; x=1698924675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfsF3RQSk7p6ZYfHiEg0EH3ueuNzJO9wf0CeyMAjqbY=;
 b=uFjJ9GKmHA2Upto3OuIUbkVCTuWA9k39rtmAfqdfy2U8w7o+3Zraq26vWHkPFP23PF
 Mc/PAYq53TdHRav3Pmrlw/VqGuPznmfQBtdOxfwVrVLeb0h+3sRbayaX9sUYfj60qDdq
 9vT6YqQKfKwPPjVgvtGF9K8OX63YRdN1xq2GYGHd6vKwS+hEzy2oIOUsQv6kURlvzcyu
 63rn4bOY/Jn9FyS4PaRZeOIV6fiokSXdtWaxBgZj4I6gxkMBJPqHpUAiHb38jqauMowD
 dx/xjLtltcjWfEbathwyykeEG0VLm5CCTKV6+4/JZAP4WrWsst/6FBUfNXFHJ4WeTjGe
 rDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698319875; x=1698924675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfsF3RQSk7p6ZYfHiEg0EH3ueuNzJO9wf0CeyMAjqbY=;
 b=NBeWC2QTeCoqEmVRnCWy+J7KX+ReAWO3ZlD9bGQO1xD4Vtq1cPhDyyITmt3wpjEgzR
 NbzhhU0Rr485dJuonV8TcXOjo219ST1kG85n1SaBkw7Tt31ox5MOYdXAL34//1q6XgF4
 Tm8sjvl0Kh+HtY46vZ/FaVTMiAKXJ/9cvQiI99yrLJs8qQ6wCETTSm0lDZIqDZ80xOml
 rZaQ9zoFQE75c1xZFr0FdDLqzR0n/t8vnPTI9TYU50gTzaiZy/VsTWRBqZqvLd3UwlQz
 bku8sqD0Tt4BHGREXP0e+KiEzOz5vfG5QpJtTwG9gRncA38EPa9lE9lvg9XREFCNFu3r
 preA==
X-Gm-Message-State: AOJu0YzHau7ZMq37p56vVN1/FW+uymPXvz/bzZOv3IWXnQ6Q5w2kcPQh
 wZfi87qBM1J0dNY/p1o5oyGeSg==
X-Google-Smtp-Source: AGHT+IGJrizQIZ0dopMXdN+sb0gU6CsYidGWGsW+h6FfGfV7ixcwInBAaXzbStKIA5NNbBz25IaHmQ==
X-Received: by 2002:a17:907:804:b0:9be:e278:4d47 with SMTP id
 wv4-20020a170907080400b009bee2784d47mr15855696ejb.27.1698319874857; 
 Thu, 26 Oct 2023 04:31:14 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
 by smtp.gmail.com with ESMTPSA id
 do6-20020a170906c10600b009ad7fc17b2asm11603734ejc.224.2023.10.26.04.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 04:31:13 -0700 (PDT)
Message-ID: <de24a508-a012-de02-4977-995eeaffa787@linaro.org>
Date: Thu, 26 Oct 2023 13:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add include/hw/timer/tmu012.h to the SH4 R2D
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20231026080011.156325-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026080011.156325-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 26/10/23 10:00, Thomas Huth wrote:
> tmu012.h is the header that belongs to hw/timer/sh_timer.c, so we
> should list it in the same section as sh_timer.c.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



