Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2075BF76
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkP5-0001pn-Oo; Fri, 21 Jul 2023 03:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMkP2-0001pU-Rj
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMkP1-00081Y-9w
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689923893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+sKueytx6/c0IwkQbujw/2jDYdfcDf+0aW82JbPAJk=;
 b=FvtBmOO978X3YiUEoBNW8EUZ8JB6pwXdsHCVoXJw/OfcwQWUsuJAfE4cUxfO50PXy1IM5T
 OL2HLmH1JPrdSKCBkYMO9qPZJgcAngGAiFAVtDi5E6kqc6nwfkUkeHzod2MnbTh4qIaWG7
 TYn4JXF+sSinvPG7DEJ/oNW9DrNZYFg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-ZYU-gnLtMq6eqPPcdxMBKg-1; Fri, 21 Jul 2023 03:18:11 -0400
X-MC-Unique: ZYU-gnLtMq6eqPPcdxMBKg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso9045785e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 00:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689923890; x=1690528690;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T+sKueytx6/c0IwkQbujw/2jDYdfcDf+0aW82JbPAJk=;
 b=gzVd2TXcfiqMmX1fv9VpkhZtOzyVoqu5grcVhG1Giy1/eVrMtIIM6wMkIYreesad86
 HIUtH1fcXZt2rsQ5n4+6S0OFZCfEtIupH7fU8j4UgAIQnDrZWgC5Cy0Rwr99cOLyu8yp
 CuAACpkm70xWkU345MnJFuAt4B5bmOqOIFyWMlpEhgx9ydWJIO1obEwwH84fA44hXj6I
 KYOo1e9szjbQUcTTM0XGmF8TQLIP4ntR7kADszlOx+olPAkefjBiqg8J1iC7jr255Y97
 10Xb2qVeB6oAtww/b2JpsBf1g0NtDnQuS//e7RUeozVboW+63luWNLHiG/sImIoooQmi
 i3Jg==
X-Gm-Message-State: ABy/qLbW7xkwxv0toAx4EZR4zRU8UDVGteqZObGwBjiAFL7LycXBkh4p
 WitADRXD9275yRbqIsa+E8KDZCGfyhhOFCYcDZIK9lKcEIITjgxKHMEcRgSTgM3BUpt2xvWNsAK
 9sFV6NAOf826eTQg=
X-Received: by 2002:a05:600c:11cf:b0:3fc:4d7:a960 with SMTP id
 b15-20020a05600c11cf00b003fc04d7a960mr670555wmi.12.1689923890642; 
 Fri, 21 Jul 2023 00:18:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfdbeK3Z/E4Q1ZYhbtnzRVLNDK46yYUTpWWWnGvQ2I/qF56sXAhmHTPcVhAsMoiPmnZzksng==
X-Received: by 2002:a05:600c:11cf:b0:3fc:4d7:a960 with SMTP id
 b15-20020a05600c11cf00b003fc04d7a960mr670541wmi.12.1689923890324; 
 Fri, 21 Jul 2023 00:18:10 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 v13-20020a1cf70d000000b003fc080acf68sm5567706wmh.34.2023.07.21.00.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 00:18:09 -0700 (PDT)
Message-ID: <10e95d52-109a-d683-a9ea-2ab9b52e795d@redhat.com>
Date: Fri, 21 Jul 2023 09:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
 <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
 <20230721090359.1b9797cd.olaf@aepfle.de>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: 8.1-rc0 testfloat fails to compile
In-Reply-To: <20230721090359.1b9797cd.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/07/2023 09.03, Olaf Hering wrote:
> Fri, 21 Jul 2023 08:54:21 +0200 Thomas Huth <thuth@redhat.com>:
> 
>> Which compiler version is causing trouble for you?
> 
> Right now it is gcc 13, hopefully every compiler will error out with -Werror=return-type.

I don't think this will happen - otherwise we would have seen this already. 
It rather looks like your compiler version is missing something here - have 
a look at the affected function:

static float64_t f64Random( void )
{

     switch ( random_ui8() & 7 ) {
      case 0:
      case 1:
      case 2:
         return f64RandomQOutP3();
      case 3:
         return f64RandomQOutPInf();
      case 4:
      case 5:
      case 6:
         return f64RandomQInfP3();
      case 7:
         return f64RandomQInfPInf();
     }

}

The argument in the switch statement is limited with "& 7" to the range of 0 
... 7 , so there is no way the control flow can really reach the bottom of 
the function. I wonder why your GCC 13 gets that wrong, all other versions 
seem to be fine.
Or are you compiling with -O0 or something similar?

> I think it makes sense to replace Leap with Tumbleweed. 

IIRC we wanted to avoid rolling releases in the CI since this would rather 
force us to deal with distro bugs on a regular basis instead of focusing on 
bugs in QEMU.

  Thomas



