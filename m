Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA678EFEF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 17:07:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbjFy-00024A-7z; Thu, 31 Aug 2023 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbjFv-00020z-Sy
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:06:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbjFt-00054p-Ba
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:06:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso7047745ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693494403; x=1694099203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ASeEk5TntfOaPM4aLzmYaBRIBLp6uNC3+X4E2AtusX8=;
 b=YELQ/C6CSOfMp/nTRUi/WfXRNY16CXwLXfTf3/gESfcwcSwfO++D8kocYKa4mkKk92
 2DLfwrMaWrf24DPjV21D3h7tdbB5RZ0bf8LrCLVZ6A0n/wNNECC/5okdhLPRe8P/zsUN
 iNfwErgHb5aldEMA6HOnP9gQTomAoGPjumwQQTCl9mDe+gu/+tbkbMvhH2Pf9lREpSaO
 tS+nZucfFP0hcfY3AVdVoLu3JVF/bwK+88nvFEUj+ecTahk49DHJbNGDzc5ekbxoVLtL
 rqlA8c2miDqNCRKzubCvP38cbxmLyua62dgtpKZBF98utv/Ah2yewd+ei1/0E7ujNdOL
 CGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693494403; x=1694099203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ASeEk5TntfOaPM4aLzmYaBRIBLp6uNC3+X4E2AtusX8=;
 b=aZxLjNmgF9bovAPxrPLAc+CGNdqdp52gM3/t/oE/w86PESPDk/gHc4hJVBZxxpBNBf
 BIm7TJuIQnrEh/oBFCSGF5b9oBrcih+VA5BpuGxa0RhSj729NljCvM4RK0xdnsSE5HgC
 RaZCc0KkWB2aMgHak7I1P5U/w5PzKk3oUaCxf0hgrlOUHh0NDVbP7JYofGtD9QCv0GLO
 NsHRAVl4i5UJ+6wwTIWtP0/9c73uyl8RDmBe+yDfhQkGGygLAUtgBJVoqCbf9Osb/5LL
 Q/t7DVHfgdo/7vhJC0puni9/C9TjKGmUY+/SXvLwcn3sH5d3Xyi3N/2sr40ewpsfCdqB
 Kk6g==
X-Gm-Message-State: AOJu0Yy97Vz1pYIFc96iy6hXiEn0+1zJLMlL9B3/0QUU6hyrjKs/JOpe
 QbBnNZZm8gtNezC3zaTNGivdbf8IMH6cneHtT0w=
X-Google-Smtp-Source: AGHT+IGc/chn/yWj2682sM0KWrr2DKQF9CZGsoxvQoR7S6siuK8RI+Y+PSzSNi2sV355SJmpstrklw==
X-Received: by 2002:a17:902:c40b:b0:1bc:671d:6d31 with SMTP id
 k11-20020a170902c40b00b001bc671d6d31mr72338plk.3.1693494403044; 
 Thu, 31 Aug 2023 08:06:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a170902ee0d00b001bf11cf2e21sm1367921plb.210.2023.08.31.08.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 08:06:41 -0700 (PDT)
Message-ID: <ff3f0c9b-c724-70e7-8bc7-904fcc5d5a58@linaro.org>
Date: Thu, 31 Aug 2023 08:06:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 11/48] target/loongarch: Implement xvhaddw/xvhsubw
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-12-gaosong@loongson.cn>
 <93b90f31-d33d-2c37-0ab8-166d9c28bb6a@linaro.org>
 <965c1068-be7d-0642-3111-39fbc4e54006@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <965c1068-be7d-0642-3111-39fbc4e54006@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 8/31/23 00:17, gaosong wrote:
> 在 2023/8/31 上午2:12, Richard Henderson 写道:
>> On 8/30/23 01:48, Song Gao wrote:
>>> --- a/target/loongarch/vec.h
>>> +++ b/target/loongarch/vec.h
>>> @@ -47,4 +47,7 @@
>>>   #define Q(x)  Q[x]
>>>   #endif /* HOST_BIG_ENDIAN */
>>> +#define DO_ADD(a, b)  (a + b)
>>> +#define DO_SUB(a, b)  (a - b)
>>> +
>>
>> Why are these moved?
>>
> I want to move simple macros together.

Ok.


r~


