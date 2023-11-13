Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 912617EA2CD
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:29:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bez-0007zm-Hb; Mon, 13 Nov 2023 13:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2ber-0007xz-HV
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:27:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2bep-0002G6-Ps
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:27:37 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc5b6d6228so28716085ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699900052; x=1700504852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qk/PjJLalMNo/aekZ9Xs4b/ft2tGDiJ0ACb0gipzgL8=;
 b=WtQtlAHUUPpYKb1CmEdM9p3IBQKj4YOOshzQgz7jG109x73ddFL/SU8SMuNSHlGaf1
 WNiF2ZdVIJMlYChHwycO3YtwzAyRhpxpIsxoWjVB7KkxD9lqNrkyQs4wdZHYHHcDc0Wm
 I3MrOVD5uHeLSyRXWbIAmDPPkWhyxDGnl0hwbL2INBLd5Zx8vA2aoUXG4edJgTOgRRn6
 webydbHEOwnXaV0bwMG6EjiSNvBmuGp52eDP8A3osZSbc3LM5Jpr+3oC7o3Z+gMRt4a5
 xv9P434jZ5cNfDpOZUK4vRTFf/a5tU759Bn7G2IIVgZsUq+NWPDMWt0vT4i11TvxiUC4
 Ejrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699900052; x=1700504852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qk/PjJLalMNo/aekZ9Xs4b/ft2tGDiJ0ACb0gipzgL8=;
 b=r1T7RQtrpcbY34uViKnCAjkdmXY3TDFv5626egSssuoU+jl+UtjBRLPDQbRXef9yiq
 5owidlIetpna32VqkLOkeJv8tHWZrAmWaNch8DnBeBdQ8jUrNkNisJQwMTxzkcd/Ph2M
 tuGjmdlU9vj7HXlV0rfi3O7VZQzZh7TlRfKfNyQv03i0dxCy2bFcRrLW7utJC5XoNby7
 zndeUV2mV7VIhclAo5P56i3ON6OsrmWbozn4mmQlqGMEE1ACR9PHaRFDnxTWNySDjy/l
 kpdndhmzqFRyFx4a+3ICely2AWT71cRh4TowYAvedLoj16ENsuUXEzU5TNn8/08gFRL6
 ZcWQ==
X-Gm-Message-State: AOJu0YxoRpXd/vc8lobsZGZR0ZHeUAxwpCuGm6XHi96wpDkKIjQVqeO2
 OOdfFutKxzLBVypNtIRNzyHv0g==
X-Google-Smtp-Source: AGHT+IGXdozYC75nqIe1BfE8y+okMwP1+fu8ttwIE9YFpVNyTyrpKh1t9vRINurvwmR9Dmq3OFjWsA==
X-Received: by 2002:a17:902:a582:b0:1cc:32be:b13 with SMTP id
 az2-20020a170902a58200b001cc32be0b13mr298664plb.64.1699900051691; 
 Mon, 13 Nov 2023 10:27:31 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:f7fc:9d46:b65e:128d:39a8?
 ([2804:7f0:bcc0:f7fc:9d46:b65e:128d:39a8])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a170902f68e00b001ca4ad86357sm4296769plg.227.2023.11.13.10.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:27:31 -0800 (PST)
Message-ID: <ab11195f-f646-4af3-9bdd-db5a26dca31d@ventanamicro.com>
Date: Mon, 13 Nov 2023 15:27:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-8.1.3 00/55] Patch Round-up for stable 8.1.3, freeze on
 2023-11-19
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
 <5d226848-8af5-41ee-a353-6bc53902085d@ventanamicro.com>
 <7af5d33d-e661-4945-987e-41ac5f623b15@tls.msk.ru>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <7af5d33d-e661-4945-987e-41ac5f623b15@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 11/13/23 15:01, Michael Tokarev wrote:
> 13.11.2023 20:44, Daniel Henrique Barboza wrote:
> 
>> It would be good to have these 2:
>>
>> 082e9e4a58 ("target/riscv/kvm: improve 'init_multiext_cfg' error msg")
>> 608bdebb60 ("target/riscv/kvm: support KVM_GET_REG_LIST")
>>
>> The first is an error msg fix. The second fixes a problem with KVM guests when
>> running Linux 6.6 and QEMU 8.1.
> 
> Sure.
> 
>> This is not a clear cherry-pick though. I'll send both in separate for you
>> convenience. Thanks,
> 
> Actually both are trivial to cherry-pick. First is a clear c-p, second needs
> a trivial context fix (where in the file to place the new functions, that's
> kvm_riscv_init_user_properties() thing).  The rest goes as-is.

Yeah, it's not a clean cherry-pick but it's trivial enough.


> 
> I've picked up both.  Thank you!

Thanks!


Daniel

> 
> /mjt

