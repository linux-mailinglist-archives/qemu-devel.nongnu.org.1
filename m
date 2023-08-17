Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2819777F551
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWbEH-0001fb-Hr; Thu, 17 Aug 2023 07:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWbEG-0001fS-H0
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWbEE-0004hT-BV
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692271909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUNUjvnqS+G7eXEpj5TLuwdsSQOaXb/wlmvs/IgDXVo=;
 b=M8WFMtcM/PKqmJbNFn364R3Msf6gopDER/6ZqUPLn16j32gEqv/ilQpGVXO3yP5DvlJa0n
 P9I84Ilgimlr49fFq+zj15w/yHInPDZuY1znLEum0EGLjbi6KixQnc75jDraHqgHWSeZX9
 fnP80D2jxWpcg3c7taEGq32X0KuF2dc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-giA4mpd7ORqHHRWooSGo9Q-1; Thu, 17 Aug 2023 07:31:47 -0400
X-MC-Unique: giA4mpd7ORqHHRWooSGo9Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so48695055e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 04:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692271906; x=1692876706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IUNUjvnqS+G7eXEpj5TLuwdsSQOaXb/wlmvs/IgDXVo=;
 b=jP2LuenXEGNdY6pn25io6RfElDQOY8TUfPz8enbsM/JKOAtzpNQDAzWo52CmTNd2F+
 psDEPCjWIDVzaDwRH1xBoUwgD5lkSOPci6o86h16NNR6iyDLHVxCj7X/4AMkkZ4hejVx
 W9qsIWnga7rDlw+ELpNhjYr1bbr8tv1Y1DuJVN88rg1J2g9ysDlXSlNtQuBeZT2GUZ2D
 BYPdyAic/l69tb8n2EJqPCmXpYPw1vZc0Tsd3Bi7T/JqWs4uvukwQMGH/nvwU7GVJVq4
 Kj3W2MfQeBHFHuorVYdA9sSQcccHeJHlYDZD9IYNK11j9YQkTfHKGYDt9k/B+ht6L7vK
 1q7Q==
X-Gm-Message-State: AOJu0YxApstnXtLN8MsAxnElPrsHMJZUrVRQL42nHME23ZTO1zdCqkDK
 1h7Tx0jjsZuOdcvyZ3IsIEClQYEn121OwNNkE2bn91+AYriezclDcqJFoKP7w0ruP93TMlG78Zx
 p6Pcx33NicILUq7g=
X-Received: by 2002:a7b:ce12:0:b0:3fe:159d:422b with SMTP id
 m18-20020a7bce12000000b003fe159d422bmr3338800wmc.32.1692271906827; 
 Thu, 17 Aug 2023 04:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxr8NeJJ4bRZl8b+zM+qA0N+/L/MK10vyXfUanqBjZ2J9fE/Hm7AFBkl1Hk4+/dXkiDr/0Hw==
X-Received: by 2002:a7b:ce12:0:b0:3fe:159d:422b with SMTP id
 m18-20020a7bce12000000b003fe159d422bmr3338785wmc.32.1692271906538; 
 Thu, 17 Aug 2023 04:31:46 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-113-156.web.vodafone.de.
 [109.42.113.156]) by smtp.gmail.com with ESMTPSA id
 t11-20020adfe44b000000b0030fd03e3d25sm24724907wrm.75.2023.08.17.04.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 04:31:45 -0700 (PDT)
Message-ID: <dd117d7e-2d98-1031-07bf-cb86a872cdf0@redhat.com>
Date: Thu, 17 Aug 2023 13:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] subprojects/berkeley-testfloat-3: Update to fix a problem
 with compiler warnings
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Olaf Hering <olaf@aepfle.de>
References: <20230816091522.1292029-1-thuth@redhat.com>
 <1a33ef6c-a3ff-ca92-5288-de66bc2818aa@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <1a33ef6c-a3ff-ca92-5288-de66bc2818aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/08/2023 14.49, Philippe Mathieu-Daudé wrote:
> On 16/8/23 11:15, Thomas Huth wrote:
>> Update the berkeley-testfloat-3 wrap to include a patch provided by
>> Olaf Hering. This fixes a problem with "control reaches end of non-void
>> function [-Werror=return-type]" compiler warning/errors that are now
>> enabled by default in certain versions of GCC.
> 
> e7af9751d9 has:
> 
> --- a/source/genCases_f32.c
> +++ b/source/genCases_f32.c
> @@ -411,6 +411,7 @@ static float32_t f32Random( void )
>        case 6:
>           return f32RandomQInfP3();
>        case 7:
> +     default:
>           return f32RandomQInfPInf();
>       }
> 
> Why the default is with 7 and not 3 or 5?
> Shouldn't we abort() or mark with __builtin_unreachable()?

If you look at the code, it's really impossible to get any other values 
here, so an abort() or something similar would not really help to discover 
additional bugs (except buggy compilers maybe). So I personally don't care 
too much, but if it bugs you, feel free to send another patch on top of it.

  Thomas



