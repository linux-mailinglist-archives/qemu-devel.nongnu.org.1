Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3AC79FB57
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 07:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfGM-0003ST-IU; Thu, 14 Sep 2023 01:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfGK-0003SL-Q2
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:51:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfGJ-00023Y-8v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:51:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso5958175e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 22:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694670693; x=1695275493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lu8VqZOX+buGGcRSpgsfV3KmCA89axPcSWRDVIyuKUA=;
 b=q50Gy/8leSwC2FJAXVX2dM6w2eu8dZCc2xnNqWW6eJuYZXgoDvcgGOXaBac10fK8pv
 4q+henTsdwkev2CgOif2w4RCtybxTjGFeQ+MA5pmAHVUfuRZ5whe+RQp92OX+/EU4/Pm
 4DH41EL4Z/4bAszRFKtJ+a9sLyqtOXIU25MeCVSRKdQy6OWQvMMg3Cn5cDyxNAwo/lCS
 RDZlF1M8v5BRrR5pLN4GuZySCO8F6Fn+wElb0jvsVHRB08NqY0pHrfsMU+Yfzqmje87F
 y4BlXKluavdOOSmvIHMriti71PunzSEbn6U2B05oq8uH7LXzNdglWblFUUzEWB3x7eWV
 c6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694670693; x=1695275493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lu8VqZOX+buGGcRSpgsfV3KmCA89axPcSWRDVIyuKUA=;
 b=oRp9ycmJZUaWuDkHoT8AWgvlR5qa85vkqXUiA6Yg7RmkE+OWGepKtKDonZ/DQTBAjR
 NTLX89L6lOCILWqY6DO29H+CzS8NEI7HKRX0ufiqR0ocIiwyzJWNN/w7ktSxruFdOAMT
 hBRQR29MZgswQ/w5/ymwjscwuw9fAXHXBHFx7AkK+5W0SuzW2U1U4Fw9BXRwGlPyT6wk
 FOMsZpVIw//VlYZxYqiaBuV02+ll6zV2M1YwplhsLM7NTd2pyxTipPNWY+s3b0VME4Oa
 Z/SHZI29+d5H9bgK8MuADgngibD/7Qhif6TTAs0H+w0Xb3Z45LVvHh1T5qoXM5iotjMm
 N15Q==
X-Gm-Message-State: AOJu0YxFAB2sO1mw6vjIwAM/V5jhQHfyT39UXf5xWO7EfDm67U22tXgV
 nU4KY+TiX0BquygQ5Fb+4OPwLYkQABr8IsBWD60=
X-Google-Smtp-Source: AGHT+IEx07pgu/tMYFfzS0D2TXuDEWupGacqNKMQDveSfXpK/STnV+h/N3v2gtt1pbu+joZuPYzp9A==
X-Received: by 2002:a5d:62c5:0:b0:31f:9838:dfb6 with SMTP id
 o5-20020a5d62c5000000b0031f9838dfb6mr3776780wrv.35.1694670692700; 
 Wed, 13 Sep 2023 22:51:32 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 u8-20020a5d6ac8000000b0031416362e23sm753145wrw.3.2023.09.13.22.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 22:51:32 -0700 (PDT)
Message-ID: <45f3efa4-50b6-d259-4845-034b80243d17@linaro.org>
Date: Thu, 14 Sep 2023 07:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/2] hw/mips/jazz: Rework the NIC init code
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20230913160922.355640-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913160922.355640-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 13/9/23 18:09, Thomas Huth wrote:

> Thomas Huth (2):
>    hw/mips/jazz: Move the NIC init code into a separate function
>    hw/mips/jazz: Simplify the NIC setup code

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


