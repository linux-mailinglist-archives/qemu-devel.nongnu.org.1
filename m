Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFCB80DF3D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 00:06:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCpKk-00043O-Kt; Mon, 11 Dec 2023 18:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpKe-0003zO-Bw
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:05:00 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpKc-0003X7-LF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:05:00 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so4194528a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 15:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702335897; x=1702940697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+BSf1+hG1ax4Kjv+hgWatS05LiuwJKk6ZEDjToO6bE=;
 b=KZaOWxKrk/pldycL07X4ZAt4ueQqUEJ1QAFgt11HzriTzVK0a9keXT1IMn3cL3Ulgi
 iY9OwTQOZNrNW9OM32lhsktcytpiZKXi1R/55JCL+Cd/g3fMBxOnSdpCqp9ecdAaXku0
 XUhINLAKg/wMa0V+lCS49r25EEhsGFJhIEP+2Cjby4f0MJ9N+33tMDYxz4InrB3Sad8a
 XZJaFEYlb23dTunORidv56uOaea0DUebxwZcVTHEEl3YjosR9CQnU7kCATP0e0DM0qBT
 VYbRZ+OA2eHw41+iIOJS4SQCjEkkDlKkCdKsxpTNopMcYMThD9rjT7aTDslth72G6mJo
 9msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702335897; x=1702940697;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+BSf1+hG1ax4Kjv+hgWatS05LiuwJKk6ZEDjToO6bE=;
 b=hkNqX6Xx6popjJkO5M2d9Ncx0eRp5Y5voFCkkDB4l+C8kLi6uV8BNjZHEtZCocgNxB
 kGBD7Xf3q+qybjhTPAmIlfspV76vVQgfCfoBlX/IecbF1gl3ZR21uZG4i+yXm927gM00
 rF8Gro0sOlyF7ngB1GJoRDukzIJ5qUStv52vHKJz313hPEbigEXGzjhtd7Dmcfy0DaBZ
 N/8wQPDyynAAfoDZJRV8aeogZMbuMCmYn5IoRnzNLREyvml4/PAdX/o5fjrstaB+sxAc
 ZY+nXrO+rnTsxuMEMCi3f6c265RJQqhMTi+YI9+BhyyhIzigP7cqYTd4wBOxa2bZ6ay9
 sZaQ==
X-Gm-Message-State: AOJu0YxE6vo4k+lqceW7QeG4kNNtkAyREV/ayPcjsWT1Hcd76AANmnLf
 m1/5pxZKcAMpuIyRMbROnZ6pviEBqUzZ594EbxFpZw==
X-Google-Smtp-Source: AGHT+IElCZ0eiqqjvFW3OY0hXecXfZthqQ3iRN4i7P0JrNX21ZHJIbsTWp9sYdmQe5LFt38dlxZlBg==
X-Received: by 2002:a05:6a20:4f91:b0:18f:d275:9f33 with SMTP id
 gh17-20020a056a204f9100b0018fd2759f33mr5115290pzb.119.1702335896678; 
 Mon, 11 Dec 2023 15:04:56 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a631c51000000b005b92e60cf57sm6838432pgm.56.2023.12.11.15.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 15:04:56 -0800 (PST)
Message-ID: <29175c6f-74f3-4e74-afab-96120162fad4@linaro.org>
Date: Mon, 11 Dec 2023 15:04:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/24] target/i386: Include missing 'exec/exec-all.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> The XRSTOR instruction ends calling tlb_flush(), declared
> in "exec/exec-all.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

