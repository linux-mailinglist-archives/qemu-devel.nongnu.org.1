Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A3AB371A2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Aug 2025 19:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqxiP-00055B-K4; Tue, 26 Aug 2025 13:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqxiH-00054B-He
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqxiF-0005wI-Cq
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756230237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3yLTx2j9yFlio4XhU7yRqa14jxVAqA1QxUTHuBOSf1s=;
 b=RYgS8XVIWnWzJIq5nMd3jjfNfRsgOaspPRpnf2DQDRAPkSkbOMqUAP5UEq4H3vQP/bCwbK
 M3bft+MkJn3K0mjemy0bAKqQz0bRDUJBaliP0zSJ8uUml81/El+GMG+s3dtXElBDcC/c4u
 b676xTYedl7bprt6EztOYYtmKXrE770=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-MbqeUcvsNyuqcBRL49hZGg-1; Tue, 26 Aug 2025 13:43:53 -0400
X-MC-Unique: MbqeUcvsNyuqcBRL49hZGg-1
X-Mimecast-MFC-AGG-ID: MbqeUcvsNyuqcBRL49hZGg_1756230232
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b05d8d0so41662945e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 10:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756230232; x=1756835032;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3yLTx2j9yFlio4XhU7yRqa14jxVAqA1QxUTHuBOSf1s=;
 b=n4ORZKodRafJBxlp8ucsqNQJTKGBPyHgo0m0pReeWyiwsS/UweSR1nu+3tELvT3M85
 lYzVMnbvVgfVaw7P5uEDB7B+Q2pnYoCuSWkej54Q1W5mXefrPoOoB0BMlqlUVdn64jmT
 M+BwWHlHon0Lk/A8YK1mDTmqd+JH5njsIaYiOkxSedTvTGLGYQjvO0evntNy5Njp75ie
 e3pbF8U0+o2W7tpJ+1673PBYCwEvl7vGpxzcPunzVf+in8tiRSXGoVENdKpVbbQUgVem
 oFgn/b1P7PgcOpJyFS2FEQ3/v/Eo4Jidr7L70GyC2LA3C9HoAiYCFOxEnLxWwDET+36n
 rKSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAH0mAi6axeDSdP3mEAAk2eFOZH0dLLqUwQq+EqMX6+3GUjBW7jOD6miHcB/Yp0QlF2t+FNH3Unlrl@nongnu.org
X-Gm-Message-State: AOJu0Ywif2kMmT8y+VbOllvC4GJmKGp181hhbuGsiNgVjBhp37DG+j1I
 tgcJgogWbsBZ9w7y7n32YPAEgLArym42nJ+S45rVrU54u36YlaVUMAtx5QMfm5/JPkz3MEI0VIQ
 ERlZeHSuj7BIEaGqRS+MiS4+3YSKDAgekpre3JLz+AY7/qLV0OZO6C75W
X-Gm-Gg: ASbGncsjR2DqpeL9k20A9WP/UM3yYwJ3hbtdIVb7PQ98PptW0c0s2QyJMjW+tOHULCE
 XK2feRoOQVrG36GKGsGisjllUtGuFMOD70p795e/C2AEIjsS1tjjyA3/ZZHX3LypC50jNWqZavj
 1WovX4UN1Xe6HdG/gYtfGxQ5RCkoxp9CmyxibAOrlxFIdOTKztU3zh5DOATyj8j0IH5r/h7D6bH
 Hh3gg1T/NToGuVWGz1+TYN7KPHCL7TAxcr/h3G+CthbS/EEV+sdZKkXwmlZbQr86hCjh5JNibyl
 XHHh4TYX40aml0bjMAgQGCj/C8OlkdIGnUhu+HO9xerOtF8zUpBhegS+G/kaRzYHC+y206IJuSh
 ri2gcNeI7nhjmrdeBCv8KJpSj
X-Received: by 2002:a05:6000:2304:b0:3cb:285f:8d9c with SMTP id
 ffacd0b85a97d-3cb285f9400mr3004060f8f.48.1756230232495; 
 Tue, 26 Aug 2025 10:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWvqXDg44RKqvmfKNET92JryD+WAmnTmhgLb5bued8OgqfNnsPrzHIRMRC83LkDRtnPvjHKQ==
X-Received: by 2002:a05:6000:2304:b0:3cb:285f:8d9c with SMTP id
 ffacd0b85a97d-3cb285f9400mr3004043f8f.48.1756230232073; 
 Tue, 26 Aug 2025 10:43:52 -0700 (PDT)
Received: from [192.168.178.61] ([151.36.40.144])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b6c5356a7sm2391855e9.15.2025.08.26.10.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 10:43:51 -0700 (PDT)
Message-ID: <5da180f5-1601-4022-925f-cc0669270f5e@redhat.com>
Date: Tue, 26 Aug 2025 19:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rust: run cargo update
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-rust@nongnu.org
References: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
 <20250826133132.4064478-2-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250826133132.4064478-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/25 15:31, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Usually, rust projects have CI bots to do that and check that nothing
> breaks. We should add this to our TODO list.

You have to adjust the subprojects as well to keep them in sync. :(

I was going to wait until Meson does it for us via cargo subprojects, or 
do it as needed until then; for example I have lying around a patch to 
update proc_macro2 and syn, because some experiments I did needed a 
newer version.

I am applying 
https://lore.kernel.org/qemu-devel/20250717062727.305466-2-pbonzini@redhat.com/ 
and your patch 4.

Paolo


