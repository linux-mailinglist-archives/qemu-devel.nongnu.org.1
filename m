Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B15B1412B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Jul 2025 19:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRba-0007Te-AJ; Mon, 28 Jul 2025 13:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugRbO-0007Ll-T0
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugRbN-0005WE-Br
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753723528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hCbxoJSEhO8ITjTOmByBxelsrE1Teyg2toB7loPgMxs=;
 b=VPYrwVcs10p1rTnGcOSo1PyEfDHarbpT4K3iTjO3heAcTtSsMkElxMXge+1FYKn2Scg4Oc
 3AzIFGlJ+wn5OP3PuqBXWZ0J9d4cfhuoWx/TIC+2hIF80jydavvAbOKEzhdt0JdClU5FQI
 2zhDHtFCkW0uMP/mXckYnrT2MONJNqI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-LejqyWlUNXaFVXTqdKy1mw-1; Mon, 28 Jul 2025 13:25:27 -0400
X-MC-Unique: LejqyWlUNXaFVXTqdKy1mw-1
X-Mimecast-MFC-AGG-ID: LejqyWlUNXaFVXTqdKy1mw_1753723525
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so22149965e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 10:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753723524; x=1754328324;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCbxoJSEhO8ITjTOmByBxelsrE1Teyg2toB7loPgMxs=;
 b=CRoYIrIX29XqQOUvuB22Yxqxmx5G0a9D63QX7TlaVuSE+l9S6zrgTHPnNXCTUijDw7
 Vekh1sMweFWXHlYB94cp5b5ayTYTfYe0oQJLFLAAlY6ZwLTo3l4ThmSfwJZvT+0fED28
 bkgvmoSdIq3cbwiN4Innxrh4AozrPCCc+TCWMt8TmFBUtARbx4AQ7+b+rqtMFFRzK/o2
 YNswNMU+SwJymiGQcnQHK1RdTOudUn4u8ugc1CZLmfgX3nuEZ3z1H+ARx69bt8ZqYj4L
 ioK4glzJ4FckBUJmf8wTUWJUpAUSmS2x1zkGYXtnAxLrbK7LfcrJdGF83a17F+clAi0/
 /I+g==
X-Gm-Message-State: AOJu0YwEYQ1rO0kHmM/88FEV2QseYwSIQaR2L+1hxHgEhpYuJcKrup9W
 KOGMHrZvhKxhb/5NF2Q/BmfGo5uPNDCxsEChng8JYLPKXNqbLaYXtS8fIKfK/mU/wOsy1QKIixv
 qqiixARGkNEsZ12qk7TqFMgAgcUyyu4FJ+wMnLU85H4Y/IkZ7y6Vbik1Laq7t75BVAvnLiqI/FA
 PpjoaIKlhvIdXR/eC1Ygg4GU40Tv7wiH7mrA==
X-Gm-Gg: ASbGncuCkddyGtdAMqS2bBqHu67ZNqevSLHK3kTp7NG8q42IFXU2xJGGy2cxjAkUL0a
 q3lqXSyiLukvZgjaKW7qCpbSMq730OP5rSC5tBYPnLt05Rbm5NXGno4Q5C4G++DE5XgCUCkqnu+
 +UvKuvqXyPGFwte23rtYO0PtZ+wPRk9fE8T5VTudA3z7yGGdq5lh/fu8cj8TBvfejIB00HRuQEX
 U+DfFuPAAQQHMyVYEnFqaqiwsKarh43h3tbji2e+XFeC0Pzf3xwUUFrPkuTllGxBxmEtqwobeRw
 LfDR1PGvlT2TMW566SG+tgVPXxFTS0teqKFyp7R6bDqL5QfEVvj8Iz8rruQiehD14pZyB5m3/ga
 hIg==
X-Received: by 2002:a05:600c:821a:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-45876447cfamr94791155e9.21.1753723524513; 
 Mon, 28 Jul 2025 10:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHVx0vv15c/0va8IxI2MC5hOENTwvMO/mdfMpo12ephS8RO5ZNNNYbmOAGbEJYl0VyaqwZBw==
X-Received: by 2002:a05:600c:821a:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-45876447cfamr94790905e9.21.1753723523882; 
 Mon, 28 Jul 2025 10:25:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac5816dsm105508185e9.17.2025.07.28.10.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 10:25:23 -0700 (PDT)
Message-ID: <490b441d-6d76-43e3-90cd-e894f4bf0d1f@redhat.com>
Date: Mon, 28 Jul 2025 19:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386: Build SEV only for 64-bit target
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250716071554.377356-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250716071554.377356-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/16/25 09:15, Cédric Le Goater wrote:
> Recent changes broke build on 32-bit host. Since there is no 32-bit
> support, restrict SEV to 64-bit.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/i386/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 14d23e27b580b2d5ea3aa4c07ba066f21a62e348..5139d2308777114e76a789c4f850fa20f3fa754f 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -4,7 +4,7 @@ config X86_FW_OVMF
>   config SEV
>       bool
>       select X86_FW_OVMF
> -    depends on KVM
> +    depends on KVM && X86_64
>   
>   config SGX
>       bool


Applied to vfio-next.

Thanks,

C.



