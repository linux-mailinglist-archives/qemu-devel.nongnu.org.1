Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1245879FB70
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfOD-0006M5-7z; Thu, 14 Sep 2023 01:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfOB-0006J3-39
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:59:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfO9-0004De-J0
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:59:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c93d2a24fso472031f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671180; x=1695275980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMtPe/CF+1E3NBLGDOGEcqHkZWheKgmoVS+xGW/15gY=;
 b=jIXR18CLi4AUxxsiaJnB/ium8XknJujJxoH4Gt3ExO4uu9piRPWIoL5Y0RrkmAmZTc
 dUsEO7zos856BGi2QYZUdJIs/+P/zv3RFgGdWJAzNrXP2ZOrxeOAufeTq6NY5rTu7wiT
 L15dbibdsajo65gr0X39u18vtnBIEq3rl2+QUU5FpsXNKYKCJm53V/VI+lUjAqqIFFaV
 RPVuRiTFHpQtFh578ohtQEcENkKwV339KoqrIrW0btt8SDnGWE2Ur74vj8N1M44lCKie
 n3tjfclmjgsBof1BSYcYqHXNu2nF2Xs05sAwTY4p33mrJAuQPn6ixKjV8lM80WZzRpKM
 p9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671180; x=1695275980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMtPe/CF+1E3NBLGDOGEcqHkZWheKgmoVS+xGW/15gY=;
 b=k/6eRakNydukSz7Ts2CHbEMhKVxQh/mDnMmK9JtMpvH1FqB7lA6PwXZlKjhMBYaP2z
 abeUHKfsmUieoJf4ecjwAHanB9703nquDEQPflScYGTFqXCFY2gJ6MNUXU+/4kPASDjG
 X2nn8C5707Vm5IF2HE3GZjBKk0rm/MiKWeekfgSZmWS631nmNn5mTGP4Qg3PX3FYdAdy
 JAhLYZhPKPS2gMsNRKUYwep7EIv9h/iVqr9oSXIXEIIclGjltx4YwdBK6WrPFolME0u/
 h47byJt6iDgnfNSNlXAduu2TFl6G8kXGgu7eRncluNgWLcMaXez7MMOxhAe4s/UB8HoG
 /Yww==
X-Gm-Message-State: AOJu0YwUJ+8eQ0IRrpyjSbXJRyjKYhiBvwLN3W9N9GH1j1NEwv8QAzyz
 HS2yQyJBiqL/slb1XUUqv5eZ1Yr8PNB9lfWMNG0=
X-Google-Smtp-Source: AGHT+IGgXM051AMIWFo55iZKOVf1F9hOMsrTNx2urHKZDfWj5rd+Te4Imdh8zibvtOxCOqs/jjK2kQ==
X-Received: by 2002:adf:fa4c:0:b0:31c:8c93:61e3 with SMTP id
 y12-20020adffa4c000000b0031c8c9361e3mr3882823wrr.60.1694671179957; 
 Wed, 13 Sep 2023 22:59:39 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 y12-20020adfee0c000000b0031aca6cc69csm764669wrn.2.2023.09.13.22.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 22:59:39 -0700 (PDT)
Message-ID: <3d644515-0905-1c7f-b910-3af9a2dd4b42@linaro.org>
Date: Thu, 14 Sep 2023 07:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 03/24] qom: Propagate alignment through type system
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 14/9/23 04:44, Richard Henderson wrote:
> Propagate alignment just like size.  This is required in
> order to get the correct alignment on most cpu subclasses
> where the size and alignment is only specified for the
> base cpu type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   qom/object.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


