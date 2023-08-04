Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D276F96D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRn52-0002ko-4y; Fri, 04 Aug 2023 01:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRn4e-0002TE-2f
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:10:05 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRn4b-0002Ol-FG
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:10:03 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-56c74961e0cso1126873eaf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691125798; x=1691730598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lXXLYCcEYDB3udwQQn3lRXfkwjB9UVvStICx80M5oTk=;
 b=mvFPG5ekkW0KQGdjYs/wuYoYApPg9Z1lq0BwnHF3dAJFR4rJGiQoCzYD5lIh/eudmo
 08QL10QiQftQrBRFSQJM4Pc0UJ+B39bX6Tjr/dFhQO5W+upuO43ILSVp0C6D2o/wMauM
 o0UeZT9DI86IC1pYSehJktZxR27f+Ugl5DZCfI2+ACHFITBtcK7gVRCd/jXxX2pUBZxh
 mxScjlVa8Po1z7MFhxUmzKL4Jle3xo/BeyaefR+1215bEG3ftcGdiA8Ul566bCBMZ5jK
 4ysWf2Uv6UhL3gzLLfTG7Pl/vu9sQJrNzIQiNP222ROi3dLL7YlQHb1UVeohEjgyTdOj
 4+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691125798; x=1691730598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lXXLYCcEYDB3udwQQn3lRXfkwjB9UVvStICx80M5oTk=;
 b=bpfPxr76vmHMRD7fmyTgO5OWFc/bbAlaLogHsrNMTl4W9hNAZWUr7VjX/Z7JOd18NH
 qphUBab+WKsQOovz8LiTsswGterKpfBh3khHZEaXHpFhLCqJ++fi5jWSJcneB8bqFVXR
 FEVG30MRk5EEjmI/foWmBnf32gZ/TkUnQP3qd8Xfl7GItvFppfGCMHJWkf1KHMz8lr9Z
 +50JaIS2z6YVsaSrw7WXpKwynRct82supwbOe5mk/xOT0pwgY6ahDZAMTkXzfzTAfnqq
 NchzVJOg1xIhDukNrmulGYmGeAFtfNQX3LOSnv2dOqHtjhx4C00t8v655/Ys7etMdpqL
 Vpuw==
X-Gm-Message-State: AOJu0YzvHHLBo/+aoXSlwO863/h4xF8P0uyC1WylyH2WnnEZl2F8PW6M
 mzHz3wUWLbtUVMgLJCvxJhg49g==
X-Google-Smtp-Source: AGHT+IEJ3zuSg+bjSmO4YVq3M012nC5Kh0ZA11SO2eWBIqqyrjRl9DY7IXb1Jk6vmsezlgYPlZM2Mw==
X-Received: by 2002:a05:6358:c2a:b0:139:bf71:f608 with SMTP id
 f42-20020a0563580c2a00b00139bf71f608mr871106rwj.14.1691125798317; 
 Thu, 03 Aug 2023 22:09:58 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 206-20020a6300d7000000b0056471d2ae8fsm595129pga.90.2023.08.03.22.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:09:57 -0700 (PDT)
Message-ID: <e420f461-f61f-24b9-515d-8e5b055c331e@daynix.com>
Date: Fri, 4 Aug 2023 14:09:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/17] linux-user: Remove last_brk
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-8-richard.henderson@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> This variable is unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

