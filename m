Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793127A2850
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 22:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhFey-0004mB-TI; Fri, 15 Sep 2023 16:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qhFex-0004lc-Cl
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 16:43:27 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qhFev-0005YQ-RC
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 16:43:27 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-502fd1e1dd8so446082e87.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694810603; x=1695415403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zc/gQrD0njymmwjojtfN9lhk+hCU88x/cyewRnzjtAM=;
 b=XiE5Gxo7LV0QTdHr9QgCULCkioAd5Fqv0lLxWntMU526ZT6E5OvLbguImpgBb2K+gK
 6ZlosTSMNP8Np1qFK9fimqDVPeNXNL+GolFoYgH4Lige6+B+t6tUpr7Nsq2iHgIylX6F
 h63NNsP/Ka9+Ow6o2ykMGgJIQ6bLnwZ3Qs0+43cbH+t6eqPQZoy7KBTOErXe0lWKkCWs
 V3JDRVhsdepYEvnclHaZSdsB/8Nwx+Asu672cVvddW3HM9ookjNYtd52fV8bkTZAlOE7
 wYvLB+XADsUNHaFYahRk+gx3WsIKMDCBL2aph5unfpLmqd3RS5SOU0+L9YvvF9T+9Aqk
 LsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694810603; x=1695415403;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zc/gQrD0njymmwjojtfN9lhk+hCU88x/cyewRnzjtAM=;
 b=sulgpBajj+ugWOhkzHVrYjgHSWFPXzHF+zrA8YALIi1oXXYFS0aj71OT5oiNFaT4RI
 jauyTkuOLYEpj8Qb9wgbIMxDfiTBJHfJDEENu3qm9Wmg9GZ7giNmuZ200pBFQfz8c2BY
 yh1u6kpajoeJRNcwESQhfJ5ScQDyG5wUwnjBlDpRCGOhRcRyOLxlvv5gqnv/bjgfazqJ
 YoGapIk+UYhbR3W1z4vQ6y9W06f/017AJUhptoMS8YTjI3JurxmMupFId2aecpO013Qj
 A68gJ8EenV+CRrCATdQjwfTT2JSQEWLitZdrVkXfzZaujvdylTIy8MrqeKPDFM5gc644
 X/bg==
X-Gm-Message-State: AOJu0YyvPQWbBxUpdS3InE7mngVT6dkaBhBctljCWHe6thxpCfT7Jlk/
 NdCXW2lS6BIL5Uv+QObKG1OriA==
X-Google-Smtp-Source: AGHT+IGAjtHuLzeS/CbE5zANuazt7XWbZGu4H4vhH6RLfQP+ZPXw9lHsNd97/OQue4wYkGeY4tJt3w==
X-Received: by 2002:ac2:4283:0:b0:500:9bbf:da17 with SMTP id
 m3-20020ac24283000000b005009bbfda17mr2352783lfh.51.1694810602898; 
 Fri, 15 Sep 2023 13:43:22 -0700 (PDT)
Received: from [192.168.200.206] (83.21.94.247.ipv4.supernova.orange.pl.
 [83.21.94.247]) by smtp.gmail.com with ESMTPSA id
 c15-20020ac244af000000b00502c642ae8asm750773lfm.109.2023.09.15.13.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 13:43:22 -0700 (PDT)
Message-ID: <15dc1b88-49be-4ead-ac7a-74dbee7a3680@linaro.org>
Date: Fri, 15 Sep 2023 22:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Implement Neoverse-N2
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20230915185453.1871167-1-peter.maydell@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230915185453.1871167-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

W dniu 15.09.2023 o 20:54, Peter Maydell pisze:
> This patchset implements a model of the Neoverse-N2 CPU.
> Because it's very similar to the Cortex-A710 we don't
> need to implement any new features for it; but because it
> supports 48 bit physical addresses we can use it in the
> sbsa-ref board.
> 
> Patch 1 fixes a few minor errors in the A710 definition
> that I spotted while I was cross-checking it against the
> N2 TRM to see what had changed.
> 
> Patch 2 is the new CPU model.

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

root@sbsa-ref:~# lscpu
Architecture:           aarch64
   CPU op-mode(s):       32-bit, 64-bit
   Byte Order:           Little Endian
CPU(s):                 2
   On-line CPU(s) list:  0,1
Vendor ID:              ARM
   BIOS Vendor ID:       QEMU
   Model name:           Neoverse-N2


