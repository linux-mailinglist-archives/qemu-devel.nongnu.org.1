Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B937E3B0E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:22:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0K9n-000571-CC; Tue, 07 Nov 2023 06:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0K9a-000514-DM
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:21:54 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0K9Y-0007kT-2F
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:21:53 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9d216597f64so838544366b.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699356110; x=1699960910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHgkZlKlE2QznWzNPrPJrsZvkIQBijBjKSAPLZvKlJk=;
 b=JG+u0gHxGP8yUBJ3ixLiZ83zux2AzTas/wuYBjSEvtIZZJBMM2VEwu980H+l4eqDj6
 zaO5/79a4iaabbrN70tVoojzh/QJONfx9IEamnCgIOW5DBwxqudEgjro+i8tgdakoafn
 QTuRc6bVa7PoBu1gUea28g/qFwgflEeo0LCSE6SY0LsSLnB7dXZmSyQSeO8w1Dt623Bi
 0bfz4f0TIQlO4BzldRzZKon+6DaJG19+epL4hhzdOUIAaqcPfdiWJNACP1P/zNpMh1LR
 Frs97pkAJcH6VtjNMXkpqRVfoxB32pYtT5dQls08RoYYXyAEVQ9EH1/iG1TjJjFkiTk6
 roQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699356110; x=1699960910;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHgkZlKlE2QznWzNPrPJrsZvkIQBijBjKSAPLZvKlJk=;
 b=drTomznJ70aRkpXrkGIkUSWicvYAPAUae7eTr4FYaCDWRf2RqXYj/Dw5k98Afc2NvP
 FtJM2p3AEwn/g9jXyRquAoOK+PvxeZNMS3AQJXFimeEiUu8rN7pBpru2TgT+1nAoNQ8b
 uWabnMMhRxbDZ3siNIlGIaZGEKXomrxsg2l4nU40IzAu61geaCOAKtHM/WCNjCrULXsw
 kzo+0ryZIteMlTN1VxoEjV/Rwri/JZjDFwChpAmCunp63RXEaJB58hH/E5ruqYyT/JQv
 fui7pwtepYV6v7rTz+P0WWwX6kcPQizfm+RMUh1VhlndTeep2BtpyHO8nEXdoivDYNGL
 RFSw==
X-Gm-Message-State: AOJu0YxSiSeLVEZ7Ms8S85Ub1IPz6Ogj0+PQ5VmdkxThvEO5aIfp62Ak
 Ehv9m+/bGgAEQ3wkwEkuamnNoQ==
X-Google-Smtp-Source: AGHT+IFeAuW7+464nHfYu7UTCzBK36FZh0gjKOXhkYrQ9jqL541RsVZd5CrQwAdJFRYb7XHLnhk5VA==
X-Received: by 2002:a17:907:9726:b0:9de:725:927 with SMTP id
 jg38-20020a170907972600b009de07250927mr9331223ejc.76.1699356109986; 
 Tue, 07 Nov 2023 03:21:49 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a170906a28b00b0098669cc16b2sm920338ejz.83.2023.11.07.03.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 03:21:49 -0800 (PST)
Message-ID: <d6afb794-41ca-4bc9-a7cb-3970cd91de24@linaro.org>
Date: Tue, 7 Nov 2023 12:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] MAINTAINERS: Add include/hw/input/pl050.h to the
 PrimeCell/CMSDK section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231020060936.524988-1-thuth@redhat.com>
 <20231020060936.524988-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231020060936.524988-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 20/10/23 08:09, Thomas Huth wrote:
> The corresponding pl050.c file is already listed here, so we should
> mention the header here, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



