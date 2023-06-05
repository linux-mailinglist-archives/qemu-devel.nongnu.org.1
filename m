Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD27228A5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6B30-0004hu-2Q; Mon, 05 Jun 2023 10:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6B2y-0004hY-7G
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:19:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6B2w-0000PA-HZ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:18:59 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-543a09ee32eso958705a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685974737; x=1688566737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1o/4nNRUiMzvtSssqrdIdkQhMn4my9sOI+BIHxag9mc=;
 b=XWv9cV8wkO823uzVDVd6VUPuSRU746d7fLCK9f9oslbf54lHyG7fkkeddxrZHg512B
 V8Ydx7+YjUlmesHi5rTBqi3/6rwxK8e9xbUvqMeu4Iji2PbfB1zaW2Po1WFClh8eG857
 7Ya9p++WxryHc1RPK8lMvT+posUl2/Rnp4rDFDUNJx8lRUt8+T05xodE5tf09kskjUAa
 lLzt/kgZF9+XkZrc5dLZ4CaBDEt526+jgb3h5HL5rY5RxTbq7kWlNxE3thlYBbApMPnV
 VMGZ3fdn8yTzX3tesmje3V3a98iajSDhxPtwvVWeHKG7XiV14g3PjoIEGnmtZprkFS1Y
 BxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685974737; x=1688566737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1o/4nNRUiMzvtSssqrdIdkQhMn4my9sOI+BIHxag9mc=;
 b=JRZUXfPgbj17+J6iEjAopVNxApX+daoiI07EgWwWI8x5JXc78+I2qJ/Z2VO2w4xGDj
 zDtUXdwJ3HMG5vrsou5XR4/9GtoZO8T0hrXTMvZPqksR/AwmxoSdz4kqepT+gn07g8VC
 e0cxxV3HR4uh2+RDVRLNrqBYvimdSVjvjmLnVq+pzkIldSVYLK715Vy2OKUfWut/kfSG
 a0CKK4hRH3T151hWpB6S7eRtPN3l8g5z2CVdeHuLG0B6QsfzXy8JgVXFIPJskvZrXJ0p
 yfNJV5Iw0HLUxg85laE+F+rCfDa/BcubKXPzcEuJLI+ZKdytSGtFaNlMzCqgihdT+fxM
 sKwQ==
X-Gm-Message-State: AC+VfDwytJywJ6TI/r8tY1vH6YEb2cO/ljdYUF5MI3K/X2Qy7id3Pz9h
 +VCRCyqkskFMg580y07IejrRpw==
X-Google-Smtp-Source: ACHHUZ7d33b9gPIlYxYo+vVLw0gIU0hN/sL234qE2ux+faEZ1TGZKYAnq/1DuWmcCQFGLKWUInuaJA==
X-Received: by 2002:a17:902:da81:b0:1ae:35b8:d5ae with SMTP id
 j1-20020a170902da8100b001ae35b8d5aemr9295365plx.19.1685974736877; 
 Mon, 05 Jun 2023 07:18:56 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 ju11-20020a170903428b00b001a9b29b6759sm6661218plb.183.2023.06.05.07.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 07:18:56 -0700 (PDT)
Message-ID: <73830e25-76a6-55b0-0f5f-2baba32b978c@linaro.org>
Date: Mon, 5 Jun 2023 07:18:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/1] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230605031848.1428047-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605031848.1428047-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/4/23 20:18, Song Gao wrote:
> The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:
> 
>    Merge tag 'migration-20230602-pull-request' ofhttps://gitlab.com/juan.quintela/qemu  into staging (2023-06-02 17:33:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20230605
> 
> for you to fetch changes up to 8555ddc671203969b0e6eb651e538d02a9a79b3a:
> 
>    hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes (2023-06-05 11:08:55 +0800)
> 
> ----------------------------------------------------------------
> Fixes Coverity CID: 1512452, 1512453
> Fixes: 78464f023b54 ("hw/loongarch/virt: Modify ipi as percpu device")

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


