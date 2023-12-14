Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB588812BEA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 10:47:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDiIm-0007Gm-0F; Thu, 14 Dec 2023 04:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDiIj-0007GJ-R4
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:46:41 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDiIi-0004P6-AT
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:46:41 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c5ed26cf6so10004703a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702547198; x=1703151998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cv5PGzpCX1F9nUNiSA5wJa//714xc/Jw/CCbAf9eNII=;
 b=Nf391/po6wMHBAbPW6jsxNkKksgoaTqi0WvckZRaDlzEVdH+WMIRD7d48xxcghnV6J
 OfDoPOolIEUrWgmPgbBKP67wJa5pf+4N6e6YnD+EYCepjyDpeYB743luIUbt4DnpZmru
 mondCAqtXxTQFo6ggpgopvEgzgsqjN466uaXsY8cb0WbuYYkJ2rgg6J3RA0G/IiE5goM
 6DwrIijbm+c9zWOOAV2hL/lhTdb5pbnKXtiLBPy9Xk8/ywP6sjszTf5JAFVtuufXt8Jm
 39lvc4OHFDZlh4u4Are7R9Z//+p9Ujli7fVntrUcFQsMTZn0PCCts/Wr6pc5AA/kZIqy
 LkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702547198; x=1703151998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cv5PGzpCX1F9nUNiSA5wJa//714xc/Jw/CCbAf9eNII=;
 b=SUkzNuxvmP1h3ykXT723FJW6aXvkoCf6qznKkUHcDXrfD+kifTwrePlJWYcxDlHFA8
 Hqm+qXUvqRxta363BXmSLQ6/AEDAibSSjfl+S/BMGOylS2ZIp3x+ClGTPAeqIGylIf1u
 9GW+x3jJRT/QACIV+4ZHx1BLiNQt+1ii1a2Bzu18Nd+FECyJ0ZQ8y0AjEyOCYBGjkT9o
 qzRBSmOBGpiNF6Spt7DEOyQOi46rHZPHQ0EyU5wJg8xwomg7hXdZLYIlV2d8STUaMpKK
 2C1F0wr1AQl93vtagIE51GM6+IW86bMVLXk/V4IbGHq3H2xvCu37r8xhvwppO2XurA/o
 OKDg==
X-Gm-Message-State: AOJu0YyzkyhQqkLSglBcY8qSmAOHF6r0WeOHgtnpP+9V7V6AiLXxENs0
 8aScbTpZd61pNHYzaV1T3xE9UQ==
X-Google-Smtp-Source: AGHT+IH4Mhtp8aGep/eo9UcFv646YiQjeYXZosT+xJeQIrklk6cLHPsySBJDVSGujleLQM68hcBA1w==
X-Received: by 2002:a17:907:6190:b0:a19:a19b:55e8 with SMTP id
 mt16-20020a170907619000b00a19a19b55e8mr4417409ejc.120.1702547198484; 
 Thu, 14 Dec 2023 01:46:38 -0800 (PST)
Received: from [192.168.199.175] ([93.23.249.68])
 by smtp.gmail.com with ESMTPSA id
 un7-20020a170907cb8700b00a1b65249053sm9024654ejc.128.2023.12.14.01.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 01:46:37 -0800 (PST)
Message-ID: <ccd8c036-1056-42eb-94d0-f578e359ae6e@linaro.org>
Date: Thu, 14 Dec 2023 10:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qemu-options: Unify the help entries for cocoa
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Carwyn Ellis <carwynellis@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20231214-options-v1-0-113f347b0e3f@daynix.com>
 <20231214-options-v1-1-113f347b0e3f@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231214-options-v1-1-113f347b0e3f@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 14/12/23 07:31, Akihiko Odaki wrote:
> Apparently the help entries were not merged when the patches got in.
> 
> Fixes: f844cdb99714 ("ui/cocoa: capture all keys and combos when mouse is grabbed")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   qemu-options.hx | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


