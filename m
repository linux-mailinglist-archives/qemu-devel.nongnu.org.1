Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55B7922D5
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVpu-00071H-7I; Tue, 05 Sep 2023 09:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVpr-0006zR-9U
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:11:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVpn-00020D-76
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:11:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401bbfc05fcso26281835e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693919469; x=1694524269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfV8wtfuDKI/NA9AcdFoGCyfZyf59zkBatLeFk7ol/o=;
 b=Ond6wo7mvcbK0sp66DCWfytun9odqAJmTb1jdX+XI7DUE16w8nTGxUov4h/6sm0wsv
 OFlK3Wtak90l//+/GKtkLqLjyUhTxKqJsAFCmwqNGXFNnWWmnEaFObFULIMH2h2NsOAn
 82RE3GmAb2dxSQ0w9PQnekOY/p/kGeoGnSQka/3Tv2BWYoxnJ69R3ILzDmzwzeG1i1zf
 tv+rFzeMWuWeNXgaWL/K9m8huwpob85vqOqAEpdH8w2Tw9OTGCyxAqm13J/xGk0y4BRp
 VdYlZFh7l43M2C0GPXeamDtBKJR+GlwJmE6inJV1TtNiIqMdi2SdPOw3kBZ6yTwfvpNf
 hsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693919469; x=1694524269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xfV8wtfuDKI/NA9AcdFoGCyfZyf59zkBatLeFk7ol/o=;
 b=GmeDI0/ZBf41OeGGM9C8Fnb1BvEYC3pTJU8EXn10EAmZKLo4ThZf5uqsEXOIVaiXxV
 DIYOgF6ujD/Fh8iQ4E4mqF1FrsA89FCUllzGNVtrKuHM58NxInZy0crgwC+Emxa+eNJE
 dhwsLyACnmzBZht4Gmep5LkCzXgsGgTOUMyhEyhZyF5lbx9ZxvWDYDErhdcdygDT07ZD
 a461ZietDh+uaqu+bV048ZnngWx7eZ3zyAkg9Hn1dZJmRBwdoMnTHFRl3e47fkizSnN9
 SIAhFY5aHOPnVCdgQ6soif9vhCX5JIL0iG//0omBqRs5772KJVwz1toHB8jq+HRXm/dG
 YOjg==
X-Gm-Message-State: AOJu0YxlChJFlTNHMuxXtif2iPl1FXcziVjHsaRuSHHMVEDFnplk4qlY
 oez0he1SUS1Cmwk69i8idx43bQ==
X-Google-Smtp-Source: AGHT+IGAOUcEzdfYZhtbC81vInYi9aff18FsxJlD1AYXD8zOSWg99r72UQi96gK5DC5pffRzZ7HLTg==
X-Received: by 2002:a5d:4ccb:0:b0:317:3b13:94c3 with SMTP id
 c11-20020a5d4ccb000000b003173b1394c3mr8805587wrt.41.1693919469391; 
 Tue, 05 Sep 2023 06:11:09 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4147000000b0031de43fe9bfsm17638113wrq.0.2023.09.05.06.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 06:11:08 -0700 (PDT)
Message-ID: <d606dac8-5fa3-0717-8921-dd0688642e07@linaro.org>
Date: Tue, 5 Sep 2023 15:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/1] target/loongarch: Add preldx instruction
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn
References: <20230905123910.3052023-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905123910.3052023-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 5/9/23 14:39, Song Gao wrote:
> Resolve the issue of starting the Loongnix 20.5[1] system failure.
> 
> Logs:
>      Loading Linux 4.19.0-19-loongson-3 ...
>      Loading initial ramdisk ...
>      PROGRESS CODE: V02010004 I0
>      PROGRESS CODE: V03101019 I0
>      Error: unknown opcode. 90000000003a3e6c: 0x382c6d82
> 
> [1] http://pkg.loongnix.cn/loongnix/isos/Loongnix-20.5/Loongnix-20.5.cartoon.gui.loongarch64.en.qcow2
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                  | 3 +++
>   target/loongarch/disas.c                       | 7 +++++++
>   target/loongarch/insn_trans/trans_memory.c.inc | 5 +++++
>   3 files changed, 15 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


