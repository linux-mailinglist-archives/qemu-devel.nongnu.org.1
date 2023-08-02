Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142776D184
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDYi-0003nq-Gm; Wed, 02 Aug 2023 11:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRDYa-0003mr-Bs
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:14:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRDYY-0002c8-BT
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:14:36 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-686e0213c0bso4908376b3a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690989272; x=1691594072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hjiqjFM/jcTjxoUBPm1tC5JjsNU//ssKlTYPwy3r5Vg=;
 b=mzyNfwRqGoaMo1O42sAbxedRLjS1Q+izi6rfEJvVM2zR5utnRM2HhKadR+hmg/NP0i
 uilOzSnITmyIIeBygX1//ieeh5k7UngVQrpdtVJFWTOyfph5HNPYPfIbRw9vIKTqgarW
 CvazLuSTHDKgC1bGTMtEWMG6yX8u9shVdt0J+PPt3dZmHIZG7OrmFoODCdqVc02cuamw
 i4WpYnOzNN0YeeeDiDE3w6kY6NP+rxbFfd+VtrUQ77Vh5UDbQvWD8HKi+67QqfTIJn0p
 newYjD/P8VX9O8Ar80CiTNAaWKCaDHxZK7y10vwnoDyV/3nhuZ95xLtkkBywZQvOsXCe
 ouIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690989272; x=1691594072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hjiqjFM/jcTjxoUBPm1tC5JjsNU//ssKlTYPwy3r5Vg=;
 b=Jf8QtizVHepqLtLcZZIS0gH+b9Auhkgl7V8iEDV1aYU4vQBNIyc8E8ProdxtB7YwC4
 UKpRYY23zmgPcexgrP1Ldy8Kk+uAynNTKsACvLskmC1C4Ydf4331+dpYU6wr0JrQOu+y
 njbrfGyP2uNlowsOgqoQn29n4bhGrRQVCJj7MbANRU6I7BkxoIEQVjFu7md5J+irfcQh
 NCOJkAe0xjCtz3m57FTKmyCxW0uS8XIsxwjxgh19adZnS5nj/4SA5kOkUtnJuOUgHRl6
 L3fBm9hacHW76jkHAUs+4OC4z2sE9s7YRYNFtrt77qMalUWZL0c92yelaBr6f8xG+LgV
 XQnA==
X-Gm-Message-State: ABy/qLbbqBvbO9vwlVEW++cxZV5tQvJU4oxawkkh8jaz8MKbkFmQLUvI
 Rd3X//5Bfj9MB7TTqqisUSq3sg==
X-Google-Smtp-Source: APBJJlGD1vPnbM86JskqLZ4uEtRn0qQnrkV7BfOWb5XTdYvQS1RqTDekx6/VTgXvaG6Z23mt8PSkwg==
X-Received: by 2002:a05:6a20:6a28:b0:13c:9317:ad78 with SMTP id
 p40-20020a056a206a2800b0013c9317ad78mr16643379pzk.46.1690989272219; 
 Wed, 02 Aug 2023 08:14:32 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 y5-20020aa78545000000b00686be6e0f36sm11216376pfn.60.2023.08.02.08.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 08:14:31 -0700 (PDT)
Message-ID: <0ebdeb87-6b86-85ad-b068-ca8df7b76989@linaro.org>
Date: Wed, 2 Aug 2023 08:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/1 for 8.1] TLS crash fix
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@gmail.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230801174650.177924-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801174650.177924-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/1/23 10:46, Daniel P. Berrangé wrote:
> The following changes since commit 802341823f1720511dd5cf53ae40285f7978c61b:
> 
>    Merge tag 'pull-tcg-20230731' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-07-31 14:02:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu  tags/io-tls-hs-crash-pull-request
> 
> for you to fetch changes up to 10be627d2b5ec2d6b3dce045144aa739eef678b4:
> 
>    io: remove io watch if TLS channel is closed during handshake (2023-08-01 18:45:27 +0100)
> 
> ----------------------------------------------------------------
> Fix crash during early close of TLS channel

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


