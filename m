Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03574A264
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHS5V-0000J1-3y; Thu, 06 Jul 2023 12:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHS5T-0000Hn-Iw
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:44:11 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHS5Q-0004nP-Pu
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:44:11 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b6f52e1c5cso14067151fa.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688661847; x=1691253847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdAqGi9meiuNIBsbd0w+Z2XLHwpHZx+PekJlmdeTDvU=;
 b=kwkeymgtNhhmRpgRZb2WZ2+Ab2ywk9YeQbwyZ0jxSy9aAYPPxcITWX3PnGKjfAhKEv
 j+iN3g1vV2h11PgYkO/OIszlURXhYgUX/CIChQz0XbaBavjyVNx+lnlTVYp6GzJCVjLO
 OteaoyBtaClYdyX12pHuRAOe87oOEkrSTQ7kGwaWPpMxguKHiQyZYirJpaiL7rZtjCgj
 EPL/AprQg7IseJ5QGrqXDY92GswVjIie+qfuNfr3FUDYQyW8r8oxTh1+F/us09RPbcrc
 PJGCRPy5WDBeaNJotRJrcrn7C6ufFPLZ1tLKXHvgRcRzA3xTf3ApqhWkPaoLdTbSJk9a
 1Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688661847; x=1691253847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SdAqGi9meiuNIBsbd0w+Z2XLHwpHZx+PekJlmdeTDvU=;
 b=ZHUwUsi5dQDZHY0nhpiuUoddwqDrKCmjnjfAQoOoMGKpsQs8pHnsVIFcvIRX2T6BvW
 dAdxjFzsFmvhOJ7TeU+C7yz/2VV/rrjOSSWBsEExPSlmTk8WZMRpu0q5y7qQ4plfVhFH
 ZNDg9YX64dgfyDYIlZEAQnJ3V6Y0219HoqM2XBaxsE/gW1GgNRg049jGaZKre1F9pWGn
 b72Vj40rD9vzCjgsdkSnoy+Mn0LCtkVnsXIPLht08fbIzbGRtvlS6DVX7zlrJMFcbxYm
 cUF4LUfRO38s1Nx1tenHfqXe5f2pox92+PK80gmvEsx1J3MBsGBkbRdhwrIQ+yMQvZ0W
 UJ/Q==
X-Gm-Message-State: ABy/qLaGzpx9swCyblmXW0fMxgFlLAwN3EqgW/8CQswvlDX7UWZhbMx2
 JhBRwTzVx4qyezlrQs1FrYbEwg==
X-Google-Smtp-Source: APBJJlFxBauAoOYjNSjh+Fain5RLPO1OBQfT044EV7Q0ZFRvz50dkjA3c8AnnkC5HiKnpES7EnFb/g==
X-Received: by 2002:a2e:740a:0:b0:2b6:c4be:8397 with SMTP id
 p10-20020a2e740a000000b002b6c4be8397mr405074ljc.20.1688661846976; 
 Thu, 06 Jul 2023 09:44:06 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 bi1-20020a170906a24100b00992aea2c55dsm1035665ejb.153.2023.07.06.09.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:44:06 -0700 (PDT)
Message-ID: <7cc2c3da-6ec1-7c4d-0c52-8752e79064cb@linaro.org>
Date: Thu, 6 Jul 2023 18:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] migration: unexport migrate_fd_error()
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org
References: <20230706102937.82490-1-lersek@redhat.com>
 <20230706102937.82490-3-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706102937.82490-3-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/7/23 12:29, Laszlo Ersek wrote:
> The only migrate_fd_error() call sites are in "migration/migration.c",
> which is also where we define migrate_fd_error(). Make the function
> static, and remove its declaration from "migration/migration.h".
> 
> Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
> Cc: qemu-trivial@nongnu.org
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   migration/migration.h | 1 -
>   migration/migration.c | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


