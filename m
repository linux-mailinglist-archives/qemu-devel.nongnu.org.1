Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB547CD482
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:34:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt07I-0000cR-DC; Wed, 18 Oct 2023 02:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt07D-0000bQ-Rb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:33:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt077-0000jf-Qj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:33:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso8184985e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 23:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697610784; x=1698215584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vIQa35M4vNuq7r8TCh/9iWXv3FeOcxQan7gdaZ0ndjQ=;
 b=HSw2Vw/SLXeSjtkq1JzTUCc1eiLW1AGpx+UQJ8hvSr/a9p8WX2O6oNkqCSCJ30atMj
 0eaTysP1xT8LWtvZtOIId4dftPnSWiWYWFM2z9sXlzFp1aze/Hs49Mz/x2OATHRJgbci
 OzBH/uWME5+u8dUolRC2NhSjssGmHw30j3OupbS5WlJ7npLktWHgfEy4f+lDpGPtqkN1
 265mu/uRrOt1ptlF2ODa/wb8TsrFoh8Kur1i7/CIAdTTMrG/0E9gcpJxC88c6utf4mb6
 zlxerDlP5txOZVZz4MJ9fOb8kjVEKUYbbDqZOn1Cbw4sFpBCgjDpq+l4eyVTS2LgqlbO
 AC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697610784; x=1698215584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIQa35M4vNuq7r8TCh/9iWXv3FeOcxQan7gdaZ0ndjQ=;
 b=a8hw0syMMujsR1Xew6/lhrG+LNJbfb0vdTLPyMqcl+FRgRGxO5DcKm2Puk1U8NVDi/
 MjwMoB9yO09xjyuhG5CbhrkunZn3sZoICF3GEZEPObhiynI3V2avk4aVVccpBAcg8F+I
 0R4xiTY60c6ra7U/BbVFRJNI0cdR8DtBJMjN+1f8C5MEKVHIGrKKrD3yaLS1vbxhpAGj
 qStcsi1lsR3cljFAcdkD6qDPccQIGENNbxFeqojE+5+7OcY75AHSAJrOicwWzDtfIRzK
 r6sEUNWtuHM7B0ruoqMuchzFRY4lLUG4PQf1NVR6IvZQ/Q9X7Yf8EL0K9MC+CoAQJMQB
 CJ9w==
X-Gm-Message-State: AOJu0YwW3qWyRFlB+Wo8Gqodo83/shZhUBmJ5878IYlgEcIKo5SYUFPv
 fIqVVL2tQVle09iWKnMs9lMIFg==
X-Google-Smtp-Source: AGHT+IGRyiCQapq4fS9KmFugKCJFJ5QT77XXEsx1JVrVAmsitt+96+HdIcl38+5glm/8cUimHHP68g==
X-Received: by 2002:a05:600c:3d14:b0:405:2d29:1648 with SMTP id
 bh20-20020a05600c3d1400b004052d291648mr3724373wmb.19.1697610783872; 
 Tue, 17 Oct 2023 23:33:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 fc8-20020a05600c524800b0040535648639sm785401wmb.36.2023.10.17.23.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 23:33:03 -0700 (PDT)
Message-ID: <4a34d96b-7eb7-d04e-e602-77a1d8ae8a7e@linaro.org>
Date: Wed, 18 Oct 2023 08:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add unvalued folders in tests/tcg/ to the
 right sections
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20231018062401.20746-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018062401.20746-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 18/10/23 08:24, Thomas Huth wrote:
> Some subfolders in tests/tcg/ are already listed in the MAINTAINERS
> file, some others aren't listed yet. Add the missing ones now to the
> MAINTAINERS file, too, to make sure that get_maintainers.pl reports
> the correct maintainer.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


