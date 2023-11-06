Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960FA7E2705
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:36:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00gq-0006Zb-TV; Mon, 06 Nov 2023 09:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00gp-0006ZL-9B
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:34:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00gn-0008TG-LQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:34:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32fdd0774d9so113799f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699281292; x=1699886092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tOvmChLgVnsH3sz4kBfjmULUb9dueBF814+cT71F1ds=;
 b=ukvkPtfDeNvFj6ivQe7myVlFk9Oa/2A0Bi53pzNDIWzou4G/nhpHcXep118s2ZP2yb
 lgH5iQhqJKoPpeHmrIeABEuxwAqDCZm5xoApd5qlyHIoszVYesYMeSUBp/BLfE3a+A1o
 y4xAwMfNWJV93oVhD0n7zQuQO0au1sQ61hTxLADZfvFtR6z6iHRPLYQoRn7fZ+GEwaFB
 HWtgxvMckInNdfQvDaTnjxISrgBu5cjPLmIzqHEaHwv8xodPoFrvib8eG3J1T4f7xnt4
 wU0xpwp1lzxq+DXPiFjwsV3M7M+7TmaiQjLl3j4IRnWPyoHDUAanvenhSfm/lQkTnc16
 /VzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281292; x=1699886092;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tOvmChLgVnsH3sz4kBfjmULUb9dueBF814+cT71F1ds=;
 b=CtCGriS+/REX1YoLDMylCUkmjS2LrtOVO35eOPcI+mXe2JpZ7Le4qONJCdBfv/haxQ
 iXy6675Gn4pcC+9yE7K7bGhSACd+u7pC9jjoWke54wb18rYXFEoeGKOBVRKH4ijFEe6w
 r7uSRHOGCwpDPLTxHb8qrEys8Q7t5R+uBUow6E4mgS6hUCDmjJiRUOqerJAzsEmmlXu3
 O6gnqj8YdeNQHJj0aTYcdGQKV7baOQVlzawewjKUnpJlOiLRrdmORcH6jxBsT/HP8cS4
 AqvFJaO4OAMcQf1qiOYxv7j2qR6WfrcldGZ/kYY7LLDJ1591Mdw3RRPr4Y5AsCHuJ3eO
 xgGw==
X-Gm-Message-State: AOJu0Ywacmt854XbQTTMmeAz72j2AzNRoJJlqId/7++cwtq8+hgVTxBK
 ZlYZ/TVBBTETRdtAXxQJ0SXozi1jFAKRLutC270=
X-Google-Smtp-Source: AGHT+IGZba8SjVcGZMVY+Ul1aksYAV+dQXYF5t3+yFz2g+w0ck+xaIjKvubXxJdz8Gg3XYK9lJrwoQ==
X-Received: by 2002:a5d:49ca:0:b0:32d:8982:ff1c with SMTP id
 t10-20020a5d49ca000000b0032d8982ff1cmr17661031wrs.36.1699281291701; 
 Mon, 06 Nov 2023 06:34:51 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 d1-20020a056000114100b0032415213a6fsm9582591wrx.87.2023.11.06.06.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:34:51 -0800 (PST)
Message-ID: <f85b4901-a592-da73-f567-65eb511cb67c@linaro.org>
Date: Mon, 6 Nov 2023 15:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/avocado: Allow newer versions of tesseract in the
 nextcube test
Content-Language: en-US
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20231101204323.35533-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231101204323.35533-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 1/11/23 21:43, Thomas Huth wrote:
> Current Linux distros ship version 5 of the tesseract OCR software,
> so the nextcube screen test is ignored there. Let's make the check
> more flexible to allow newer versions, too, and remove the old v3
> test since most Linux distros don't ship this version anymore.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   tests/avocado/machine_m68k_nextcube.py | 15 +++------------
>   tests/avocado/tesseract_utils.py       |  4 ++--
>   2 files changed, 5 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


