Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E97CC50C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskNB-0003J9-Cm; Tue, 17 Oct 2023 09:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskN9-0003IA-7h
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:44:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskN7-0004EV-Pu
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:44:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so3028940b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697550271; x=1698155071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zDtPhJ/dWj9gcmf5BggvtMzae3nZKWLwDQnAqvCT2Jk=;
 b=jw29AUf+VKLqw2mubuRS5D6nKLj4Q2CXMp6GFxN7IJD+BFCmo4OhpI15/Xyx3nn0gT
 yvbjTJG/mrfz+xPqspMPiBGTtdLo38knskLZg+OQdm6chilXFyYXSI8N2T+csWgmtvtJ
 wtXAGXV46HLkJt5QL0Wjb5VLZxb/Pz9kS5rSeCuYfvUXIA7keqP57IO++/RyTgjlbGnM
 2qfNr30cM+eHfdqiRc+SMIk9zH3EPbw37kfTj1hWb2Twa4iiPvXk9QlQYNHd7AA6/2dU
 jl8+cFFrCOXJNILEQVg+VfNMqTR2O2WP5OTVQUnJJD22dof/l++mL4qM9QMm06urzB+P
 FQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697550271; x=1698155071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zDtPhJ/dWj9gcmf5BggvtMzae3nZKWLwDQnAqvCT2Jk=;
 b=Kq0A4u5b7RPwR3BHwMt9W/ZKJnRRQ9XT1hH9gDCwpfg36Ce/1Sh1PTD1DkeXJXcn3w
 AMtFQRiSvMj9zRoc+DEZ4XhZkcChbK65U0y0GDfvVJZpTDWm4rSWQmM/OAG7iUHW+yYt
 m4gYZ59ja1tTlr3vcjV8l/2dIsGVAQnES2Bq2Y3Z+eutyq/KArhy74do8BL4Cgob+DtX
 6grs5ot71IOF0nVmZ84zz3TmzF3G776FU1IlalaoZ6OP7yDrUyrzkubNfP7f+fOD7GXh
 /HM8uhFLabGDhPupG6vsInfuGtthEYgp5kr7tqSKhshc51BNpje8hzEhomH0i486p+do
 qL9Q==
X-Gm-Message-State: AOJu0Yw8AHMhS/H9wTetmtdyn/yyj1bMQytFG1yQBB0aAh4NIeP24kaV
 7TZhpXwIVb8DV9x+OgoS4EIOpTkkrUyruO3jiqU=
X-Google-Smtp-Source: AGHT+IH04IM5L329e5esbwORaI1nL5s/dveeeojqAFDTZZ1PwMMOqkTik9nHhBN50k8xfAQOUTDrzg==
X-Received: by 2002:a05:6a00:24c3:b0:6be:2dce:cf5a with SMTP id
 d3-20020a056a0024c300b006be2dcecf5amr2370840pfv.26.1697550271581; 
 Tue, 17 Oct 2023 06:44:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y18-20020aa79432000000b006bd2bbbaf49sm1424836pfo.122.2023.10.17.06.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 06:44:31 -0700 (PDT)
Message-ID: <455b66df-b0b9-4b5c-b061-1b74de80acb5@linaro.org>
Date: Tue, 17 Oct 2023 06:44:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/m68k: Use i128 for 128-bit load/store in
 m68k_copy_line()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20231017122702.39311-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231017122702.39311-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/17/23 05:27, Philippe Mathieu-Daudé wrote:
> -    tcg_gen_qemu_st_i64(t1, addr, index, MO_TEUQ);
> +    tcg_gen_st_i128(t, addr, index);

Lost the "qemu".


r~

