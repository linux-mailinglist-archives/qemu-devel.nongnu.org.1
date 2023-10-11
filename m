Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B46D7C55B2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZSs-0001Fm-8x; Wed, 11 Oct 2023 09:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZSm-0001Et-9q
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:41:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZSf-0000td-Sj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:41:23 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so1149258366b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697031676; x=1697636476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4PUjye3ERdJ76l6US0Zmn24YryjjfRVK7HgRZAA4IuM=;
 b=R/geXxJELaBF6wS6tS7iBO7Ud1FyX6XHHJ0Sz7kdRHqdsURfq4cjYSbSFd7l6+ITKF
 Ylzd4OEZWenhxfi0NVyFmMFdQfoIRlRQHmYzFGHiAUqgP+VHdB/rfxCo6ikhnsVKmxEK
 A91JWqaXlo9Rb1n3yk0qDGFz1feMZiQYUQFJhUTen4TwI/p5ND9EpMbhj79j8bRauwNR
 wHnR3F74Bn+/8Yd4ddX/lzh7S8Sd8Jx014h5kwqXvSEdciQpXbiyP5pL0lrHS1WR+GJN
 CjUyanglzaqrIxDw0ouR35HUoUfjapiN2OnBBzckSKtzO8pdMQabSq59h+O7xjRbIFaj
 yOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697031676; x=1697636476;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4PUjye3ERdJ76l6US0Zmn24YryjjfRVK7HgRZAA4IuM=;
 b=UpwGRBreq8LcrGGFPmK4rz/LtMxfoqudlGAR6qDFwoJsXnpm0Av/ZRh1Qu+7Uo1PEO
 zAC5KYW+zvt0vgrP4O38bwK3Wta8LTC22oNKIv18mJY1OpqaU4UuymivPfIQR6SDBbpb
 v7gEOH40xjhX5Hy5YuQiHpLM1UC8W0VEnw1OS1mSMA3YRT2yLam9LUp0Xb2X3zO1jVnG
 ab3ijZzkgy4VjJo2hsUd+24g0ntKfI62pJ1vKnmOQTQbxYdFiGiexWeCccdWYpkb/Gbg
 nlNIq6wzQ6kwS3J6LZoiXD+zjf58UwasNvWYxJF/CxP7uiQuEN6/HFKpCv84WZWPwn1p
 04MQ==
X-Gm-Message-State: AOJu0Ywgu5rAIOCnDQ5kKH0pO4Nm9tVt9nLLbFZMvprSLZXXQrHGodXn
 n9MrL8r4RSakSL1apTsysMHBjw==
X-Google-Smtp-Source: AGHT+IHhNYj5wkfwX48RpSyMFNeQ3278noLbxMcbVX0iXkUJf4xPlhaMEi1KSsNK16LPcK/TS/r2NQ==
X-Received: by 2002:a17:907:7f26:b0:99d:ddae:f5d4 with SMTP id
 qf38-20020a1709077f2600b0099dddaef5d4mr23948497ejc.44.1697031675608; 
 Wed, 11 Oct 2023 06:41:15 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 g20-20020a17090613d400b009b96e88759bsm10094030ejc.13.2023.10.11.06.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 06:41:14 -0700 (PDT)
Message-ID: <93e4c252-e0bc-6eb2-cb80-924617f44285@linaro.org>
Date: Wed, 11 Oct 2023 15:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] hw/ppc/ppc440_uc: Remove dead l2sram_update_mappings()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231011124312.60476-1-philmd@linaro.org>
 <20231011124312.60476-3-philmd@linaro.org>
 <46e1397e-dc3b-c90c-8b1b-f5b62807d3c0@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <46e1397e-dc3b-c90c-8b1b-f5b62807d3c0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zoltan,

