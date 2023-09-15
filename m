Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F58C7A2445
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCGQ-0002oK-CF; Fri, 15 Sep 2023 13:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCGO-0002o6-O6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:05:52 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCGN-00014i-3G
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:05:52 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-502984f5018so3951314e87.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694797549; x=1695402349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uc0ipgrPD8RlCu5sHCNArZoXgzSz+ZqYoRJ/5qMNAFk=;
 b=RXnlhaPQmccqNdrx0CS+gUjjarXbEzorH6JG/J9/Q15s5sAXRrmrNoNlJEFtE7+GN7
 RE03n07hlllax0fP86fcCo3bQ7JkrsySIK8FjEzNhOUGgXW9tEiUFAcv5x6WFj+hLVjk
 fr+wIPOI2Q9QnzV6GVuJWRHDpA3BSfng6yC7DijLsqYL3JLV/ZrMeDCFSRVYjizmQX9y
 72GSPCAihEpRrDfoGzVXnOcLFwS9wViI/HrQQFOoGjeXtbezj4IIVeg6UA4p6ziR6Ah9
 I/h8zPm66xm9/FXILEcWhWnVaSbwRQTfjuy3PnUdmiA0UKPr7wnDz3r1XrJJ/R36yQxI
 q8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797549; x=1695402349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uc0ipgrPD8RlCu5sHCNArZoXgzSz+ZqYoRJ/5qMNAFk=;
 b=BUXmJNYxmn+AZpQEOC9fCT1C/sKaoClNnpFtrbwNEyvFkCmABrYXyLTuog+FEmaU15
 HW2JSkCtUeDh+vUjz4hxGInfAgnqcsIp1QVW15vVfZohJYvf6wwvnb/bxEBYn0gkn/CI
 pGXvXyDuETRG7TI5I9mIy5gLcnnvDe+ma++g3gLaecJZzjQYzB82RqpXLLR8YzIQqkfL
 3SRCRpC9A0yTIrb/H8o/wB+8X+IR1uZ/9iU3IATqcVsOYEkI4kOx8PP8GROQ0W5XoyvP
 fkFfCuqesmFH9A0MJv8s77N9ejSw+hYMFeEpXyvpLrSeg3j8nQkjt4W/svUnvKPQgCqI
 c7eA==
X-Gm-Message-State: AOJu0Yzqq5OKGQ2bxhl+RlwLhIECtLUDtvHF6llEwz/8CidSVmRfLOuE
 YxWQ3x0VQUcaujz43Tm3tbXHzA==
X-Google-Smtp-Source: AGHT+IFU1RP/+M9C042GwxHiPTS5hmlU3YiydCJEHWbKbrnJ/lrz6hi86pXFom/F1Lmw90luY8N54Q==
X-Received: by 2002:a05:6512:3c82:b0:500:b2be:61e1 with SMTP id
 h2-20020a0565123c8200b00500b2be61e1mr2460904lfv.58.1694797548675; 
 Fri, 15 Sep 2023 10:05:48 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 t13-20020aa7d70d000000b0052328d4268asm2450142edq.81.2023.09.15.10.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 10:05:48 -0700 (PDT)
Message-ID: <68061609-79f5-78a3-548f-2cc5ac2c2828@linaro.org>
Date: Fri, 15 Sep 2023 19:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] vdpa net: fix error message setting virtio status
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei
 <yin31149@gmail.com>, si-wei.liu@oracle.com, Jason Wang
 <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
References: <20230915170322.3076956-1-eperezma@redhat.com>
 <20230915170322.3076956-2-eperezma@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915170322.3076956-2-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 19:03, Eugenio Pérez wrote:
> It incorrectly prints "error setting features", probably because a copy
> paste miss.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


