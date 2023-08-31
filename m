Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 183BB78E62B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 08:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbau0-0008UG-Ij; Thu, 31 Aug 2023 02:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbatt-0008RA-ID
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:11:30 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbatr-0005Pz-5L
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:11:29 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52bca2e8563so471990a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693462285; x=1694067085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23HH6W9oiX0Td0WTUVAKAot+IsF2Xsx2IgqizwueE7A=;
 b=WjtcKexcD9kYXcmj+aFydYVqnhWYo3ditxO4/sv75rzF7eiNFzDOWY+lHYedOGCe3c
 vEhBf1gOYKWrZqFIbeXduSnp09eszR5W9Tt2ayFS3DjDSAct72bxIJQhvrl9MAdyrNGJ
 ub04vYDOWFIGmLRZodl6if522iygyz0ePQJHxfl+VwkCj6nWNGhRJTdB7+1edDGfSFY9
 hIurzyeErQPCuRGvo5zFHYJKHMQTZhrmCKwrYH3dgghxIZXB8XbKdadIZNFO7c/Rw/GP
 eiBNlQYiaAKwi3U92JUd78NGRm798hNpU385FbSir6uPFI98EDHIQ71Mgar2DQY+03rC
 bCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693462285; x=1694067085;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23HH6W9oiX0Td0WTUVAKAot+IsF2Xsx2IgqizwueE7A=;
 b=d11MuvhOGoLPNqP1P2ydkC9CHZ7esOt2GqNafQpZK5hRU7i2PceNIbn795fwPqLFvy
 IbrbiESKo1gCfK8U0d2O2V15x8IetvDIVO2j2sNUZI3RSXRftMi83flQXuhje4NItRQ1
 7cSbhU2JGd8qz8Tc1MwMd+7GydcJCGmq89lCdPCIgPic1nNap5bjoKlZWzX53rWEvOdi
 Z4cPL5UjXOlHxjF+s3oQ0aYW3BGb9AVhAQUIQywDGD7W5XN6OUdS9J1Mhn0iA3zTNdmE
 y9pVKS/ZtNsZPZyMfdifXDMDs0COkrHGgLnxeuSahNJgGaNbwsbHnDUKPSoiCUNRN15W
 uHPw==
X-Gm-Message-State: AOJu0Yzt8X0C60nPMk1dIZc8FcI2MmN3BUAQpkBfO68ezqlolLd+E6ca
 RqojxIvgMpO0EYPWwY6caNJlBA==
X-Google-Smtp-Source: AGHT+IHiS+EN49zaK8G05x20+8T94/jQMkcKJbTUtiDTQXrE90R5PYzE2kiDN1Ezr1dYixOCu/qhsg==
X-Received: by 2002:a17:906:3d22:b0:9a1:be5b:f4a5 with SMTP id
 l2-20020a1709063d2200b009a1be5bf4a5mr3282876ejf.35.1693462285445; 
 Wed, 30 Aug 2023 23:11:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 qw17-20020a170906fcb100b0099d798a6bb5sm376043ejb.67.2023.08.30.23.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 23:11:24 -0700 (PDT)
Message-ID: <a4ef9f54-7a57-af6f-c947-5383a7559288@linaro.org>
Date: Thu, 31 Aug 2023 08:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: About "PC_MACHINE_CLASS" definition.
Content-Language: en-US
To: Liu Jaloo <liu.jaloo@gmail.com>, qemu-devel@nongnu.org
References: <CAOYM0N0o2SdiaAqtBm5md4z_FQnnP2csPrapc+5L47Qcaiw3Kg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAOYM0N0o2SdiaAqtBm5md4z_FQnnP2csPrapc+5L47Qcaiw3Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

Hi,

On 31/8/23 05:15, Liu Jaloo wrote:
> Where actually defined the "PC_MACHINE_CLASS", I can't find it in source 
> code, please help to point out the file.

It is defined in include/hw/i386/pc.h:

OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)

The macro itself is defined in include/qom/object.h:

/**
  * OBJECT_DECLARE_TYPE:
  * @InstanceType: instance struct name
  * @ClassType: class struct name
  * @MODULE_OBJ_NAME: the object name in uppercase with underscore 
separators
  *
  * This macro is typically used in a header file, and will:
  *
  *   - create the typedefs for the object and class structs
  *   - register the type for use with g_autoptr
  *   - provide three standard type cast functions
  *
  * The object struct and class struct need to be declared manually.
  */

See the QOM documentation:

https://qemu-project.gitlab.io/qemu/devel/qom.html

Regards,

Phil.