On 11/10/23 15:31, BALATON Zoltan wrote:
> On Wed, 11 Oct 2023, Philippe Mathieu-Daudé wrote:
>> Apparently l2sram_update_mappings() bit-rotted over time,
>> when defining MAP_L2SRAM we get:
>>
>>  hw/ppc/ppc440_uc.c:83:17: error: no member named 'isarc' in 'struct 
>> ppc4xx_l2sram_t'
>>      if (l2sram->isarc != isarc ||
>>          ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:84:18: error: no member named 'isacntl' in 'struct 
>> ppc4xx_l2sram_t'
>>          (l2sram->isacntl & 0x80000000) != (isacntl & 0x80000000)) {
>>           ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:85:21: error: no member named 'isacntl' in 'struct 
>> ppc4xx_l2sram_t'
>>          if (l2sram->isacntl & 0x80000000) {
>>              ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:88:50: error: no member named 'isarc_ram' in 
>> 'struct ppc4xx_l2sram_t'
>>                                          &l2sram->isarc_ram);
>>                                           ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:93:50: error: no member named 'isarc_ram' in 
>> 'struct ppc4xx_l2sram_t'
>>                                          &l2sram->isarc_ram);
>>                                           ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:96:17: error: no member named 'dsarc' in 'struct 
>> ppc4xx_l2sram_t'
>>      if (l2sram->dsarc != dsarc ||
>>          ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:97:18: error: no member named 'dsacntl' in 'struct 
>> ppc4xx_l2sram_t'
>>          (l2sram->dsacntl & 0x80000000) != (dsacntl & 0x80000000)) {
>>           ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:98:21: error: no member named 'dsacntl' in 'struct 
>> ppc4xx_l2sram_t'
>>          if (l2sram->dsacntl & 0x80000000) {
>>              ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:100:52: error: no member named 'dsarc' in 'struct 
>> ppc4xx_l2sram_t'
>>              if (!(isacntl & 0x80000000) || l2sram->dsarc != isarc) {
>>                                             ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:103:54: error: no member named 'dsarc_ram' in 
>> 'struct ppc4xx_l2sram_t'
>>                                              &l2sram->dsarc_ram);
>>                                               ~~~~~~  ^
>>  hw/ppc/ppc440_uc.c:111:54: error: no member named 'dsarc_ram' in 
>> 'struct ppc4xx_l2sram_t'
>>                                              &l2sram->dsarc_ram);
>>                                               ~~~~~~  ^
>>
>> Remove that dead code.

I missed to remove:

-- >8 --
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 3a66b0c7f7..1312aa2080 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -154,7 +154,6 @@ static void dcr_write_l2sram(void *opaque, int dcrn, 
uint32_t val)
          /*l2sram->isram1[dcrn - DCR_L2CACHE_BASE] = val;*/
          break;
      }
-    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
  }

  static void l2sram_reset(void *opaque)
@@ -164,7 +163,6 @@ static void l2sram_reset(void *opaque)
      memset(l2sram->l2cache, 0, sizeof(l2sram->l2cache));
      l2sram->l2cache[DCR_L2CACHE_STAT - DCR_L2CACHE_BASE] = 0x80000000;
      memset(l2sram->isram0, 0, sizeof(l2sram->isram0));
-    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
  }
---

>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/ppc/ppc440_uc.c | 40 ----------------------------------------
>> 1 file changed, 40 deletions(-)
>>
>> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
>> index 4181c843a8..643a79e330 100644
>> --- a/hw/ppc/ppc440_uc.c
>> +++ b/hw/ppc/ppc440_uc.c
>> @@ -73,46 +73,6 @@ typedef struct ppc4xx_l2sram_t {
>>     uint32_t isram0[11];
>> } ppc4xx_l2sram_t;
>>
>> -#ifdef MAP_L2SRAM
>> -static void l2sram_update_mappings(ppc4xx_l2sram_t *l2sram,
>> -                                   uint32_t isarc, uint32_t isacntl,
>> -                                   uint32_t dsarc, uint32_t dsacntl)
> 
> If you remove this then nobody will remember this could be modelled or 
> may be fixed so maybe leave it as a reminder for now.

We can keep this code if someone fix it and enable it (convert the
definition to a static boolean). Some APIs are being modified, we can
not test modifications in such dead code. Even converting to a comment
doesn't seem useful.

Maybe you can add a comment "If you are interested in ..., see
l2sram_update_mappings() draft implementation in
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04261.html"?

> Regards,
> BALATON Zoltan


