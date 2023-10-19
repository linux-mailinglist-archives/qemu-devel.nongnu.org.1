Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 792897D041A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtalM-0004M1-2k; Thu, 19 Oct 2023 17:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtalK-0004I0-7I
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:41:02 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtalI-0000Mj-Ns
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:41:01 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507973f3b65so156287e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697751659; x=1698356459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zr55r2AeBcnjH3tOVL5JBchW9ADcgy5ONzknaHE7wsM=;
 b=dBCxYAOd0TgnUuWy5qd9dbxdgq1GijQAbzpxDUnyhhY2TplNktpbGI6RJBtFUVj49a
 YN7uuxgGt9cuGjUfkeDetugnIokyf6nWx4GeKfE0A7iVYcNspuImG1dHrl2dsDOZiqpY
 DCoW4UqwVEBSfXfYg4ETIJ3FDWyo0DQV/lUdJ44OCKyYvP43qV51nx7HpSycpe3RfjS/
 5oGTzIkZHfpTKaVlJFJxl0V886O0rfHET1cc7a3BAkuE94/0VpL9NNggOiZQCpapXhnq
 Ud9kFkCtxpwvz+e2zttqVm08YjE/aFyelBBdqfThrl4gjGb+GksfuKZhTueqXS8iN8fr
 XRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697751659; x=1698356459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zr55r2AeBcnjH3tOVL5JBchW9ADcgy5ONzknaHE7wsM=;
 b=WLU0bootrAFQBLNicio+GRLobJsFvyONltp6caJ+XFXNlXbK/SgKwV1rHBdAv8RLP3
 8qKz8XbH4t/v22iGVEYkx3LqdGYp1TMpCJsL4rDK/Rd+SaGMcreYTPG5gtsFQAXX4AtK
 DVk8XhYPRYEV8hd0DGsuEelu82lIIdA+Co91Dlf3dK6MTShbHBwhqVo0g5Onj8BetF6f
 yi3oU963fbQ3Us1yjIHWTVg/R512zRmUdEsfoBEplD+YO8OmtMa5aiZ9nbaSW1UOGB/x
 lZHOdkoClycajmYrRXmjlWKrZYpAh6QNYDvlXCoqLb071XX2JLZ/i3/RMSpWd+Vi5LPr
 uxHA==
X-Gm-Message-State: AOJu0Yzwp+aVmD7vh99OmEJtq5dp6LC58x4X3nidVNYlXc/IthD5CWlB
 SLHmVn7iQC2VNTjLcmxj0f7mB8/RxNRBkfxPi6RUHQ==
X-Google-Smtp-Source: AGHT+IFYe5cNFsa9gqi9uksRIG2tEg57YcUKM+qVrbDsL9LuIpkPhm1xHu4XZzkMvqr/dP6NXVmlrg==
X-Received: by 2002:a05:6512:612:b0:507:9787:6776 with SMTP id
 b18-20020a056512061200b0050797876776mr2393552lfe.5.1697751658872; 
 Thu, 19 Oct 2023 14:40:58 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 mb8-20020a170906eb0800b009ae57888718sm215110ejb.207.2023.10.19.14.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:40:58 -0700 (PDT)
Message-ID: <53d5ddf4-20c0-bdb4-5fd2-82555990a6f7@linaro.org>
Date: Thu, 19 Oct 2023 23:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add hw/input/lasips2.c to the HPPA machine
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-trivial@nongnu.org
References: <20231017151933.213780-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017151933.213780-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 17/10/23 17:19, Thomas Huth wrote:
> hw/input/lasips2.c and the corresponding header include/hw/input/lasips2.h
> are only used by the HPPA machine, so add them to the corresponding section
> in the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Thanks, queued to hw-misc.

