Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B1277B8B2
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 14:34:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVWm2-0000Dp-On; Mon, 14 Aug 2023 08:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qVWlk-0000Cp-2K
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:34:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qVWli-0003qs-If
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:33:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe8242fc4dso34716475e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692016435; x=1692621235;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=modwVgnyQO0tS2jyHd6PU08kHttePTsxsxzhgr3EUIk=;
 b=llnLhEGRWesHu0mfCdHlQp/v/UwuA752kTdGkPmdpkm1uwT6nNmNVTXiOVUfLB+4bn
 3JVNbRGgvVCgrZ1810E7/hQWuaXPiV5OY/VffUr9Wsfk+VwIsEkOFSyyk68vULYwovSV
 BH5Lxy/93EiHeldu97y6eZaZB/nCxSWtWrlmr9K920x7ugRErYdbA9uV5EvU35+bHkuO
 WKKjuGI9LR11TWIM4GyL1xCHYfhyxncqjCM16jVASN5g0usqLT41tFoFGqufM9/9di3T
 xSydNJmnTXDRwJFLhj9ubTYmX0UVs8B9BIAzuEsUCJzuR+XuFOLN/75j8bhwH2BJrLyP
 XKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692016435; x=1692621235;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=modwVgnyQO0tS2jyHd6PU08kHttePTsxsxzhgr3EUIk=;
 b=W366btwZ+A3/r+q7R5G+APHuLYP6yUpwQTIMwC5B9vNnNlEoXG1UqZRiwSn6IOd5AN
 0oXvncxePHmdn76YEnLSugUqZg6jStTqzWoDtmYS6cUYDDgacu8rTAIBMlqPvPaL6CUk
 8pd94ZWfyV0Bbd80N4FMQDujOmu92zyePvJSFKmvr8J5WxeosDhahA4bAeNk3EZ4I6hI
 7KlZjYQc7ZtGcH9BCLnV3dzlA+bsgKqIFQ+q7AaE6QQwIa4suq4F281xGaxt0EI+9JTS
 pNE2zk1t1kDmkpY0qo1wKT+Rbyv0CTFIz7WyBmU6Zoc3j+sS1PRhuEiSRY5KNo9ihraF
 +QJQ==
X-Gm-Message-State: AOJu0YwkSVxsyLvczfg59pzD5S9DPjhthtpbFSu1FIMddaRP38NfxLzk
 0QXdP81p+IZPfzg8AtKs6+s=
X-Google-Smtp-Source: AGHT+IFHP5qTZciV27J7i7dF8FIlUbM+Cre8sFUBkCkyQCAJrADn5jZgrubt2DJy+RqGiAlBWVpKUg==
X-Received: by 2002:a05:600c:c7:b0:3fa:934c:8356 with SMTP id
 u7-20020a05600c00c700b003fa934c8356mr7379368wmm.10.1692016434703; 
 Mon, 14 Aug 2023 05:33:54 -0700 (PDT)
Received: from [192.168.17.102] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fbb0c01d4bsm14217278wmi.16.2023.08.14.05.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 05:33:54 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <766425f1-1039-b4ae-1ea0-c0c44406fc74@xen.org>
Date: Mon, 14 Aug 2023 13:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] i386/xen: Don't advertise XENFEAT_supervisor_mode_kernel
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org
References: <782b63c1f9c41a6bfa771789cde4b45644b3a239.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <782b63c1f9c41a6bfa771789cde4b45644b3a239.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.265, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 08/08/2023 18:08, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> XENFEAT_supervisor_mode_kernel shouldn't be set for HVM guests. It
> confuses lscpu into thinking it's running in PVH mode.
> 
> No non-cosmetic effects have been observed so far.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Only really cosmetic. Don't feel strongly about whether it makes 8.1.
> 
>   target/i386/kvm/xen-emu.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


