Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902C802B24
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:59:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA12f-0008If-Ca; Sun, 03 Dec 2023 23:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA12d-0008DR-Ma
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:58:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA12b-0005iS-MR
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9c6j0Z1tX+9zGq2kEnV5rYViWwnJosu3sisMb3FIPwY=;
 b=O5dZIhVwh0181FIJnEG9U1i6Z94RGD4PHjFAF1TC6tN4lhNNQZX/P+wow7hDJVSxGpCGDJ
 vaSJCHSl8L9Zp86TJzktowVpbd45q3I/Tt1vdAMw2k9SznrGA458n15MzS1arEwkhvQgnp
 GSRCAS/ICdZhNGG579jfdumd3oSTI8o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-ll7GNlRwPXCNNT63yXoy5w-1; Sun, 03 Dec 2023 23:58:43 -0500
X-MC-Unique: ll7GNlRwPXCNNT63yXoy5w-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d05f06d312so11077535ad.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665922; x=1702270722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9c6j0Z1tX+9zGq2kEnV5rYViWwnJosu3sisMb3FIPwY=;
 b=gGZyMPTCKGmEXffFm08CVXjaMDQfk8KIx/4qz/pONmdnzO+2AnU5jljNI9XMZUZl27
 pLxyYz6kESOuqtji83943lqtM0fh4jV+6xI+N5U97HgQoyxGtsob+WRX1Ug6bByplKVM
 FTgvE8DgSRHpORSqiAnRlIz2SfRVlqTons1nBUI+THPnUReWKqXSLCdqcKUKzX6r1Ck8
 De9sgPzyvZK/nES1n5nBI3nzo0ExILJ2inctcnwTpiy/sN86hI7znfNfhLee5Grst3eR
 2Q2K3Kw0ap7FzKuzGUwq2Hhl3I96oW7JuEa6Vsjhj/Yw3+JE7g6CvDDw5eXh3nfdbBbk
 rKfA==
X-Gm-Message-State: AOJu0YzKm7Q35eb4MGU9IvyXwgQPb9uA0hDu45zv27k70VimCFN9DBQ6
 fqTS5uP5E9n1h6Sq8oc3EEZBFCS1C39RRXy8Qfvse6H4gAQYbI9vCInd9i82djZLeyV/RILUC9V
 orJ45LLxdfYr0fiXbwYI/vw4=
X-Received: by 2002:a17:902:a3c3:b0:1cc:29ef:df81 with SMTP id
 q3-20020a170902a3c300b001cc29efdf81mr1152961plb.41.1701665922547; 
 Sun, 03 Dec 2023 20:58:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJvKjHnR3rkWMFGt1T5AuTutafXjfooJgkh32TRi+6RG02X9+6FCtFgrVHIfGRQ9m9n1xNBQ==
X-Received: by 2002:a17:902:a3c3:b0:1cc:29ef:df81 with SMTP id
 q3-20020a170902a3c300b001cc29efdf81mr1152951plb.41.1701665922294; 
 Sun, 03 Dec 2023 20:58:42 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:58:41 -0800 (PST)
Message-ID: <21169543-3f81-4b41-ae0d-dc7c397128de@redhat.com>
Date: Mon, 4 Dec 2023 14:58:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 17/25] backends: Reduce variable scope in
 host_memory_backend_memory_complete
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-18-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Reduce the &local_err variable use and remove the 'out:' label.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/hostmem.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


