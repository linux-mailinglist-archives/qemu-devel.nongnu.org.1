Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291297A91EC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDqm-0003oU-Qi; Thu, 21 Sep 2023 03:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDqh-0003ng-Vr
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:11:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDqg-0001QB-DX
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:11:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso4876555ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695280300; x=1695885100;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q4nAW9BNn0JX6DAgHhlQ/tHPs+P4qY3LOcUWvUC9Yxk=;
 b=1wn+lJXV/b/RQebCzgNWUGlFlkwc1XUjKCWkotVf91kej8E1RfKeBf1dw0Wj8pGHQk
 VjyKkb5ca+h/L7G4hGpoNLMK/7owyDsjSxG9GR5SQ6jyFMGq+JccQGMdRrzfLkbjQciB
 S+UjWhVsM+bBQ/fE0dYCb5HzD7VBP/EKpjvkOIM7c6FtOFvoUihxOIfzChFqKfdH9zsr
 LmwVsTn/hjA49jtKzRWvILjo52rrfrKl7pbPJq0KtL0fPVuu0F+FcLhdqwbE8R3/aSBC
 CPNPmroJ7ZPWf3nzSHglMvVGpBYTQmQvWPpY/2Ly56A4UpIrAEC3DdFTGKNkYJQF4A1E
 NzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695280300; x=1695885100;
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q4nAW9BNn0JX6DAgHhlQ/tHPs+P4qY3LOcUWvUC9Yxk=;
 b=DrSDiaGDatI+UvVOLvjKqSS6G9vO8caiJT9RT7bmuJelRAh1uKvab7KPpoerhu1VWZ
 VgD3i0dfnW7Ml3YmsiHSUbGkxN9HI+uaZttqf1lbrHFvtw1m/AhlfrtVbM58LjwCbijm
 IR0Gop10X2oKp94xP1r8NuSxYzYMnt9k9Zl5nXTNRSdbmthnIkCp3qoN8HCZOYjLWyyL
 d1UIbOKlgYRzDpMLiMeHEuVWIp4PtZMbqj2yaiyI4ui5AkoIe3WJ0MSQXZzjQkWvE+8K
 WSLTKQI2LHFYL2+g51ojcmR2ENd6OR50ah8aKoG1JJEa3zXWkxZ+zOQ51s+5d6cICsmy
 z94w==
X-Gm-Message-State: AOJu0YxkhiuxPGs9v1vPy0sFJIEQaFEbYguvVS0QxU5Z5gR5ev+Ku4g0
 EjB5j5K8YTwu5pTY6x7ctN70u2uP0V5VWR2hiDg=
X-Google-Smtp-Source: AGHT+IG0wXX0DbKaIf4pq43apsOLCq0eKyb8QGszisbD8Kso9dsEYZwWLz50np1K9famQgWSXiE5Aw==
X-Received: by 2002:a17:903:2445:b0:1bb:a7bc:37a4 with SMTP id
 l5-20020a170903244500b001bba7bc37a4mr5031595pls.24.1695280300558; 
 Thu, 21 Sep 2023 00:11:40 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a1709027c9800b001c3267ae31bsm664985pll.301.2023.09.21.00.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:11:40 -0700 (PDT)
Message-ID: <2d8c2e40-52cb-4d21-aa0b-4a87e9898b3b@daynix.com>
Date: Thu, 21 Sep 2023 16:11:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl: Free machine list
Content-Language: en-US
Cc: qemu-devel@nongnu.org
References: <20230722062641.18505-1-akihiko.odaki@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230722062641.18505-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/07/22 15:26, Akihiko Odaki wrote:
> Free machine list and make LeakSanitizer happy.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   softmmu/vl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..802f728298 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1484,7 +1484,8 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>   
>   static void machine_help_func(const QDict *qdict)
>   {
> -    GSList *machines, *el;
> +    g_autoptr(GSList) machines = NULL;
> +    GSList *el;
>       const char *type = qdict_get_try_str(qdict, "type");
>   
>       machines = object_class_get_list(TYPE_MACHINE, false);

Hi Paolo,

Can you have a look at this patch?

Regards,
Akihiko Odaki

