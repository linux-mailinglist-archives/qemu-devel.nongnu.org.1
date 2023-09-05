Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46979213E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRuQ-0003Ks-9N; Tue, 05 Sep 2023 04:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRu6-0003Cb-UR
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:59:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRu3-0000AJ-Fo
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:59:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-402d0eda361so14522795e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693904358; x=1694509158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fFSdJDombvd+rd5pQzJJ2wZFkYPkFfldpsIghShkl+w=;
 b=HuYCc6Y+aAEWoYLtMntnFZ1dDit4oUwjKQj4bI+KdLHQK3/xlh4U/5SehgIr6CkoGH
 u4sCWZVhf6IRLG09mHWQiNBOwbvX0c1krSXIgMtDNc/MehUmqK+KmgjT+B4gSQ6VpVJM
 rFTVkjxVcNrNKuAcjt9BXGN8C3Y56NqgwlUM/47wkwUVpgeSbpclXIGhnV+LBzXudmVO
 AG4GiHPgUOwDOLasf/JoAcFjhE8GzDiEsrU1xYnrDzR6xmqI/saaK87asVYS43IA1ls5
 1Vp12gW5kJ67rY+jaAw6fqulcPc3xdDVwziyJWaJE9jycHV33H6aL2ED/0fuGUAFwY9E
 lceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693904358; x=1694509158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fFSdJDombvd+rd5pQzJJ2wZFkYPkFfldpsIghShkl+w=;
 b=HCtBsCXWuWX+Nivx2KILcPYsamCp/GmZA4gr/Kk7whYxU7DNTYCGmZmLF/OZps+mpT
 zP2aaUbS4Fd7KK/+LfyVimL/pL1QVC5Gjq6ivWQAjRP9XB+kbfniWmSa4oCYUJoSQrBX
 Qb1pBShgrsi68765Z4eNLOLkMb5JEi9Wopv05x6Cg+zTsnQ2Q3DWYovBnqRP4j5kBmdy
 O30thXutjqGImUJxue2QlOMDzQiZvseiiRJdnCpbk0rBjOrhKCUdivpRJlp+poAQ/pmh
 tsuaiTOjYZNx5a60qy5jkGzXGOvNoVdv1f6zs1cpC0Fq5z7XgZ/18GdJWBp6ZVCad+W6
 JfmA==
X-Gm-Message-State: AOJu0YzRvCgHp1hqRgS4zvEKhCzeX+vdFKCv/mbVmsrYx6DTuXG1Jby4
 gmmp17OaA3/s5scADo6AnWCLTQ==
X-Google-Smtp-Source: AGHT+IGbh5g0fSLsIgi9AROhgesfTcuGvZBYhFTLHDeM+eRrinTmimdhA/+j0sfMjOMfzZYKqFMuzw==
X-Received: by 2002:a05:600c:2181:b0:401:d803:6242 with SMTP id
 e1-20020a05600c218100b00401d8036242mr9250334wme.27.1693904357927; 
 Tue, 05 Sep 2023 01:59:17 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c00d300b003fe17901fcdsm19409968wmm.32.2023.09.05.01.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 01:59:17 -0700 (PDT)
Message-ID: <13f5859d-9da7-4862-ba1e-487e60098fe7@linaro.org>
Date: Tue, 5 Sep 2023 10:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] cxl/type3: Expose ct3 functions so that inheriters
 can call them
Content-Language: en-US
To: Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 junhee.ryu@sk.com, kwangjin.ko@sk.com,
 Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-4-gregory.price@memverge.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-4-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Gregory,

On 1/9/23 03:29, Gregory Price wrote:
> For devices built on top of ct3, we need the init, realize, and
> exit functions exposed to correctly start up and tear down.

You shouldn't need this. Your device class can inherit from
the CT3 base class by setting its .parent to TYPE_CXL_TYPE3:

static const TypeInfo my_cxl_types[] = {
     {
         .name           = TYPE_MY_CXL_DEVICE_X,
         .parent         = TYPE_CXL_TYPE3,
         .class_init     = dev_x_class_init,
     },
     {
         .name           = TYPE_MY_CXL_DEVICE_Y,
         .parent         = TYPE_CXL_TYPE3,
         .class_init     = dev_y_class_init,
     }
};

You can see some documentation about QOM here:
https://qemu-project.gitlab.io/qemu/devel/qom.html
But still you'll have to look at examples in the tree.

> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/mem/cxl_type3.c          | 8 ++++----
>   include/hw/cxl/cxl_device.h | 5 +++++
>   2 files changed, 9 insertions(+), 4 deletions(-)


