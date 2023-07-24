Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E175F52B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNtoH-00005A-GG; Mon, 24 Jul 2023 07:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qNtoC-0008W6-EU
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qNtoA-0002w6-FR
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690198376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mvtuR7Puzx0Hn/NXZdlDuiQXkdckGWZp0KGrZQB2Kk=;
 b=FUrpj9qGX5UUlZFc2a9Q+jD1ckSQtrJYjRMkQPH7DVIhr13QC/x+jUi6W+bv9Y4+2Sub6C
 +9PiTFRQ9SpRtbrOHcjR1NfnIwmndJeUjiNOt2JVuykt1RFEBiOzJz/STwoHwWpDNVn+mZ
 qlLDMqASm+Vs+qmOKrQMtJzAqW0xk6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-40zRPBG5NQqgBTtj8vw16g-1; Mon, 24 Jul 2023 07:32:55 -0400
X-MC-Unique: 40zRPBG5NQqgBTtj8vw16g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so21915995e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 04:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690198374; x=1690803174;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mvtuR7Puzx0Hn/NXZdlDuiQXkdckGWZp0KGrZQB2Kk=;
 b=MynUICh4cNIIplP5Hq6rEmi9pTZRiMDmmYfkE8jbAEugjgVA4UVKrd7NL7gqDgTvqD
 z6aiMyAIu5uUIhIMAeHRUZ29EuFmD3uYdnHN2tYsxGnXfZZ6zuJVqEyvRBBYY169Yzwm
 AiNqIpFzUJY3tXBuZl4Y5YcevSsZ5of/ODqMF6hc4+8RPplMS3HOP0mEdW9hkjnMjOwh
 IkxJE+Ez+378lvrhrlIL12Dh2QBkto2G8w45IuhAsTFNGisKAvZrVZQDWmEUCm9J7YgK
 T9FIB6ptLn4pITs0IyW3pf9zuQlkOKmrH8BuzquzDTl66XQ5e0lAqrKqRM3LfpI2Y0I6
 UMag==
X-Gm-Message-State: ABy/qLYJCouD4ua/74MQhy3T6VrXHFxJnBYzoomVraNmmkRTXtGugghP
 QDJEbXYuvt2xRZ/AlFUluXltPCYFvpIk1bTNIWmw2Drm29+ylg28dBjYjoOikS3qchn5y+ZlwuV
 efrTLVdOq19OB9iQ=
X-Received: by 2002:adf:e551:0:b0:317:5948:1fe0 with SMTP id
 z17-20020adfe551000000b0031759481fe0mr2511534wrm.45.1690198374154; 
 Mon, 24 Jul 2023 04:32:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkKWH6yjWXuqqHIX8928C6Q0ZjyEEdYbFryYTz9wgk6zoRwxS9ikAM6Czehzwuee5FYDePKw==
X-Received: by 2002:adf:e551:0:b0:317:5948:1fe0 with SMTP id
 z17-20020adfe551000000b0031759481fe0mr2511515wrm.45.1690198373755; 
 Mon, 24 Jul 2023 04:32:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77?
 (p200300cbc73dbb0091a50d1c3a7e4c77.dip0.t-ipconnect.de.
 [2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a5d5956000000b003063db8f45bsm12655133wri.23.2023.07.24.04.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 04:32:53 -0700 (PDT)
Message-ID: <f627b63c-87d7-afcb-6ca3-b0751cce2fe6@redhat.com>
Date: Mon, 24 Jul 2023 13:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/14] target/s390x: Make CKSM raise an exception if R2
 is odd
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230724082032.66864-1-iii@linux.ibm.com>
 <20230724082032.66864-2-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230724082032.66864-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 24.07.23 10:15, Ilya Leoshkevich wrote:
> R2 designates an even-odd register pair; the instruction should raise
> a specification exception when R2 is not even.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


