Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEAC7FBB11
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:15:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xv8-0002sH-Q3; Tue, 28 Nov 2023 08:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7xv4-0002rb-CF
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:14:30 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7xv2-0002tU-5N
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:14:30 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a08e4352992so550677366b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701177264; x=1701782064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wv+gmnL8J16L1l7YYAj7C2zH+0NIwbizMaSBPX68Mt8=;
 b=dE8PTe0gbI8WDZ2TxViNlBfa9BRtbkzqDyCGkseEg06x4JxAjth7tLhFiJIFN25fBu
 SY60YEZPKZ+QgRPfmGJ3SiTpHd8cMNR69goJpCmM2MYB7gPXRvVM5r4i4JoewhhW1gSk
 l+bXlLjNkoSaD2x0Z0+teYFGhkhkRv1Cuio3f4nxZ2PoPsy2UjUyb9quA0Y/pqNnlFKo
 9OKxfSbVg72a9yCC3y/tG1UFPSJmHc4LSfJ9oOHDSOLVUk14CJEAoYcOP8JNgvbmyDhh
 qn6xUB8HgOyFTSswxsVBxEBTPq99gPNQIz1O8Pcb6zEgylgIHOdObAjeAvxcjZvv10zG
 4xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701177264; x=1701782064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wv+gmnL8J16L1l7YYAj7C2zH+0NIwbizMaSBPX68Mt8=;
 b=PNsPYINH7IBCpJcPDFWS5ACzBaQptRFiDwf/OJ/GAO2XSHB6sKgBkToCrFCMFkFCQq
 Rw2BEjGbgE0gEY28PpRWoUGKC3Bx2cKjExQ26OxqW+cyCFmtqhW/0rx6+kGYFo9IXJ2N
 DOqS1/B80WDy4zuIsOVOE2Xdc/VykkcTI8q2RvkmCVRUTzkvd6pH7/E41jomu/QftuLk
 tWeE0rupxlbGKq5o3IF0QT/ilMNawytDzhHf/yic2rExA2qeXTM2mQgw2sa5i2b6+qc/
 D/DcRMEivf7okE3xBRhkjtueyCulgRPg5kbDujnORuXEpP+luZ8UPFwiFmSOdvNlqAHV
 pTKQ==
X-Gm-Message-State: AOJu0YxMBokpZZUWUMYwwUJHYwvVdGDf9vxJq3MW5MD9DVHfBjlirJJt
 Wlzt70iG7A93WRVZL9duess+1w==
X-Google-Smtp-Source: AGHT+IHaAZdN3zqDqa9l1IX8NVYoCfRVvotAVzrrKpTGqXhXeKUTaWBma7xCN9rDMnB4eDzGXf/6Eg==
X-Received: by 2002:a17:906:f354:b0:a0d:efba:4492 with SMTP id
 hg20-20020a170906f35400b00a0defba4492mr4707615ejb.10.1701177264594; 
 Tue, 28 Nov 2023 05:14:24 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 j20-20020a1709064b5400b00a11e9036cffsm1202811ejv.195.2023.11.28.05.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 05:14:23 -0800 (PST)
Message-ID: <72c2d2ae-6f47-4a43-98a2-fb589f5e9de0@linaro.org>
Date: Tue, 28 Nov 2023 14:14:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/s390: Fix wrong command example in
 s390-cpu-topology.rst
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20231127134917.568552-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127134917.568552-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/11/23 14:49, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
>  From s390_possible_cpu_arch_ids() in hw/s390x/s390-virtio-ccw.c, the
> "core-id" is the index of possible_cpus->cpus[], so it should only be
> less than possible_cpus->len, which is equal to ms->smp.max_cpus.
> 
> Fix the wrong "core-id" 112, because it isn't less than maxcpus (36) in
> -smp, and the valid core ids are 0-35 inclusive.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
> Changes since v1 RFC:
>   * Fixed typo. (Nina)
>   * Polished the description of the reason for fixing the wrong core-id.
>     (Nina)
> ---
>   docs/devel/s390-cpu-topology.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Patch queued, thanks!

Phil.


