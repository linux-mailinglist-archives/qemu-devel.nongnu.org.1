Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B97A4A91
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:24:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEDD-0002EH-QU; Mon, 18 Sep 2023 09:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiECw-0002De-93
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:22:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiECu-0002Le-IV
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:22:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso51035945e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695043351; x=1695648151; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0anQ6h/PgYOw1hK91diRTA822RYc/JFlE7SUBKfY/E=;
 b=a9g4m9GE5a1L7s75CI6NBCMhhdACW/tImByfVNUceBIVPy1PBnGcMo9R4DhXQrqZVf
 meLe/2rIE9pYH/UKw1HFPy59dvC3UnxQ7irjS4mkXU0JfA55RI43kxFZKpeS5TLRakKQ
 jXkYUoRGWPPN8gKnvDJACv/3TherzTTBEH9PbLVJ8euj8dxVhztTVo04Idr+U2CvVnfb
 Lv7u4Q8uAvbUZMqU3Cwmzq1RlNpj7tVhnKobt330KOCgKgQoJJVxJUY4BRtWmDXRGXTf
 3A22KtNmZRwD0775+qojIBoy6SgtmBSn8l4bvtdj+uikXThuCwIz0Bblaz+viApvsVsq
 JHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695043351; x=1695648151;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P0anQ6h/PgYOw1hK91diRTA822RYc/JFlE7SUBKfY/E=;
 b=CvsdrOoI3aOnFRxMOjO2/DLSCgnCr0VqZSsJpQAD/WXFier2wRd1k/WxQ8sqhmNQSa
 d95FS3SjfBiAyhlhhLyRtZLVtdlzXQtPZG0Dvs5M1t2Zalr8uEvclcjicdTUwd0NcGt1
 hJQ3sNfNiL52RyGD7pSCs4mVHPaJZ7uyHZk/bfNz1xJDGBYdFy5hdowASiQxJeBZIkf+
 7jT25AnvkTLsXyaF4ZQlO7mzU7Q9FBEACoG6B906iEnupeBgGB/0TTaDBR6aZYXVSsrw
 zYF1ua/HeK3SmUmJN9bJA4JHlRXOBu9PXrIWNdmVHhKdaFIFHjGmDE0SweDpZSvv3Gpi
 IJsg==
X-Gm-Message-State: AOJu0YycDt1RJyJigAdU2DowsEs7ho3LKgDAdxz3ylo8bIsJ/S59yRkB
 WSndSQx1dBn/tg9Q/KEc3eGDzg==
X-Google-Smtp-Source: AGHT+IHjsdoBX2S5jDm9f0WS1d+uCKoTGcyrR37r5gqmsXb9TcPahxzvF5ox85KEWND9OcxGsBjgyQ==
X-Received: by 2002:a05:600c:ac8:b0:402:f54d:745 with SMTP id
 c8-20020a05600c0ac800b00402f54d0745mr7443295wmr.17.1695043350684; 
 Mon, 18 Sep 2023 06:22:30 -0700 (PDT)
Received: from [192.168.186.175] ([77.205.68.72])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm12534426wmk.6.2023.09.18.06.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 06:22:30 -0700 (PDT)
Message-ID: <59e5fc47-cd15-f7b5-a0f7-c0620de33576@linaro.org>
Date: Mon, 18 Sep 2023 14:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Content-Language: en-US
To: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: target/sparc: What is CPU_FEATURE_FLOAT128 for?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Mark, Artyom,

I'm looking at the CPU_FEATURE_FLOAT128 definition introduced
in commit 64a88d5d3a ("CPU feature selection support"). Any
clue how it was supposed to be used?

Thanks,

Phil.

