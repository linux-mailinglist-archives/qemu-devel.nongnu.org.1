Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C187EE48E
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3eZ8-0004RK-41; Thu, 16 Nov 2023 10:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3eYx-0004Nb-M3
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:45:52 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3eYv-0002Rd-JD
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:45:51 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9f2a53704aaso128769366b.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700149548; x=1700754348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m4RyCgPNieXnLopOdVZWxmb/8p015nFktcyrzFQayGQ=;
 b=HgHrtwqVnbs9dy5QV2lKsRDvW0+y31CsktRHmKg0+M6qpCS/AjP2KOlg6KJf2hpDmM
 jufEJPFPeq0fNWzzzpOZ7X8Tvu/7NkmfkTHvdG6J8rsgPHdAmQlmnCTXCAVI5YtIkLuG
 VJyv7nS74Tn0dxBwHWOnW6F7SWir39VqmYaGYF17jxEbaJU46F8ZWiblTk7sn1e3uHBi
 yHzTqspHcX4P/nlF9awrDHm+kn2B8QanD0VWl/kNlrAq3tQ/t2q+Ri1LyA4/MLryX+O1
 rDPCiMKvOdasW3Vm2ACOT2EW5UrXRV3Y9UGHsxIIMQxbIkHpCPJHKH+HL2epT13pEKut
 +hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149548; x=1700754348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4RyCgPNieXnLopOdVZWxmb/8p015nFktcyrzFQayGQ=;
 b=do/DSz2MIpl14SnKjwbbVFknnMHxT1lqjIKw2+d++k4B6kXpIaep41C7HutdRYCSAQ
 Xov5Qh+WXdRGw0Sxn2F0HhTRcn6f28LWUcLfhM+yPGc/1nwVbWFK0aH4CQEjSC0dgdaz
 1qq56HU9hUuTgN4Nf2ltbcED3EkOVXixWkt8X1XSv1o2phbOdBiHhH3hWAO5ltJStwRx
 IjDueEvc9Xl+2blRj48lDaUkAB/lAwPjcmP1cZhCFIkXGC1pHfWOv8NQumiTUgaHGI6H
 3+H3tzEu9/wcZl0QAskvdWe5W8uiDEcF+5OgbB9199AqMhSbjwrqvijBUKMQ2oAda9CP
 9eSA==
X-Gm-Message-State: AOJu0YwXY4J1HLU0brVZp3vu1gMl2zFoYt3IDJE7+a+LWQH78ueLM1it
 tFRpKGjLKozST0Z0Xr+M5GWv/A==
X-Google-Smtp-Source: AGHT+IHA1pHponPcDZjr+hRQzJqyBR/dDwGIXVFUnVOX4iMufiQukM0ljVTBBfO6EQquAJbZavdDmA==
X-Received: by 2002:a17:906:3655:b0:9ae:5253:175b with SMTP id
 r21-20020a170906365500b009ae5253175bmr14391579ejb.34.1700149547803; 
 Thu, 16 Nov 2023 07:45:47 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 fi5-20020a170906da0500b009e5db336137sm8634527ejb.196.2023.11.16.07.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 07:45:47 -0800 (PST)
Message-ID: <dba8c159-f3e1-41e0-bc88-3811b143b1ce@linaro.org>
Date: Thu, 16 Nov 2023 16:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] tests/unit/test-io-task: Rename "qemu:dummy" to
 avoid colon in the name
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231116131454.541434-1-thuth@redhat.com>
 <20231116131454.541434-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116131454.541434-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 16/11/23 14:14, Thomas Huth wrote:
> Type names should not contain special characters like ":" (so that
> they are easier to use with QAPI and other parts). We are going to
> forbid such names in an upcoming patch. Thus let's replace the ":"
> here with a "-".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/unit/test-io-task.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


