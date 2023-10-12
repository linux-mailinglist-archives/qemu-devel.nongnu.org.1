Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89C7C6C42
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 13:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtot-0007qi-3l; Thu, 12 Oct 2023 07:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqtoj-0007nM-JB
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:25:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqtoh-00056R-J8
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:25:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so8780415e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697109922; x=1697714722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=myotuKchjawAAdVNYjFyZAXE7AUpZ7N7NpqY9ysppLg=;
 b=aGr5QcZRP882yvxszTYkl/lpUUDwqnpNfKnVvkt5Qbz95SR2qdC2t3QVmdLVq3e2I4
 4yEz9hTj7j5DN7CtIc3+3dNkNTG+LIGmWcoF4oJkA2n0wordbrdBODC6fmL+YteYapWx
 hyBhgD2k0VsTB12GlyJZNyNw/PezZDRIZbsgPpiL8PYX7iScuUQa1Xr0x+gJCmawjVVv
 sbmboX7MttbfT7L9Yz7tjdjcHXZDF0kqTgC8vGNAzMMrPyr0UvEYcfjSKCpjKsTGALj4
 g5MXzBvpOPPGpb/4gCAhIUcJ/27JV1d3Q12y6xALp9XRGPV1uog80ilB7CPufkfgsD6q
 DzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697109922; x=1697714722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=myotuKchjawAAdVNYjFyZAXE7AUpZ7N7NpqY9ysppLg=;
 b=WgfujZLB3Y/NdVCIJKc+kP8h63wOxOzbWxwMe9Vo988F9e8wU419a7VlkM8lumqSwf
 f0nmzEivD0LbwwQqX4Gr7OhNha7edLuFlSLS4p08GQwKZk5wahmCufpkHdZbrdircS/s
 tuCs2HrDwwU0UqXl07LOclfn/eDwYg72i5HZ+AVcb+/CNzzt+eNW9ZSWsbT2b0ORoJx2
 unEqFPax1UqBIPKn//6twgcCUph1b4qgU38V19Qr8yKd2hItLnTpbySZSdR2TvRORIab
 KgBaonnb0Zd5Ey1lV4OGeeCRYrhO+Bg6kUcNy3i03CidGyo+VG9xUUy9/RC8UNKvy4rw
 VYqA==
X-Gm-Message-State: AOJu0YwGACl0U/g/Lsp6gVIMCUjV4sv5xt1YmMNcNrv68nqRx5CmQdSl
 J+bIbLNZQPSHzxurSYMgkthDww==
X-Google-Smtp-Source: AGHT+IFjOeJh7wxNhbmAICeJMYVHWAl0Nl72er8nAzqeU4sHfYqrCFIeWo3QN11lCA85NuDjfIRhAQ==
X-Received: by 2002:a7b:c3d2:0:b0:402:cc5c:c98 with SMTP id
 t18-20020a7bc3d2000000b00402cc5c0c98mr20823412wmj.13.1697109921724; 
 Thu, 12 Oct 2023 04:25:21 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c15c300b004075d5664basm4924636wmf.8.2023.10.12.04.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 04:25:20 -0700 (PDT)
Message-ID: <3e72aa8e-9793-7c05-722e-5a2f9a6ca76d@linaro.org>
Date: Thu, 12 Oct 2023 13:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add include/sysemu/qtest.h to the qtest
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>
References: <20231012111401.871711-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012111401.871711-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 12/10/23 13:14, Thomas Huth wrote:
> We already list system/qtest.c in the qtest section, so the
> corresponding header file should be listed here, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


