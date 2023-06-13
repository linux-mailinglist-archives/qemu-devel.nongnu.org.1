Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64F72DDC9
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 11:35:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90QH-0003FS-3J; Tue, 13 Jun 2023 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90QF-0003EK-6d
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:34:43 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Q5-0004t9-JI
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:34:42 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-977c89c47bdso955154466b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686648865; x=1689240865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=po8Bu2NN9eN8EOnPq1AOSRaMBRFchIE7Z6J516uwNfo=;
 b=yboz9TlEtG/u/C9e3AALJaMxIq7EP9GnMQOOpEyoQuN61hV8c4UqZ5xYsPZPojewn7
 XZdw5qF+OXOi7TM4a8Rtzzv0USj8zLLJSmBcZyqYRGVz3J6pX6W4nyMlcuZxth24mtnG
 fhtaMy4BZ2UHbiQKuxb03PrJyp6thETu8P9IuTzX6GlFraJmPTCDraY+ZeqWEfkr6N8M
 lzDFnwP7cqK1og0Gic4JwBffIi/lfzhqTRHOU5ySf86qtpOIUyGasAfUuDL3hDzbqn1N
 4OJmKW9COVpTTD271LC8kbTCoMOmP8zEEXw+5s0wpJeQ26UOwtHhrTsPfpkJRq8Hl7JX
 xQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686648865; x=1689240865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=po8Bu2NN9eN8EOnPq1AOSRaMBRFchIE7Z6J516uwNfo=;
 b=fbzBkKZkqhsy+sp6RgPcIdgraZfr8Z0J4zNhzSObBzL57vI1/V29z7bPruNZJyAVcN
 2UFY1mTzS0vS3GK+uIJFDXAzaF+dif30MiYRbNQ5txeY7a8zpHjgeieGebIW2wwq/uwX
 y4HcyX+zF8G0OCfQjjvgAiFePihaogoexvbYKHwv+I+L8H0IhuTmpQjxEZm7g+qWEyzY
 4iK1xycId74OZa0QcaOk6ZLBX6gOnGZ/+gb4OI9508FFpgIGkBhKXlEt34F/hqndUz4w
 PTSyScvZ0OHthnyCjAJKa1Y7DhwYufjf+EuXlTkj9E+8GVagHhYTUS/NLhfx0jiWSbyf
 a9xg==
X-Gm-Message-State: AC+VfDywuz2gxyrLV61z0YH8iMznwZ2GlUHd7bbVQb3z/J+Yay7UW+Au
 fMRidvdG5Jd9w5D6NsHt4akemIjiKWnbnaQ9AxTleQ==
X-Google-Smtp-Source: ACHHUZ640BtQVB5DolWZHuHc0VMTPGcYO5oaQ1jY71NY8tVXkbKkmd848w5KPm3WpNYVrefhXuCP2A==
X-Received: by 2002:a17:906:fd88:b0:966:4d75:4a44 with SMTP id
 xa8-20020a170906fd8800b009664d754a44mr13013345ejb.24.1686648865359; 
 Tue, 13 Jun 2023 02:34:25 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a170906139500b009745482c5b7sm6368703ejc.94.2023.06.13.02.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:34:24 -0700 (PDT)
Message-ID: <a043b593-c576-5dd2-8ac7-63ecad5533af@linaro.org>
Date: Tue, 13 Jun 2023 11:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/2] hw/vfio: Improve vfio_get_dirty_bitmap() tracepoint
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20230530180556.24441-1-joao.m.martins@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530180556.24441-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 30/5/23 20:05, Joao Martins wrote:

> Joao Martins (2):
>    exec/ram_addr: return number of dirty pages in
>      cpu_physical_memory_set_dirty_lebitmap()
>    hw/vfio: Add number of dirty pages to vfio_get_dirty_bitmap tracepoint

Queued, thanks.

