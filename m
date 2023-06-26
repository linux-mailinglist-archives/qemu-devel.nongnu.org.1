Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992E873D9C7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhdY-0003bD-G7; Mon, 26 Jun 2023 04:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhd8-0003Wj-Ek
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:31:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhd5-0005Dp-Mt
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:31:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2603248f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687768281; x=1690360281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ebqY3AO6K515IxjP/HvUxhg9H0SA2Ld1/dX5IGmUf2A=;
 b=cQEPsyFkpIJRtmvRY3+aYysacOCipnYj75cjz3tjxEr/7KJ6Rw67GjgMNTDFQRH+Z3
 0Dza4LDgZk+iML+SXQLFWHJ9fJESejTVEf9o+lHQzAQJ5OvkJYOURyAUN0XIHnQobWG0
 xfefmjXpTr1i3skX2k6XK2nWS+RLqxlnHDyJxXxxOM2wdCqYXKYNolmwdi7x7We01oCk
 bBxpQC8HXco0AX0sDLgZMt8n29oGpz7DQT7FKn53Yn+XUN51T0bfzZ6EqTaLWUvfcLVd
 uw/66jnCntf3Q8Lo31qKO0yiNijGR114BDy+ZJYzE9PFF8EdR/I1V9LSEd7MZDh51a74
 0jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768281; x=1690360281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ebqY3AO6K515IxjP/HvUxhg9H0SA2Ld1/dX5IGmUf2A=;
 b=F2CNmo5DrMbpI9m+0IpgFOrnVqUNDf6v0UKGSiwVlbIDkB+yY80GUfTDMdlgCALid6
 QOOw0pZ/mXuB8VEzHXDdNwVgglzzTkrQUK9rlS554LJyxqyLjl7DckUTCQECa0fqUmvp
 X/YQ29Yu+ePeCRoLhuq920ixmeDdbaTjOHz5ftgpaqh1zhiQveZURbyTNsRwQUsUdyDk
 n0eTyrJ+0nn1xq5B/HGMUJZZMVfcn6NpH1+FFAE99FIgDAe+h6wL8ioceHlg61DYqGB/
 HbvCeUm2PMn6nFs6JO9oKQykaLqNO7bVrc4Q8C2Swwi6T7LNw1vqh1SwDbUw8hBE5W5a
 bQOA==
X-Gm-Message-State: AC+VfDy4Kad0oRFwkoWz1C3C8gkXBbOfyDVXVBqm7K4ufvxnRkUmMQ+/
 NR9e1VJsI51PWFIIYE7utCtiQg==
X-Google-Smtp-Source: ACHHUZ5REcl1glbbbgGBFxawNFFeBaR2g3xICsSHcaWw1Azfo2rUovb5hhZHhe8r4+zEtBx+8lQ7rA==
X-Received: by 2002:a05:6000:10c8:b0:30e:5bd0:21a2 with SMTP id
 b8-20020a05600010c800b0030e5bd021a2mr19911055wrx.52.1687768281478; 
 Mon, 26 Jun 2023 01:31:21 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a5d46c8000000b00300aee6c9cesm6646641wrs.20.2023.06.26.01.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:31:21 -0700 (PDT)
Message-ID: <1b18a3f0-078c-7b9b-79f6-8d82a3490b04@linaro.org>
Date: Mon, 26 Jun 2023 10:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/nios2 : Explicitly ask for target-endian loads and
 stores
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20230623172556.1951974-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623172556.1951974-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 19:25, Peter Maydell wrote:
> When we generate code for guest loads and stores, at the moment they
> end up being requests for a host-endian access. So for target-system-nios2
> (little endian) a load like
>     ldw        r3,0(r4)
> results on an x86 host in the TCG IR
>     qemu_ld_a32_i32 r3,loc2,al+leul,0
> but on s390 it is
>     qemu_ld_a32_i32 r3,loc2,al+beul,0
> 
> The result is that guests don't work on big-endian hosts.
> 
> Use the MO_TE* memops rather than the plain ones.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1693
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Presumably this got lost in a recent conversion somewhere,
> but I can't figure out where, so maybe it's been broken much
> longer...

It has been broken since initial commit: 032c76bc6f9 was already wrong.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

