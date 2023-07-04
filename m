Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA627469C5
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 08:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGZgR-00089N-Dj; Tue, 04 Jul 2023 02:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qGZgP-000895-69
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qGZgN-0006f1-AE
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688452717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnH2hrGNADfwQl072FwzLxhfuZFKxQkYllO0+e3d6j0=;
 b=Alb+3ZWkolQDLjZyQc1i2wNh+oIKuxAlXpL6QbUbDysw5Ce4H1NHJnHFnwu/dYjSbX9QuI
 oc46rwDxUlsLvadYY5YP6UOy/oJjb8YmmPHefGqlLSFyY50ZeYrveBMCU8DmlIKgkw8QOJ
 rmfTNR5zbINr+595KkEQyJ6g4JehT0s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-l4v0USbJOBi709oejU01xQ-1; Tue, 04 Jul 2023 02:38:36 -0400
X-MC-Unique: l4v0USbJOBi709oejU01xQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-988907e1b15so438346066b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 23:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688452715; x=1691044715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnH2hrGNADfwQl072FwzLxhfuZFKxQkYllO0+e3d6j0=;
 b=LH/MrQpQ+XPRKR+Px21nvY5CYWt1EU4ZKX9jH5phQthkD8VOC6/+WN4IGy2scDPGFr
 +On0f7EgeICmezXKrHPseyzM5eYjd0Z/UZ+8jSNGRClMdUpsdwBqVdbuZAh4LYUFCIqT
 IwmwqJ+jSxWV4zchm2T+vNWACCdhHFjfwPI22Kud9AFWEZZs2ivqBHd4BTwQxqaV/M75
 /gUyHOErE15GMhbchxxMMx/X4+e86fJswadcXNxQMoN/ntVf7Uu6XACemniUM+1lcT/n
 tXTQjTf/e2OFLU0jUfJNScY22sfLdUCTkz14/cdXMtxkeQXbmHrnEY3mvz8/R2hJ4o/x
 dDcg==
X-Gm-Message-State: ABy/qLZ1hbKcdwfiX+i229Jk3IUtsze45vDxDOGNaPQYIM0DzUWPkYko
 O2WXXJcQD4WplfdDhD9elnVoVVbPjszi4VOLdY12ShWKfEGsIkPLeBfj/RGDBVPFfWXdUbjUqDL
 knzh2gKQuvxvjfDA=
X-Received: by 2002:a17:906:3c11:b0:991:ec83:c0aa with SMTP id
 h17-20020a1709063c1100b00991ec83c0aamr9636231ejg.70.1688452715608; 
 Mon, 03 Jul 2023 23:38:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFV8NcVNRcOkcLyy0r7Vxf3k8j3w3+6CPnWwrdqo4ePQiHsXJ8GcmL2hzWV/gvG+CwrVj1Btw==
X-Received: by 2002:a17:906:3c11:b0:991:ec83:c0aa with SMTP id
 h17-20020a1709063c1100b00991ec83c0aamr9636218ejg.70.1688452715254; 
 Mon, 03 Jul 2023 23:38:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 re3-20020a170906d8c300b00977ca5de275sm13126036ejb.13.2023.07.03.23.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 23:38:34 -0700 (PDT)
Message-ID: <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
Date: Tue, 4 Jul 2023 08:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
To: Bernhard Beschow <shentey@gmail.com>, Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/3/23 22:33, Bernhard Beschow wrote:
> Paolo, Peter: Should we switch to pci_device_reset() in
> pci_xen_ide_unplug()? Or is device_cold_reset() supposed to do
> everything?

device_cold_reset() does not reset state that is part of the bus, so I 
think it's consistent that it doesn't call pci_do_device_reset().

I agree that calling pci_device_reset() would be a better match for 
pci_xen_ide_unplug().

Paolo


