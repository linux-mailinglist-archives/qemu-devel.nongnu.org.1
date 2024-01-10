Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C2829E25
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 17:02:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNb10-0001wk-Qe; Wed, 10 Jan 2024 11:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNb0y-0001wa-E5
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:01:12 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNb0w-0001TU-J3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:01:12 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e461c1f5bso38216335e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704902468; x=1705507268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o8hJLVV6ac+MaDIfvX/KqWJ5Tuvnjxo0NEX31B3hfD8=;
 b=uvUxXey2Ixoak/2UfDfGyex6+MXgpQuRnf+ntaYyf6h9HtM9+GjcbKxg90fgDYAdm9
 nTJcDcivGMHxxKi7u8Vm70XVV3catAzY1+kPIBPfCDBAYiJHhUqOVVSn1hWaNwE37nvv
 YvOmP/oDDUSqrRsd3wX1R7r+qZCxKhpEsszOwMIk/nsqUEudQaTe4q+qDr5WMrXyPQPi
 VVqPPfe/3SCxBwvCOBAzI8DZPW/0m8QSuuaS4v13iWb5Kmwszn6eT9raU0+zZIJRoLsv
 TMJdvuGnb+I7uRhKgUac4fazCttMccp7x98JXk26KVedADZAZ4+CfgRb686Zait8xUF1
 iKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704902468; x=1705507268;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o8hJLVV6ac+MaDIfvX/KqWJ5Tuvnjxo0NEX31B3hfD8=;
 b=rVzKoBJ6TNGwCxNhZ3kwJGtFvXUcVPwgTIP67D5Tq42AT912b4DNelqHr8Ya12Y/ke
 YoVGjbc5ZgRO2ydeNlViJEBpWkA5aXvpHaz9IHxGtxwTBVR1NSgLdDOaIK6KFm//6nZz
 9eYpvt6KuiGdK5ICHjXOoejjaKwuRAW+uft700jD7kmUIdMZl/va07Je/dt8GpDk8Ce0
 eGVG4v723uqw3fkKtxKsng0LkfBM0gQk8ZKr2R8e0qrD6dNxcLuLMReWpq765meTlfb4
 e5G1d1p9zco+mB3mWRR0ZvUD3t1OaEx8h+5eQssQedVcBNAceNV0XM0HPaldTPr+0pCz
 0VEw==
X-Gm-Message-State: AOJu0YyHZSBkyViE2QRphxw8KB+/PyV+YMKoMNesR6dHutv5zjjMbtZ+
 Eznjvd17k/o4e11Lzz6qB0HcfdfEOIRc7lyF8MY/K2Wagpk=
X-Google-Smtp-Source: AGHT+IHQKQXXGS2VriJ93glzZzGJttEHd9U2YjzNHNbHOH0ljwZJjgml0RR0icyeiFsYD4qBARTLuw==
X-Received: by 2002:a05:600c:3113:b0:40e:4cae:a3df with SMTP id
 g19-20020a05600c311300b0040e4caea3dfmr643125wmo.128.1704902468503; 
 Wed, 10 Jan 2024 08:01:08 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc2b2000000b0040d5c58c41dsm2541135wmk.24.2024.01.10.08.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 08:01:07 -0800 (PST)
Message-ID: <20f3d501-7ff4-4094-8f34-9393c4c7c1e0@linaro.org>
Date: Wed, 10 Jan 2024 17:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Goldfish TTY enhancement
Content-Language: en-US
To: Jason Thorpe <thorpej@me.com>, qemu-devel@nongnu.org
References: <8FAAD163-46DD-426F-AF69-1DDAB45B2A9B@me.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, David 'Digit' Turner <digit@android.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8FAAD163-46DD-426F-AF69-1DDAB45B2A9B@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Jason,

On 10/1/24 16:24, Jason Thorpe wrote:
> Having recently written a driver for the Goldfish TTY for NetBSD, I found it a bit odd (and a little annoying) that the device has a PUT_CHAR register but not a GET_CHAR register, something particularly useful for early-console or in-kernel debugger use.  As it stands, to get a single character from the device, you have to first poke a DMA address into 1 (or 2) registers and then poke the command register.  Depending on the operating system environment, this might involve a lot of kernel machinery.  My current driver works around this, but makes an explicit assumption that a physical address is a valid DMA address, which is the true for the m68k virt platform, but is the sort of assumption one shouldn’t be making these days.
> 
> Would there be an objection to adding a single-register-read get-char operation to the Goldfish TTY?  The change I have in mind is to bump the version to 2 (so that driver software can identity the capability) and then allow reads of the PUT_CHAR register to return the first pending byte or -1 if the FIFO is empty.  Happy to create an additional register for the purpose if that’s preferred, but it seemed better to keep the footprint of the device the same.

IIUC Goldfish virtual HW is maintained externally by Google
https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT

I suppose the spec needs to be updated before the change can be
accepted in mainstream QEMU, but since I'm not sure I Cc'ed Alex,
David and Laurent.

Regards,

Phil.

> 
> If the consensus is that this is a worthwhile enhancement, I’ll post a patch.
> 
> Cheers.
> 
> -- thorpej
> 
> 


