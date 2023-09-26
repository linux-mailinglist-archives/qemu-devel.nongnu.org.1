Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2D7AF0B2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAv7-00011M-Vh; Tue, 26 Sep 2023 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlAv5-00010h-FI
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlAv3-00072d-67
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695745695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+NMgrCV0pikA+288IrDGd2zfa082XxI+sgoR3hk6tUM=;
 b=iSO7gXu0p3rdy3vpHQCbPTmVTNGgQXdUVSVmkdi1pHfH22CoSlInR13OHakAJKaLYf3WKI
 LJfzF6ARlYRKHMx8sZ2aZdP3lfw/QSKRUPwDBYgbty1MllVBAgDE8EITIe7hGQKKLM50Cw
 mrckHE78zxTCcVvU7LILyaI50aFk3zc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-2dIXUJEKOtqUeZQ6pMf36w-1; Tue, 26 Sep 2023 12:28:11 -0400
X-MC-Unique: 2dIXUJEKOtqUeZQ6pMf36w-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77409d24881so1421056985a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695745691; x=1696350491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+NMgrCV0pikA+288IrDGd2zfa082XxI+sgoR3hk6tUM=;
 b=NycxzZ3XHJU64vOyLvByeKfE02iAYfuyEyDkcWDqojwrsKzOQVzPHSYmlQP6yYm4pt
 TWfwFE+QE6AFrDpx133QmcdebUrqX3KpXUnz/30k0LZpD9bj9oPb9vvovWpxb3ncWZZm
 kgxn5P4xMpRmX4R30zeOi/3A2+wfLhhS7JsEeccVoHeKukvSlqrjdJNFnQ5ElAXVax3D
 IBFol1jxNo6Ei38l5/ysEo7mECAp8KxiOLD7nLXV+mEBYP2jChixGSQWSvNB+rpKR0hb
 9xE6qaCSBX5qOm1ynHccvTjodqeu9/P3cTmgpF9wH7j/7oHjfQ/1EtQ4LGBORqrMtBoX
 gmMw==
X-Gm-Message-State: AOJu0YzFQSRJWDo990Updp+UCekfSlTqSHZcguMTCYHQvRbbVYgJmvt6
 ScbDYeu67LzcKnc0eL27E2u7rTDm3A9D8YauCCJsTzECzCqRZDWy8JDeGiWagzXVatoMe0D3/Z4
 APGi1h1dDw0YdmsE=
X-Received: by 2002:a05:620a:989:b0:76f:22f7:408f with SMTP id
 x9-20020a05620a098900b0076f22f7408fmr8895568qkx.34.1695745691209; 
 Tue, 26 Sep 2023 09:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFmVH4bkPbhwbuD3EcClpYZsE+1QQkBLxN9uCI7ubz7z4C/qJiUpjwgdu86DQgAUenulKXLg==
X-Received: by 2002:a05:620a:989:b0:76f:22f7:408f with SMTP id
 x9-20020a05620a098900b0076f22f7408fmr8895550qkx.34.1695745690878; 
 Tue, 26 Sep 2023 09:28:10 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-189.web.vodafone.de.
 [109.42.114.189]) by smtp.gmail.com with ESMTPSA id
 g20-20020ae9e114000000b00774652483b7sm1092317qkm.33.2023.09.26.09.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 09:28:10 -0700 (PDT)
Message-ID: <a68e35c7-fd0a-485f-c0c4-7093e879c91c@redhat.com>
Date: Tue, 26 Sep 2023 18:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/22] hw/m68k: Clean up local variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-13-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230904161235.84651-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/09/2023 18.12, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>    hw/m68k/virt.c:263:13: error: declaration shadows a local variable [-Werror,-Wshadow]
>              BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
>              ^
>    hw/m68k/bootinfo.h:47:13: note: expanded from macro 'BOOTINFOSTR'
>          int i; \
>              ^
>    hw/m68k/virt.c:130:9: note: previous declaration is here
>      int i;
>          ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/bootinfo.h | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


