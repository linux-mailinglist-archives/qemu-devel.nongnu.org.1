Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52077B6B96
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:30:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngPS-0004w7-0s; Tue, 03 Oct 2023 10:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qngPP-0004vI-Sk
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:29:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qngPO-0006wh-4O
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:29:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405417465aaso10338385e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696343396; x=1696948196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0AsNLbWUO9UMmd8b5Jij1zwO5hgHkJ7ZdZdK4D/2Kbk=;
 b=QwGOoOjmqyAitmFF2kMk+wBXjB7Xyenric+BimnYO3P00LkrhySRfh1/ptFJ2Asg7i
 mr0LzUN9T9srpFMcQfNfGp9AIve33B46nhitEw8prJikPGWSwAl5FfZ0B9vkakesiAq5
 W5Hmnm5rBBsC9I9FtGqZEKWzKQDVf+Jc5Ds63YrGSwCwuH3qcdEk9iw9upp0+m1hZdox
 zWkSfvHvemBRMs3dx9tP4QMufXdXqZTCjzIgijj2NVr5r3PF7zuHS34ouIffEdu99TCl
 veHUhRtofMTmA5iVUkbGp154x0IX7msrOukuvTAewmG5h3rixT2xi4vtLZNnSEEMxUPU
 GagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696343396; x=1696948196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0AsNLbWUO9UMmd8b5Jij1zwO5hgHkJ7ZdZdK4D/2Kbk=;
 b=D/ffWq8aokht3hJEP8zhqJGRv1/1pZ8zUkc4jrt2y1Dt+kOCvx4Lzxs8ZcxpBEHNNI
 Xg5j6NNIaz/Z5P3mpb3lpsoEkPa/l9EW/RKbTCAjQr+E3QTiJhr7baI0QAQN5qAMlR7Y
 QC4I3PcWxxxW2F2PT+OwTzniAtuUVKUGdxp8VWKl6FuO4+Xmtd19CPSVY3qvbAqsz/Vi
 UJ85blrWmxfrwK0m3nnyBmmVveb2rFjN8CQR2il4R7ZSxUnB8puPENs0MLu5NcV7E8ok
 R/hCllGuL+GfTZI77LODKU6afsFd0/G6lGj/qO2U5ZT6DXjXTzYp3sc6M6sVW+RKwcbd
 EzJA==
X-Gm-Message-State: AOJu0YxvlcMPCyUHu+1O3yX6YD565iXIdNxJBtf55yILnmXX9mHudSbQ
 guQF1nKcXJWQR8pVw98IQmzq58VhPDgtWvOjQXGrpg==
X-Google-Smtp-Source: AGHT+IHsQMGYX0sFloYUtQ7JodeOoXMzSKIszUSriJqyPVhF/1t3l77+z7Uvz3IR3Ul8W9YAFFRI9w==
X-Received: by 2002:a05:600c:21d1:b0:401:cb45:3fb8 with SMTP id
 x17-20020a05600c21d100b00401cb453fb8mr13594246wmj.38.1696343396230; 
 Tue, 03 Oct 2023 07:29:56 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 v11-20020a1cf70b000000b004065d67c3c9sm1419429wmh.8.2023.10.03.07.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 07:29:55 -0700 (PDT)
Message-ID: <2f56c993-39f4-476e-25e6-80969d46e413@linaro.org>
Date: Tue, 3 Oct 2023 16:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] accel: Restrict tcg_exec_[un]realizefn() to TCG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230915190009.68404-1-philmd@linaro.org>
 <87e1be19-c1c6-73fb-3569-7dbf186662f7@linaro.org>
 <96a726c8-186c-3f09-9d9b-d17d7f5289e2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <96a726c8-186c-3f09-9d9b-d17d7f5289e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 16:04, Richard Henderson wrote:
> On 10/2/23 23:44, Philippe Mathieu-Daudé wrote:
>> On 15/9/23 21:00, Philippe Mathieu-Daudé wrote:
>>> - Add missing accel_cpu_unrealize()
>>> - Add AccelClass::[un]realize_cpu handlers
>>> - Use tcg_exec_[un]realizefn as AccelClass handlers
>>>
>>> Philippe Mathieu-Daudé (5):
>>>    accel: Rename accel_cpu_realizefn() ->  accel_cpu_realize()
>>>    accel: Introduce accel_cpu_unrealize() stub
>>>    accel: Declare AccelClass::[un]realize_cpu() handlers
>>>    accel/tcg: Have tcg_exec_realizefn() return a boolean
>>>    accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
>>
>> Ping?
>>
> 
> I have this series queued for the next tcg pull.

Oh I didn't noticed, thanks!

My preference would be v2, which Claudio already
reviewed and tested:
https://lore.kernel.org/qemu-devel/20231003123026.99229-1-philmd@linaro.org/


