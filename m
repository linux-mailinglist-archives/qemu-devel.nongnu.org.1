Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398307182F5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M96-0008EE-Nr; Wed, 31 May 2023 09:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M8x-0008C6-DO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:45:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M8u-0000mE-Vk
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:45:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30af0aa4812so2632399f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540732; x=1688132732;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GwWKj9NbRQJDoERURH0R6WuM+p+LRBZLeUamA3d8adM=;
 b=zvHjiY6rH2bRghd4ADaliGI8B1WUJJv29sD1o9L2ggzuQZK7W7NVvnRbeNU4QiDvaD
 dxHy0QcPyPoeMzEEpRD82f9NXgIgdrGI8MwjySFu3+lAf0StSmJ9nTro868O+08WUTB4
 DDKUoffiq+AEamjpZMo5kd0cAdIG3DuMODFhdIEbiF+hHi1wshkoV4UoJ7+mZKukEzP7
 ss9eJmuF5CqW6UYFIvY5Me/FZE5Svi4nm3NATixfDJRf/+f+m+KkPiWyZjGz0V26Fhrk
 lMq3rOAPBL+417vcq20RQ3KGwKagu69rB0IGw2J5namden4Ui+Nq6OtCzahATVI4TuLQ
 1JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540732; x=1688132732;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GwWKj9NbRQJDoERURH0R6WuM+p+LRBZLeUamA3d8adM=;
 b=Y4MSEnXONb9Gwfo80ZOy7xymq2Wvw7aT1GpJY7+BJPDWQ2dFkLmLNt+QzNRB6/qS8y
 t/cPKULGuHNH+MhUDMO4gTxWDKpdmorpOHw573cIoXm+e1qmNaihuj04T98FoJz8fy2b
 TdPBnAWk3mm3cAMLpJPOb2/BT/J4GCOOYOLwjvinmnUtqN5kFv7/vuMs9bCo7eV1bag1
 sWPNVSkGWiSM3gttBsWFy6Fkuw3b51zAkd8tmGzXqYoGWiS4g+SHsx6HvjkENDawV/MS
 YZ5VG8lD8+DHps6tn5/MrmrhG+RLnbgCsGjKz4BXJ+kuZfs5CD3mN4yNPL9JcznEFOhM
 mW+Q==
X-Gm-Message-State: AC+VfDyyQmUf+LTzbleAOMhzCxTXYboS1MXg00sOFRxyzJ51yOBHliN3
 c+NVibiA4RM+gxYgULJekILFsy54nHF1YeJz5JE=
X-Google-Smtp-Source: ACHHUZ6PGuc7ky62bcz9rMDUNkHm094ahQ4HNTartxU1eNLDatdMeBjoe3R510IjuL36Bmy4l3mJkQ==
X-Received: by 2002:a5d:4bd2:0:b0:307:9b66:f512 with SMTP id
 l18-20020a5d4bd2000000b003079b66f512mr4458985wrt.19.1685540732568; 
 Wed, 31 May 2023 06:45:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 q7-20020adff507000000b0030add836194sm6952488wro.65.2023.05.31.06.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:45:32 -0700 (PDT)
Message-ID: <d3bdf6a6-bfc9-d776-6562-4a43771e5a6b@linaro.org>
Date: Wed, 31 May 2023 15:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 11/23] q800: move VIA1 device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-12-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the VIA1 device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 16 +++++++++-------
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


