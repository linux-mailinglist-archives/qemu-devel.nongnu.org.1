Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F5777CEA
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU822-00072d-Sz; Thu, 10 Aug 2023 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU821-000721-CB
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:57:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU81z-0007QQ-3p
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:57:01 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe5695b180so9106505e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691683017; x=1692287817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IftU204Dx3wX9GbOj52OKsZdF8meIuhiRJV4tTtRhzg=;
 b=lmF79bjOH3NyzLC7ga1wH5kFoakb9ECoW34XxZMk87j519QTw9AejqWdKL/gLU9U6e
 EIYBwq5uj46BaVsIcPLDTUE0W8eaLY6vX7mY+cGoXvOa3zoXGCN4+tAinRfxSiKGFzS9
 d7ztFMbfyGgd7bLIr2Ezq7MW+wAQrXHdng7bABtfOfxfnPclRFndCap5MZre1AMfvmt6
 OjeE+FOQXB0dB2hIgzRZ/eCWgKqeiDUoN08RoDR0oNtlHRabaQeXyxFb1IkC2OLdxF9d
 C2qpBfzBPIjRlIi2uIqjhA5sh0LlK+nQPUatyH7QymoXa4ZsfFTUvGJaIrm8YdcQBXHE
 6r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691683017; x=1692287817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IftU204Dx3wX9GbOj52OKsZdF8meIuhiRJV4tTtRhzg=;
 b=RYxWBAELML8X5m/VWdynBSdbS41PIT7aCpAPy791hD3rUNAqy/RujfwaXG+/2xcHLD
 e8pquUXXSGc06xv1HpxsDX2m6l0wCCfW1Zejviy+TEXgivyydXlrndS3ix1MATxyZ7Yp
 EQBDcQJhg4yA9KEqKXF4MmuLCMc8JvGof3odzRS3XScJbWyQ6h00QkbsT5pX85V89dM4
 +lZa+Kyd81YoEXkeO5cwYQRz4YyukveCaTFEgZXZNjbyN+1K0t5DvIAyCCJQHJOU9OaO
 LcDW0/KX+N6mU9W0ZNyp0vEdTszU1LkP8VW07DfRoItX1IwBOsEc7zAYsU6RfpPtw00x
 Qkag==
X-Gm-Message-State: AOJu0YxxA8NVsKIs6Jb6a6/faKvkixCu4GQU035XOrOzTN5eSdwNYVHa
 AVSEqg0cPgesiDcBwgXKBH74RQ==
X-Google-Smtp-Source: AGHT+IGsVbOUUzCe6wYBdQ1X431JQoVBiwZ7U+plB+t2qApaP2vuzvOhdKQmW4ARmvk+t+LKPDfWag==
X-Received: by 2002:adf:e34b:0:b0:317:6681:e426 with SMTP id
 n11-20020adfe34b000000b003176681e426mr2167114wrj.25.1691683017449; 
 Thu, 10 Aug 2023 08:56:57 -0700 (PDT)
Received: from [192.168.69.115] (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr.
 [176.184.7.255]) by smtp.gmail.com with ESMTPSA id
 j13-20020a5d452d000000b003179d7ed4f3sm2601025wra.12.2023.08.10.08.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 08:56:56 -0700 (PDT)
Message-ID: <e3b16390-d174-6c8c-3a36-d31dc5298376@linaro.org>
Date: Thu, 10 Aug 2023 17:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] gdbstub: more fixes for client Ctrl-C handling
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230810153640.1879717-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 10/8/23 17:36, Alex Bennée wrote:
> The original fix caused problems with spurious characters on other
> system emulation. So:
> 
>    - instead of spamming output make the warning a trace point
>    - ensure we only allow a stop reply if it was 0x3
> 
> Suggested-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
> ---
>   gdbstub/gdbstub.c    | 5 +++--
>   gdbstub/trace-events | 1 +
>   2 files changed, 4 insertions(+), 2 deletions(-)


> diff --git a/gdbstub/trace-events b/gdbstub/trace-events
> index 0c18a4d70a..b383bf8d29 100644
> --- a/gdbstub/trace-events
> +++ b/gdbstub/trace-events
> @@ -26,6 +26,7 @@ gdbstub_err_invalid_repeat(uint8_t ch) "got invalid RLE count: 0x%02x"
>   gdbstub_err_invalid_rle(void) "got invalid RLE sequence"
>   gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x%02x"
>   gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
> +gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (%c) while target running"

Since unexpected packet can be non-ASCII, better log its hexa value.

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




