Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F020710D48
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2B33-00062x-VT; Thu, 25 May 2023 09:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2B30-00060O-J9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2B2y-0005hI-VH
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685021427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2q8WueuEOfs1IfuAJPPMC1cxUPDDymndENcQtdmWPk=;
 b=Kj0sBee0P3tBsbvH8C0ZB8ydGEZgaWOg4jx+HcncZoE4+Caci+hCIXBcr7eSdDCFONmI3w
 JUZyZZlDdwldS0NQK4jxtZhdbWfor5geEXfDbDFAKs39Bb6PJJO1c8r5uJEmY8pFL+Dgad
 KdgZbS2r6sgcVXW+AOkCAzHrIBJM80U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ykQmKyh9NUCN7aiDF2kJ2A-1; Thu, 25 May 2023 09:30:25 -0400
X-MC-Unique: ykQmKyh9NUCN7aiDF2kJ2A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96fffd1ba46so63241666b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685021424; x=1687613424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2q8WueuEOfs1IfuAJPPMC1cxUPDDymndENcQtdmWPk=;
 b=fn1SlF5bvVprqgHPIUvlXXDuRU/e3/qZkFMiMpAjU1pn60DxxSTAzSnoKrg+RABEbi
 onejx5o7bpsNE+owh04sZn+aDIoJPnvgnpSwvvNFut5HoMLx3SzOQYaGopKe5WKKPVVt
 LqjLRxDCsFPRoVO4M+XMVM9MY/a/dSObWMD+C3txfXOm7BwTHLkZJ3oNNop3T47QRHHh
 01LG+fECXhx1p3amHJ494leBCXIuxaMy2p3AvsfUDEKfo/hNTUFlIWaXzXzTYUpnUNF6
 ZXutPkI2S2m+2XVfXwZ+7PqbbZkx/JIKyuot3cbrzUobErAXou25pmkazN9pOEWFI8Rw
 O18Q==
X-Gm-Message-State: AC+VfDzRSb7BF9EQUiwmMAY8q1veoLF8JnzRjcjBSdEVhAOGI1uNtdxT
 yCsn1ALWTHnUSBIS9Y43p4jUdAIODRKZpOBkvcI+aUzdGI/UxjwgW4/fGTmMF8s9Ito1huSWofr
 C4S+XfTVzUAz1SjI=
X-Received: by 2002:a17:907:5ce:b0:94e:e5fe:b54f with SMTP id
 wg14-20020a17090705ce00b0094ee5feb54fmr1686211ejb.23.1685021424754; 
 Thu, 25 May 2023 06:30:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5w8EoI83K5ew9uDUklsWtjsv/oGiI/+wysKxvvox/Rs8ens4C/CL1foixvz2ujpip9A9hzCQ==
X-Received: by 2002:a17:907:5ce:b0:94e:e5fe:b54f with SMTP id
 wg14-20020a17090705ce00b0094ee5feb54fmr1686181ejb.23.1685021424447; 
 Thu, 25 May 2023 06:30:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe?
 ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.googlemail.com with ESMTPSA id
 w22-20020a170906131600b00965e1be3002sm826232ejb.166.2023.05.25.06.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:30:23 -0700 (PDT)
Message-ID: <13671ccd-8048-d60f-89df-a0306f053657@redhat.com>
Date: Thu, 25 May 2023 15:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
 <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/23/23 16:33, Richard Henderson wrote:
> 
> The tests are poorly ordered, testing many unlikely things before the 
> most likely thing (normal).  A better ordering would be
> 
>      if (likely(tp##_is_normal(arg))) {
>      } else if (tp##_is_zero(arg)) {
>      } else if (tp##_is_zero_or_denormal(arg)) {
>      } else if (tp##_is_infinity(arg)) {
>      } else {
>          // nan case
>      }

Might also benefit from a is_finite (true if zero or normal or denormal) 
predicate, to do

if (tp##_is_finite(arg)) {
     if (!tp##_is_zero_or_denormal(arg)) {
        // normal
     } else if (tp##_is_zero(arg)) {
     } else {
        // denormal
     }
} else if (tp##_is_infinity(arg)) {
} else {
     // nan
}

since is_normal is a bit more complex and inefficient than the others. 
The compiler should easily reuse the result of masking away the sign bit.

Paolo


