Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D49765B01
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:56:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4zd-0007Vs-As; Thu, 27 Jul 2023 13:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP4zX-0007RB-Mr
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:41:35 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP4zV-0004CS-HX
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:41:35 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-55fcc15e109so676162a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690479683; x=1691084483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=amoJHJjV8AA1d0OHUeNdCTzLiqpZuZzRwYpAqyrpf9U=;
 b=swOK8CZ5g7+fG1+DrkYv768nrP1MHU/J99X4Kj0/Jte7zFlEIMxLcfSYYIqSbCTt2s
 97btCqLGkdhGu2Nc9R1ndPNhj+2uzubQF6NtsA0pIt8ZqCClBTN8QtyrvUfCLXzTLoth
 I5U1Ii53EPhl9mBh2gPNgR554ZStHF7gBs7CVSQXh23RcGYJiZQqJxFz01NNMi2TvbOc
 DqBLGqFFi45MyHAn0E9ThP0lZ/i08bZPDzEGPoc4P8YyTCbT1n3yJZkBRuMSyCbQNXg0
 n7ScB3529y/eucM3PdKTFD3St9GzzhNZnegWcPL6NAYQbLTblltmzYEKQPLoyjH7E+ir
 rnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690479683; x=1691084483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=amoJHJjV8AA1d0OHUeNdCTzLiqpZuZzRwYpAqyrpf9U=;
 b=TbYGwT8mxnu8xEDhnE9EKoolG97ehi/RgOX2Xc5T846DdpMJQzTu+G57U3uOdIbv3X
 gLEI/uJyIvFePu77xrQRgk1spFbEnmJgVCSwII99+3Lb7qCkwunQQ4JLor88BZ7yPOWG
 duKlNbw2g5Mg0mcRQ2nTo7WP5smjYQ2Y3K5YxYOzNU6ZEEB/hRKuBL9UkQ4hhVENrRcF
 B6noKF8R9tnJKUDY4HLNKyn9oRfeUxQXPCVYQZm8Al0PsHeGx4LHWQTl2eSHEdzL8s3t
 YztAjLJwpYMQwf8sQGWb1A7DOUgnCHgbpOHrDeWQsqTpL8yO9FsU6/HT2bxhoDZ2nV/Z
 fMYw==
X-Gm-Message-State: ABy/qLbKxmcHBOYblgREIi7gDOLm3SlCm50l+0kYKEKbczn8ugiw6lB8
 rOrFsvmgSLNxzV4SZ8uu6w6wJg==
X-Google-Smtp-Source: APBJJlEFLc1gymeOnhnhgWYqHiCy48LjPvlBZTHcVXA/e4shpsJa9bfyIfdbid+b9vjgWBqTdM3ldg==
X-Received: by 2002:a17:90b:3101:b0:268:3000:61cf with SMTP id
 gc1-20020a17090b310100b00268300061cfmr4221696pjb.35.1690479683335; 
 Thu, 27 Jul 2023 10:41:23 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a17090aec0f00b0025bdc3454c6sm3055463pjy.8.2023.07.27.10.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 10:41:22 -0700 (PDT)
Message-ID: <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
Date: Thu, 27 Jul 2023 10:41:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 7/21/23 02:08, Claudio Fontana wrote:
> Thread 3 "qemu-system-s39" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7ffff53516c0 (LWP 215975)]
> (gdb) bt
> #0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
> #1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
> #2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
> #3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
> #4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
> #5  0x0000555555b96134 in page_unlock__debug (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:348
> #6  0x0000555555b962a9 in page_unlock (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:397
> #7  0x0000555555b96580 in tb_unlock_pages (tb=0x7fffefffeb00) at ../accel/tcg/tb-maint.c:483
> #8  0x0000555555b94698 in cpu_exec_longjmp_cleanup (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:556


https://patchew.org/QEMU/20230726201330.357175-1-richard.henderson@linaro.org/


r~

