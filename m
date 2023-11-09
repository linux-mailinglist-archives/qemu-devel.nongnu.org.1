Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED8E7E66F0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:41:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r11W1-0006tO-Dy; Thu, 09 Nov 2023 04:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r11Vy-0006t1-Md
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:39:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r11Vw-0006Jj-OS
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699522791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QixPTX/dfx8uDQo8PZ4GqYEzhmANEGUZLwKLweNpk2w=;
 b=A4yxUC//LMtH1Ybtgjwmn9wGqUSanh8MYrNH3MNxvN5Ey2Kxr54H23rD2nrSDVc6Ok98X5
 mnR6SttMI33Ae1e1rX9mzAsjv3ugcVMiwIneFRnykzooHD19CHq5dlYUcLYshmE8aLThwX
 gJ7+NlfY6cMuDVb4lwNt9BnqFfXPnoU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-UxQzCnIfNm22bHc-1oenRw-1; Thu, 09 Nov 2023 04:39:49 -0500
X-MC-Unique: UxQzCnIfNm22bHc-1oenRw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-542d910f34bso478914a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 01:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699522788; x=1700127588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QixPTX/dfx8uDQo8PZ4GqYEzhmANEGUZLwKLweNpk2w=;
 b=BynAJ4TgZvSrX6QYDxlMBCTo/9iK+NP4zfcVUra2sKfi0Om6cwhOX7R0vdAqIhbfH6
 5HRLYoGX9eq8aVrNiCpAtMxG14hBZ2pV4FiPCD9kEyzN4DVtMGv/2mx+wH+AlOZtkn21
 r0pan08cRuQhpXu0FhnboCSInPHFsfv0yUm91fZj9p4i8ihGnLBeWCKIvIgO3sUU+6rm
 CeHjds3EtBuTjDv+T8JE8f5x+xipHBNsDnBa1qR44GvfO4JcbnX0Eq18KwO+OpBYPBB5
 a3tNk6G65awB6JYBEYEiYzxxY54D/1hjxnNcSym/baNMJeaTswQX+EkuNgu+fv8UJyBn
 Sceg==
X-Gm-Message-State: AOJu0Yxaeowp/Oxg3yHJ5qyF+XdRBnr41c1ndn+TGAsj/mc9xx+4vCsl
 KjG9FJoIzUpvsrMlh29/x+7cEdsSsJBXIat2genPOoqJRCyf7rpVQfqarlysdQbod86x2CQ5SsY
 OjP/b314ZvJSZBN3bunHkNa4=
X-Received: by 2002:a50:9356:0:b0:543:bac5:925 with SMTP id
 n22-20020a509356000000b00543bac50925mr3987871eda.20.1699522788281; 
 Thu, 09 Nov 2023 01:39:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxmAIPDtsnrVWHch519841sPwQPc3JxZq1Y3Zw1G70Eh1hw3Fo8Lahaz3QbgV6CccAL7N4lQ==
X-Received: by 2002:a50:9356:0:b0:543:bac5:925 with SMTP id
 n22-20020a509356000000b00543bac50925mr3987853eda.20.1699522788015; 
 Thu, 09 Nov 2023 01:39:48 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 o10-20020a509b0a000000b0053dec545c8fsm8072563edi.3.2023.11.09.01.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 01:39:47 -0800 (PST)
Message-ID: <e31326a7-8cb0-4863-8bfa-e6f73d50f432@redhat.com>
Date: Thu, 9 Nov 2023 10:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] plugins: Move the windows linking function to qemu
Content-Language: en-US
To: Greg Manning <gmanning@rapitasystems.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231109092554.1253-1-gmanning@rapitasystems.com>
 <20231109092554.1253-2-gmanning@rapitasystems.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231109092554.1253-2-gmanning@rapitasystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/9/23 10:25, Greg Manning wrote:
> Previously, a plugin author needed an implementation of the
> __pfnDliFailureHook2 or __pfnDliNotifyHook2 hook in the plugin. Now all
> they need is a null exported pointer with the right name (as in
> win32_linker.c). If QEMU finds this, it will set it to the hook
> function, which has now moved into qemu (os-win32.c).
> 
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
> ---

Thanks for trying! :)

I'm not sure how big an improvement this is, but I'll let Alex judge.

The main issue I had with win32_linker.c is the additional complexity 
for external plugins, which is now decreased but to some extent remains. 
  I should have made that clearer.  One possibility is to put the 
definition in a macro, and have the plugin sources simply expand the macro.

Paolo


