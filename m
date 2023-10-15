Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7277C9C76
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 00:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs9ku-0005xM-Jn; Sun, 15 Oct 2023 18:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs9kp-0005xD-CD
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 18:38:35 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs9kn-0006tk-Uo
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 18:38:35 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d9ad67058fcso3873237276.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697409512; x=1698014312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ln0bxe55L6itFtt/9RseuDDKXFHaR9irdzUlPxaPf8E=;
 b=hnYyWMZtkYEP3X78gR8YBg3YXBWSLSYF4fQRkftfaWpawpazAomYCckiED+MhZuImw
 SJjCp9doHImg/QT7EogG6qznQMkPNlt2DjwvBn6z8rO5v+5pqz1KnOParIQk5ZpFyl6I
 dbCf6RiOQIcXrTwUfXnCQp3XW7cdsIxSW/MkJgogxdieisKKU2xe80lXT4EnJT5qLuSo
 wHyhrtb9eCWgmsbUIxGGr6aCOkjDB5JLLguL8D8puy4Z5rlWI1BW5IbzKi2ruYi6m8NL
 JvttDoFVzdl/CzSYe8n9UW+uCZNlGXh/ROJUJDmHB88qK3+aZxl3OVk1H5xYCxMsWShJ
 dBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409512; x=1698014312;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ln0bxe55L6itFtt/9RseuDDKXFHaR9irdzUlPxaPf8E=;
 b=FEdh5MVfTvYdFbjuPEBI6rM25Nh/B1zXb4nKsuGWc4FI49tTTr0dJKm2eDW2Om//Ca
 ywLLYyl6eTXfVSReCX0NzjsszLc/RhKtHvQQVGoZ7mkgNZGwycPBbGV7Epcfgky200xn
 afoJnGyP1CAXqRsVQQSb+SHhFs9BHWcdhKqMaiXo82Py3YozfpD9K/0A/6Cfypz7/Mr8
 KnzGbpXFb2JF6ZnEBpo1zokcTzj83b56HPInVQHFIR4a+DMDqf6Ibg6qAfl8fH/nqKB9
 IYEpKw1DsiLUf6KnMhnRkiIJeRGwYnBdRZF4ER1+6Yg5iJbnU3mfC4E2LEGUD4aFGXct
 Rbzw==
X-Gm-Message-State: AOJu0Yxal3eml5YKUqPmS0FxI+vSxk/Rk2CMbMM06cies901bMwlEecs
 mlea0j9eAvurIWh8oy1xjUZD9Q==
X-Google-Smtp-Source: AGHT+IGjk8sdLYeruZkD0oZIZghV2mO53qZjdAwin/6CmEwUsCbfX8d4zmqxKQQ+21Kuj9y6uS/+mg==
X-Received: by 2002:a25:7689:0:b0:d9a:4b0f:402b with SMTP id
 r131-20020a257689000000b00d9a4b0f402bmr18356461ybc.38.1697409512136; 
 Sun, 15 Oct 2023 15:38:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a627917000000b006b2677d3685sm4770670pfc.207.2023.10.15.15.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:38:31 -0700 (PDT)
Message-ID: <eb2238fa-d50c-496f-bc19-25288a8b0099@linaro.org>
Date: Sun, 15 Oct 2023 15:38:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/85] target/sparc: Convert to decodetree
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20231013212846.165724-1-richard.henderson@linaro.org>
 <925432d7-a8dd-43cf-b27a-ec1c862623ed@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <925432d7-a8dd-43cf-b27a-ec1c862623ed@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2f.google.com
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

On 10/15/23 13:12, Mark Cave-Ayland wrote:
> 1 ./qemu-system-sparc -cdrom debian-40r4a-sparc-netinst.iso -boot d -bios ss5.bin (Boot 
> with real SS-5 PROM instead of OpenBIOS)
> 
> -> Hangs during PROM memory test
> 
> -> Bisected to:
> 91b579b5293c4c5c3cfaf0214a5523b655dea4fe is the first bad commit
> commit 91b579b5293c4c5c3cfaf0214a5523b655dea4fe
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Fri Oct 13 14:27:57 2023 -0700
> 
>      target/sparc: Move JMPL, RETT, RETURN to decodetree
> 
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>      Message-Id: <20231013212846.165724-37-richard.henderson@linaro.org>

Incorrectly translated "call %o7".

Old decoder always computed the source into a temp; new decoder tries to use cpu_gpr[] 
directly.  Clobbered %o7 with return address before setting npc.  Fixed by moving the 
return address store later.


r~

