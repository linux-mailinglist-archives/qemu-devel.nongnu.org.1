Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4118E9B4235
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Oct 2024 07:14:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRT-0001YQ-Jh; Tue, 29 Oct 2024 02:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR9-0001NQ-Ki
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR8-00079I-16
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so35761965e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182236; x=1730787036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4xMNvOFHoQMIxTPyZxSwGEaFshytQZXSxDE1TsC4b5w=;
 b=aECJHCugHnyLORhBplDduF99NLoyHhm8kHwXgQz/QakI+zAkGOiCk0dNmsEl6p1fv0
 +VjyCMfoBrSUzch2GNAaElKGUqiSk9EfQgss5kNUXLqngEM+L9yxrhFXHlH8wVFp+xrI
 K7JQEzEqL7Y0OcBe6wjuIDfJC5Ty2NrxQAsQo4T9emssuiz4wUQSGGHALmGkD8dHreOy
 +HTArpyU6hl/2f9/Ij716dnwYUGoMu0jtdC5XT4VHbE0URZNuvZH5AX3zv4KpTL8PY8H
 /zNGm9WvAB0+b8hFaQhOYtSJJ1IlnT7l1ZL9Oe1NrXEqpWzaL2V7UGhWaxabtsc2GAnl
 qTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182236; x=1730787036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4xMNvOFHoQMIxTPyZxSwGEaFshytQZXSxDE1TsC4b5w=;
 b=kDZXtVsRg9/k9vbh4MUu8x7SGw+F3dTx6ikrWrR++KxzMML8Qtk6o/chJnMwQ2afGl
 HydH+ChOen/mPnYjO2BV+3yZfC9N/rCLrQN2ArrltOIoR/OlKqoLBIisgs0U2lZFA95v
 rHAZNb0kdIciwQoAZ4uG7kvS6uPggR88hClnkEJR1prs9ES1h5O+v5Ci65vN6bn0mOKm
 6PawuvCMNSZGF3AtHrUO0+SWL8KeLaJtwcidp57Sxz3X44bteuzKWH5OFv0d4dM0nzCI
 iXYfepDMos6bvokTAsowpAypR4wll2dUZy+YdXQa9Kxp91QKyv6LDsQnL/0etKXn23sG
 UCww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiCeHoA3RGW7/OW4cQVH9f3hvcvUAmXjPn5yFtcGDgGQLf/W97wiqCyfmHRH+Hf+RdBXEC2l9UwcQ0@nongnu.org
X-Gm-Message-State: AOJu0YyZ1+8KXVLZQURzshS9E8k02MZdYEw6V0LhIpIsiYf9MDLlWXHK
 WcyRL8n95uR+coSqKP4tSKM3ZF2n9KgjOwtaDg5CV839/9eBLiENwMi0QACsLGk=
X-Google-Smtp-Source: AGHT+IEGsX814W0LFqfoUf7zBxb/lvHLCt5x85TFKSV2oBWHRFrtdMGF1PcQ0Y1duhjfzCpcjB7xkg==
X-Received: by 2002:a05:600c:4588:b0:42c:b54c:a6d7 with SMTP id
 5b1f17b1804b1-431b5630bb9mr5994435e9.14.1730182236482; 
 Mon, 28 Oct 2024 23:10:36 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70bc1sm11560253f8f.70.2024.10.28.23.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:36 -0700 (PDT)
Message-ID: <b8dec070-e111-4484-9eb5-d98560692a48@linaro.org>
Date: Mon, 28 Oct 2024 12:14:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] target/hppa: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> Set the 2-NaN propagation rule explicitly in env->fp_status.
> 
> Really we only need to do this at CPU reset (after reset has zeroed
> out most of the CPU state struct, which typically includes fp_status
> fields).  However target/hppa does not currently implement CPU reset
> at all, so leave a TODO comment to note that this could be moved if
> we ever do implement reset.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/hppa/fpu_helper.c       | 6 ++++++
>   fpu/softfloat-specialize.c.inc | 4 ++--
>   2 files changed, 8 insertions(+), 2 deletions(-)

We could do this in hppa_cpu_init().  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

