Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFFB78FF56
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5Iv-0001A6-SH; Fri, 01 Sep 2023 10:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5It-00012u-0v
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:39:19 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5Iq-0006Ux-S9
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:39:18 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31dca134c83so1723976f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693579155; x=1694183955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rnf9zgg6R8u3E7vZDk2ckuRwyiSUU1VRytWzDkZQYao=;
 b=UiXqe4ngZ7mHTtKmcCFjdz30JXyIqYUzIGS94iFCfGIqwkjEt0q0ALrlOJ+a/+Gv+B
 JaQNr3tE9q+YF8uhh7kmlO4J8li+VXY+FMmZwB9cNT8aAlBm87l3FKIuUeXTw06C1os2
 NceaqlIKiyaZG4hKZVcbmo8QBXazJSsk01Vto6TbBOIBrBlRJEEFKPjOkP/Qtyouy+UW
 PA4oBB/gpRoYYbK3PKUGPQjS7ISgFoJVUdG6juEDQP4w1DIXD0Fyn5zOnZ4nIsk74tGu
 y0StDvjR3fV38dakG8Dejzzom3ouYVxZZEKmTCNU7aJu4wD2TeydOcQ56AGTe9SeKxEw
 Xwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693579155; x=1694183955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rnf9zgg6R8u3E7vZDk2ckuRwyiSUU1VRytWzDkZQYao=;
 b=c2ts6r9tLJ0ygC7wdXqClLTbcGDx3lWOqVfM+FDc3gYgG76idA/Xx5Qo5ytsg4Run9
 a0CnEMxmtyd8ZmZWwq2Pqjd57PzrWPzoNtFn0UGzjI127Kpu8wCjfABNlOlRnpbmDMNQ
 8tASFGBUJNTw07PWwJ72EDz2WJi3q5I7JZ8SopkWrvgg2m2tX5MoIy9cNw4RqikUlmp2
 OSlPzqsptNuADKzcKIqw7TI4g0p471FBzeewrpHu1UexOLrawWxypNtt9t4rEUYtIltn
 Pi3SgniB+htil//KgsTf+I0ALNjNbQWgheSWiFuhzWEFd+MIbp49fQ+1J4ZMbgfewROZ
 +tDQ==
X-Gm-Message-State: AOJu0YzzponD545IQY9IwefqOFAY8Z9O60zaBTPoNL+sfQXZIJx/Iw+N
 DRbtFCCoqsoScsnJPMj29UILp772JorT9PiRmME=
X-Google-Smtp-Source: AGHT+IHJmWDCOse0EqgC5E97XuptaZl8PcyTGiJ8ApLcqVWuYFvjjxsz79EdPlRbXW7UAoxMCVmllg==
X-Received: by 2002:a5d:43c3:0:b0:317:3d36:b2cd with SMTP id
 v3-20020a5d43c3000000b003173d36b2cdmr1793122wrr.71.1693579155203; 
 Fri, 01 Sep 2023 07:39:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.220])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a056000050300b003179d5aee67sm5378161wrf.94.2023.09.01.07.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 07:39:14 -0700 (PDT)
Message-ID: <342296c5-41b8-31ba-4331-6c067ed4fa1c@linaro.org>
Date: Fri, 1 Sep 2023 16:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 07/13] linux-user: Show heap address in /proc/pid/maps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <20230824010237.1379735-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824010237.1379735-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 24/8/23 03:02, Richard Henderson wrote:
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


