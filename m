Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B916C718E5A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:20:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UAE-0002af-1k; Wed, 31 May 2023 18:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UAB-0002aF-88
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:19:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UA9-0000og-N5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:19:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so147888f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685571564; x=1688163564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxCGu26N1DnVbS9u4QXDxgJXwWXO0ofahh/Q1cbo31o=;
 b=Ig6CFPliWEQsi0LXtvVINsAXUex4VwA4tipDCsfGXnQIMKO09u3WV1Es6rnUBPqloc
 x6+ZR5OUpIcEuGPo+Fje0y3daF9xz1JYHruvQKMeEVl3ilyNFPSkV5tSh3hiWQ8riE9P
 XA2vZZDlt8quQlJ9jeylLLLRdArxvyUja3W1VPyWYi2ty9ltuQ2M5CR40VSlhSLvx353
 /Vsr1gXSN1gnwmUlgOQYvNs2zzghg0BSK3ToOUxqP1Lo1jlIUv324lZtu4Q1xOlvYCJi
 OBXMzjpSy0pXT3Gsk3dAsp6dTw69OqU/10CFc05Qnz1ySy/5LUFIICQqb1byrjPVxGZS
 D1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685571564; x=1688163564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uxCGu26N1DnVbS9u4QXDxgJXwWXO0ofahh/Q1cbo31o=;
 b=RDmx9SB0ttiyCr6GmBA5dlBvhYpPzBRuImQ+iLJCjVmfImgcaN1ZqTTA2HEzImUpqJ
 RHBvVe4fAEGSvcz8Vp16YU5WVCM3A9tHh+mWGKp8xik+EdWiKZEgz7b/G7nGEFQQO8qb
 NmUveGtj5DpaPfkqu7t8eNOZQADoGDV/OK+1CrDYI6AGAyXz9GilhntpVx4avRYb/7O6
 kvjaHt14XdXK0CMYAafyg6dCPzxpkU5jJKsGD6GK1eYcuJk0AQCIATVCAz+UZgEL7gNf
 8RhjopLrrGCoCJfIIY1Lus9ODCe/3e83jHkZikNwn7zUqTnjqA/tp9T8tad59l1ZxR0j
 NPjw==
X-Gm-Message-State: AC+VfDytEAgSIzT6xsARjwS+AJkXlbgyjHNVOyfRf8yeczgB1hx1V6Js
 AWiwN+mKda3s7aU2nTB2/rtuHw==
X-Google-Smtp-Source: ACHHUZ44aNT3Y3LUyT3RVHHEGvTKKBGHQEk2wpVvwwDjS3f8fWVOcnAHNf1LmUTwG/uOfV4SKNDGrg==
X-Received: by 2002:adf:fe0c:0:b0:309:11d8:62a6 with SMTP id
 n12-20020adffe0c000000b0030911d862a6mr313968wrr.43.1685571563921; 
 Wed, 31 May 2023 15:19:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a5d46c3000000b002f28de9f73bsm8110400wrs.55.2023.05.31.15.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 15:19:23 -0700 (PDT)
Message-ID: <ab6d9333-4953-f7e0-3372-e13371b912ea@linaro.org>
Date: Thu, 1 Jun 2023 00:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/4] pcie: Add a PCIe capability version helper
Content-Language: en-US
To: Robin Voetter <robin@streamhpc.com>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-4-alex.williamson@redhat.com>
 <9ddfb5ef-a096-7171-8d12-c18b32c694b1@streamhpc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <9ddfb5ef-a096-7171-8d12-c18b32c694b1@streamhpc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 1/6/23 00:02, Robin Voetter wrote:
> On 5/27/23 01:15, Alex Williamson wrote:
>> Report the PCIe capability version for a device
>>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Robin Voetter <robin@streamhpc.com>
Tested-by: Robin Voetter <robin@streamhpc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Kind regards,
> 
> Robin Voetter
> 


