Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC39821961
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:03:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbcW-0005et-2o; Tue, 02 Jan 2024 05:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbcT-0005eW-QT
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:03:33 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbcS-0005aB-8r
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:03:33 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336897b6bd6so9092342f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704189810; x=1704794610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M0wLPGnIynKRRM50/B7Da3ux7PV6irRv88v68SOn5ZU=;
 b=OYZZ2z1P6hwEOCi+yMiAGv4Gna6hcWLzCndueteGhNiuY4cZXBktje8XZkvOskYJik
 pngwQXBzhuO+rxnhpMTDHue8dVq1zok+KKLCoLKFNfFafyvc8AgGuNhR7cinM0TieGt2
 XP8PLrzt18xPd8mb9RadKxugrycIqAD5gdeJDN0Vf5XqzIIFWXdyz4EjJNE1GB5MDKHW
 aK/b0roNFJARx1Imzcqo2jBzKN2MPzEXGrPngonX6Zu/HqcMNRTh8NZVxAWADkZlig+J
 HOaOxJ+G67+kIqH+IJgz0VuZzHmSpY+BOV4s/No8t95QJcGQ26xBzDjvNNN3nksq0Rv0
 2gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704189810; x=1704794610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0wLPGnIynKRRM50/B7Da3ux7PV6irRv88v68SOn5ZU=;
 b=qnTN7qg1zVTSlj7Sy48yEtnbMS3SubGYNfPpWGhJJVbyshzLbrQNYq1/xdrAcVnUza
 KWK0BUDV7OuVw1j6OdoLrDf7HBafcP4CH9ZyWFXXIFVzq5eNWI3cHcXBVlQu7cv+btAf
 +b7TuBEzrZMhWPqp0TI+r1/RzV9TzztpIYq3s/LxggwPE6V3wJosMAY2JXMm/sAhGbsV
 Y4bi5mbnF0bdar1Wxyhw9Sqf6u2Vu5hjXiFzW0cxzfT+38+QZ/iDBLWt+WiTiPfFiTbU
 yhegMfZs60ojJHoLRj01rH6UUCRQVFBbTNTU3qRvsAFBazfdsWX4LOkb/Tvm6m0BK8Ey
 7HuQ==
X-Gm-Message-State: AOJu0YybVVxrCjQ3ExP5dLqGZD6WM80OuUtKo36uhqaFK/HXRCjn+FbD
 YcwP2k0Z9Zc+wjaiw1xpjieO+drwggfONg==
X-Google-Smtp-Source: AGHT+IHUUHSjVEk7N69nkHarhoN2SrixokYtP97cxukihQ7LvpAF1OUwdY3oMseu8M7KTi0WmImAzw==
X-Received: by 2002:adf:ce81:0:b0:336:6896:617d with SMTP id
 r1-20020adfce81000000b003366896617dmr8713356wrn.91.1704189810603; 
 Tue, 02 Jan 2024 02:03:30 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b003366da509ecsm28030822wrq.85.2024.01.02.02.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:03:30 -0800 (PST)
Message-ID: <baa3c690-8502-46f6-a694-77ca2070cf55@linaro.org>
Date: Tue, 2 Jan 2024 11:03:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] migration/multifd: Simplify
 multifd_channel_connect() if else statement
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-7-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231231093016.14204-7-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 31/12/23 10:30, Avihai Horon wrote:
> The else branch in multifd_channel_connect() is redundant because when
> the if branch is taken the function returns.
> 
> Simplify the code by removing the else branch.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/multifd.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


