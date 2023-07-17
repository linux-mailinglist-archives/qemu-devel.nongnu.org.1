Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2668756CE3
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTeT-0006rV-UL; Mon, 17 Jul 2023 15:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLTeL-0006qv-Vu
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:12:50 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLTeJ-0005jF-0N
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:12:48 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-79969c14964so1268206241.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689621164; x=1692213164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/22Ka842hfTB0T9Q/YG93R+7V5yFdD0n0+uNxg4g4Wc=;
 b=guzimCcnjoZeC/KMgC0Y8W+h9pHyMHW4O7cdc48m5AGiu7SMDDoiHVYARcwDBo53fr
 A0minn30ylLtV93h5sVEQRZdV4GlBI54lexLVyr21q9uUrFJr6KIzMNdh70KLpc52BVD
 0+Uo/vwWQtqAM+jYvOSA5KlgHZ0IY84rXe3Vgdb4XgVElTbLTnbIRe6CsBsAAzuZxQs8
 PELdCtYd+cqYb5rjeMDRZan1hiwA5ArCgf3GjLL0S9Gb7JUGKgUTXtFQ7Pz2rEhA7q/O
 K5/EzLQMdt4FH/teARt4Tdt4q5gTmqxLPPx/KPclMU5dChLGNqkQkCTngEHQqJovewxd
 zzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689621164; x=1692213164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/22Ka842hfTB0T9Q/YG93R+7V5yFdD0n0+uNxg4g4Wc=;
 b=Sy2qEhVMGbRZ5CeVXDm4ox4Zc51jPJOkqWkmRamuxD0L+Ng+QsODjiDBIlorrBMTvG
 70tjUGpEPO2CQoKHrHIbM9MYBZfLRc31i3PpR54K5vSdKAtP3V3z6W2EVDBUUL/gK8W/
 vfG9S82xEaVtN5S/y2Y6cIDDemKT4QpZGGTLvbE3Q8wTU6aEUOF/v18fPJOMVy20N7h5
 hcd3IC1NbGrmdwBhH0t1XvSXUqQYqIulNFgbiFB6FHQLBzZvjK+cpF64Iw/BrDxeBx/O
 +sNOVBAlEXDQ8BzbcE3RV3jWeWOl+OKYfXPT7u24D4s4aY62JuALwuZfFA/41Fismofy
 a/MQ==
X-Gm-Message-State: ABy/qLalWmQog+T48RWmHgTLWfNNAJy6lQjDUc/oQCd9/BaDrWVYA91z
 33vvb73EOy/KFE4SsKPW2XVowQ==
X-Google-Smtp-Source: APBJJlHxfUykdFR0yXNp3z6B8mco8CE6nvETZJKGw0A11g6YpABOWBbWk0q7jPAuAo60sBvzZaGhbQ==
X-Received: by 2002:a05:6102:99:b0:443:6c11:fc5b with SMTP id
 t25-20020a056102009900b004436c11fc5bmr211187vsp.14.1689621164711; 
 Mon, 17 Jul 2023 12:12:44 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.27.30])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a0ce2cd000000b00630228acc55sm110163qvl.118.2023.07.17.12.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 12:12:44 -0700 (PDT)
Message-ID: <1fab0981-f189-fbc3-692b-85ee2c68415b@linaro.org>
Date: Mon, 17 Jul 2023 20:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/19] UI & audio patches
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/17/23 13:45, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit ed8ad9728a9c0eec34db9dff61dfa2f1dd625637:
> 
>    Merge tag 'pull-tpm-2023-07-14-1' ofhttps://github.com/stefanberger/qemu-tpm  into staging (2023-07-15 14:54:04 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git  tags/ui-pull-request
> 
> for you to fetch changes up to 92f69a2c9bca26ee756c7cb932142664aca9c9c6:
> 
>    audio/pw: improve channel position code (2023-07-17 15:23:31 +0400)
> 
> ----------------------------------------------------------------
> ui & audio fixes for 8.1

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


