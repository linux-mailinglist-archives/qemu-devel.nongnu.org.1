Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E970A554
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 06:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0EHj-0005yP-Lb; Sat, 20 May 2023 00:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0EHa-0005y3-BZ
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:33:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0EHX-0005Pe-SE
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:33:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f417ea5252so27114945e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684557204; x=1687149204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uHqgTOxO/55l81/eQ2mLjxk3UGcriiFZTTBqZjCiBaE=;
 b=zHJeFMXrT7vK5q140ceAVib6/LL6DkgsF64YCekGJR/U8nRpWJB2zf9Tt1TnEWhJB9
 4v079fl7QIPvIlcvtuxtMpeQBHHFLpXMIy1s38C1rMRuij3yFFFz4ymjzQvyM3y+Rvm3
 IZHkgwBHD2NU2ONsfprm96oXvMM2zEEJaN9eg77gGvMX7Im2hgNU67PrYi1xSnUPQRC4
 YqudXBlOJRK+AcpqW0F6vjx4QpGTI3dLrGH5/7NV0TPXbPN6sMxFDAXWLaY6DI8bfCD/
 b/JLUE5gHX5tMlLwU4UPp6zgO2oSkANnqt8dftRtNOP2RWoVLpPUStUll0K3pxhZMyhs
 LH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684557204; x=1687149204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uHqgTOxO/55l81/eQ2mLjxk3UGcriiFZTTBqZjCiBaE=;
 b=hf4n25oHXqLv63PVouxiWxyVleHaB/lpI+Puyn0kMAnI+ayTsdnPThYcdEsB4/TGDV
 eYY+RRJMH/Ph29yD/LK4nJGYanXQ1wxAA0hCZCjgbiVGqFBkgJF7C14vp7Y5NgyD00HJ
 x/o2C6gmPao4i3G7b6AmhXyPHS1K9Xz39nGmT17epGH4K/PDpyclGXKOdkY/iJvrndBb
 5AgTjnBw9mUYQMdxOU1i1jUBFkZS4RW6mwNMPqj0nJgujCHwJZGkPvhmJ/a+NxcHCZQ5
 q0BGfFwdmWMHSimWtWZ9e6/OXfds+Vm04yzJDu7RXbEt1180+anEW9OAtiDEthEzzSJc
 CwhQ==
X-Gm-Message-State: AC+VfDyuIKhjN5T1FJLsJTByyN7wgRXhFSPg08kNUF0NrI8i/qa4xFiF
 YqaIst/Cz7a6aH3drHw8plNqnQ==
X-Google-Smtp-Source: ACHHUZ7dqcfi+OJ7V6V6aGLMOF7dl+OWF6L2fDDGSVtj6C5uQY91KLUJDjtT03nli0AmtuB+b9IfcA==
X-Received: by 2002:a7b:cbc8:0:b0:3f4:28fd:83e0 with SMTP id
 n8-20020a7bcbc8000000b003f428fd83e0mr2773987wmi.31.1684557203912; 
 Fri, 19 May 2023 21:33:23 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 b9-20020a5d4b89000000b00304b5b2f5ffsm738067wrt.53.2023.05.19.21.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 21:33:23 -0700 (PDT)
Message-ID: <fe0cffdd-a044-ee15-f84e-9799b76993c7@linaro.org>
Date: Sat, 20 May 2023 06:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 2/4] vfio: Implement a common device info helper
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org
References: <20230519215739.402729-1-alex.williamson@redhat.com>
 <20230519215739.402729-3-alex.williamson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519215739.402729-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 19/5/23 23:57, Alex Williamson wrote:
> A common helper implementing the realloc algorithm for handling
> capabilities.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   hw/s390x/s390-pci-vfio.c      | 37 ++++------------------------
>   hw/vfio/common.c              | 46 ++++++++++++++++++++++++++---------
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 41 insertions(+), 43 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


